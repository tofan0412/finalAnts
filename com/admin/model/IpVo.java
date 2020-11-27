package ants.com.admin.model;

public class IpVo {
	
	
	private String ip_id;
	private String ip_addr;
	private String ip_status;
	private String admin_id;
	
	
	public String getIp_id() {
		return ip_id;
	}
	public void setIp_id(String ip_id) {
		this.ip_id = ip_id;
	}
	public String getIp_addr() {
		return ip_addr;
	}
	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr;
	}
	public String getIp_status() {
		return ip_status;
	}
	public void setIp_status(String ip_status) {
		this.ip_status = ip_status;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	
	
	@Override
	public String toString() {
		return "IpVo [ip_id=" + ip_id + ", ip_addr=" + ip_addr + ", ip_status=" + ip_status + ", admin_id=" + admin_id
				+ "]";
	}
	
	
}
