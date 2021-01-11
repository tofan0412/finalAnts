package ants.com.common.model;

import ants.com.base.model.BaseVo;

public class MsgVo extends BaseVo {
	private String msgIdx;
	private String msgCont;
	private String msgWriter;
	private String msgReceiver;
	private String regDt;
	private String msgStatus;
	private String msgType;
	
	public String getMsgReceiver() {
		return msgReceiver;
	}
	public void setMsgReceiver(String msgReceiver) {
		this.msgReceiver = msgReceiver;
	}
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
		return "MsgVo [msgIdx=" + msgIdx + ", msgCont=" + msgCont + ", msgWriter="
				+ msgWriter + ", regDt=" + regDt + "]";
	}
}
