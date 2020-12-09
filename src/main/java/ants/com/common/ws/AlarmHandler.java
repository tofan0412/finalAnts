package ants.com.common.ws;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jaxen.function.SubstringFunction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import ants.com.member.model.MemberVo;


public class AlarmHandler extends TextWebSocketHandler {
	private static final Logger logger = LoggerFactory.getLogger(AlarmHandler.class);

	// 로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1대1
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	/* 클라이언트가 서버로 연결 시*/
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);

		Map<String, Object> httpSession = session.getAttributes();
		MemberVo SMEMBER = (MemberVo) httpSession.get("SMEMBER");
		String senderId = SMEMBER.getMemId();
		
		userSessionsMap.put(senderId, session);
		logger.debug("sessions:{}",sessions);
		logger.debug("userSessionMap:{}",userSessionsMap);
	}
	
	/* 클라이언트가 데이터 전송 시*/
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		
		if(msg != null) {
			String[] strs = msg.split(",");
			
			// pl요청
			if(strs != null && strs.length == 6) {
				String callerName = strs[0];
				String reqId = strs[1];
				String callerId = strs[2];
				String url = strs[3];
				String receiverId = strs[4];
				String type = strs[5];
				
				//받는사람이 로그인해서 있다면
				WebSocketSession requestSession = userSessionsMap.get(receiverId);
				logger.debug("receiverId:{}",requestSession);
				
				if("req-pl".equals(type) && requestSession != null) {
					TextMessage tmpMsg = new TextMessage(type + "&&" +callerName + "님이" + " pl요청을 보냈습니다. " +
								"<a type='external' href=" +url+ ">요청서 보기</a>");
					requestSession.sendMessage(tmpMsg);
				}
			}
			
			// 댓글,답글이 달렸을 때
			if(strs != null && strs.length == 8) {
				String issueId = strs[0];  						//이슈아이디, 핫이슈 아이디
				String callerName = strs[1];					//댓글 			,답글 작성자 이름
				String callerId = strs[2];						//댓글 			,답글 작성자 아이디
				String url = strs[3];							//댓글달린 게시물 	,해당 핫이슈 게시판
				String issueTitle = strs[4];					//댓글달린 이슈제목 	,답글달린 게시물 제목
				String replyCont = strs[5];						//댓글내용,		,답글 제목		 
				String receiverId = strs[6];					//알림 받는사람 아이디
				String type = strs[7];							//알림 타입
				
				if(issueTitle.length()>6) {
					issueTitle = issueTitle.substring(0,6) + "..";
				}
				if(replyCont.length()>6) {
					replyCont = replyCont.substring(0, 6) + "..";
				}
				
				//게시물작성자가 로그인해 있다면
				WebSocketSession boardWriterSession = userSessionsMap.get(receiverId);
				//댓글
				if(type.equals("reply") && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(type + "&&" + callerName + "&&" + issueTitle + " : " + replyCont + "<a type='external' href="+url+">댓글 보기</a>");
					boardWriterSession.sendMessage(tmpMsg);
				}
				else if(type.equals("posts") && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(type +"&&" + callerName +"&&" + issueTitle + " : " + replyCont + "<a type='external' href="+url+">게시판으로 가기</a>");
					boardWriterSession.sendMessage(tmpMsg);
				}
				
			}
		}
	}
	
	/* 연결해제 시*/
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		userSessionsMap.remove(session.getId());
		sessions.remove(session);
	}
	
	

}
