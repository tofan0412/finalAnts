package ants.com.member.web;


import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.member.service.MemberService;
import ants.com.member.service.ProjectService;
import ants.com.member.service.ProjectmemberService;

@RequestMapping("/project")
@Controller
public class ProjectController {
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Resource(name = "projectService")
	private ProjectService projectService;

	@RequestMapping("/ProList")
		
	
	
}
