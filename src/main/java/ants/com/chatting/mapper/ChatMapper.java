package ants.com.chatting.mapper;

import java.util.List;

import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("chatMapper")
public interface ChatMapper {
	public List<ChatGroupVo> readChatList(String memId);
	
	public List<ChatVo> readMessages(String cgroupId);
}
