package ants.com.member.web;

import javax.annotation.Resource;
import javax.servlet.annotation.MultipartConfig;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.member.model.MemberVo;
import ants.com.member.service.MemberService;

@MultipartConfig
@Controller
public class Profile_Controller {
	
	@Resource(name = "memberService")
	private MemberService memberService;
	
		
	@RequestMapping("/profileImgView")
	public String profileImgView(MemberVo memberVo, Model model) {	// public ProfileImgView profileImgView(String userid, Model model)
		//응답으로 생성하려고 하는 것 : 이미지 파일을 읽어서 output stream 객체에 쓰는 것
		memberVo = memberService.getMember(memberVo);
		model.addAttribute("filepath", memberVo.getMemFilepath());
		
		return "profileImgView"; 									// return new ProfileImgView();
		// filepath 를 가지고
		// view package -> profileImgView.java 로 이동
		
		// application-context.xml 에 bean 객체 등록
		
	}
}
