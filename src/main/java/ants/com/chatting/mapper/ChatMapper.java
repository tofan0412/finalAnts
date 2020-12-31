package ants.com.chatting.mapper;

import java.util.List;

import ants.com.chatting.model.ChatGroupVo;
import ants.com.chatting.model.ChatHistoryVo;
import ants.com.chatting.model.ChatMemberVo;
import ants.com.chatting.model.ChatVo;
import ants.com.member.model.ProjectMemberVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("chatMapper")
public interface ChatMapper {
	public List<ChatGroupVo> readChatList(ChatGroupVo chatGroupVo);
	
	public ChatGroupVo readCgroupName(String cgroupId);
	
	public List<ChatVo> readMessages(ChatVo chatVo);
	
	public int sendMessage(ChatVo chatVo);
	
	public List<ProjectMemberVo> readChatMembers(String reqId);

	// 하나의 채팅방에 참여하고 있는 회원 리스트 뽑아오기
	public List<ChatMemberVo> readCgroupMembers(String cgroupId);
	
	// 먼저, 채팅방을 개설한다.
	public int insertChatGroup(ChatGroupVo chatGroupVo);
	
	// 이후, 해당 채팅방에 초대 받은 회원 명부를 DB에 등록한다. 
	public int insertChatMembers(ChatMemberVo chatMemberVo);

	// 사용자가 채팅방 메시지를 어디까지 읽었는지를 저장해 놔야 한다.
	public int insertChatHistory(ChatHistoryVo chatHistoryVo);
	
	// 가장 마지막에 읽은 메시지 번호를 수정한다.
	public int updateChatHistory(ChatHistoryVo chatHistoryVo);
	
	// 가장 최근의 메시지를 뽑아온다.
	public String recentMsg(String cgroupId);
	
	// 채팅방에서 나가기
	public int exitChat(ChatMemberVo chatMemberVo);
		
	// 채팅멤버 이름업데이트
	public int chatmembernameupdate(ChatMemberVo chatmembervo);
}
