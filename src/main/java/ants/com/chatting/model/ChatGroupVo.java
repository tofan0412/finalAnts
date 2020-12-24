package ants.com.chatting.model;

public class ChatGroupVo {
	private String cgroupId;
	private String cgroupName;
	private String reqId;
	
	// 채팅 리스트 불러올 때 값을 쿼리에 전달하기 위해 추가.
	private String memId;
	
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
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
