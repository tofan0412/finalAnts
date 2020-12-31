package ants.com.board.memBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.member.model.ProjectMemberVo;
import ants.com.member.service.ProjectmemberService;

@Controller
public class GanttController {
	
	@Resource(name="promemService")
	ProjectmemberService promemService;
	
	@RequestMapping("/ganttView")
	public String ganttView(HttpSession session, Model model) {
		String reqId = (String) session.getAttribute("projectId");
		List<ProjectMemberVo> promemList  = promemService.proMemListIn(reqId);
		model.addAttribute("promemList", promemList);
		
		return "tiles/gantt/gantt2";
	}
	
}
