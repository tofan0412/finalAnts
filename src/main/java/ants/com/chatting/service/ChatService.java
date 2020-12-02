package ants.com.chatting.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ants.com.chatting.mapper.ChatMapper;
import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatVo;
import ants.com.member.model.ProjectMemberVo;

@Service("chatService")
public class ChatService{
	private static final Logger logger = LoggerFactory.getLogger(ChatService.class);
	
	@Resource(name="chatMapper")
	private ChatMapper mapper;

	public List<ChatGroupVo> readChatList(String reqId){
		return mapper.readChatList(reqId);
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
	
	// 채팅방 개설 위해 해당 프로젝트에서 현재 참여하고 있는 인원 리스트 불러오기 ..
	public List<ProjectMemberVo> readChatMembers(String reqId){
		List<ProjectMemberVo> result = mapper.readChatMembers(reqId);
		return result;
	}
	
}
