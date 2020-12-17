package ants.com.board.manageBoard.model;

import ants.com.base.model.BaseVo;

public class TodoVo extends BaseVo{
	
	private String todoId;
	private String todoStart;
	private String todoEnd;
	private String todoCont;
	private String todoTitle;
	private String todoPercent;
	private String todoImportance;
	private String todoLevel;
	private String reqId;
	private String memId;
	private String todoParentid;
	private String del;
	private String memName;
	
	public String getTodoId() {
		return todoId;
	}
	public void setTodoId(String todoId) {
		this.todoId = todoId;
	}

	public String getTodoStart() {
		return todoStart;
	}
	public void setTodoStart(String todoStart) {
		this.todoStart = todoStart;
	}
	public String getTodoEnd() {
		return todoEnd;
	}
	public void setTodoEnd(String todoEnd) {
		this.todoEnd = todoEnd;
	}
	public String getTodoCont() {
		return todoCont;
	}
	public void setTodoCont(String todoCont) {
		this.todoCont = todoCont;
	}
	public String getTodoTitle() {
		return todoTitle;
	}
	public void setTodoTitle(String todoTitle) {
		this.todoTitle = todoTitle;
	}
	
	public String getTodoImportance() {
		return todoImportance;
	}
	public void setTodoImportance(String todoImportance) {
		this.todoImportance = todoImportance;
	}
	public String getTodoLevel() {
		return todoLevel;
	}
	public void setTodoLevel(String todoLevel) {
		this.todoLevel = todoLevel;
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
	public String getTodoParentid() {
		return todoParentid;
	}
	public void setTodoParentid(String todoParentid) {
		this.todoParentid = todoParentid;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getTodoPercent() {
		return todoPercent;
	}
	public void setTodoPercent(String todoPercent) {
		this.todoPercent = todoPercent;
	}
	
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	@Override
	public String toString() {
		return "TodoVo [todoId=" + todoId + ", todoStart=" + todoStart + ", todoEnd=" + todoEnd + ", todoCont="
				+ todoCont + ", todoTitle=" + todoTitle + ", todoPercent=" + todoPercent + ", todoImportance="
				+ todoImportance + ", todoLevel=" + todoLevel + ", reqId=" + reqId + ", memId=" + memId
				+ ", todoParentid=" + todoParentid + ", del=" + del + "]";
	}
	
	
	
}
