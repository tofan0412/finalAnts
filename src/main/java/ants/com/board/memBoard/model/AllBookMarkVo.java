package ants.com.board.memBoard.model;

import ants.com.base.model.BaseVo;

public class AllBookMarkVo extends BaseVo{
	
	private String bookId;
	private String issueId;
	private String reqId;
	private String memId;
	private String issueTitle;
	private String issueKind;
	private String regDt;
	private String memName;
	private String sort;
	
	
	
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getBookId() {
		return bookId;
	}
	public void setBookId(String bookId) {
		this.bookId = bookId;
	}
	public String getIssueId() {
		return issueId;
	}
	public void setIssueId(String issueId) {
		this.issueId = issueId;
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
	public String getIssueTitle() {
		return issueTitle;
	}
	public void setIssueTitle(String issueTitle) {
		this.issueTitle = issueTitle;
	}
	public String getIssueKind() {
		return issueKind;
	}
	public void setIssueKind(String issueKind) {
		this.issueKind = issueKind;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	@Override
	public String toString() {
		return "AllBookMarkVo [bookId=" + bookId + ", issueId=" + issueId + ", reqId=" + reqId + ", memId=" + memId
				+ ", issueTitle=" + issueTitle + ", issueKind=" + issueKind + ", regDt=" + regDt + ", memName="
				+ memName + "]";
	}
	
	
	
	
	
	
}
