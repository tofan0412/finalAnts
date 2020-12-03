package ants.com.chatting.model;

public class ChatMemberVo {
	private String chatmemId;	// 고유 PK 
	private String cgroupId; 	// 채팅방 번호..
	private String memId;		// 참여 회원 아이디
	
	
	public String getChatmemId() {
		return chatmemId;
	}

	public void setChatmemId(String chatmemId) {
		this.chatmemId = chatmemId;
	}

	public String getCgroupId() {
		return cgroupId;
	}

	public void setCgroupId(String cgroupId) {
		this.cgroupId = cgroupId;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	@Override
	public String toString() {
		return "ChatMemberVo [chatmemId=" + chatmemId + ", cgroupId=" + cgroupId + ", memId=" + memId + "]";
	}
	
}
