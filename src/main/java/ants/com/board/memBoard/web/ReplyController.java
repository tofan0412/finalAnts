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
import ants.com.member.model.MemberVo;

@RequestMapping("/reply")
@Controller
public class ReplyController {

	@Resource(name="memBoardService")
	memBoardService memBoardService;
	
	
	
	// 댓글 작성
	@RequestMapping(path ="/insertreply")
	public String insertapply(ReplyVo replyVo, Model model, HttpSession session
								,RedirectAttributes ra, HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
		
		MemberVo membervo = (MemberVo) session.getAttribute("SMEMBER");
				
		replyVo.setMemId(membervo.getMemId());		
		replyVo.setCategoryId(replyVo.getCategoryId());		
		
		System.out.println("replyvo : " + replyVo );
		
		
		memBoardService.insertreply(replyVo);
		
		model.addAttribute("someId", replyVo.getSomeId());
	
		return "jsonView";
//		return this.controller.geteachissue(replyVo.getSomeId(), session, model);
//		return "redirect:/promember/eachissueDetail?issueId="+replyVo.getSomeId();
	}
	
	
	// 댓글 삭제
	@RequestMapping(path ="/delreply")
	public String deleteapply(ReplyVo replyVo, Model model, HttpSession session) throws SQLException, IOException {
		
		System.out.println(replyVo.getReplyId());
		System.out.println(replyVo.getSomeId());
		memBoardService.delreply(replyVo);
		
		return "jsonView";
	}
	
	
	
	
	
}
