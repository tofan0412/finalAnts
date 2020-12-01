package ants.com.chatting.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ants.com.chatting.mapper.ChatMapper;
import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatVo;

@Service("chatService")
public class ChatService{
	private static final Logger logger = LoggerFactory.getLogger(ChatService.class);
	
	@Resource(name="chatMapper")
	private ChatMapper mapper;

	public List<ChatGroupVo> readChatList(String memId){
		return mapper.readChatList(memId);
	}
	
	public List<ChatVo> readMessages(String cgroupId){
		return mapper.readMessages(cgroupId);
	}
	
	public ChatGroupVo readChatGroup(String cgroupId) {
		return mapper.readChatGroup(cgroupId);
	}
	
	// 전송한 메시지 DB에 저장하기..
	public int sendMessage(ChatVo chatVo) {
		logger.debug("그룹 : {}, 아이디 : {}, 내용 : {}, 입력일 : {}",
								chatVo.getCgroupId(), 
								chatVo.getMemId(), 
								chatVo.getChatCont(),
								chatVo.getRegDt());	
		
		int result = mapper.sendMessage(chatVo);
		logger.debug("result : {}", result);
		return result;
	}
	
}
