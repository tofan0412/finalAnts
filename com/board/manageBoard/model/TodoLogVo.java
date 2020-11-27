package ants.com.board.manageBoard.model;

import java.util.Date;

public class TodoLogVo {

	
	private String todo_id;
	private String log_id;
	private String log_comment;
	private String before_id;
	private String after_id;
	private Date reg_dt;
	
	
	public String getTodo_id() {
		return todo_id;
	}
	public void setTodo_id(String todo_id) {
		this.todo_id = todo_id;
	}
	public String getLog_id() {
		return log_id;
	}
	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}
	public String getLog_comment() {
		return log_comment;
	}
	public void setLog_comment(String log_comment) {
		this.log_comment = log_comment;
	}
	public String getBefore_id() {
		return before_id;
	}
	public void setBefore_id(String before_id) {
		this.before_id = before_id;
	}
	public String getAfter_id() {
		return after_id;
	}
	public void setAfter_id(String after_id) {
		this.after_id = after_id;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	
	
	@Override
	public String toString() {
		return "TodoLogVo [todo_id=" + todo_id + ", log_id=" + log_id + ", log_comment=" + log_comment + ", before_id="
				+ before_id + ", after_id=" + after_id + ", reg_dt=" + reg_dt + "]";
	}
	
	
	
	
}
