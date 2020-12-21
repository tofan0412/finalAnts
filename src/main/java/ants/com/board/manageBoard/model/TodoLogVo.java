package ants.com.board.manageBoard.model;


public class TodoLogVo {

	
	private String todoId;
	private String logId;
	private String logComment;
	private String beforeId;
	private String afterId;
	private String regDt;
	private String elapsedDay;
	private String elapsedTime;
	private String elapsedMin;
	
	
	
	public String getElapsedMin() {
		return elapsedMin;
	}
	public void setElapsedMin(String elapsedMin) {
		this.elapsedMin = elapsedMin;
	}
	public String getElapsedDay() {
		return elapsedDay;
	}
	public void setElapsedDay(String elapsedDay) {
		this.elapsedDay = elapsedDay;
	}
	public String getElapsedTime() {
		return elapsedTime;
	}
	public void setElapsedTime(String elapsedTime) {
		this.elapsedTime = elapsedTime;
	}
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
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	@Override
	public String toString() {
		return "TodoLogVo [todoId=" + todoId + ", logId=" + logId + ", logComment=" + logComment + ", beforeId="
				+ beforeId + ", afterId=" + afterId + ", regDt=" + regDt + ", elapsedDay=" + elapsedDay
				+ ", elapsedTime=" + elapsedTime + ", elapsedMin=" + elapsedMin + "]";
	}
	
	
	
}
