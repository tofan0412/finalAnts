package ants.com.admin.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.admin.model.NoticeVo;
import ants.com.admin.service.AdminService;
import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import egovframework.rte.fdl.property.EgovPropertyService;

@RequestMapping("/admin")
@Controller
public class AdminController {
//	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
//	@Resource(name="AdminService")
//	AdminService adminService;
	
//	@RequestMapping("/project")
//	public String projectmain(HttpSession session) {
//		
//		session.setAttribute("reqId", "1");
//		return "tiles/board/issuecontentmenu";
//	}
	
//	/** EgovPropertyService */
//	@Resource(name = "propertiesService")
//	protected EgovPropertyService propertiesService;
//	
//	
//	@RequestMapping("/notice_eachproject")
//	public String eachproject(HttpSession session) {
//		
//		session.setAttribute("noticeId", "1");
//		
//		return "notice/notice_eachproject";
//	}
	
//	// 카테고리 내역 조회
//		@RequestMapping("/eachproject2")
//		public String eachproject2(HttpSession session, Model model) {
//			
//			session.setAttribute("reqId", "1");
//			String memId = "cony@naver.com";
//			List<CategoryVo> categorylist = promemService.categorylist(memId);
//			String reqId = (String)session.getAttribute("reqId");
//			
////			List<IssueVo> issuelist = promemService.issuelist(reqId);		
//			
//			
////			model.addAttribute("issuelist", issuelist);
////			model.addAttribute("categorylist", categorylist);
////			System.out.println(categorylist);
//			
//			return "tiles/board/issuelist";
//		}
	
	
	
	
	
	
	
	
	
	
	
	
	
//	@RequestMapping("/admin_project")
//	public String test() {
//		return "admin/admin_project";
//	}
	
//	@RequestMapping("/eachproject")
//	public String eachproject(HttpSession session) {
//		
//		session.setAttribute("reqId", "1");
//		
//		return "board/eachproject";
//	}
//	
//	
//	//게시글 목록
//	@RequestMapping("/noticeList")
//	public String getnoticelist(HttpSession session, Model model) {
//		
//		String adminId = (String)session.getAttribute("adminId");
//		
//		List<NoticeVo> noticelist = AdminService.noticelist(adminId);		
//		model.addAttribute("noticelist", noticelist);
//		 
//		return "notice/noticeList";
//	}
	
//	//게시글 등록
//	@RequestMapping("/noticeWrite")
//	public String getnoticewrite(HttpSession session, Model model) {
//		
//		return "notice/noticeWrite";
//	}
//	
//	//게시글 조회
//	@RequestMapping("/noticeRead")
//	public String getnoticeread(HttpSession session, Model model) {
//		
//		return "notice/noticeRead";
//	}
//	
//	//게시글 수정
//	@RequestMapping("/noticeModify")
//	public String getnoticemodify(HttpSession session, Model model) {
//		
//		return "notice/noticeModify";
//	}
	
	
//	//등록 페이지
//	@RequestMapping(value="/noticewrite", method = RequestMethod.GET)
//	public String writeGET() {
//		logger.info("write GET...");
//		return "/notice/noticeWrite";
//		
//	}
//	//등록 처리
//	@RequestMapping(value="/write", method="RequestMethod.POST")
//	public String writePOST(NoticeVo noticeVo, RedirectAttributes redirectAttributes) throws Exception{
//		logger.info("write POST...");
//		return "redirect:/notice/noticeList";
//	}
//	//조회 처리
//	@RequestMapping(value="/noticeRead", method=RequestMethod.GET)
//	public String read(@RequestParam("noticeId") String noticeId, Model model) throws Exception{
//		logger.info("read..");
//		model.addAttribute("notice", adminService.read(noticeId));
//		return "/notice/noticeRead";
//	}
	
}
