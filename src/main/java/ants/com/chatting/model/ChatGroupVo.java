package ants.com.chatting.model;

public class ChatGroupVo {
	private String cgroupId;
	private String cgroupName;
	private String reqId;
	
	public String getCgroupId() {
		return cgroupId;
	}
	public void setCgroupId(String cgroupId) {
		this.cgroupId = cgroupId;
	}
	public String getCgroupName() {
		return cgroupName;
	}
	public void setCgroupName(String cgroupName) {
		this.cgroupName = cgroupName;
	}
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	@Override
	public String toString() {
		return "ChatGroupVo [cgroupId=" + cgroupId + ", cgroupName=" + cgroupName + ", reqId=" + reqId + "]";
	}
	
}
