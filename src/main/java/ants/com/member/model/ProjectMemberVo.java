package ants.com.member.model;

public class ProjectMemberVo {
	private String reqId;
	private String promemId;
	private String memId;
	private String memName;
	private String promemStatus;
	private String title;
	private String plName;
	private String plId;
	private String memFilepath;
	
	public String getMemFilepath() {
		return memFilepath;
	}
	public void setMemFilepath(String memFilepath) {
		this.memFilepath = memFilepath;
	}
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
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
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
	public String getPlId() {
		return plId;
	}
	public void setPlId(String plId) {
		this.plId = plId;
	}
	@Override
	public String toString() {
		return "ProjectMemberVo [reqId=" + reqId + ", promemId=" + promemId + ", memId=" + memId + ", memName="
				+ memName + ", promemStatus=" + promemStatus + ", title=" + title + ", plName=" + plName + ", plId="
				+ plId + "]";
	}
	
	
}
