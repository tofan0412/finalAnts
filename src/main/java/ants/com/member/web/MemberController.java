package ants.com.member.web;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import ants.com.admin.model.NoticeVo;
import ants.com.admin.service.AdminService;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.memBoard.model.ScheduleVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.common.model.AlarmVo;
import ants.com.common.model.IpHistoryVo;
import ants.com.common.service.AlarmService;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.service.MemberService;
import ants.com.member.service.ProjectService;
import ants.com.member.service.ProjectmemberService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@MultipartConfig
@RequestMapping("/member")
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);


	@Resource(name = "memberService")
	private MemberService memberService;
	
	@Resource(name = "projectService")
	private ProjectService projectService;
	
	@Resource(name="adminService")
	private AdminService adminService;
	
	@Resource(name = "memBoardService")
	private memBoardService memBoardService;
	
	@Resource(name="promemService")
	ProjectmemberService promemService;
	
	@Resource(name="alarmService")
	private AlarmService alarmService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping("/mainView")
	public String mainView() {
		return "main.tiles/main";
	}

	// 로그인 페이지 이동
	@RequestMapping("/loginView")
	public String loginView() {
		return "member/login";
	}
	
	// 블락 페이지 이동
	@RequestMapping("/blockView")
	public String blockView() {
		return "member/block";
	}
	
	// 메인 페이지로 이동
	@RequestMapping("/projectMainView")
	public String projectMainView() {
		return "main/layout/contentmain";
	}
				
	// 로그인 로직
	@RequestMapping(path = "/loginFunc")
	public String loginFunc(MemberVo memberVo, HttpSession session, Model model) {
		
		logger.debug("LoginCOntroller - memberVo : {} ", memberVo);
		
		MemberVo dbMember = memberService.getMember(memberVo);
		logger.debug("dbMember : {}", dbMember);
			
		if (dbMember != (null) && memberVo.getMemPass().equals(dbMember.getMemPass())) {
			session.setAttribute("SMEMBER", dbMember);
			// 로그인 정보를 history에 기록한다.
			
			// 1. IP 가져오기
			HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder
										.currentRequestAttributes()).getRequest();
			String ip = req.getHeader("X-FORWARDED-FOR");
			
			if (ip == null) ip = req.getRemoteAddr();
			model.addAttribute("clientIp", ip);
			
			// 2. IpHistoryVo를 이용하여 기록하기.
			IpHistoryVo log = new IpHistoryVo();
			log.setMemId(dbMember.getMemId());
			log.setIpAddr(ip);
			
			adminService.insertMemLoginLog(log);
			
			
			List<ScheduleVo> showCalendar = new ArrayList<>();	// 캘린더 목록 선언 및 초기화
			List<IssueVo> resultList = new ArrayList<>();		// 공지사항 목록 선언 및 초기화
			
			// 회원 타입이 MEM일 때만 조회
			if(dbMember.getMemType().equals("MEM")) {
				// 로그인 한 회원 프로젝트 리스트 가져옴
				List<ProjectVo> proList = projectService.memInProjectList(dbMember.getMemId());
				
				// MEM의 프로젝트 리스트가 있을때만
				if (proList.size() != 0) {
					session.setAttribute("memInProjectList", proList);	// 프로젝트 리스트 세션에 저장
					
					// 로그인
					/*캘린더 초기값 */
					ScheduleVo scheduleVo = new ScheduleVo();		
					scheduleVo.setReqId(proList.get(proList.size()-1).getReqId());		// 가져온 프로젝트 리스트 중에 첫번째리스트에 있는 캘린더 보여줄거
					showCalendar = memBoardService.showCalendar(scheduleVo); // 첫번째 프로젝트 번호 가져가서 캘린더 가져옴
					
					/*공지사항 초기값*/
					IssueVo issueVo = new IssueVo();
					issueVo.setMemId(dbMember.getMemId());
					issueVo.setReqId(proList.get(proList.size()-1).getReqId());	// 첫번째 프로젝트의 이슈 가져오기
					issueVo.setCategoryId("3");						// 카테고리 번호 (3번이 이슈)
					issueVo.setIssueKind("notice");					// 이슈 말머리 선택 (공지사항)
					model.addAttribute("reqId", proList.get(proList.size()-1).getReqId());	// 기본 프로젝트 번호 jsp로 넘겨주기
					model.addAttribute("proName", proList.get(proList.size()-1).getProName());	// 프로젝트 이름
							
					/** pageing setting */
					PaginationInfo paginationInfo = new PaginationInfo();
					paginationInfo.setCurrentPageNo(issueVo.getPageIndex());
					paginationInfo.setRecordCountPerPage(issueVo.getPageUnit());
					paginationInfo.setPageSize(issueVo.getPageSize());
					
					issueVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
					issueVo.setLastIndex(paginationInfo.getLastRecordIndex());
					issueVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

					resultList = promemService.issuelist(issueVo);
					
				}
				
				List<ProjectVo> pro_pL = projectService.plInProjectList(dbMember.getMemId());// 프로젝트 리스트 조회
					
				// PL의 프로젝트 리스트가 있을때만
				if (pro_pL.size() != 0) {
					session.setAttribute("plInProjectList", pro_pL);	// 프로젝트 리스트 세션에 저장
				}
			}	
			
			
			// 회원 타입이 PM일 때만 조회
			if(dbMember.getMemType().equals("PM")) {
				List<ProjectVo> prp_pm = projectService.pmInProjectList(dbMember.getMemId());// 프로젝트 리스트 조회			
				
				// PM의 프로젝트 리스트가 있을때만
				if (prp_pm.size() != 0) {
					session.setAttribute("pmInProjectList", prp_pm);	// 프로젝트 리스트 세션에 저장
					
					// 로그인
					/*캘린더 초기값 */
					ScheduleVo scheduleVo = new ScheduleVo();		
					scheduleVo.setReqId(prp_pm.get(prp_pm.size()-1).getReqId());		// 가져온 프로젝트 리스트 중에 첫번째리스트에 있는 캘린더 보여줄거
					showCalendar = memBoardService.showCalendar(scheduleVo); // 첫번째 프로젝트 번호 가져가서 캘린더 가져옴
						
					/*공지사항 초기값*/
					IssueVo issueVo = new IssueVo();	
					issueVo.setMemId(dbMember.getMemId());
					issueVo.setReqId(prp_pm.get(prp_pm.size()-1).getReqId());	// 첫번째 프로젝트의 이슈 가져오기
					issueVo.setCategoryId("3");					// 카테고리 번호 (3번이 이슈)
					issueVo.setIssueKind("notice");				// 이슈 말머리 선택 (공지사항)
					model.addAttribute("reqId", prp_pm.get(prp_pm.size()-1).getReqId());	// 기본 프로젝트 번호 jsp로 넘겨주기
					model.addAttribute("proName", prp_pm.get(prp_pm.size()-1).getProName());	// 프로젝트 이름
					
					/** pageing setting */
					PaginationInfo paginationInfo = new PaginationInfo();
					paginationInfo.setCurrentPageNo(issueVo.getPageIndex());
					paginationInfo.setRecordCountPerPage(issueVo.getPageUnit());
					paginationInfo.setPageSize(issueVo.getPageSize());
					
					issueVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
					issueVo.setLastIndex(paginationInfo.getLastRecordIndex());
					issueVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

					resultList = promemService.issuelist(issueVo);
				}
			}	
			
			// 캘린더 전송	// 캘린더는 있든 없든 전송해야함
			model.addAttribute("showSchedule", showCalendar);
			// 공지사항 전송 
			model.addAttribute("issuelist", resultList);
			
			//alarm
			AlarmVo alarmVo = new AlarmVo();
			alarmVo.setMemId(dbMember.getMemId());
			alarmVo = alarmService.alarmCount(alarmVo);
			
			session.setAttribute("alarmCnt", alarmVo);
				
			return "main/layout/contentmain";
		} else {
			return "redirect:/member/loginView";
		}
	}
		
	// 로그인 체크 ajax
	@RequestMapping(path = "/logincheck", method = RequestMethod.GET)
	public String logincheck(MemberVo memberVo, Model model) {
		
		logger.debug("LoginCOntroller - logincheck : {} ", memberVo);
		
		MemberVo dbMember = memberService.logincheck(memberVo);
		
		logger.debug("logincheck rowcount : {}", dbMember);
		
		
		model.addAttribute("memId", dbMember.getMemId());
		model.addAttribute("memPass", dbMember.getMemPass());
		
		return "member/login";
	}

	// 회원가입 페이지 이동
	@RequestMapping(path = "/memberRegistview", method = RequestMethod.GET)
	public String getView() {
		return "main.tiles/member/memberRegist";
	}
	
	// 회원가입 로직
	@RequestMapping(path="/memberRegist", method=RequestMethod.POST)
	public String memberRegist(MemberVo memberVo, BindingResult br, @RequestPart(value="memFilename", required=false) MultipartFile file, Model model, @RequestParam(value="imgname", required=false)String imgname) {
		logger.debug("memberVo : {} / imgname : {}", memberVo, imgname);
		logger.debug("filename : {} / memFilename : {} / size : {}", file.getName(), file.getOriginalFilename(),file.getSize());
		
		String Filename = "";
		String Filepath = "";
		
		if(!file.getOriginalFilename().equals("") && !file.getOriginalFilename().equals(null)) {
			
			logger.debug("br.hasErrors() : {}", br.hasErrors());
	
			if (br.hasErrors()) {
//				return "main.tiles/member/memberRegist";
			}
	
			String filekey = UUID.randomUUID().toString();
			Filepath = "D:\\upload\\"+ filekey + "\\"+ file.getOriginalFilename();
			Filename = file.getOriginalFilename();
			File uploadFile = new File(Filepath);
			
			try {
				file.transferTo(uploadFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
	
			logger.debug("---------------------통과-------------------");
		}else {
			// 기본 이미지 중에 선택했을때
			if(!imgname.equals("") && !imgname.equals(null)) {
				Filepath = imgname;
				Filename = imgname.split("/")[4];
			// 기본이미지 값이 널일때 (기본이미지/파일 아무것도 선택 안함)
			}else { 
				Filepath = "http://localhost/profile/user-0.png";
				Filename = "user-0.png";
			}
		}

		memberVo.setMemFilepath(Filepath);
		memberVo.setMemFilename(Filename);
		
		logger.debug("memId : {}", memberVo.getMemId());
		logger.debug("memberVo : {}", memberVo);
		

		int insertCnt = 0;
		try {
			insertCnt = memberService.insertMember(memberVo);
		} catch (SQLException | IOException e) {
			return "main.tiles/member/memberRegist";
		}
		
		if (insertCnt == 1) {
			model.addAttribute("cnt", insertCnt);
			return "main.tiles/main";
		} else {
			return "redirect:member/memberRegist";
		}
	}
	
	
	// 중복아이디 체크
	@ResponseBody @RequestMapping(path = "/checkSignup", method = RequestMethod.POST) 
	public String checkSignup(HttpServletRequest request, MemberVo memberVo) { 
		String memId = request.getParameter("memId");
		int rowcount = memberService.checkSignup(memberVo); 
		
		return String.valueOf(rowcount);
	}
	
	
	// 비밀번호 수정 - 이메일
	/** 자바 메일 발송 * @throws MessagingException * @throws AddressException **/
	@RequestMapping(value = "/mailsender")
	public String mailSender(MemberVo memberVo, HttpServletRequest request, ModelMap mo, Model model)
			throws AddressException, MessagingException {

		// 네이버일 경우 smtp.naver.com 을 입력합니다.
		// Google일 경우 smtp.gmail.com 을 입력합니다.

		// 네이버 메일 환경설정에서 "POP3/IMAP" 설정 사용으로 바꿔준다.
		String host = "smtp.naver.com";

		// POP3/IMAP 설정시 네이버에서 알려줌
		final String username = "noylit"; // 네이버 아이디를 입력해주세요. @naver.com은 입력하지 마시구요.
		final String password = "1234c5678"; // 네이버 이메일 비밀번호를 입력해주세요.
		int port = 465; // 포트번호
		
		String uuid = UUID.randomUUID().toString();
		model.addAttribute("uuid", uuid);
		model.addAttribute("memId", memberVo.getMemId());
		// 메일 내용
		String recipient = memberVo.getMemId(); // 받는 사람의 메일주소를 입력해주세요.
		String subject = "비밀번호 변경(URL)"; // 메일 제목 입력해주세요.
		String body = "http://localhost/member/passupdateemail?memId=" + memberVo.getMemId().replace("@", "%40"); // 메일 내용 입력해주세요.

		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성

		// SMTP 서버 정보 설정
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		// Session 생성
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = username;
			String pw = password;

			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});

		session.setDebug(true); // for debug

		Message mimeMessage = new MimeMessage(session); // MimeMessage 생성
		mimeMessage.setFrom(new InternetAddress("noylit@naver.com")); // 발신자 셋팅, 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀
																		// 주소를 다 작성해주세요.
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); // 수신자셋팅 //.TO 외에 .CC(참조)
																							// .BCC(숨은참조) 도 있음
		
		mimeMessage.setSubject(subject); // 제목셋팅
		mimeMessage.setText(body); // 내용셋팅
		Transport.send(mimeMessage); // javax.mail.Transport.send() 이용 }
		
		return "main.tiles/main";
	}
	
	
	// 비밀번호 수정 - 이메일
	@RequestMapping(path = "/passupdateemail", method = RequestMethod.GET)
	public String passupdateemail(MemberVo memberVo,Model model) {
		model.addAttribute("memId", memberVo.getMemId());
		
		return "main.tiles/member/memberPassmodified";
	}
	
	
	// 비밀번호 수정 (문자,메일 -> 비밀번호 수정 쿼리로)
	@RequestMapping(path = "/passupdate", method = RequestMethod.GET)
	public String passupdate(MemberVo memberVo) {

		int updatecnt = memberService.updatePass(memberVo);

		if (updatecnt == 1) {
			return mainView();		// 수정되면 메인으로
		} else {					// 수정하는 정보에 전화번호가 없으면   메일 수정창으로 복귀
			if (memberVo.getMemTel().equals(null) || memberVo.getMemTel().equals("")) {
				return "main.tiles/member/memberPassmodified";
			}else {		// 수정하는 정보에 전화번호가 있으면 전화번호 수정창으로 복귀
				return "main.tiles/member/memberPassmodified2";
			}
		}
	}
	
	
	// 인증번호 생성
	public static String numberGen(int len, int dupCd) {
		Random rand = new Random();
		String numStr = ""; // 난수가 저장될 변수

		for (int i = 0; i < len; i++) {
			// 0~9 까지 난수 생성
			String ran = Integer.toString(rand.nextInt(10));
			if (dupCd == 1) {
				// 중복 허용시 numStr에 append
				numStr += ran;
			} else if (dupCd == 2) {
				// 중복을 허용하지 않을시 중복된 값이 있는지 검사한다
				if (!numStr.contains(ran)) {
					// 중복된 값이 없으면 numStr에 append
					numStr += ran;
				} else {
					// 생성된 난수가 중복되면 루틴을 다시 실행한다
					i -= 1;
				}
			}
		}
		return numStr;
	}
	

	// 비밀번호 수정 - 문자
	@RequestMapping(path = "/sendSms")
	public String sendSms(HttpServletRequest request, MemberVo memberVo, Model model) throws Exception {

		String api_key = "NCSLFKWJHGFLOQ9K";
		String api_secret = "HYV5DTDAVLUMKWMFB8WZVLAPZ56LUZAL";
		net.nurigo.java_sdk.api.Message coolsms = new net.nurigo.java_sdk.api.Message(api_key, api_secret);
		
		// 인증번호 생성
		String validatenumber = numberGen(6,2);
		
		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", memberVo.getMemTel()); // 수신번호
		params.put("from", "01049057321"); // 발신번호
		params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
		params.put("text", "인증번호 : " + validatenumber); // 문자내용
		params.put("app_version", "JAVA SDK v1.2"); // application name and version
		
		model.addAttribute("uuid", validatenumber);
		model.addAttribute("memId", memberVo.getMemId());
		model.addAttribute("memTel", memberVo.getMemTel());
		
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		
		return "main.tiles/member/memberPassmodified2";
	}
	
	// 프로필 수정 페이지
	@RequestMapping("/profileupdateview")
	public String profileupdateview(MemberVo memberVo, Model model) {
		MemberVo dbMember = memberService.getMember(memberVo);
		model.addAttribute("memberVo", dbMember);
		return "tiles/member/profileupdateview";
	}
	
	
    @RequestMapping(path="/profileupdate", method = RequestMethod.POST)                // VO 객체 바로 뒤에 Binding 와야함... 안그럼 매칭안됨
    public String profileupdate(HttpSession session, Model model, String imgname, MemberVo memberVo, BindingResult br,
                                                                @RequestPart(value="memFilename", required=false) MultipartFile file) {
        
        logger.debug("memFilename : {}", file.getOriginalFilename());
        String Filename = "";
        String Filepath = "";
        
        if(!file.getOriginalFilename().equals("") && !file.getOriginalFilename().equals(null)) {
            
            if (br.hasErrors()) {
//                return "main.tiles/member/memberRegist";
            }
    
            String filekey = UUID.randomUUID().toString();
            
             /*filekey + "\\"+*/
            Filepath = "D:\\upload\\"+ file.getOriginalFilename();
            Filename = file.getOriginalFilename();
            File uploadFile = new File(Filepath);
            
            try {
                file.transferTo(uploadFile);
            } catch (IllegalStateException | IOException e) {
                e.printStackTrace();
            }
            
        }else {
            
            // 기본 이미지 중에 선택했을때
            if(!imgname.equals("") && !imgname.equals(null)) {
                Filepath = imgname;
                Filename = imgname.split("/")[4];
            
            // 기본이미지 값이 널일때 (기본이미지/파일 아무것도 선택 안함)
            }else { 
                Filepath = "http://localhost/profile/user-0.png";
                Filename = "user-0.png";
            }
        }
        memberVo.setMemFilepath(Filepath);
        memberVo.setMemFilename(Filename);
        
        
        int updateCnt = memberService.profileupdate(memberVo);
        
        if(updateCnt == 1){
            return "redirect:/member/profile";
        }else {
            return "tiles/member/profileupdateview";    
        }

    }
	
	// 프로필 보기
	@RequestMapping("/profile")
	public String profile(HttpSession session, MemberVo memberVo, Model model) {
		
		memberVo = (MemberVo) session.getAttribute("SMEMBER");
		logger.debug("LoginCOntroller - memberVo : {} ", memberVo);
		MemberVo dbMember = memberService.getMember(memberVo);
		logger.debug("dbMember : {}", dbMember);
		
		model.addAttribute("memberVo",dbMember);
		return "tiles/member/memberProfile";
	}
	
	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/member/loginView";
	}
	
	// 알람 on/off
	@RequestMapping(path = "/updateAlarm", method = RequestMethod.GET)
	public String updateAlarm(MemberVo memberVo, Model model) {
		int dbMember = memberService.updateAlarm(memberVo);
		model.addAttribute("memberVo", memberVo);
		return "tiles/member/memberProfile";
	}
		
	
	// 공지사항리스트 출력
	// admin 인터셉터 때문에 관리자로 로그인 안하면 admin url을 탈수 없기 때문에 따로 만듦
	@RequestMapping("/noticelistmemview")
	public String noticelistmemview(@ModelAttribute("noticeVo") NoticeVo noticeVo, HttpSession session, Model model) throws Exception{
			
		/** EgovPropertyService.sample */
		noticeVo.setPageUnit(propertiesService.getInt("pageUnit"));
		noticeVo.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(noticeVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(noticeVo.getPageUnit());
		paginationInfo.setPageSize(noticeVo.getPageSize());

		noticeVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		noticeVo.setLastIndex(paginationInfo.getLastRecordIndex());
		noticeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<NoticeVo> resultList = adminService.noticelist(noticeVo);
		model.addAttribute("noticelist", resultList);

		int totCnt = adminService.noticePagingListCnt(noticeVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
					
		return "main.tiles/notice/noticelistmemview";
	}
			
		
	// 각 공지사항 상세보기
	@RequestMapping("/noticedetailmemview")
	public String noticedetailmemview(String noticeId, HttpSession session, Model model) {
			
		NoticeVo noticevo = adminService.geteachnotice(noticeId);
		model.addAttribute("noticevo", noticevo);
		
		return "main.tiles/notice/noticedetailmemview";
	}
		
	
}
