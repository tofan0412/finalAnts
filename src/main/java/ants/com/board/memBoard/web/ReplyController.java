package ants.com.board.memBoard.web;

import java.io.IOException;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.service.memBoardService;

@RequestMapping("/reply")
@Controller
public class ReplyController {

	@Resource(name="memBoardService")
	memBoardService memBoardService;
	
	
	
	// 댓글 작성
	@RequestMapping(path ="/insertreply")
	public String insertapply(ReplyVo replyVo, Model model, HttpSession session
								,RedirectAttributes ra, HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
		
//		
//		MemberVo membervo = (MemberVo) session.getAttribute("SMEMBER");
		
//		ReplyVo replyvo = new ReplyVo();		
//		replyvo.setMemId(membervo.getMemId());
		
		replyVo.setMemId("pl1");
		replyVo.setCategoryId("3");		
		replyVo.setReqId("1");
		
		System.out.println("replyvo : " + replyVo );
		
		
		memBoardService.insertreply(replyVo);
		
		model.addAttribute("issueId", replyVo.getSomeId());
	
		return "jsonView";
//		return this.controller.geteachissue(replyVo.getSomeId(), session, model);
//		return "redirect:/promember/eachissueDetail?issueId="+replyVo.getSomeId();
	}
	
	
	// 댓글 삭제
	@RequestMapping(path ="/delreply")
	public String deleteapply(ReplyVo replyVo, Model model, HttpSession session) throws SQLException, IOException {
		
		memBoardService.delreply(replyVo.getReplyId());
		
		return "redirect:/board/boardDetail?someId="+replyVo.getSomeId();
	}
	
	
	
	
	
}
