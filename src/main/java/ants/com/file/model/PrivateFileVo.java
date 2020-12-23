package ants.com.file.model;

import ants.com.base.model.BaseVo;

public class PrivateFileVo extends BaseVo {
	
	
	private String privId;
	private String privFilepath;
	private String privFilename;
	private String regDt;
	private String privSize;
	private String memId;
	private String privExtension;
	private String type;
	
	
	public String getPrivId() {
		return privId;
	}
	public void setPrivId(String privId) {
		this.privId = privId;
	}
	public String getPrivFilepath() {
		return privFilepath;
	}
	public void setPrivFilepath(String privFilepath) {
		this.privFilepath = privFilepath;
	}
	public String getPrivFilename() {
		return privFilename;
	}
	public void setPrivFilename(String privFilename) {
		this.privFilename = privFilename;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getPrivSize() {
		return privSize;
	}
	public void setPrivSize(String privSize) {
		this.privSize = privSize;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getPrivExtension() {
		return privExtension;
	}
	public void setPrivExtension(String privExtension) {
		this.privExtension = privExtension;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "PrivateFileVo [privId=" + privId + ", privFilepath=" + privFilepath + ", privFilename=" + privFilename
				+ ", regDt=" + regDt + ", privSize=" + privSize + ", memId=" + memId + ", privExtension="
				+ privExtension + "]";
	}

}
