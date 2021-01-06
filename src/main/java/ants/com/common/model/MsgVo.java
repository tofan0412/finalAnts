package ants.com.common.model;

public class MsgVo {
	private String msgIdx;
	private String msgTitle;
	private String msgCont;
	private String msgWriter;
	private String regDt;
	
	public String getMsgIdx() {
		return msgIdx;
	}
	public void setMsgIdx(String msgIdx) {
		this.msgIdx = msgIdx;
	}
	public String getMsgTitle() {
		return msgTitle;
	}
	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}
	public String getMsgCont() {
		return msgCont;
	}
	public void setMsgCont(String msgCont) {
		this.msgCont = msgCont;
	}
	public String getMsgWriter() {
		return msgWriter;
	}
	public void setMsgWriter(String msgWriter) {
		this.msgWriter = msgWriter;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	@Override
	public String toString() {
		return "MsgVo [msgIdx=" + msgIdx + ", msgTitle=" + msgTitle + ", msgCont=" + msgCont + ", msgWriter="
				+ msgWriter + ", regDt=" + regDt + "]";
	}
}
