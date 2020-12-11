package ants.com.member.model;

import ants.com.base.model.BaseVo;

public class ReqVo extends BaseVo{
	private String reqId;
	private String reqTitle;
	private String reqCont;
	private String reqPeriod;
	private String reqFilepath;
	private String reqFilename;
	private String memId;
	private String plId;
	private String status;
	private String plName;
	private String proPercent;
	private String proId;
	private String categoryId;
	
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
	public String getReqFilepath() {
		return reqFilepath;
	}
	public void setReqFilepath(String reqFilepath) {
		this.reqFilepath = reqFilepath;
	}
	public String getReqFilename() {
		return reqFilename;
	}
	public void setReqFilename(String reqFilename) {
		this.reqFilename = reqFilename;
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
	
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	@Override
	public String toString() {
		return "ReqVo [reqId=" + reqId + ", reqTitle=" + reqTitle + ", reqCont=" + reqCont + ", reqPeriod=" + reqPeriod
				+ ", reqFilepath=" + reqFilepath + ", reqFilename=" + reqFilename + ", memId=" + memId + ", plId="
				+ plId + ", status=" + status + ", plName=" + plName + ", proPercent=" + proPercent + ", proId=" + proId
				+ ", categoryId=" + categoryId + "]";
	}
	
	
	
	
	
	
	
	
	
}
