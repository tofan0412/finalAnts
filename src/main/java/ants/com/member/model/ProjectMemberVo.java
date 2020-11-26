package ants.com.member.model;

public class ProjectMemberVo {
	
	
	private String req_id;
	private String promem_id;
	private String mem_id;
	private String promem_status;
	
	
	public String getReq_id() {
		return req_id;
	}
	public void setReq_id(String req_id) {
		this.req_id = req_id;
	}
	public String getPromem_id() {
		return promem_id;
	}
	public void setPromem_id(String promem_id) {
		this.promem_id = promem_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getPromem_status() {
		return promem_status;
	}
	public void setPromem_status(String promem_status) {
		this.promem_status = promem_status;
	}
	
	
	@Override
	public String toString() {
		return "ProjectMemberVo [req_id=" + req_id + ", promem_id=" + promem_id + ", mem_id=" + mem_id
				+ ", promem_status=" + promem_status + "]";
	}
	
	
	
	
}
