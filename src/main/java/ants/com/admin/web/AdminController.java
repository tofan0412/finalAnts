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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.admin.model.NoticeVo;
import ants.com.admin.service.AdminService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/admin")
@Controller
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Resource(name="adminService")
	AdminService adminService;
	
	
	@RequestMapping("/adminproject")
	public String projectmain(HttpSession session) {
		
		session.setAttribute("noticeId", "1");
		return "tiles/notice/noticecontentmenu";
	}
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	@RequestMapping("/adeachproject")
	public String adeachproject(HttpSession session) {
		
		session.setAttribute("noticeId", "1");
		
		return "notice/admineachproject";
	}
	
//	// 카테고리 내역 조회
//	@RequestMapping("/adeachproject2")
//	public String adeachproject2(HttpSession session, Model model) {
//		
//		session.setAttribute("noticeId", "1");
//		String adminId = "admin";
//		List<CategoryVo> categorylist = adminService.categorylist(adminId);
//		String noticeId = (String)session.getAttribute("noticeId");
//		
////			List<NoticeVo> noticelist = adminService.noticelist(noticeId);		
//		
//		
////			model.addAttribute("noticelist", noticelist);
////			model.addAttribute("categorylist", categorylist);
////			System.out.println(categorylist);
//		
//		return "tiles/notice/noticelist";
//	}
	
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
		
		return "tiles/notice/noticelist2";
	}
	
	// 각 공지사항 상세보기
	@RequestMapping("/eachnoticeDetail")
	public String geteachnotice(String noticeId, HttpSession session, Model model) {
		
		NoticeVo noticevo = adminService.geteachnotice(noticeId);
		
		model.addAttribute("noticevo", noticevo);
		
		
		model.addAttribute("adminId", "admin");
		 
		return "tiles/notice/noticeDetail";
	}
	
	// 공지사항 작성 View
	@RequestMapping("/insertnoticeView")
	public String insertnoticeView(HttpSession session) {

		return "tiles/notice/noticeInsert";
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
		
		return "tiles/notice/noticeUpdate";
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
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////test







	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

