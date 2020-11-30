package ants.com.member.web;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import ants.com.member.model.MemberVo;
import ants.com.member.service.MemberServiceI;

@MultipartConfig
@RequestMapping("/member")
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Resource(name="memberService")
	MemberServiceI memberService;
	
	
	@RequestMapping("/mainView")
	public String mainView() {
		logger.debug("메인뷰 진입");
		return "main.tiles/main";
	}
	
	
	@RequestMapping("/loginView")
	public String viewlogin() {
		logger.debug("MemberController loginView");
		return "member/login";
	}
	
	
	
	@RequestMapping(path="/loginFunc", method = RequestMethod.GET )							
	public String process(String memId, String memPass, MemberVo memberVo, HttpSession session, Model model) {
		
		logger.debug("LoginCOntroller - memId : {} / memPass: {} ", memId, memPass);	

		
		MemberVo dbMember = memberService.getMember(memId);
		logger.debug("dbMember : {}", dbMember);
		
		
		if(dbMember != (null) && memberVo.getMemPass().equals(dbMember.getMemPass()) ) {
			session.setAttribute("S_MEMBER", memberVo);
			model.addAttribute("to_day", new Date());
			
			if(dbMember.getMemType().equals("pl")) {
				return "manager/pl_main";
			}else if(dbMember.getMemType().equals("pm")) {
				return "manager/pm_main";
			}else {
				return "main";
			}
			
		}else {
			return "member/login";
		}
			
	}
	
	
	
	
	@RequestMapping(path= "/memberRegistview", method = RequestMethod.GET)	
	public String getView() {
		logger.debug("memberRegist-Controller.getView()");
		return "member/memberRegist";	
	}
	
	
	
	@RequestMapping(path="/memberRegist", method = RequestMethod.POST)							
	public String memberRegist(String memId, MemberVo memberVo, BindingResult br ,@RequestPart("realFilename") MultipartFile file) { 
		
		logger.debug("memberVo : {}", memberVo );
		logger.debug("filename : {} / realFilename : {} / size : {}", file.getName(), file.getOriginalFilename(), file.getSize());
		
	
//		logger.debug("br.hasErrors() : {}", br.hasErrors() );
//		if(br.hasErrors()) {					
//			return "member/memberRegist";	
//		}
		
		String Filename = "D:\\upload\\" + file.getOriginalFilename();
		File uploadFile = new File(Filename);
		
		try {
			file.transferTo(uploadFile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		logger.debug("---------------------통과-------------------");
		
		
		memberVo.setMemFilepath(Filename);
		memberVo.setMemFilename(file.getOriginalFilename());
		
		
		logger.debug("memId : {}", memId);
		logger.debug("memberVo : {}", memberVo);
		int insertCnt = memberService.insertMember(memberVo);
		logger.debug("insertCnt : {}", insertCnt);
		
		if(insertCnt == 1){
			return "main";
		}else {
			return "redirect:member/memberRegist";
		}
	}
	
	
	
}
