package ants.com.member.model;

import ants.com.base.model.BaseVo;

public class ReqVo extends BaseVo{
	private String reqId;
	private String reqTitle;
	private String reqCont;
	private String reqPeriod;
	private String memId;
	private String plId;
	private String status;
	private String plName;
	private String proPercent;
	private String proId;
	private String proName;
	private String categoryId;
	private String del;
	private String proStatus;
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getReqTitle() {
		return reqTitle;
	}
	public void setReqTitle(String reqTitle) {
		this.reqTitle = reqTitle;
	}
	public String getReqCont() {
		return reqCont;
	}
	public void setReqCont(String reqCont) {
		this.reqCont = reqCont;
	}
	public String getReqPeriod() {
		return reqPeriod;
	}
	public void setReqPeriod(String reqPeriod) {
		this.reqPeriod = reqPeriod;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getPlId() {
		return plId;
	}
	public void setPlId(String plId) {
		this.plId = plId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPlName() {
		return plName;
	}
	public void setPlName(String plName) {
		this.plName = plName;
	}
	public String getProPercent() {
		return proPercent;
	}
	public void setProPercent(String proPercent) {
		this.proPercent = proPercent;
	}
	public String getProId() {
		return proId;
	}
	public void setProId(String proId) {
		this.proId = proId;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getProStatus() {
		return proStatus;
	}
	public void setProStatus(String proStatus) {
		this.proStatus = proStatus;
	}
	@Override
	public String toString() {
		return "ReqVo [reqId=" + reqId + ", reqTitle=" + reqTitle + ", reqCont=" + reqCont + ", reqPeriod=" + reqPeriod
				+ ", memId=" + memId + ", plId=" + plId + ", status=" + status + ", plName=" + plName + ", proPercent="
				+ proPercent + ", proId=" + proId + ", proName=" + proName + ", categoryId=" + categoryId + ", del="
				+ del + ", proStatus=" + proStatus + "]";
	}
	
	
	
	
	
	
	
	
	
	
	
}
