package ants.com.chatting.model;

public class ChatVo {

	private String memId;
	private String memName;
	private String regDt;
	private String cgroupId;
	private String chatId;
	private String chatCont;
	
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public void setMemId(String memId) {
		this.memId = memId; 
	}
	public String getMemId() {
		return memId; 
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt; 
	}
	public String getRegDt() {
		return regDt; 
	}
	public void setCgroupId(String cgroupId) {
		this.cgroupId = cgroupId; 
	}
	public String getCgroupId() {
		return cgroupId; 
	}
	public void setChatId(String chatId) {
		this.chatId = chatId; 
	}
	public String getChatId() {
		return chatId; 
	}
	public void setChatCont(String chatCont) {
		this.chatCont = chatCont; 
	}
	public String getChatCont() {
		return chatCont; 
	}

}
