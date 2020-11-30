package ants.com.member.model;

import java.util.Date;

public class ProjectVo {
	
	
	private String reqId;
	private String memId;
	private String proName;
	private String percent;
	private Date regDt;
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getPercent() {
		return percent;
	}
	public void setPercent(String percent) {
		this.percent = percent;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	@Override
	public String toString() {
		return "ProjectVo [reqId=" + reqId + ", memId=" + memId + ", proName=" + proName + ", percent=" + percent
				+ ", regDt=" + regDt + "]";
	}
}
