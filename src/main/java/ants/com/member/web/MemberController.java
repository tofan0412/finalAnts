package ants.com.member.web;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
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
import javax.swing.JOptionPane;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.service.MemberService;
import ants.com.member.service.ProjectService;
import ants.com.member.service.ProjectmemberService;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import java.sql.SQLException;

@MultipartConfig
@RequestMapping("/member")
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Resource(name = "memberService")
	private MemberService memberService;
	
	@Resource(name = "projectService")
	private ProjectService projectService;
	
	

	@RequestMapping("/mainView")
	public String mainView() {
		logger.debug("메인뷰 진입");
		return "main.tiles/main";
	}

	// 로그인 페이지 이동
	@RequestMapping("/loginView")
	public String loginView() {
		logger.debug("MemberController loginView");
		return "member/login";
	}

	// 로그인 로직
		@RequestMapping(path = "/loginFunc")
		public String process(MemberVo memberVo, HttpSession session, Model model) {

			logger.debug("LoginCOntroller - memberVo : {} ", memberVo);

			MemberVo dbMember = memberService.getMember(memberVo.getMemId());
			logger.debug("dbMember : {}", dbMember);

			if (dbMember != (null) && memberVo.getMemPass().equals(dbMember.getMemPass())) {
				session.setAttribute("SMEMBER", memberVo);
				List<ProjectVo>proList = projectService.memInProjectList(memberVo.getMemId());
				logger.debug("projectList:{}",proList);
				if(proList.size()!=0) {
					session.setAttribute("projectList", proList);	
				}

				if (dbMember.getMemType().equals("PL") || dbMember.getMemType().equals("PM")) {
					List<ProjectVo> plpmList = projectService.plpmInProjectList(memberVo.getMemId());
					session.setAttribute("plpmList", plpmList);	
					logger.debug("plpmList:{}",plpmList);
					return "content/project";
				} else {
					return "content/project";
				}

			} else {
				JOptionPane.showMessageDialog(null, "일치하는 회원정보가 없습니다.");
				return "redirect:/member/loginView";
			}
		}
		
	
	
	
	// 회원가입 페이지 이동
	@RequestMapping(path = "/memberRegistview", method = RequestMethod.GET)
	public String getView() {
		logger.debug("memberRegist-Controller.getView()");
		return "main.tiles/member/memberRegist";
	}

	// 회원가입 로직
	@RequestMapping(path = "/memberRegist", method = RequestMethod.POST)
	public String memberRegist(MemberVo memberVo, BindingResult br, @RequestPart(value="realFilename", required=false) MultipartFile file, Model model) {

		logger.debug("memberVo : {}", memberVo);
		logger.debug("filename : {} / realFilename : {} / size : {}", file.getName(), file.getOriginalFilename(),
				file.getSize());

		 logger.debug("br.hasErrors() : {}", br.hasErrors() );
		 
		
		if(br.hasErrors()) {
			return "main.tiles/member/memberRegist";
		}
		
		String Filename = "";
		if(file.getOriginalFilename().equals(null)) {	// 파일 선택 안했을때 기본값
			Filename =  "D:\\upload\\user.png";
		}else {
			Filename = "D:\\upload\\" + file.getOriginalFilename();
		}

		File uploadFile = new File(Filename);

		try {
			file.transferTo(uploadFile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}

		logger.debug("---------------------통과-------------------");

		memberVo.setMemFilepath(Filename);
		if(file.getOriginalFilename().equals(null)) {	// 파일 선택 안했을때 기본값
			memberVo.setMemFilename("user.png");
		}else {
			memberVo.setMemFilename(file.getOriginalFilename());
		}
		
		
		
		logger.debug("memId : {}", memberVo.getMemId());
		logger.debug("memberVo : {}", memberVo);
		
		int insertCnt = 0;
		try {
			insertCnt = memberService.insertMember(memberVo);
		} catch (SQLException | IOException e) {
			return "main.tiles/member/memberRegist";
		}
		
		logger.debug("insertCnt : {}", insertCnt);
		
		if (insertCnt == 1) {
			model.addAttribute("cnt", insertCnt);
			return "main.tiles/main";
		} else {
			return "redirect:member/memberRegist";
		}
	}
	
	// 중복아이디 체크
	@ResponseBody @RequestMapping(path = "/checkSignup", method = RequestMethod.POST) 
	public String checkSignup(HttpServletRequest request) { 
		String memId = request.getParameter("memId"); 
		int rowcount = memberService.checkSignup(memId); 
		logger.debug("checkSignup : {}", rowcount);
		
		return String.valueOf(rowcount);
	}

	
	// 비밀번호 수정 - 이메일
	/** 자바 메일 발송 * @throws MessagingException * @throws AddressException **/
	@RequestMapping(value = "/mailsender")
	public String mailSender(MemberVo memberVo, HttpServletRequest request, ModelMap mo, Model model)
			throws AddressException, MessagingException {
		logger.debug("memberRegist-Controller - mailSender()");

		// 네이버일 경우 smtp.naver.com 을 입력합니다.
		// Google일 경우 smtp.gmail.com 을 입력합니다.

		// 네이버 메일 환경설정에서 "POP3/IMAP" 설정 사용으로 바꿔준다.
		String host = "smtp.naver.com";

		// POP3/IMAP 설정시 네이버에서 알려줌
		final String username = "noylit"; // 네이버 아이디를 입력해주세요. @naver.com은 입력하지 마시구요.
		final String password = "1234a5678"; // 네이버 이메일 비밀번호를 입력해주세요.
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
	
	
	// 비밀번호 수정
	@RequestMapping(path = "/passupdateemail", method = RequestMethod.GET)
	public String passupdateemail(MemberVo memberVo,Model model) {
		model.addAttribute("memId", memberVo.getMemId());
		
		return "main.tiles/member/memberPassmodified";
	}
	
	
	

	// 비밀번호 수정
	@RequestMapping(path = "/passupdate", method = RequestMethod.GET)
	public String passupdate(MemberVo memberVo) {
		logger.debug("memberRegist-Controller - passupdate()");

		int updatecnt = memberService.updatePass(memberVo);
		logger.debug("memberRegist-Controller - passupdate()-updatecnt : {}", updatecnt);

		if (updatecnt == 1) {
			return mainView();
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

	// 문자로 비밀번호 변경
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
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		session.removeAttribute("SMEMBER");
		session.removeAttribute("reqId");
		return loginView();
	}
	



}
