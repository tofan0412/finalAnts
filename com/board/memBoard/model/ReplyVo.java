package ants.com.board.memBoard.model;

import java.util.Date;

public class ReplyVo {
	
	
	private String reply_id;
	private String some_id;
	private String reply_cont;
	private Date reg_dt;
	private String del;
	private String category_id;
	private String req_id;
	private String mem_id;
	
	
	public String getReply_id() {
		return reply_id;
	}
	public void setReply_id(String reply_id) {
		this.reply_id = reply_id;
	}
	public String getSome_id() {
		return some_id;
	}
	public void setSome_id(String some_id) {
		this.some_id = some_id;
	}
	public String getReply_cont() {
		return reply_cont;
	}
	public void setReply_cont(String reply_cont) {
		this.reply_cont = reply_cont;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
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
		return "ReplyVo [reply_id=" + reply_id + ", some_id=" + some_id + ", reply_cont=" + reply_cont + ", reg_dt="
				+ reg_dt + ", del=" + del + ", category_id=" + category_id + ", req_id=" + req_id + ", mem_id=" + mem_id
				+ "]";
	}
	
	
	
}
