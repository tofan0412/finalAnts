package ants.com.admin.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ants.com.admin.model.AdminVo;
import ants.com.admin.model.NoticeVo;
import ants.com.admin.service.AdminService;
import ants.com.member.model.MemberVo;
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
		return "admain.tiles/layout/admin/adcontentmenu";
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
				return "admain.tiles/layout/admin/adcontentmenu";
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
		return "admain.tiles/layout/admin/adcontentmenu";
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
		
		return "admain.tiles/notice/noticelist2";
	}
	
	// 각 공지사항 상세보기
	@RequestMapping("/eachnoticeDetail")
	public String geteachnotice(String noticeId, HttpSession session, Model model) {
		
		NoticeVo noticevo = adminService.geteachnotice(noticeId);
		
		model.addAttribute("noticevo", noticevo);
		
		
		model.addAttribute("adminId", "admin");
		 
		return "admain.tiles/notice/noticeDetail";
	}
	
	// 공지사항 작성 View
	@RequestMapping("/insertnoticeView")
	public String insertnoticeView(HttpSession session) {

		return "admain.tiles/notice/noticeInsert";
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
		
		return "admain.tiles/notice/noticeUpdate";
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
	
//	//멤버 목록
//	@RequestMapping("/memberlist")
//	public String memberList(@ModelAttribute("memberVo") MemberVo memberVo, HttpSession session, Model model) throws Exception {
//		String memId = (String)session.getAttribute("memId");
//		memberVo.setMemId(memId);
//		List<MemberVo> resultList = adminService.memberlist(memberVo);
//		model.addAttribute("memberlist", resultList);
//		return "admain.tiles/admin/memberlist";
//		
//	}
//	// 각 멤버리스트 상세보기
//	@RequestMapping("/eachmemberDetail")
//	public String geteachmember(String memId, HttpSession session, Model model) {
//		
//		MemberVo membervo = adminService.geteachmember(memId);
//		
//		model.addAttribute("membervo", membervo);
//		
////		model.addAttribute("adminId", "admin");
//		 
//		return "admain.tiles/admin/memberDetail";
//	}
//	
//	// 멤버리스트 작성 View
//	@RequestMapping("/insertmemberView")
//	public String insertmemberView(HttpSession session) {
//
//		return "admain.tiles/admin/memberInsert";
//	}
//	
//	// 멤버리스트 작성
//	@RequestMapping("/insertmember")
//	public String insertmember(MemberVo memberVo, HttpSession session, Model model) {
//		
//		String memId = (String)session.getAttribute("memId");
//		
////		memberVo.setAdminId("admin");
//		
//		int insertCnt = adminService.insertmember(memberVo);
//
//		if(insertCnt>0) {		
//			return "redirect:/admin/memberlist";
//		}else {
//			return "redirect:/admin/insertmemberView";
//			
//		}	
//	}
//	
//	// 멤버리스트 update View
//	@RequestMapping("/updatememberView")
//	public String updatememberView(String memId, HttpSession session, Model model) {
//		
//		MemberVo membervo = adminService.geteachmember(memId);
//		model.addAttribute("memberVo", membervo);
//		
//		return "admain.tiles/admin/memberUpdate";
//	}
//	
//	// 멤버리스트 update 
//	@RequestMapping("/updatemember")
//	public String updatemember(MemberVo memberVo, HttpSession session, Model model) {
//		
////			String reqId = (String)session.getAttribute("reqId");
//		String memId = (String)session.getAttribute("memId");
////			noticeVo.setNoticeId(noticeId);
////		noticeVo.setAdminId("admin");
//		
//		int insertCnt = adminService.updatemember(memberVo);
//		
//		if(insertCnt>0) {		
//			return "redirect:/admin/memberlist";
//		}else {
//			return "redirect:/admin/updatememberView";
//			
//		}
//	}
//	
//	// 멤버리스트 delete 
//	@RequestMapping("/delmember")
//	public String delmember(String memId, HttpSession session, Model model) {		
//		int delCnt = adminService.delmember(memId);
//		if(delCnt>0) {		
//			return "redirect:/admin/memberlist";
//		}else {
//			return "redirect:/admin/eachmemberDetail?memId="+memId;
//		}
//	}
	
	
	
	
	
	
	
	
	
	
	
	
}

