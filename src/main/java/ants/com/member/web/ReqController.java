package ants.com.member.web;

import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.enterprise.inject.New;
import javax.jws.WebParam.Mode;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ants.com.member.model.MemberVo;
import ants.com.member.model.ReqVo;
import ants.com.member.service.ReqService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/req")
@Controller
public class ReqController {
	private static final Logger logger = LoggerFactory.getLogger(ReqController.class);

	@Resource(name = "reqService")
	private ReqService reqService;

	/**
	 * 요구사항정의서 목록을 조회한다
	 * 
	 * @param reqVo
	 *            사용자 아이디와 일치하는 요구사항정의서
	 * @param model
	 * @param memId
	 *            사용자 아이디
	 * @return
	 */
	@RequestMapping("/reqList")
	public String selectReqList(@ModelAttribute("reqVo") ReqVo reqVo, ModelMap model,
			@RequestParam(name = "memID", required = false) String memId) {
		// member_id
		memId = "pm1";
		reqVo.setMemId(memId);

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(reqVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(reqVo.getPageUnit());
		paginationInfo.setPageSize(reqVo.getPageSize());

		reqVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		reqVo.setLastIndex(paginationInfo.getLastRecordIndex());
		reqVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		logger.debug("--reqVo 페이지정보:{},{}", reqVo.getFirstIndex(), reqVo.getLastIndex());

		List<?> reqList = reqService.reqList(reqVo);
		model.addAttribute("reqList", reqList);
		logger.debug("reqList:{}", reqList);

		int totCnt = reqService.reqListCount(reqVo);
		logger.debug("totCnt:{}", totCnt);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "tiles/member/reqList";
	}

	/**
	 * 요구사항정의서 등록화면을 조회한다
	 * 
	 * @param reqVo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/reqInsertView")
	public String insertReqView(@ModelAttribute("reqVo") ReqVo reqVo, Model model) {
		model.addAttribute("reqVo", reqVo);
		return "tiles/member/reqInsert";
	}

	/**
	 * 요구사항정의서를 등록한다.
	 * 
	 * @param reqVo
	 *            - 등록할 요구사항정의서정보가 담긴 Vo
	 * @return
	 */
	@RequestMapping(value = "/reqInsert", method = RequestMethod.POST)
	public String insertReq(@ModelAttribute("reqVo") ReqVo reqVo, Model model) {
		logger.debug("등록할 요구사항 정의서 정보:{}", reqVo);

		int cnt = reqService.reqInsert(reqVo);
		logger.debug("요구사항정의서 등록 결과...:{}", cnt);

		if (cnt == 1) {
			return "redirect:/req/reqList";
		} else {
			model.addAttribute(reqVo);
			return "tiles/member/reqInsert";
		}
	}

	
	@RequestMapping(path = "/addPLView")
	public String addPLView() {
		return "tiles/member/addPL";
	}

	/** 자바 메일 발송 * @throws MessagingException * @throws AddressException **/
	@RequestMapping(value = "/mailsender")
	public String mailSender(MemberVo memberVo, HttpServletRequest request, ModelMap mo)
			throws AddressException, MessagingException {

		// 네이버일 경우 smtp.naver.com 을 입력합니다.
		// Google일 경우 smtp.gmail.com 을 입력합니다.

		// 네이버 메일 환경설정에서 "POP3/IMAP" 설정 사용으로 바꿔준다.
		String host = "smtp.naver.com";

		String email = memberVo.getMemId().split("@")[0];

		// POP3/IMAP 설정시 네이버에서 알려줌
		final String username = "ays157"; // 네이버 아이디를 입력해주세요. @naver.com은 입력하지 마시구요.
		final String password = "alalal02628"; // 네이버 이메일 비밀번호를 입력해주세요.
		int port = 465; // 포트번호

		// 메일 내용
		String recipient = memberVo.getMemId(); // 받는 사람의 메일주소를 입력해주세요.
		String subject = "메일테스트"; // 메일 제목 입력해주세요.
		String body = username + "님으로 부터 메일을 받았습니다.   http://localhost/req/reqList"; // 메일 내용 입력해주세요.

		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성

		// SMTP 서버 정보 설정
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);

		// Session 생성
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = username;
			String pw = password;

			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});

		session.setDebug(true); // for debug

		Message mimeMessage = new MimeMessage(session); // MimeMessage 생성
		mimeMessage.setFrom(new InternetAddress(memberVo.getMemId())); // 발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀
																		// 주소를 다 작성해주세요.
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); // 수신자셋팅 //.TO 외에 .CC(참조)
																							// .BCC(숨은참조) 도 있음

		mimeMessage.setSubject(subject); // 제목셋팅
		mimeMessage.setText(body); // 내용셋팅
		Transport.send(mimeMessage); // javax.mail.Transport.send() 이용 }

		return "main";
	}

}
