package ants.com.chatting.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.chatting.mapper.ChatMapper;
import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatHistoryVo;
import ants.com.chatting.model.ChatMemberVo;
import ants.com.chatting.model.ChatVo;
import ants.com.member.model.ProjectMemberVo;

@Service("chatService")
public class ChatService{
	
	@Resource(name="chatMapper")
	private ChatMapper mapper;

	public List<ChatGroupVo> readChatList(ChatGroupVo chatGroupVo){
		return mapper.readChatList(chatGroupVo);
	}
	
	public List<ChatVo> readMessages(ChatVo chatVo){
		return mapper.readMessages(chatVo);
	}
	
	public ChatGroupVo readCgroupName(String cgroupId) {
		return mapper.readCgroupName(cgroupId);
	}
	
	// 전송한 메시지 DB에 저장하기..
	public int sendMessage(ChatVo chatVo) {
		return mapper.sendMessage(chatVo);
	}
	
	// 채팅방 개설 위해 해당 프로젝트에서 현재 참여하고 있는 인원 리스트 불러오기 ..
	public List<ProjectMemberVo> readChatMembers(String projectId){
		return mapper.readChatMembers(projectId);
	}

	// 하나의 채팅방에 참여하고 있는 회원 리스트 뽑아오기
	public List<ChatMemberVo> readCgroupMembers(String cgroupId){
		return mapper.readCgroupMembers(cgroupId);
	}
	
	public int insertChatGroup(ChatGroupVo chatGroupVo) {
		return mapper.insertChatGroup(chatGroupVo);
	}
	
	public int insertChatMembers(ChatMemberVo chatMemberVo) {
		return mapper.insertChatMembers(chatMemberVo);
	}
	
	// 사용자가 채팅방에서 메시지를 어디까지 읽었는지를 저장해야 한다.
	public int insertChatHistory(ChatHistoryVo chatHistoryVo) {
		return mapper.insertChatHistory(chatHistoryVo);
	}

	// 가장 마지막에 읽은 메시지 번호를 수정한다.
	public int updateChatHistory(ChatHistoryVo chatHistoryVo) {
		return mapper.updateChatHistory(chatHistoryVo);
	}
	
	// 가장 최근의 메시지를 가져온다.
	public String recentMsg(String cgroupId) {
		return mapper.recentMsg(cgroupId);
	}
	
	// 채팅방에서 나가기
	public int exitChat(ChatMemberVo chatMemberVo) {
		return mapper.exitChat(chatMemberVo);
	}

	public int chatmembernameupdate(ChatMemberVo chatmembervo) {
		return mapper.chatmembernameupdate(chatmembervo);
	}
}
