package ants.com.board.memBoard.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.memBoard.model.BookmarkVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;

@RequestMapping("/bookmark")
@Controller
public class BookmarkController {

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
		
		String reqId = (String)session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		bookmarkVo.setMemId(memId);
		bookmarkVo.setReqId(reqId);		
		
		memBoardService.removebookmark(bookmarkVo);
		
		return "jsonView";
	}
	
	// 북마크 조회
	@RequestMapping(path ="/getallbookmark")
	public String getallbookmark(ProjectMemberVo promemVo, Model model, HttpSession session) throws SQLException, IOException {
		
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		promemVo.setMemId(memId);
		
		List<BookmarkVo> booklist = memBoardService.getallbookmark(promemVo);
		model.addAttribute("bookmarklist", booklist);
		System.out.println("booklist :" + booklist);
		
		return "tiles/board/bookmarklist";
	}
	
}
