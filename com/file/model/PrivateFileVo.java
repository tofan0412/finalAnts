package ants.com.file.model;

import java.util.Date;

public class PrivateFileVo {
	
	
	private String priv_id;
	private String priv_filepath;
	private String priv_filename;
	private Date reg_dt;
	private String priv_size;
	private String mem_id;
	
	
	public String getPriv_id() {
		return priv_id;
	}
	public void setPriv_id(String priv_id) {
		this.priv_id = priv_id;
	}
	public String getPriv_filepath() {
		return priv_filepath;
	}
	public void setPriv_filepath(String priv_filepath) {
		this.priv_filepath = priv_filepath;
	}
	public String getPriv_filename() {
		return priv_filename;
	}
	public void setPriv_filename(String priv_filename) {
		this.priv_filename = priv_filename;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getPriv_size() {
		return priv_size;
	}
	public void setPriv_size(String priv_size) {
		this.priv_size = priv_size;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	
	@Override
	public String toString() {
		return "PrivateFileVo [priv_id=" + priv_id + ", priv_filepath=" + priv_filepath + ", priv_filename="
				+ priv_filename + ", reg_dt=" + reg_dt + ", priv_size=" + priv_size + ", mem_id=" + mem_id + "]";
	}
	
	
	
}
