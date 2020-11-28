package ants.com.member.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.member.model.MemberVo;
import ants.com.member.service.MemberServiceI;

@RequestMapping("/projectMember")
@Controller
public class ProjectMemberController {
	private static final Logger logger = LoggerFactory.getLogger(ProjectMemberController.class);
	
	@Resource(name="memberService")
	MemberServiceI memberService;
	
	
	

	
	@RequestMapping("/project")
	public String test() {
		return "content/project";
	}
	
	
	
}
