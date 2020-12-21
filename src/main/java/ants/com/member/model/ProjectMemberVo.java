package ants.com.member.model;

public class ProjectMemberVo {
	
	
	private String reqId;
	private String promemId;
	private String memId;
	private String promemStatus;
	private String title;
	private String plName;
	
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
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getPlName() {
		return plName;
	}
	public void setPlName(String plName) {
		this.plName = plName;
	}
	@Override
	public String toString() {
		return "ProjectMemberVo [reqId=" + reqId + ", promemId=" + promemId + ", memId=" + memId + ", promemStatus="
				+ promemStatus + ", title=" + title + ", plName=" + plName + "]";
	}
	
}
