package ants.com.board.memBoard.model;


public class ScheduleVo {
	
	
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
	@Override
	public String toString() {
		return "ScheduleVo [scheId=" + scheId + ", scheTitle=" + scheTitle + ", scheCont=" + scheCont + ", regDt="
				+ regDt + ", xVal=" + xVal + ", yVal=" + yVal + ", categoryId=" + categoryId + ", reqId=" + reqId
				+ ", memId=" + memId + ", del=" + del + "]";
	}
	
	
}
