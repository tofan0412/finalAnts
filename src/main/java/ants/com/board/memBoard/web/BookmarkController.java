package ants.com.board.memBoard.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.memBoard.model.AllBookMarkVo;
import ants.com.board.memBoard.model.BookmarkVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/bookmark")
@Controller
public class BookmarkController {

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="memBoardService")
	memBoardService memBoardService;
	
	// 북마크 조회
	@RequestMapping(path ="/getbookmark")
	public String getbookmark(ProjectMemberVo promemVo, Model model, HttpSession session) throws SQLException, IOException {
		
		String reqId = (String)session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		promemVo.setMemId(memId);
		promemVo.setReqId(reqId);
		
		List<BookmarkVo> booklist = memBoardService.getbookmark(promemVo);
		model.addAttribute("bookmarklist", booklist);
		System.out.println("booklist :" + booklist);
		
		return "jsonView";
	}
	
	// 북마크 추가
	@RequestMapping(path ="/addbookmark")
	public String addbookmark(BookmarkVo bookmarkVo, Model model, HttpSession session) throws SQLException, IOException {
		
		String reqId = (String)session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		bookmarkVo.setMemId(memId);
		bookmarkVo.setReqId(reqId);		
		
		memBoardService.insertbookmark(bookmarkVo);
		
		return "jsonView";
	}
	
	// 북마크 삭제
	@RequestMapping(path ="/removebookmark")
	public String removebookmark(BookmarkVo bookmarkVo, Model model, HttpSession session) throws SQLException, IOException {
		

		if(session.getAttribute("projectId") != null) {
			String reqId = (String)session.getAttribute("projectId");
			bookmarkVo.setReqId(reqId);			
		}
		
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();		
		bookmarkVo.setMemId(memId);
		
		memBoardService.removebookmark(bookmarkVo);
		
		return "jsonView";
	}
	
	// 북마크 조회
	@RequestMapping(path ="/getallbookmark")
	public String getallbookmark(@ModelAttribute("AllBookMarkVo") AllBookMarkVo allbookmarkVo, Model model, HttpSession session) throws SQLException, IOException {
		
		session.setAttribute("categoryId", "9");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		allbookmarkVo.setMemId(memId);
		
		
		/** EgovPropertyService.sample */
		allbookmarkVo.setPageUnit(propertiesService.getInt("pageUnit"));
		allbookmarkVo.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(allbookmarkVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(allbookmarkVo.getPageUnit());
		paginationInfo.setPageSize(allbookmarkVo.getPageSize());

		allbookmarkVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		allbookmarkVo.setLastIndex(paginationInfo.getLastRecordIndex());
		allbookmarkVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		List<BookmarkVo> booklist = memBoardService.getallbookmark(allbookmarkVo);
		model.addAttribute("bookmarklist", booklist);
		System.out.println("booklist :" + booklist);
		
		int totCnt = memBoardService.bookmarkPagingListCnt(allbookmarkVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		if(allbookmarkVo.getSort() == null || allbookmarkVo.getSort().equals("1")) {
			model.addAttribute("sort", "1");
		}else {
			model.addAttribute("sort", "2");
		}
		
		if(allbookmarkVo.getSearchKeyword() != null) {			
			session.setAttribute("searchKeyword", allbookmarkVo.getSearchKeyword());
			session.setAttribute("searchCondition",allbookmarkVo.getSearchCondition());
			session.setAttribute("issueKind", allbookmarkVo.getIssueKind());
			session.setAttribute("pageIndex", allbookmarkVo.getPageIndex());
		}
		
		return "tiles/board/bookmarklist";
	}
	
}
