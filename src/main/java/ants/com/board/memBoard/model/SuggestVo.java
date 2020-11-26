package ants.com.board.memBoard.model;

import java.util.Date;

public class SuggestVo {

	
	private String sgt_id;
	private String sgt_title;
	private String sgt_cont;
	private Date reg_dt;
	private String sgt_status;
	private String category_id;
	private String todo_id;
	private String del;
	
	
	public String getSgt_id() {
		return sgt_id;
	}
	public void setSgt_id(String sgt_id) {
		this.sgt_id = sgt_id;
	}
	public String getSgt_title() {
		return sgt_title;
	}
	public void setSgt_title(String sgt_title) {
		this.sgt_title = sgt_title;
	}
	public String getSgt_cont() {
		return sgt_cont;
	}
	public void setSgt_cont(String sgt_cont) {
		this.sgt_cont = sgt_cont;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getSgt_status() {
		return sgt_status;
	}
	public void setSgt_status(String sgt_status) {
		this.sgt_status = sgt_status;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getTodo_id() {
		return todo_id;
	}
	public void setTodo_id(String todo_id) {
		this.todo_id = todo_id;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	
	
	@Override
	public String toString() {
		return "SuggestVo [sgt_id=" + sgt_id + ", sgt_title=" + sgt_title + ", sgt_cont=" + sgt_cont + ", reg_dt="
				+ reg_dt + ", sgt_status=" + sgt_status + ", category_id=" + category_id + ", todo_id=" + todo_id
				+ ", del=" + del + "]";
	}
	
	
	
	
}
