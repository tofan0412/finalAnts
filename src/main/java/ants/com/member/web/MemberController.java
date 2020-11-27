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

@RequestMapping("/member")
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Resource(name="memberService")
	MemberServiceI memberService;
	
	@RequestMapping("/loginView")
	public String loginView() {
		logger.debug("로그인뷰 진입 ...");
		return "login";
	}
	
	
	@RequestMapping("/mainView")
	public String mainView() {
		logger.debug("메인뷰 진입");
		return "main.tiles/main";
	}
	
	
	@RequestMapping("/viewlogin")
	public String viewlogin() {
		logger.debug("MemberController viewlogin");
		return "member/login";
	}
	
	
	
//	@RequestMapping("/loginFunc")
//	public String login(String mem_id, String mem_pass,HttpSession session, Model model) {
//		logger.debug("MemberController loginFunc : {}", mem_id);
//		
//		MemberVo memberVo = memberService.getMember(mem_id);
//		
//		if (memberVo != null) {
//			session.setAttribute("s_member", memberVo);
//			return "success";
//		}
//		return "main";
//	}
//	
	
	
	
	
}
