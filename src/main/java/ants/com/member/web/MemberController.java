package ants.com.member.web;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	
	
	
	@RequestMapping(path="/loginFunc", params= {"mem_id"}, method = RequestMethod.GET )							
	public String process(String mem_id, String mem_pass, MemberVo memberVo, HttpSession session, Model model) {
		
		logger.debug("LoginCOntroller.process() {} / {} / {}", mem_id, mem_pass, memberVo);	
		logger.debug("user_id : {}", mem_id);	

		
		MemberVo dbMember = memberService.getMember(mem_id);
		logger.debug("dbMember : {}", dbMember);
		
		
		if(dbMember != (null) && memberVo.getMem_pass().equals(dbMember.getMem_pass()) ) {
			session.setAttribute("S_MEMBER", memberVo);
			model.addAttribute("to_day", new Date());
			return "main";
			
		}else {
			return "member/login";
		}
			
	}
	
	
	
	
}
