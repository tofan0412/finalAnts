package ants.com.board.manageBoard.model;

import java.util.Date;

public class TodoLogVo {

	
	private String todoId;
	private String logId;
	private String logComment;
	private String beforeId;
	private String afterId;
	private Date regDt;
	
	public String getTodoId() {
		return todoId;
	}
	public void setTodoId(String todoId) {
		this.todoId = todoId;
	}
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
	}
	public String getLogComment() {
		return logComment;
	}
	public void setLogComment(String logComment) {
		this.logComment = logComment;
	}
	public String getBeforeId() {
		return beforeId;
	}
	public void setBeforeId(String beforeId) {
		this.beforeId = beforeId;
	}
	public String getAfterId() {
		return afterId;
	}
	public void setAfterId(String afterId) {
		this.afterId = afterId;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	@Override
	public String toString() {
		return "TodoLogVo [todoId=" + todoId + ", logId=" + logId + ", logComment=" + logComment + ", beforeId="
				+ beforeId + ", afterId=" + afterId + ", regDt=" + regDt + "]";
	}
	
}
