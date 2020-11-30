package ants.com.member.web;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	
	
	// 로그인 페이지 이동
	@RequestMapping("/loginView")
	public String viewlogin() {
		logger.debug("MemberController loginView");
		return "member/login";
	}
	
	
	// 로그인 로직
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
	
	
	
	// 회원가입 페이지 이동
	@RequestMapping(path= "/memberRegistview", method = RequestMethod.GET)	
	public String getView() {
		logger.debug("memberRegist-Controller.getView()");
		return "member/memberRegist";	
	}
	
	
	// 회원가입 로직
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
	
	
	
	// 비밀번호 찾기 페이지 이동
	@RequestMapping(path= "/memberforgotview", method = RequestMethod.GET)	
	public String memberforgotview() {
		logger.debug("memberRegist-Controller.memberforgotview()");
		return "member/memberforgot";	
	}
	
	
	
	/** 자바 메일 발송 * @throws MessagingException * @throws AddressException **/ 
	@RequestMapping(value = "/mailsender") 
	public String mailSender(HttpServletRequest request, ModelMap mo, String mail) throws AddressException, MessagingException { 
		
		// 네이버일 경우 smtp.naver.com 을 입력합니다. 
		// Google일 경우 smtp.gmail.com 을 입력합니다. 
		
		
		// 네이버 메일 환경설정에서 "POP3/IMAP" 설정 사용으로 바꿔준다.
		String host = "smtp.naver.com"; 
		
		// POP3/IMAP 설정시 네이버에서 알려줌
		final String username = "noylit"; 		//네이버 아이디를 입력해주세요. @naver.com은 입력하지 마시구요. 
		final String password = "1234a5678"; 	//네이버 이메일 비밀번호를 입력해주세요. 
		int port=465; 							//포트번호 
		
		
		// 메일 내용 
		String recipient = "noylit@naver.com"; //받는 사람의 메일주소를 입력해주세요. 
		String subject = "메일테스트"; //메일 제목 입력해주세요. 
		String body = username+"님으로 부터 메일을 받았습니다."; //메일 내용 입력해주세요. 
		
		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성 
		
		
		// SMTP 서버 정보 설정 
		props.put("mail.smtp.host", host); 
		props.put("mail.smtp.port", port); 
		props.put("mail.smtp.auth", "true"); 
		props.put("mail.smtp.ssl.enable", "true"); 
		props.put("mail.smtp.ssl.trust", host); 
		
		//Session 생성 
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			String un=username; 
			String pw=password; 
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw); 
			} 
		}); 
		
		session.setDebug(true); //for debug 
		
		Message mimeMessage = new MimeMessage(session); //MimeMessage 생성 
		mimeMessage.setFrom(new InternetAddress("noylit@naver.com")); //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요. 
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음 
		
		
		mimeMessage.setSubject(subject); //제목셋팅 
		mimeMessage.setText(body); //내용셋팅 
		Transport.send(mimeMessage); //javax.mail.Transport.send() 이용 }
		
		
		return "main";
	}

	
}
