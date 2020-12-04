package ants.com.member.web;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.member.model.ReqVo;
import ants.com.member.service.ProjectService;

@RequestMapping("/project")
@Controller
public class ProjectController {
	
	@Resource(name = "projectService")
	private ProjectService projectService;

	@RequestMapping("/readReqList")
	// 나에게 요청된 요구사항정의서 목록을 살펴본다. 
	public String readReqList(String plId, Model model) {
		List<ReqVo> reqList = projectService.readReqList(plId);
		
		model.addAttribute("reqList", reqList);
		return "main.tiles/reqList";
	}
	
	
}
