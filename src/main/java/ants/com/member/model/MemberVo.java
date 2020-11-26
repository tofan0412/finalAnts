package ants.com.member.model;

public class MemberVo {
	
	
	private String mem_id;
	private String mem_name;
	private String mem_pass;
	private String mem_tel;
	private String mem_filepath;
	private String mem_filename;
	private String mem_alert;
	private String del;
	private String mem_type;
	
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_pass() {
		return mem_pass;
	}
	public void setMem_pass(String mem_pass) {
		this.mem_pass = mem_pass;
	}
	public String getMem_tel() {
		return mem_tel;
	}
	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}
	public String getMem_filepath() {
		return mem_filepath;
	}
	public void setMem_filepath(String mem_filepath) {
		this.mem_filepath = mem_filepath;
	}
	public String getMem_filename() {
		return mem_filename;
	}
	public void setMem_filename(String mem_filename) {
		this.mem_filename = mem_filename;
	}
	public String getMem_alert() {
		return mem_alert;
	}
	public void setMem_alert(String mem_alert) {
		this.mem_alert = mem_alert;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getMem_type() {
		return mem_type;
	}
	public void setMem_type(String mem_type) {
		this.mem_type = mem_type;
	}
	
	
	@Override
	public String toString() {
		return "MemberVo [mem_id=" + mem_id + ", mem_name=" + mem_name + ", mem_pass=" + mem_pass + ", mem_tel="
				+ mem_tel + ", mem_filepath=" + mem_filepath + ", mem_filename=" + mem_filename + ", mem_alert="
				+ mem_alert + ", del=" + del + ", mem_type=" + mem_type + "]";
	}
	
	
	
}
