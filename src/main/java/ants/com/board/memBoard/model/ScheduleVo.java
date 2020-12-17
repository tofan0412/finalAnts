package ants.com.board.memBoard.model;

import ants.com.base.model.BaseVo;

public class ScheduleVo extends BaseVo {
	
	
	private String scheId;
	private String scheTitle;
	private String scheCont;
	private String regDt;
	private String xVal;
	private String yVal;
	private String categoryId;
	private String reqId;
	private String memId;
	private String del;
	private String startDt;
	private String endDt;
	private String juso;
	private String calendarcss;
	private String memName;
	
	
	public String getCalendarcss() {
		return calendarcss;
	}
	public void setCalendarcss(String calendarcss) {
		this.calendarcss = calendarcss;
	}
	public String getScheId() {
		return scheId;
	}
	public void setScheId(String scheId) {
		this.scheId = scheId;
	}
	public String getScheTitle() {
		return scheTitle;
	}
	public void setScheTitle(String scheTitle) {
		this.scheTitle = scheTitle;
	}
	public String getScheCont() {
		return scheCont;
	}
	public void setScheCont(String scheCont) {
		this.scheCont = scheCont;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getxVal() {
		return xVal;
	}
	public void setxVal(String xVal) {
		this.xVal = xVal;
	}
	public String getyVal() {
		return yVal;
	}
	public void setyVal(String yVal) {
		this.yVal = yVal;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
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
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getJuso() {
		return juso;
	}
	public void setJuso(String juso) {
		this.juso = juso;
	}
	
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	@Override
	public String toString() {
		return "ScheduleVo [scheId=" + scheId + ", scheTitle=" + scheTitle + ", scheCont=" + scheCont + ", regDt="
				+ regDt + ", xVal=" + xVal + ", yVal=" + yVal + ", categoryId=" + categoryId + ", reqId=" + reqId
				+ ", memId=" + memId + ", del=" + del + ", startDt=" + startDt + ", endDt=" + endDt + ", juso=" + juso
				+ ", calendarcss=" + calendarcss + "]";
	}
	
	
	
	
	
	
	
	
	
}
