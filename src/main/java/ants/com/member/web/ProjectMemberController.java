package ants.com.member.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.file.model.PublicFileVo;
import ants.com.file.web.FileController;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.model.ReqVo;
import ants.com.member.service.ProjectmemberService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/projectMember")
@Controller
public class ProjectMemberController {
	private static final Logger logger = LoggerFactory.getLogger(ProjectMemberController.class);

	@Resource(name="promemService")
	ProjectmemberService promemService;
	
	@Resource(name="memBoardService")
	memBoardService memBoardService;
	
	@Autowired
	FileController filecontroller;

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
		
		session.setAttribute("projectId", "1");
		session.setAttribute("memId", "pl1");
		
		return "board/eachproject";
	}
	
	// 이슈리스트 출력
	@RequestMapping("/issuelist")
	public String getissuelist(@ModelAttribute("issueVo") IssueVo issueVo, HttpSession session, Model model) throws Exception{
		
		String reqId = (String)session.getAttribute("projectId");
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
		
//		String memId = "cony@naver.com";
//		List<CategoryVo> categorylist = promemService.categorylist(memId);

//		model.addAttribute("categorylist", categorylist);
		
		return "tiles/board/issuelist2";
	}
	
	// 각 이슈 상세보기
	@RequestMapping("/eachissueDetail")
	public String geteachissue(String issueId, HttpSession session, Model model) throws SQLException, IOException {
		
		IssueVo issuevo = promemService.geteachissue(issueId);	
		
		PublicFileVo pfv = new PublicFileVo();
		pfv.setReqId((String)session.getAttribute("projectId"));
		pfv.setCategoryId("3");
		pfv.setSomeId(issueId);
		
		filecontroller.getfiles(pfv, model);

		model.addAttribute("issuevo", issuevo);	
		model.addAttribute("memId", issuevo.getMemId());
		
		ReplyVo replyVo = new ReplyVo();
		replyVo.setReqId("1");
		replyVo.setSomeId(issueId);
		replyVo.setMemId("pl1");
		replyVo.setCategoryId("3");
		
		List<ReplyVo> replylist= memBoardService.replylist(replyVo);
		model.addAttribute("replylist", replylist);
		 
		return "tiles/board/issueDetail";
	}
	
	
	// 이슈 작성 View
	@RequestMapping("/insertissueView")
	public String insertissueView(HttpSession session) {

		return "tiles/board/issueInsert";
	}
	
	// 이슈 작성
	@RequestMapping("/insertissue")
	public String insertissue(IssueVo issueVo, MultipartHttpServletRequest multirequest, HttpSession session, Model model) {
		
		String reqId = (String)session.getAttribute("projectId");
		issueVo.setReqId(reqId);
		issueVo.setMemId("pl1");
		issueVo.setCategoryId("3");
		
		if(issueVo.getTodoId() == null) {
			issueVo.setTodoId("");
		}
		 
		
		
		System.out.println(issueVo);
		String insertseq  = promemService.insertissue(issueVo);
		
		System.out.println(insertseq);
		
		PublicFileVo pfv = new PublicFileVo();
		pfv.setCategoryId("3");
		pfv.setReqId("1");
		pfv.setSomeId(insertseq);
		
		filecontroller.insertfile(pfv, model, multirequest);

		
		return "redirect:/projectMember/issuelist";

	}
	
	
	// 이슈 mytodolist
	@RequestMapping("/mytodolist")
	public String mytodolist(HttpSession session, Model model) {
		String memId = "pl1";
		String reqId = (String)session.getAttribute("projectId");
		
		ProjectMemberVo promemVo = new ProjectMemberVo();
		promemVo.setMemId(memId);
		promemVo.setReqId(reqId);
		
		List<TodoVo> mytodolist = promemService.mytodolist(promemVo);
		model.addAttribute("todolist", mytodolist);
		
		System.out.println("todolist : " + mytodolist);
		
		return "jsonView";
		
	}
	
	
	
	// 이슈 update View
	@RequestMapping("/updateissueView")
	public String updateissueView(String issueId, Model model) {
		
		IssueVo issuevo = promemService.geteachissue(issueId);
		
		PublicFileVo pfv = new PublicFileVo();
		pfv.setCategoryId("3");
		pfv.setReqId("1");
		pfv.setSomeId(issueId);
		
		filecontroller.getfiles(pfv, model);
		
		
		model.addAttribute("issueVo", issuevo);
		
		return "tiles/board/issueUpdate";
	}
	
	// 이슈 update 
	@RequestMapping("/updateissue")
	public String updateissue(IssueVo issueVo, String delfile, MultipartHttpServletRequest multirequest, HttpSession session, Model model ) {
		
		String reqId = (String)session.getAttribute("projectId");
		issueVo.setReqId(reqId);
		issueVo.setMemId("pl1");
		
		int insertCnt = promemService.updateissue(issueVo);
		
		PublicFileVo pfv = new PublicFileVo();
		pfv.setCategoryId("3");
		pfv.setReqId("1");
		pfv.setSomeId(issueVo.getIssueId());
		
		
		filecontroller.delfiles(delfile);
		
		filecontroller.insertfile(pfv, model, multirequest);
		
		
		
		if(insertCnt>0) {		
			return "redirect:/projectMember/eachissueDetail?issueId="+issueVo.getIssueId();
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
