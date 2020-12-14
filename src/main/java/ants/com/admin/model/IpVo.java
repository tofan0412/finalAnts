package ants.com.admin.model;

import ants.com.base.model.BaseVo;

public class IpVo extends BaseVo{
	private String ipId;
	private String ipAddr;
	private String ipStatus;
	private String adminId;
	private String del;
	
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getIpId() {
		return ipId;
	}
	public void setIpId(String ipId) {
		this.ipId = ipId;
	}
	public String getIpAddr() {
		return ipAddr;
	}
	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	public String getIpStatus() {
		return ipStatus;
	}
	public void setIpStatus(String ipStatus) {
		this.ipStatus = ipStatus;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	
	
	@Override
	public String toString() {
		return "IpVo [ipId=" + ipId + ", ipAddr=" + ipAddr + ", ipStatus=" + ipStatus + ", adminId=" + adminId + "]";
	}
	
	
	
	
}
