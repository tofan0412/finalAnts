package ants.com.chatting.model;

public class ChatMemberVo {
	private String chatmemId;	// 고유 PK 
	private String cgroupId; 	// 채팅방 번호..
	private String memId;		// 참여 회원 아이디
	private String regDt;		// 참여 일시
	private String memName;		// 사용자 이름
	
	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

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
