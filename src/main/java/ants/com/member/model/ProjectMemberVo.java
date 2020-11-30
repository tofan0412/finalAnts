package ants.com.member.model;

public class ProjectMemberVo {
	
	
	private String reqId;
	private String promemId;
	private String memId;
	private String promemStatus;
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getPromemId() {
		return promemId;
	}
	public void setPromemId(String promemId) {
		this.promemId = promemId;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getPromemStatus() {
		return promemStatus;
	}
	public void setPromemStatus(String promemStatus) {
		this.promemStatus = promemStatus;
	}
	@Override
	public String toString() {
		return "ProjectMemberVo [reqId=" + reqId + ", promemId=" + promemId + ", memId=" + memId + ", promemStatus="
				+ promemStatus + "]";
	}
	
	
}
