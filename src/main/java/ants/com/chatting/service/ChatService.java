package ants.com.chatting.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.chatting.mapper.ChatMapper;
import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatVo;

@Service("chatService")
public class ChatService{
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
	
}
