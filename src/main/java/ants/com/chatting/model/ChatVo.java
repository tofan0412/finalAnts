package ants.com.chatting.model;

import java.util.Date;

public class ChatVo {
	
	
	private String CHAT_ID;
	private String CHAT_CONT;
	private Date REG_DT;
	private String CHATMEM_ID;
	
	
	public String getCHAT_ID() {
		return CHAT_ID;
	}
	public void setCHAT_ID(String cHAT_ID) {
		CHAT_ID = cHAT_ID;
	}
	public String getCHAT_CONT() {
		return CHAT_CONT;
	}
	public void setCHAT_CONT(String cHAT_CONT) {
		CHAT_CONT = cHAT_CONT;
	}
	public Date getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(Date rEG_DT) {
		REG_DT = rEG_DT;
	}
	public String getCHATMEM_ID() {
		return CHATMEM_ID;
	}
	public void setCHATMEM_ID(String cHATMEM_ID) {
		CHATMEM_ID = cHATMEM_ID;
	}
	
	
	@Override
	public String toString() {
		return "ChatVo [CHAT_ID=" + CHAT_ID + ", CHAT_CONT=" + CHAT_CONT + ", REG_DT=" + REG_DT + ", CHATMEM_ID="
				+ CHATMEM_ID + "]";
	}
	
	
	
	
}
