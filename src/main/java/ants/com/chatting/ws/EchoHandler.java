package ants.com.chatting.ws;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import ants.com.member.model.MemberVo;

@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(EchoHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) 
			throws Exception {
		// 로그인한 정보 넣기
		Map<String, Object> httpSession = session.getAttributes();
		MemberVo SMEMBER = (MemberVo) httpSession.get("SMEMBER");
		
		LOGGER.info("{} 연결 됨\n", SMEMBER.getMemId());
		
		sessionList.add(session);
	}

	@Override
	protected void handleTextMessage(
			WebSocketSession session, TextMessage message) throws Exception {
		Map<String, Object> httpSession = session.getAttributes();
		MemberVo SMEMBER = (MemberVo) httpSession.get("SMEMBER");
		
		LOGGER.info("{}로부터 \'{}\' 받음\n", SMEMBER.getMemId(), message.getPayload()); 
		
		// sessionList에 존재하는 모든 사용자에게 메시지 뿌리기 ..
		for(WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(SMEMBER.getMemId() + "$$$$" + message.getPayload()));
		}
	}

	@Override
	public void afterConnectionClosed(
			WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, Object> httpSession = session.getAttributes();
		MemberVo SMEMBER = (MemberVo) httpSession.get("SMEMBER");
		
		sessionList.remove(session);
		LOGGER.info("{} 연결 끊김\n", SMEMBER.getMemId());
	}
}
