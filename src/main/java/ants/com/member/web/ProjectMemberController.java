package ants.com.member.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.chatting.model.ChatMemberVo;
import ants.com.chatting.service.ChatService;
import ants.com.file.model.PublicFileVo;
import ants.com.file.view.FileController;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.service.MemberService;
import ants.com.member.service.ProjectmemberService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/projectMember")
@Controller
public class ProjectMemberController {

	@Resource(name="promemService")
	ProjectmemberService promemService;
	
	@Resource(name="memBoardService")
	memBoardService memBoardService;
	
	@Resource(name="memberService")
	MemberService memberService;
	
	@Resource(name="chatService")
	ChatService chatService;
	
	@Autowired
	FileController filecontroller;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	@RequestMapping("/eachproject")
	public String eachproject(HttpSession session) {
		
		session.setAttribute("projectId", "1");
		session.setAttribute("memId", "pl1");
		
		return "board/eachproject";
	}
	
	// 나의 이슈리스트 출력
	@RequestMapping("/myissuelist")
	public String getMyissuelist(@ModelAttribute("issueVo") IssueVo issueVo, HttpSession session, Model model) throws Exception{
		
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		issueVo.setMemId(memId);
		session.setAttribute("categoryId", "8");
		
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

		List<IssueVo> myresultList = promemService.myissuelist(issueVo);
		model.addAttribute("myissuelist", myresultList);

		int totCnt = promemService.myissuePagingListCnt(issueVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		if(issueVo.getSort() == null || issueVo.getSort().equals("1")) {
			model.addAttribute("sort", "1");
		}else {
			model.addAttribute("sort", "2");
		}
		
		if(issueVo.getSearchKeyword() != null) {			
			session.setAttribute("searchKeyword", issueVo.getSearchKeyword());
			session.setAttribute("searchCondition",issueVo.getSearchCondition());
			session.setAttribute("issueKind", issueVo.getIssueKind());
			session.setAttribute("pageIndex", issueVo.getPageIndex());
		}
		
		return "tiles/board/MY_issueList";
	}
	
	
	
	// 해당 프로젝트 이슈리스트 출력
	@RequestMapping("/issuelist")
	public String getissuelist(@ModelAttribute("issueVo") IssueVo issueVo, HttpSession session, Model model) throws Exception{
		
		session.setAttribute("categoryId", "3");
		String reqId = (String)session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		issueVo.setMemId(memId);
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
		
		if(issueVo.getSort() == null || issueVo.getSort().equals("1")) {
			model.addAttribute("sort", "1");
		}else {
			model.addAttribute("sort", "2");
		}
		
		if(issueVo.getSearchKeyword() != null) {			
			session.setAttribute("searchKeyword", issueVo.getSearchKeyword());
			session.setAttribute("searchCondition",issueVo.getSearchCondition());
			session.setAttribute("issueKind", issueVo.getIssueKind());
			session.setAttribute("pageIndex", issueVo.getPageIndex());
		}
		
		return "tiles/board/issuelist2";
	}
	
	// 각 이슈 상세보기
	@RequestMapping("/eachissueDetail")
	public String geteachissue(IssueVo issueVo, String reqId, HttpSession session, Model model) throws SQLException, IOException {
		
		IssueVo issuevo = promemService.geteachissue(issueVo.getIssueId());	// 이슈상세조회
		
		if(session.getAttribute("projectId") !=  null) {
			reqId = (String)session.getAttribute("projectId");
		}
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		System.out.println("reqId : " + reqId);
		PublicFileVo pfv = new PublicFileVo("3",issueVo.getIssueId() , reqId);//파일조회
		filecontroller.getfiles(pfv, model);

		ReplyVo replyVo = new ReplyVo(issueVo.getIssueId(), "3", reqId,memId);	//댓글 조회
		List<ReplyVo> replylist= memBoardService.replylist(replyVo);
		
		model.addAttribute("issuevo", issuevo);	
		model.addAttribute("replylist", replylist);
		 
		return "tiles/board/issueDetail";
	}
	
	
	// 이슈 작성 View
	@RequestMapping("/insertissueView")
	public String insertissueView(HttpSession session, Model model) {
		
		String issueSeq = promemService.getissueid();
		model.addAttribute("issueSeq", issueSeq);
		return "tiles/board/issueInsert2";
	}
	
	// 이슈 작성
	@RequestMapping("/insertissue")
	public String insertissue(IssueVo issueVo, MultipartHttpServletRequest multirequest, HttpSession session, Model model) {
		
		String reqId = (String)session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		issueVo.setReqId(reqId);
		issueVo.setMemId(memId);
		issueVo.setCategoryId("3");
		
		if(issueVo.getTodoId() == null) {
			issueVo.setTodoId("");
		}

		promemService.insertissue(issueVo);
	
		return "redirect:/projectMember/issuelist";

	}
	
	// 내 이슈 작성 View
	@RequestMapping("/insertmytodoissueView")
	public String insertmytodoissueView(TodoVo todoVo, HttpSession session, Model model) {
		System.out.println("왔니");
		String issueSeq = promemService.getissueid();
		model.addAttribute("issueSeq", issueSeq);
		model.addAttribute("todoVo", todoVo);
		
		return "tiles/board/issueInsert3";
	}
	
	
	
	// 이슈 글 작성시 mytodolist ajax호출
	@RequestMapping("/mytodolist")
	public String mytodolist(HttpSession session, Model model) {
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
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
	public String updateissueView(IssueVo issueVo, Model model, HttpSession session) {
		
		String reqId = (String)session.getAttribute("projectId");
		IssueVo issuevo = promemService.geteachissue(issueVo.getIssueId());
		
		PublicFileVo pfv = new PublicFileVo("3",issueVo.getIssueId() ,reqId);
		
		filecontroller.getfiles(pfv, model);
				
		model.addAttribute("issueVo", issuevo);
		
		return "tiles/board/issueUpdate";
	}
	
	

	// 이슈 update 
	@RequestMapping("/updateissue")
	public String updateissue(IssueVo issueVo, String delfile, MultipartHttpServletRequest multirequest,
					HttpSession session, Model model, RedirectAttributes ra ) {
		
		String reqId = (String)session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		issueVo.setReqId(reqId);
		issueVo.setMemId(memId);
		
		int insertCnt = promemService.updateissue(issueVo);
		
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
		
		if(delCnt>0) {		
			return "redirect:/projectMember/issuelist";
		}else {
			return "redirect:/projectMember/eachissueDetail?issue="+issueId;
		}
	}
	
	// reqId 이용해서 해당 프로젝트에 참여하고 있는 회원 리스트 뽑아오기
	@ResponseBody
	@RequestMapping("/proMemList")
	public List<ProjectMemberVo> proMemList(String reqId){
		List<ProjectMemberVo> list = promemService.proMemList(reqId);
		
		// 회원 프로필 이미지를 저장한다.
		for (int i = 0; i < list.size(); i++) {
			MemberVo memInfo = new MemberVo();
			memInfo.setMemId(list.get(i).getMemId());

			MemberVo memberVo = memberService.getMember(memInfo);
			list.get(i).setMemFilepath(memberVo.getMemFilepath());
		}
		return list;
	}
	
	// 서버단에서, 채팅에 참여하고 있는 인원은 제외한 프로젝트 멤버 불러오기
	@RequestMapping("/canInviteProMemList")
	@ResponseBody
	public List<ProjectMemberVo> canInviteProMemList(String reqId, String cgroupId){
		// 1-1. 프로젝트에 참여중인 회원 목록 불러오기
		List<ProjectMemberVo> list = promemService.proMemList(reqId);
		
		// 1-2. 회원 프로필 경로 저장하기
		for (int i = 0; i < list.size(); i++) {
			MemberVo memInfo = new MemberVo();
			memInfo.setMemId(list.get(i).getMemId());

			MemberVo memberVo = memberService.getMember(memInfo);
			list.get(i).setMemFilepath(memberVo.getMemFilepath());
		}
		
		// 2. 이 중에서 이미 채팅에 참여하고 있는 회원은 제외해야 한다.
		List<ChatMemberVo> chatMemList = chatService.readCgroupMembers(cgroupId);
		
		// 이미 채팅에 참여하고 있는 놈들은 아이디를 수정한다.
		for(int i = 0 ; i < list.size() ; i++) {
			for (int j = 0 ; j < chatMemList.size(); j++) {
				if(list.get(i).getMemId().equals(chatMemList.get(j).getMemId())) {
//					list.get(i).setMemId("exceptIt!");
					list.remove(i);
					i--;
					break;
				}
			}
		}
		return list;
	}
	
	// 프로젝트멤버 상태를 변경한다.
	@RequestMapping("/promemUpdate")
	@ResponseBody
	public String promemUpdate(ProjectMemberVo projectMemberVo) {
		projectMemberVo.setPromemStatus("OUT");
		int result = promemService.promemUpdate(projectMemberVo);
		if (result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
}
