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
	
	
	
	@RequestMapping(path="/loginFunc", params= {"mem_id"}, method = RequestMethod.GET )							
	public String process(String mem_id, String mem_pass, MemberVo memberVo, HttpSession session, Model model) {
		
		logger.debug("LoginCOntroller.process() {} / {} / {}", mem_id, mem_pass, memberVo);	
		logger.debug("user_id : {}", mem_id);	

		
		MemberVo dbMember = memberService.getMember(mem_id);
		logger.debug("dbMember : {}", dbMember);
		
		
		if(dbMember != (null) && memberVo.getMem_pass().equals(dbMember.getMem_pass()) ) {
			session.setAttribute("S_MEMBER", memberVo);
			model.addAttribute("to_day", new Date());
			
			if(dbMember.getMem_type().equals("pl")) {
				return "manager/pl_main";
			}else if(dbMember.getMem_type().equals("pm")) {
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
	
	
	
	/*, BindingResult br ,@RequestPart("realFilename") MultipartFile file*/
	@RequestMapping(path="/memberRegist", method = RequestMethod.POST)							
	public String memberRegist(String mem_id, MemberVo memberVo, BindingResult br ,@RequestPart("realFilename") MultipartFile file) { 
		
		logger.debug("memberVo : {}", memberVo );
		logger.debug("filename : {} / realFilename : {} / size : {}", file.getName(), file.getOriginalFilename(), file.getSize());
		
	
//		logger.debug("br.hasErrors() : {}", br.hasErrors() );
//		if(br.hasErrors()) {					// 왜 안될까...... 메세지는 제대로 뜨는데...
//			return "member/memberRegist";	
//		}
		
		// jsp에서 넘어오는 <input type = file name="realfilename> 이름이 겹쳐서 mapping이 값을 넣어주려고 하기 때문에 이름이 겹치지 않게 해주어야 한다.
		String Filename = "D:\\upload\\" + file.getOriginalFilename();
		File uploadFile = new File(Filename);
		
		// 파일 업로드		// 이미지 파일 realname, name 둘중 하나만 값이 있으면 오류발생 둘다 널이면 괜찮음
		try {
			file.transferTo(uploadFile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		logger.debug("---------------------통과-------------------");
		
		
		memberVo.setMem_filepath(Filename);
		memberVo.setMem_filename(file.getOriginalFilename());
		
//		 사용자 정보 등록   ,real_Filename,file.getOriginalFilename()     , real_Filename, file.getOriginalFilename()
//		memberVo = new MemberVo();
		
		logger.debug("mem_id : {}", mem_id);
		logger.debug("memberVo : {}", memberVo);
		int insertCnt = memberService.insertMember(memberVo);
		logger.debug("insertCnt : {}", insertCnt);
		
		//try {
		if(insertCnt == 1){
		
			return "main";
			
			
		//}catch() {
			
		//}
		
		
		}else {
			return "redirect:member/memberRegist";
		}
	}
	
	
	
}
