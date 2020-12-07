package ants.com.common.ws;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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
		
	}
	
	/* 클라이언트가 데이터 전송 시*/
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		if(msg != null) {
			String[] strs = msg.split(",");
			
			// pl요청
			if(strs != null && strs[5].equals("r-pl")) {
				String callerName = strs[0];
				String reqId = strs[1];
				String callerId = strs[2];
				String url = strs[3];
				String receiverId = strs[4];
				String type = strs[5];
				
				//받는사람이 로그인해서 있다면
				WebSocketSession boardWriterSession = userSessionsMap.get(receiverId);
				logger.debug("receiverId:{}",boardWriterSession);
				
				if("r-pl".equals(type) && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(callerName + "님이" + "pl요청을 보냈습니다." +
								"<a type='external' href=" +url+ ">요청서 보기</a>");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
		super.handleTextMessage(session, message);
	}
	
	/* 연결해제 시*/
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		userSessionsMap.remove(session.getId());
		sessions.remove(session);
	}
	
	

}
