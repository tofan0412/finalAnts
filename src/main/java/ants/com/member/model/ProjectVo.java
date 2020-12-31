package ants.com.member.model;

import ants.com.base.model.BaseVo;

public class ProjectVo extends BaseVo{
	private String reqId;
	private String memId;
	private String proName;
	private String percent;
	private String regDt;
	private String del;
	private String endDt;
	private String elepsedTime;
	private String proStatus;
	private String proChangeDate ;
	private String esElepsedTime ;
	
	
	public String getEsElepsedTime() {
		return esElepsedTime;
	}
	public void setEsElepsedTime(String esElepsedTime) {
		this.esElepsedTime = esElepsedTime;
	}
	public String getProStatus() {
		return proStatus;
	}
	public void setProStatus(String proStatus) {
		this.proStatus = proStatus;
	}
	public String getProChangeDate() {
		return proChangeDate;
	}
	public void setProChangeDate(String proChangeDate) {
		this.proChangeDate = proChangeDate;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
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
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getElepsedTime() {
		return elepsedTime;
	}
	public void setElepsedTime(String elepsedTime) {
		this.elepsedTime = elepsedTime;
	}
	@Override
	public String toString() {
		return "ProjectVo [reqId=" + reqId + ", memId=" + memId + ", proName=" + proName + ", percent=" + percent
				+ ", regDt=" + regDt + ", del=" + del + ", endDt=" + endDt + ", elepsedTime=" + elepsedTime
				+ ", proStatus=" + proStatus + ", proChangeDate=" + proChangeDate + ", esElepsedTime=" + esElepsedTime
				+ "]";
	}
	
	
	
	

}