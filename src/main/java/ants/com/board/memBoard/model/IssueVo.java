package ants.com.board.memBoard.model;

import ants.com.base.model.BaseVo;

public class IssueVo extends BaseVo{

	private String issueId;
	private String issueTitle;
	private String issueCont;
	private String regDt;
	private String categoryId;
	private String issueKind;
	private String issueDel;
	private String todoId;
	private String reqId;
	private String memId;
	private String memName;
	private String bookmark;
	private String proName;
	private String sort;
	
	
	
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getIssueId() {
		return issueId;
	}
	public void setIssueId(String issueId) {
		this.issueId = issueId;
	}
	public String getIssueTitle() {
		return issueTitle;
	}
	public void setIssueTitle(String issueTitle) {
		this.issueTitle = issueTitle;
	}
	public String getIssueCont() {
		return issueCont;
	}
	public void setIssueCont(String issueCont) {
		this.issueCont = issueCont;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getIssueKind() {
		return issueKind;
	}
	public void setIssueKind(String issueKind) {
		this.issueKind = issueKind;
	}
	public String getIssueDel() {
		return issueDel;
	}
	public void setIssueDel(String issueDel) {
		this.issueDel = issueDel;
	}
	public String getTodoId() {
		return todoId;
	}
	public void setTodoId(String todoId) {
		this.todoId = todoId;
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
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getBookmark() {
		return bookmark;
	}
	public void setBookmark(String bookmark) {
		this.bookmark = bookmark;
	}	
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	
	@Override
	public String toString() {
		return "IssueListVo [issueId=" + issueId + ", issueTitle=" + issueTitle + ", issueCont=" + issueCont
				+ ", regDt=" + regDt + ", categoryId=" + categoryId + ", issueKind=" + issueKind + ", issueDel="
				+ issueDel + ", todoId=" + todoId + ", reqId=" + reqId + ", memId=" + memId + ", memName=" + memName
				+ ", bookmark=" + bookmark + "]";
	}
	
	
	
	
	
}
