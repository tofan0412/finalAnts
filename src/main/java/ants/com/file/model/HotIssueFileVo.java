package ants.com.file.model;

import java.util.Date;

public class HotIssueFileVo {
	
	
	private String hissuef_id;
	private String hissue_id;
	private String hiussef_filepath;
	private String hissuef_filename;
	private Date reg_dt;
	private String hissuef_size;
	
	
	public String getHissuef_id() {
		return hissuef_id;
	}
	public void setHissuef_id(String hissuef_id) {
		this.hissuef_id = hissuef_id;
	}
	public String getHissue_id() {
		return hissue_id;
	}
	public void setHissue_id(String hissue_id) {
		this.hissue_id = hissue_id;
	}
	public String getHiussef_filepath() {
		return hiussef_filepath;
	}
	public void setHiussef_filepath(String hiussef_filepath) {
		this.hiussef_filepath = hiussef_filepath;
	}
	public String getHissuef_filename() {
		return hissuef_filename;
	}
	public void setHissuef_filename(String hissuef_filename) {
		this.hissuef_filename = hissuef_filename;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getHissuef_size() {
		return hissuef_size;
	}
	public void setHissuef_size(String hissuef_size) {
		this.hissuef_size = hissuef_size;
	}
	
	
	@Override
	public String toString() {
		return "HotIssueFileVo [hissuef_id=" + hissuef_id + ", hissue_id=" + hissue_id + ", hiussef_filepath="
				+ hiussef_filepath + ", hissuef_filename=" + hissuef_filename + ", reg_dt=" + reg_dt + ", hissuef_size="
				+ hissuef_size + "]";
	}
	
	
	
}
