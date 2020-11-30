package ants.com.chatting.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.chatting.mapper.ChatMapper;

@Service("chatService")
public class ChatService{
	@Resource(name="chatMapper")
	private ChatMapper mapper;

}
