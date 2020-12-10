package ants.com.file.model;


import ants.com.base.model.BaseVo;

public class HotIssueFileVo extends BaseVo{
	
	private String hissuefId;
	private String hissueId;
	private String hiussefFilepath;
	private String hissuefFilename;
	private String hissuefExtension;
	private String regDt;
	private String hissuefSize;
	
	
	public HotIssueFileVo() {
	}
	
	// 파일 검색시
	public HotIssueFileVo(String hissuefId, String hissueId) {
		super();
		this.hissuefId = hissuefId;
		this.hissueId = hissueId;
	}

	
	public HotIssueFileVo(String hissueId, String hiussefFilepath, String hissuefFilename, String hissuefExtension,
			String hissuefSize) {
		super();
		this.hissueId = hissueId;
		this.hiussefFilepath = hiussefFilepath;
		this.hissuefFilename = hissuefFilename;
		this.hissuefExtension = hissuefExtension;
		this.hissuefSize = hissuefSize;
	}

	public String getHissuefId() {
		return hissuefId;
	}
	public String getHissuefExtension() {
		return hissuefExtension;
	}

	public void setHissuefExtension(String hissuefExtension) {
		this.hissuefExtension = hissuefExtension;
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
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
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
