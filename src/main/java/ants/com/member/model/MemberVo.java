package ants.com.member.model;

import org.hibernate.validator.constraints.NotEmpty;

import ants.com.base.model.BaseVo;

 public class MemberVo extends BaseVo{
		
	private String memId;
	private String memName;
	private String memPass;
	
	private String memTel;
	private String memFilepath;
	private String memFilename;
	private String memAlert;
	private String del;
	private String memType;
	
	
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemPass() {
		return memPass;
	}
	public void setMemPass(String memPass) {
		this.memPass = memPass;
	}
	public String getMemTel() {
		return memTel;
	}
	public void setMemTel(String memTel) {
		this.memTel = memTel;
	}
	public String getMemFilepath() {
		return memFilepath;
	}
	public void setMemFilepath(String memFilepath) {
		this.memFilepath = memFilepath;
	}
	public String getMemFilename() {
		return memFilename;
	}
	public void setMemFilename(String memFilename) {
		this.memFilename = memFilename;
	}
	public String getMemAlert() {
		return memAlert;
	}
	public void setMemAlert(String memAlert) {
		this.memAlert = memAlert;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getMemType() {
		return memType;
	}
	public void setMemType(String memType) {
		this.memType = memType;
	}
	
	
	@Override
	public String toString() {
		return "MemberVo [memId=" + memId + ", memName=" + memName + ", memPass=" + memPass + ", memTel=" + memTel
				+ ", memFilepath=" + memFilepath + ", memFilename=" + memFilename + ", memAlert=" + memAlert + ", del="
				+ del + ", memType=" + memType + "]";
	}

	
}
