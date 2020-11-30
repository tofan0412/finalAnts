package ants.com.member.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.model.ReqVo;
import ants.com.member.service.ProjectmemberService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/projectMember")
@Controller
public class ProjectMemberController {
	private static final Logger logger = LoggerFactory.getLogger(ProjectMemberController.class);

	@Resource(name="promemService")
	ProjectmemberService promemService;
	

	@RequestMapping("/project")
	public String projectmain(HttpSession session) {
		
		session.setAttribute("reqId", "1");
		return "tiles/board/issuecontentmenu";
	}
	
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	@RequestMapping("/eachproject")
	public String eachproject(HttpSession session) {
		
		session.setAttribute("reqId", "1");
		
		return "board/eachproject";
	}
	
	// 카테고리 내역 조회
	@RequestMapping("/eachproject2")
	public String eachproject2(HttpSession session, Model model) {
		
		session.setAttribute("reqId", "1");
		String memId = "cony@naver.com";
		List<CategoryVo> categorylist = promemService.categorylist(memId);
		String reqId = (String)session.getAttribute("reqId");
		
//		List<IssueVo> issuelist = promemService.issuelist(reqId);		
		
		
//		model.addAttribute("issuelist", issuelist);
//		model.addAttribute("categorylist", categorylist);
//		System.out.println(categorylist);
		
		return "tiles/board/issuelist";
	}
	
	// 이슈리스트 출력
	@RequestMapping("/issuelist")
	public String getissuelist(@ModelAttribute("issueVo") IssueVo issueVo, HttpSession session, Model model) throws Exception{
		
		String reqId = (String)session.getAttribute("reqId");
		 
//		IssueVo issueVo = new IssueVo();
		issueVo.setReqId(reqId);
		
		/** EgovPropertyService.sample */
		issueVo.setPageUnit(propertiesService.getInt("pageUnit"));
		issueVo.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(issueVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(issueVo.getPageUnit());
		paginationInfo.setPageSize(issueVo.getPageSize());

		issueVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		issueVo.setLastIndex(paginationInfo.getLastRecordIndex());
		issueVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<IssueVo> resultList = promemService.issuelist(issueVo);
		model.addAttribute("issuelist", resultList);

		int totCnt = promemService.issuePagingListCnt(issueVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		String memId = "cony@naver.com";
		List<CategoryVo> categorylist = promemService.categorylist(memId);
		model.addAttribute("categorylist", categorylist);
		
		
		return "tiles/board/issuelist2";
	}
	
	// 각 이슈 상세보기
	@RequestMapping("/eachissueDetail")
	public String geteachissue(String issueId, HttpSession session, Model model) {
		
		IssueVo issuevo = promemService.geteachissue(issueId);
		
		model.addAttribute("issuevo", issuevo);
		 
		return "tiles/board/issueDetail";
	}
	
	// 이슈 작성 View
	@RequestMapping("/insertissueView")
	public String insertissueView(HttpSession session) {

		return "tiles/board/issueInsert";
	}
	
	// 이슈 작성
	@RequestMapping("/insertissue")
	public String insertissue(IssueVo issueVo, HttpSession session, Model model) {
		
		String reqId = (String)session.getAttribute("reqId");
		issueVo.setReqId(reqId);
		issueVo.setMemId("cony@naver.com");
		
//		System.out.println(issueVo);
		int insertCnt = promemService.insertissue(issueVo);

		if(insertCnt>0) {		
			return "redirect:/projectMember/issuelist";
		}else {
			return "redirect:/projectMember/insertissueView";
			
		}
	}
	
	// 이슈 update View
	@RequestMapping("/updateissueView")
	public String updateissueView(String issueId, HttpSession session, Model model) {
		
		IssueVo issuevo = promemService.geteachissue(issueId);
		model.addAttribute("issueVo", issuevo);
		
		return "tiles/board/issueUpdate";
	}
	
	// 이슈 update 
	@RequestMapping("/updateissue")
	public String updateissue(IssueVo issueVo, HttpSession session, Model model) {
		
		String reqId = (String)session.getAttribute("reqId");
		issueVo.setReqId(reqId);
		issueVo.setMemId("cony@naver.com");
		
		int insertCnt = promemService.insertissue(issueVo);
		
		if(insertCnt>0) {		
			return "redirect:/projectMember/issuelist";
		}else {
			return "redirect:/projectMember/updateissueView";
			
		}
	}
	
	
	// 이슈 delete 
	@RequestMapping("/delissue")
	public String delissue(String issueId, HttpSession session, Model model) {
		
		
		int delCnt = promemService.delissue(issueId);
		System.out.println(delCnt);
		
		if(delCnt>0) {		
			return "redirect:/projectMember/issuelist";
		}else {
			return "redirect:/projectMember/eachissueDetail?issue="+issueId;
		}
	}
	
	
	
	
	
	
}
