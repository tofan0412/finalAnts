package ants.com.board.manageBoard.model;

import java.util.Date;

public class HotIssueVo {

	
	private String hissueId;
	private String hissueTitle;
	private String hissuetCont;
	private Date regDt;
	private String reqId;
	private String categoryId;
	private String hissueParentid;
	private String hissueLevel;
	private String del;
	public String getHissueId() {
		return hissueId;
	}
	public void setHissueId(String hissueId) {
		this.hissueId = hissueId;
	}
	public String getHissueTitle() {
		return hissueTitle;
	}
	public void setHissueTitle(String hissueTitle) {
		this.hissueTitle = hissueTitle;
	}
	public String getHissuetCont() {
		return hissuetCont;
	}
	public void setHissuetCont(String hissuetCont) {
		this.hissuetCont = hissuetCont;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getHissueParentid() {
		return hissueParentid;
	}
	public void setHissueParentid(String hissueParentid) {
		this.hissueParentid = hissueParentid;
	}
	public String getHissueLevel() {
		return hissueLevel;
	}
	public void setHissueLevel(String hissueLevel) {
		this.hissueLevel = hissueLevel;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	
	@Override
	public String toString() {
		return "HotIssueVo [hissueId=" + hissueId + ", hissueTitle=" + hissueTitle + ", hissuetCont=" + hissuetCont
				+ ", regDt=" + regDt + ", reqId=" + reqId + ", categoryId=" + categoryId + ", hissueParentid="
				+ hissueParentid + ", hissueLevel=" + hissueLevel + ", del=" + del + "]";
	}
	
}
