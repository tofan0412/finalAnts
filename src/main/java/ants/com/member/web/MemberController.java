package ants.com.member.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {

	@RequestMapping("/login/loginView")
	public String loginView() {
		return "login";
	}
	
	
}
