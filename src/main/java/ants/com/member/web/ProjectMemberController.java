package ants.com.member.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.model.MemberVo;
import ants.com.member.service.MemberServiceI;
import ants.com.member.service.ProjectmemberServiceI;

@RequestMapping("/projectMember")
@Controller
public class ProjectMemberController {
	private static final Logger logger = LoggerFactory.getLogger(ProjectMemberController.class);
	
	@Resource(name="memberService")
	MemberServiceI memberService;
	
	@Resource(name="promemService")
	ProjectmemberServiceI promemService;
	
	
	
	@RequestMapping("/project")
	public String projectmain() {
		
		return "content/project";
	}
	
	
	@RequestMapping("/eachproject")
	public String eachproject() {
		
		return "board/eachproject";
	}
	
	
	@RequestMapping("/issuelist")
	public String getissuelist(String req_id, HttpSession session, Model model) {
		
//		 MemberVo memberVo = (MemberVo)session.getAttribute("s_member");
//		 String mem_id = memberVo.getMem_id();
		System.out.println("req_id : " + req_id);
//		String req_id = "1";
		List<IssueVo> issuelist = promemService.issuelist(req_id);
		
		System.out.println("issuelist : " + issuelist);
		model.addAttribute("issuelist", issuelist);
		 
		return "board/issuelist";
	}
	
	@RequestMapping("/eachissue")
	public String geteachissue(String issue_id, HttpSession session, Model model) {
		
//		 MemberVo memberVo = (MemberVo)session.getAttribute("s_member");
//		 String mem_id = memberVo.getMem_id();
		System.out.println("issue_id : " + issue_id);
//		String req_id = "1";
		IssueVo issuevo = promemService.geteachissue(issue_id);
		
		model.addAttribute("issuevo", issuevo);
		 
		return "board/issueDetail";
	}
	
	
}
