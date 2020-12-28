package ants.com.common.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ants.com.common.service.CommonService;

@RequestMapping("/common")
@Controller
public class CommonController {

	@Resource(name = "commonService")
	private CommonService commonService;
	
	// Left.jsp에서 개인 메뉴를 사용할 때는 세션에 저장된 projectId를 지운다.
	
	@RequestMapping("/setChatStatusNone")
	@ResponseBody
	public String setChatStatusNone(HttpSession session ) {
		session.setAttribute("chatStatus", "none");
		return "success";
	}
}
