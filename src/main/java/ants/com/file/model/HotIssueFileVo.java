package ants.com.file.model;

import java.util.Date;

public class HotIssueFileVo {
	
	
	private String hissuefId;
	private String hissueId;
	private String hiussefFilepath;
	private String hissuefFilename;
	private Date regDt;
	private String hissuefSize;
	
	public String getHissuefId() {
		return hissuefId;
	}
	public void setHissuefId(String hissuefId) {
		this.hissuefId = hissuefId;
	}
	public String getHissueId() {
		return hissueId;
	}
	public void setHissueId(String hissueId) {
		this.hissueId = hissueId;
	}
	public String getHiussefFilepath() {
		return hiussefFilepath;
	}
	public void setHiussefFilepath(String hiussefFilepath) {
		this.hiussefFilepath = hiussefFilepath;
	}
	public String getHissuefFilename() {
		return hissuefFilename;
	}
	public void setHissuefFilename(String hissuefFilename) {
		this.hissuefFilename = hissuefFilename;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	public String getHissuefSize() {
		return hissuefSize;
	}
	public void setHissuefSize(String hissuefSize) {
		this.hissuefSize = hissuefSize;
	}
	@Override
	public String toString() {
		return "HotIssueFileVo [hissuefId=" + hissuefId + ", hissueId=" + hissueId + ", hiussefFilepath="
				+ hiussefFilepath + ", hissuefFilename=" + hissuefFilename + ", regDt=" + regDt + ", hissuefSize="
				+ hissuefSize + "]";
	}
	
}
