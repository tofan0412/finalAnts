package ants.com.member.model;

public class ReqListVo {
	
	
	private String req_id;
	private String req_title;
	private String req_cont;
	private String req_period;
	private String req_filepath;
	private String req_filename;
	private String mem_id;
	
	
	public String getReq_id() {
		return req_id;
	}
	public void setReq_id(String req_id) {
		this.req_id = req_id;
	}
	public String getReq_title() {
		return req_title;
	}
	public void setReq_title(String req_title) {
		this.req_title = req_title;
	}
	public String getReq_cont() {
		return req_cont;
	}
	public void setReq_cont(String req_cont) {
		this.req_cont = req_cont;
	}
	public String getReq_period() {
		return req_period;
	}
	public void setReq_period(String req_period) {
		this.req_period = req_period;
	}
	public String getReq_filepath() {
		return req_filepath;
	}
	public void setReq_filepath(String req_filepath) {
		this.req_filepath = req_filepath;
	}
	public String getReq_filename() {
		return req_filename;
	}
	public void setReq_filename(String req_filename) {
		this.req_filename = req_filename;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	
	@Override
	public String toString() {
		return "ReqListVo [req_id=" + req_id + ", req_title=" + req_title + ", req_cont=" + req_cont + ", req_period="
				+ req_period + ", req_filepath=" + req_filepath + ", req_filename=" + req_filename + ", mem_id="
				+ mem_id + "]";
	}
	
	
	
}
