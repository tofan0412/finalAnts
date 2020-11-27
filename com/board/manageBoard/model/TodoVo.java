package ants.com.board.manageBoard.model;

import java.util.Date;

public class TodoVo {
	
	
	private String todo_id;
	private Date todo_start;
	private Date todo_end;
	private String todo_cont;
	private String todo_title;
	private String percent;
	private String todo_importance;
	private String todo_level;
	private String req_id;
	private String mem_id;
	private String todo_parentid;
	private String del;
	
	
	public String getTodo_id() {
		return todo_id;
	}
	public void setTodo_id(String todo_id) {
		this.todo_id = todo_id;
	}
	public Date getTodo_start() {
		return todo_start;
	}
	public void setTodo_start(Date todo_start) {
		this.todo_start = todo_start;
	}
	public Date getTodo_end() {
		return todo_end;
	}
	public void setTodo_end(Date todo_end) {
		this.todo_end = todo_end;
	}
	public String getTodo_cont() {
		return todo_cont;
	}
	public void setTodo_cont(String todo_cont) {
		this.todo_cont = todo_cont;
	}
	public String getTodo_title() {
		return todo_title;
	}
	public void setTodo_title(String todo_title) {
		this.todo_title = todo_title;
	}
	public String getPercent() {
		return percent;
	}
	public void setPercent(String percent) {
		this.percent = percent;
	}
	public String getTodo_importance() {
		return todo_importance;
	}
	public void setTodo_importance(String todo_importance) {
		this.todo_importance = todo_importance;
	}
	public String getTodo_level() {
		return todo_level;
	}
	public void setTodo_level(String todo_level) {
		this.todo_level = todo_level;
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
	public String getTodo_parentid() {
		return todo_parentid;
	}
	public void setTodo_parentid(String todo_parentid) {
		this.todo_parentid = todo_parentid;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	
	
	@Override
	public String toString() {
		return "TodoVo [todo_id=" + todo_id + ", todo_start=" + todo_start + ", todo_end=" + todo_end + ", todo_cont="
				+ todo_cont + ", todo_title=" + todo_title + ", percent=" + percent + ", todo_importance="
				+ todo_importance + ", todo_level=" + todo_level + ", req_id=" + req_id + ", mem_id=" + mem_id
				+ ", todo_parentid=" + todo_parentid + ", del=" + del + "]";
	}
	
	
}
