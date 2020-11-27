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
	
	@RequestMapping("/loginView")
	public String loginView() {
		logger.debug("로그인뷰 진입 ...");
		return "login";
	}
	
	@RequestMapping("/loginFunc")
	public String login(String mem_id, String mem_pass,HttpSession session, Model model) {
		logger.debug("로그인 메서드 진입 ...{}", mem_id);
		Map<String, String> memInfo = new HashMap<>();
		memInfo.put("mem_id", mem_id);
		memInfo.put("mem_pass", mem_pass);
		
		MemberVo memberVo = memberService.login(memInfo);
		
		logger.debug("DB에서 찾은 값은 ? {}", memberVo);
		if (memberVo != null) {
			session.setAttribute("s_member", memberVo);
			return "success";
		}
		return "login";
	}
	
	@RequestMapping("/project")
	public String test() {
		return "content/project";
	}
	
	
	
}
