package ants.com.board.memBoard.model;

import java.util.Date;

public class ScheduleVo {
	
	
	private String sche_id;
	private String sche_title;
	private String sche_cont;
	private Date reg_dt;
	private String x_val;
	private String y_val;
	private String category_id;
	private String req_id;
	private String mem_id;
	private String del;
	
	
	public String getSche_id() {
		return sche_id;
	}
	public void setSche_id(String sche_id) {
		this.sche_id = sche_id;
	}
	public String getSche_title() {
		return sche_title;
	}
	public void setSche_title(String sche_title) {
		this.sche_title = sche_title;
	}
	public String getSche_cont() {
		return sche_cont;
	}
	public void setSche_cont(String sche_cont) {
		this.sche_cont = sche_cont;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getX_val() {
		return x_val;
	}
	public void setX_val(String x_val) {
		this.x_val = x_val;
	}
	public String getY_val() {
		return y_val;
	}
	public void setY_val(String y_val) {
		this.y_val = y_val;
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
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}


	@Override
	public String toString() {
		return "ScheduleVo [sche_id=" + sche_id + ", sche_title=" + sche_title + ", sche_cont=" + sche_cont
				+ ", reg_dt=" + reg_dt + ", x_val=" + x_val + ", y_val=" + y_val + ", category_id=" + category_id
				+ ", req_id=" + req_id + ", mem_id=" + mem_id + ", del=" + del + "]";
	}
	
	
	
}
