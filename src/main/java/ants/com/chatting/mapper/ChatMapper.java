package ants.com.chatting.mapper;

import java.util.List;

import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatMemberVo;
import ants.com.chatting.model.ChatVo;
import ants.com.member.model.ProjectMemberVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("chatMapper")
public interface ChatMapper {
	public List<ChatGroupVo> readChatList(ChatGroupVo chatGroupVo);
	
	public ChatGroupVo readCgroupName(String cgroupId);
	
	public List<ChatVo> readMessages(String cgroupId);
	
	public int sendMessage(ChatVo chatVo);
	
	public List<ProjectMemberVo> readChatMembers(String reqId);
	
	// 먼저, 채팅방을 개설한다.
	public int insertChatGroup(ChatGroupVo chatGroupVo);
	
	// 이후, 해당 채팅방에 초대 받은 회원 명부를 DB에 등록한다. 
	public int insertChatMembers(ChatMemberVo chatMemberVo);
	
}
