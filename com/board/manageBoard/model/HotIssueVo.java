package ants.com.board.manageBoard.model;

import java.util.Date;

public class HotIssueVo {

	
	private String hissue_id;
	private String hissue_title;
	private String hissuet_cont;
	private Date reg_dt;
	private String req_id;
	private String category_id;
	private String hissue_parentid;
	private String hissue_level;
	private String del;
	
	
	public String getHissue_id() {
		return hissue_id;
	}
	public void setHissue_id(String hissue_id) {
		this.hissue_id = hissue_id;
	}
	public String getHissue_title() {
		return hissue_title;
	}
	public void setHissue_title(String hissue_title) {
		this.hissue_title = hissue_title;
	}
	public String getHissuet_cont() {
		return hissuet_cont;
	}
	public void setHissuet_cont(String hissuet_cont) {
		this.hissuet_cont = hissuet_cont;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getReq_id() {
		return req_id;
	}
	public void setReq_id(String req_id) {
		this.req_id = req_id;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getHissue_parentid() {
		return hissue_parentid;
	}
	public void setHissue_parentid(String hissue_parentid) {
		this.hissue_parentid = hissue_parentid;
	}
	public String getHissue_level() {
		return hissue_level;
	}
	public void setHissue_level(String hissue_level) {
		this.hissue_level = hissue_level;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	
	
	@Override
	public String toString() {
		return "HotIssueVo [hissue_id=" + hissue_id + ", hissue_title=" + hissue_title + ", hissuet_cont="
				+ hissuet_cont + ", reg_dt=" + reg_dt + ", req_id=" + req_id + ", category_id=" + category_id
				+ ", hissue_parentid=" + hissue_parentid + ", hissue_level=" + hissue_level + ", del=" + del + "]";
	}
	
	
}
