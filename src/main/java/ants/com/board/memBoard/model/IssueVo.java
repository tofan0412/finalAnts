package ants.com.board.memBoard.model;

import java.util.Date;

public class IssueVo {

	
	private String issue_id;
	private String issue_title;
	private String issue_cont;
	private Date reg_dt;
	private String category_id;
	private String issue_kind;
	private String issue_del;
	private String todo_id;
	private String req_id;
	private String mem_id;
	
	
	public String getIssue_id() {
		return issue_id;
	}
	public void setIssue_id(String issue_id) {
		this.issue_id = issue_id;
	}
	public String getIssue_title() {
		return issue_title;
	}
	public void setIssue_title(String issue_title) {
		this.issue_title = issue_title;
	}
	public String getIssue_cont() {
		return issue_cont;
	}
	public void setIssue_cont(String issue_cont) {
		this.issue_cont = issue_cont;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getIssue_kind() {
		return issue_kind;
	}
	public void setIssue_kind(String issue_kind) {
		this.issue_kind = issue_kind;
	}
	public String getIssue_del() {
		return issue_del;
	}
	public void setIssue_del(String issue_del) {
		this.issue_del = issue_del;
	}
	public String getTodo_id() {
		return todo_id;
	}
	public void setTodo_id(String todo_id) {
		this.todo_id = todo_id;
	}
	public String getReq_id() {
		return req_id;
	}
	public void setReq_id(String req_id) {
		this.req_id = req_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	
	@Override
	public String toString() {
		return "IssueVo [issue_id=" + issue_id + ", issue_title=" + issue_title + ", issue_cont=" + issue_cont
				+ ", reg_dt=" + reg_dt + ", category_id=" + category_id + ", issue_kind=" + issue_kind + ", issue_del="
				+ issue_del + ", todo_id=" + todo_id + ", req_id=" + req_id + ", mem_id=" + mem_id + "]";
	}
	
	
}
