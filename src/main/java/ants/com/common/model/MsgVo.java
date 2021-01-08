package ants.com.common.model;

import ants.com.base.model.BaseVo;

public class MsgVo extends BaseVo {
	private String msgIdx;
	private String msgTitle;
	private String msgCont;
	private String msgWriter;
	private String regDt;
	private String msgStatus;
	private String msgType;
	
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getMsgStatus() {
		return msgStatus;
	}
	public void setMsgStatus(String msgStatus) {
		this.msgStatus = msgStatus;
	}
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
