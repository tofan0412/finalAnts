package ants.com.member.web;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ants.com.member.model.ProjectVo;
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
		return "tiles/project/projectList";
	}
	
	// 요구사항 정의서에 대한 프로젝트를 생성한다 in DB
	@RequestMapping(value="/insertProject")
	public String insertProject(ProjectVo projectVo) {
		return projectService.insertProject(projectVo);
	}
	
	
}
