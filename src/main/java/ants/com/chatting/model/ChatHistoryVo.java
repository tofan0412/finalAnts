package ants.com.chatting.model;

public class ChatHistoryVo {
	private String chathistIdx; 
	private String cgroupId;
	private String memId;
	private String chatId;
	
	@Override
	public String toString() {
		return "ChatHistoryVo [chathistIdx=" + chathistIdx + ", cgroupId=" + cgroupId + ", memId=" + memId + ", chatId="
				+ chatId + "]";
	}
	public String getChathistIdx() {
		return chathistIdx;
	}
	public void setChathistIdx(String chathistIdx) {
		this.chathistIdx = chathistIdx;
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
	public String getChatId() {
		return chatId;
	}
	public void setChatId(String chatId) {
		this.chatId = chatId;
	}
}
