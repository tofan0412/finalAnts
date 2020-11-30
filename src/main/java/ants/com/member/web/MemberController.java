package ants.com.member.web;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;
import javax.json.JsonObject;
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

import org.hibernate.validator.constraints.Email;
import org.json.simple.JSONObject;
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
import ants.com.member.service.MemberService;
import net.nurigo.java_sdk.Coolsms;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@MultipartConfig
@RequestMapping("/member")
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	
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
	public String process(MemberVo memberVo, HttpSession session, Model model) {
		
		logger.debug("LoginCOntroller - memberVo : {} ", memberVo);	
		
		MemberVo dbMember = memberService.getMember(memberVo.getMemId());
		logger.debug("dbMember : {}", dbMember);
		
		if(dbMember != (null) && memberVo.getMemPass().equals(dbMember.getMemPass()) ) {
			session.setAttribute("S_MEMBER", memberVo);
			model.addAttribute("to_day", new Date());
			
			if(dbMember.getMemType().equals("pl")) {
				return "manager/pl_main";
			}else if(dbMember.getMemType().equals("pm")) {
				return "manager/pm_main";
			}else {
				return mainView();
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
	public String memberRegist(MemberVo memberVo, BindingResult br ,@RequestPart("realFilename") MultipartFile file) { 
		
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
		
		logger.debug("memId : {}", memberVo.getMemId());
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
		logger.debug("memberRegist-Controller - memberforgotview()");
		return "tiles/member/memberforgot";	
	}
	
	
	
	// 비밀번호 수정 - 이메일
	/** 자바 메일 발송 * @throws MessagingException * @throws AddressException **/ 
	@RequestMapping(value = "/mailsender") 
	public String mailSender(MemberVo memberVo, HttpServletRequest request, ModelMap mo, Model model) throws AddressException, MessagingException { 
		logger.debug("memberRegist-Controller - mailSender()");
		
		// 네이버일 경우 smtp.naver.com 을 입력합니다. 
		// Google일 경우 smtp.gmail.com 을 입력합니다. 
		
		
		// 네이버 메일 환경설정에서 "POP3/IMAP" 설정 사용으로 바꿔준다.
		String host = "smtp.naver.com"; 
		
		
		// POP3/IMAP 설정시 네이버에서 알려줌
		final String username = "noylit"; 		//네이버 아이디를 입력해주세요. @naver.com은 입력하지 마시구요. 
		final String password = "1234a5678"; 	//네이버 이메일 비밀번호를 입력해주세요. 
		int port=465; 							//포트번호 
		
		
		String uuid = UUID.randomUUID().toString();
		model.addAttribute("uuid", uuid);
		model.addAttribute("memId", memberVo.getMemId());
		// 메일 내용 
		String recipient = memberVo.getMemId(); //받는 사람의 메일주소를 입력해주세요. 
		String subject = "메일테스트"; //메일 제목 입력해주세요. 
		String body = username+"님으로 부터 메일을 받았습니다." 
					+ "키 값 : " + uuid; //메일 내용 입력해주세요. 
		
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
		mimeMessage.setFrom(new InternetAddress(memberVo.getMemId())); //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요. 
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음 
		
		
		mimeMessage.setSubject(subject); //제목셋팅 
		mimeMessage.setText(body); //내용셋팅 
		Transport.send(mimeMessage); //javax.mail.Transport.send() 이용 }
		
		
		return "member/memberPassmodified";
	}

	
	
	
	// 비밀번호 수정
	@RequestMapping(path= "/passupdate", method = RequestMethod.GET)	
	public String passupdate(MemberVo memberVo) {
		logger.debug("memberRegist-Controller - passupdate()");
		
		int updatecnt = memberService.updatePass(memberVo);
		
		if(updatecnt==1) {
			return mainView();	
		}else {
			return "member/memberPassmodified";
		}
	}
	
	
	
	// 비밀번호 수정 - 전화번호
	@RequestMapping(path= "/phonesender", method = RequestMethod.GET)	
	public String phonesender(MemberVo memberVo) {
		logger.debug("memberRegist-Controller - phonesender()");
		
			
		return "member/memberPassmodified2";
		
	}
	
	
	
	
	  @RequestMapping(path = "/sendSms")
	  public void sendSms(HttpServletRequest request) throws Exception {

		   String api_key = "NCSLFKWJHGFLOQ9K";
		    String api_secret = "HYV5DTDAVLUMKWMFB8WZVLAPZ56LUZAL";
		    net.nurigo.java_sdk.api.Message coolsms = new net.nurigo.java_sdk.api.Message(api_key, api_secret);
		    	 
		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", "01049057321"); // 수신번호
		    params.put("from", "01049057321"); // 발신번호
		    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
		    params.put("text", "Test Message"); // 문자내용    
		    params.put("app_version", "JAVA SDK v1.2"); // application name and version

		    // Optional parameters for your own needs
		    // params.put("image", "desert.jpg"); // image for MMS. type must be set as "MMS"
		    // params.put("image_encoding", "binary"); // image encoding binary(default), base64 
		    // params.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다.
		    // params.put("delay", "10"); // 0~20사이의 값으로 전송지연 시간을 줄 수 있습니다.
		    // params.put("force_sms", "true"); // 푸시 및 알림톡 이용시에도 강제로 SMS로 발송되도록 할 수 있습니다.
		    // params.put("refname", ""); // Reference name
		    // params.put("country", "KR"); // Korea(KR) Japan(JP) America(USA) China(CN) Default is Korea
		    // params.put("sender_key", "5554025sa8e61072frrrd5d4cc2rrrr65e15bb64"); // 알림톡 사용을 위해 필요합니다. 신청방법 : http://www.coolsms.co.kr/AboutAlimTalk
		    // params.put("template_code", "C004"); // 알림톡 template code 입니다. 자세한 설명은 http://www.coolsms.co.kr/AboutAlimTalk을 참조해주세요. 
		    // params.put("datetime", "20140106153000"); // Format must be(YYYYMMDDHHMISS) 2014 01 06 15 30 00 (2014 Jan 06th 3pm 30 00)
		    // params.put("mid", "mymsgid01"); // set message id. Server creates automatically if empty
		    // params.put("gid", "mymsg_group_id01"); // set group id. Server creates automatically if empty
		    // params.put("subject", "Message Title"); // set msg title for LMS and MMS
		    // params.put("charset", "euckr"); // For Korean language, set euckr or utf-8
		    // params.put("app_version", "Purplebook 4.1") // 어플리케이션 버전

		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
	  }

	
/*	
	final String URL = "https://api.coolsms.co.kr";
	private String sms_url = URL + "/sms/1.5/";
	private String senderid_url = URL + "/senderid/1.1/";
	private String api_key;
	private String api_secret;	
	private String timestamp;
	private Https https = new Https();
	Properties properties = System.getProperties();

	
	 * Set api_key, api_secret
	 
	public Coolsms(String api_key, String api_secret) {
		this.api_key = api_key;
		this.api_secret = api_secret;
	}
	
	
	 * Send messages
	 * @param set : HashMap<String, String>
	 
	public JSONObject send(HashMap<String, String> params) {
		JSONObject response = new JSONObject();
		try {
			// 기본정보 입력
			params = setBasicInfo(params);
			params.put("os_platform", properties.getProperty("os_name"));
			params.put("dev_lang", "JAVA " + properties.getProperty("java.version"));
			params.put("sdk_version", "JAVA SDK 1.1");

			// Send message 
			response = https.postRequest(sms_url + "send", params);	
		} catch (Exception e) {
			response.put("status", false);
			response.put("message", e.toString());
		}
		return response;
	}*/

}
