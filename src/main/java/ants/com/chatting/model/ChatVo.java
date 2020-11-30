package ants.com.chatting.model;

import java.util.Date;

public class ChatVo {
	
	private String chatId;
	private String chatCont;
	private Date regDt;
	private String chatmemId;
	public String getChatId() {
		return chatId;
	}
	public void setChatId(String chatId) {
		this.chatId = chatId;
	}
	public String getChatCont() {
		return chatCont;
	}
	public void setChatCont(String chatCont) {
		this.chatCont = chatCont;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	public String getChatmemId() {
		return chatmemId;
	}
	public void setChatmemId(String chatmemId) {
		this.chatmemId = chatmemId;
	}
	@Override
	public String toString() {
		return "ChatVo [chatId=" + chatId + ", chatCont=" + chatCont + ", regDt=" + regDt + ", chatmemId=" + chatmemId
				+ "]";
	}
	
	
}
