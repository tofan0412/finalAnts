package ants.com.admin.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.multipart.MultipartFile;

import ants.com.admin.model.AdminVo;
import ants.com.admin.model.NoticeVo;
import ants.com.admin.service.AdminService;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ReqVo;
import ants.com.member.service.MemberService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/admin")
@Controller
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Resource(name="adminService")
	AdminService adminService;
	
	@Resource(name="memberService")
	MemberService memberService;
	
	@RequestMapping("/adminproject")
	public String projectmain(HttpSession session) {
		
		session.setAttribute("noticeId", "1");
		return "admin.tiles/layout/admin/adcontentmenu";
	}
	
	////////////////////////////////////////////////관리자 로그인
	
	//관리자 로그인 페이지
	@RequestMapping("/adloginView")
	public String adloginView() {
		return "/layout/admin/adlogin";
	}
	
	// 로그인 로직
	@RequestMapping(path = "/adloginFunc")
	public String adloginFunc(AdminVo adminVo, HttpSession session, Model model) {


		AdminVo dbAdmin = adminService.getAdmin(adminVo);
		logger.debug("dbAdmin : {}", dbAdmin);
		
		if (dbAdmin != (null) && adminVo.getAdminPass().equals(dbAdmin.getAdminPass())) {
			session.setAttribute("SADMIN", dbAdmin);
				return "admin.tiles/layout/admin/adcontentmenu";
		} else {
			return "redirect:/member/loginView";
		}

	}
	
	// 로그인 체크 ajax
	@RequestMapping(path = "/adlogincheck", method = RequestMethod.GET)
	public String adlogincheck(AdminVo adminVo, Model model) {
		
		logger.debug("LoginController - logincheck : {} ", adminVo);
		
		AdminVo dbAdmin = adminService.adlogincheck(adminVo);
		
		logger.debug("logincheck rowcount : {}", dbAdmin);
		
		
		model.addAttribute("adminId", dbAdmin.getAdminId());
		model.addAttribute("adminPass", dbAdmin.getAdminPass());
		
		return "/layout/admin/adlogin";
	}
	
	//관리자 로그아웃
	@RequestMapping("/adlogout")
	public String adlogout(HttpSession session) {
		session.invalidate();
		return adloginView();
	}
	
	// 화면 상단 로고 클릭 시 메인 페이지로 이동
	@RequestMapping("/adMainView")
	public String adMainView() {
		return "admin.tiles/layout/admin/adcontentmenu";
	}
///////////////////////////////////////////////////////////////////////////////////////////////관리자 로그인 끝	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////관리자 공지사항	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	@RequestMapping("/adeachproject")
	public String adeachproject(HttpSession session) {
		
		session.setAttribute("noticeId", "1");
		
		return "notice/admineachproject";
	}
	
	
	// 공지사항리스트 출력
	@RequestMapping("/noticelist")
	public String getnoticelist(@ModelAttribute("noticeVo") NoticeVo noticeVo, HttpSession session, Model model) throws Exception{
			
//		String reqId = (String)session.getAttribute("reqId"); //프로젝트Id를 안쓰는데 어찌하지..
		String noticeId = (String)session.getAttribute("noticeId");
	
//			IssueVo issueVo = new IssueVo();
//		issueVo.setReqId(reqId);
		noticeVo.setNoticeId(noticeId);
		
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
		
//		String memId = "cony@naver.com";
//		List<CategoryVo> categorylist = promemService.categorylist(memId);
//		model.addAttribute("categorylist", categorylist);
		
		return "admin.tiles/notice/noticelist2";
	}
	
	// 각 공지사항 상세보기
	@RequestMapping("/eachnoticeDetail")
	public String geteachnotice(String noticeId, HttpSession session, Model model) {
		
		NoticeVo noticevo = adminService.geteachnotice(noticeId);
		
		model.addAttribute("noticevo", noticevo);
		
		
		model.addAttribute("adminId", "admin");
		 
		return "admin.tiles/notice/noticeDetail";
	}
	
	// 공지사항 작성 View
	@RequestMapping("/insertnoticeView")
	public String insertnoticeView(HttpSession session) {

		return "admin.tiles/notice/noticeInsert";
	}
	
	// 공지사항 작성
	@RequestMapping("/insertnotice")
	public String insertnotice(NoticeVo noticeVo, HttpSession session, Model model) {
		
//		System.out.println(noticeVo);
//		String reqId = (String)session.getAttribute("reqId");
		String noticeId = (String)session.getAttribute("noticeId");
		
		noticeVo.setAdminId("admin");
		
//			System.out.println(issueVo);
		int insertCnt = adminService.insertnotice(noticeVo);

		if(insertCnt>0) {		
			return "redirect:/admin/noticelist";
		}else {
			return "redirect:/admin/insertnoticeView";
			
		}	
	}
	
	
	// 공지사항 update View
	@RequestMapping("/updatenoticeView")
	public String updatenoticeView(String noticeId, HttpSession session, Model model) {
		
		NoticeVo noticevo = adminService.geteachnotice(noticeId);
		model.addAttribute("noticeVo", noticevo);
		
		return "admin.tiles/notice/noticeUpdate";
	}
	
	// 공지사항 update 
	@RequestMapping("/updatenotice")
	public String updatenotice(NoticeVo noticeVo, HttpSession session, Model model) {
		
//		String reqId = (String)session.getAttribute("reqId");
		String noticeId = (String)session.getAttribute("noticeId");
//		noticeVo.setNoticeId(noticeId);
		noticeVo.setAdminId("admin");
		
		int insertCnt = adminService.updatenotice(noticeVo);
		
		if(insertCnt>0) {		
			return "redirect:/admin/noticelist";
		}else {
			return "redirect:/admin/updatenoticeView";
			
		}
	}
	
	// 공지사항 delete 
	@RequestMapping("/delnotice")
	public String delnotice(String noticeId, HttpSession session, Model model) {		
		int delCnt = adminService.delnotice(noticeId);
		if(delCnt>0) {		
			return "redirect:/admin/noticelist";
		}else {
			return "redirect:/admin/eachnoticeDetail?noticeId="+noticeId;
		}
	}
//////////////////////////////////////////////////////////////////////////////////////////////관리자 공지사항 끝
	
//////////////////////////////////////////////////////////////////////////////////////////////멤버 리스트 시작
	
	//회원 리스트 목록 조회
	@RequestMapping("/memberlist")
	public String getmemberlist(@ModelAttribute("memberVo") MemberVo memberVo,
									Model model, HttpSession session)throws Exception {
		String memId = (String)session.getAttribute("memId");
	
		memberVo.setMemId(memId);
		
		/** EgovPropertyService.sample */
		memberVo.setPageUnit(propertiesService.getInt("pageUnit"));
		memberVo.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(memberVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(memberVo.getPageUnit());
		paginationInfo.setPageSize(memberVo.getPageSize());

		memberVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		memberVo.setLastIndex(paginationInfo.getLastRecordIndex());
		memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<MemberVo> resultList = adminService.memberlist(memberVo);
		model.addAttribute("memberlist", resultList);
		logger.debug("memberlist", resultList);

		int totCnt = adminService.memberlistPagingListCnt(memberVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		logger.debug("paginationInfo", paginationInfo);

		return "admin.tiles/memberlist/memberList2";
	}
	
	// 각 공지사항 상세보기
	@RequestMapping("/eachmemlistDetail")
	public String geteachmemlist(String memId, HttpSession session, Model model) {
		
		MemberVo membervo = adminService.geteachmemlist(memId);
		
		model.addAttribute("membervo", membervo);
		
		
//		model.addAttribute("adminId", "admin");
		 
		return "admin.tiles/memberlist/memlistDetail";
	}
	
	
	
	// 프로필 보기
	@RequestMapping("/memlistprofile")
	public String memlistprofile(HttpSession session, MemberVo memberVo, Model model) {
		
		MemberVo dbMember = adminService.getMember(memberVo);
		logger.debug("dbMember : {}", dbMember);
		
		model.addAttribute("memberVo",dbMember);
		return "admin.tiles/memberlist/memberProfile";
	}
	
	
	// 프로필 수정 페이지
	@RequestMapping("/memlistprofileupdate")
	public String memlistprofileupdate(MemberVo memberVo, Model model) {
		MemberVo dbMember = adminService.getMember(memberVo);
		model.addAttribute("memberVo", dbMember);
		return "admin.tiles/memberlist/profileupdateview";
	}
	
	
	 @RequestMapping(path="/memlistproupdate", method = RequestMethod.POST)                // VO 객체 바로 뒤에 Binding 와야함... 안그럼 매칭안됨
	public String memlistproupdate(HttpSession session, Model model, String imgname, MemberVo memberVo, BindingResult br,
			@RequestPart(value = "memFilename", required = false) MultipartFile file) {

		logger.debug("memFilename : {}", file.getOriginalFilename());
		String Filename = "";
		String Filepath = "";

		if (!file.getOriginalFilename().equals("") && !file.getOriginalFilename().equals(null)) {

			if (br.hasErrors()) {
				// return "main.tiles/member/memberRegist";
			}

			String filekey = UUID.randomUUID().toString();

			/* filekey + "\\"+ */
			Filepath = "D:\\upload\\" + file.getOriginalFilename();
			Filename = file.getOriginalFilename();
			File uploadFile = new File(Filepath);

			try {
				file.transferTo(uploadFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

		} else {

			// 기본 이미지 중에 선택했을때
			if (!imgname.equals("") && !imgname.equals(null)) {
				Filepath = imgname;
				Filename = imgname.split("/")[4];

				// 기본이미지 값이 널일때 (기본이미지/파일 아무것도 선택 안함)
			} else {
				Filepath = "http://localhost/profile/user-0.png";
				Filename = "user-0.png";
			}
		}
		memberVo.setMemFilepath(Filepath);
		memberVo.setMemFilename(Filename);

		int updateCnt = adminService.memlistproupdate(memberVo);

		if (updateCnt == 1) {
			return "redirect:/admin/memlistprofile?memId=" + memberVo.getMemId();
		} else {
			return "admin.tiles/memberlist/profileupdateview";
		}

	}
	
	 //회원 삭제
	@RequestMapping("/delmemlist")
	public String delmemlist(String memId, HttpSession session, Model model) {		
		int delCnt = adminService.delmemlist(memId);
		if(delCnt>0) {		
			return "redirect:/admin/memberlist";
		}else {
			return "redirect:/admin/eachmemlistDetail?memId="+memId;
		}
	}
	
	
}

