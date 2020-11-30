package ants.com.chatting.model;

public class ChatMemberVo {

	
	private String cgroupId;
	private String chatmemId;
	private String promemId;
	public String getCgroupId() {
		return cgroupId;
	}
	public void setCgroupId(String cgroupId) {
		this.cgroupId = cgroupId;
	}
	public String getChatmemId() {
		return chatmemId;
	}
	public void setChatmemId(String chatmemId) {
		this.chatmemId = chatmemId;
	}
	public String getPromemId() {
		return promemId;
	}
	public void setPromemId(String promemId) {
		this.promemId = promemId;
	}
	@Override
	public String toString() {
		return "ChatMemberVo [cgroupId=" + cgroupId + ", chatmemId=" + chatmemId + ", promemId=" + promemId + "]";
	}
	
}
