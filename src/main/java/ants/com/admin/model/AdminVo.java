package ants.com.admin.model;

public class AdminVo {
	
	
	private String adminId;
	private String adminPass;
	
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPass() {
		return adminPass;
	}
	public void setAdminPass(String adminPass) {
		this.adminPass = adminPass;
	}
	
	@Override
	public String toString() {
		return "AdminVo [adminId=" + adminId + ", adminPass=" + adminPass + "]";
	}
	
	
	
	
	
	
}
