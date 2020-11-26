package ants.com.member.model;

import java.util.Date;

public class ProjectVo {
	
	
	private String REQ_ID;
	private String MEM_ID;
	private String PRO_NAME;
	private String PERCENT;
	private Date REG_DT;
	
	
	public String getREQ_ID() {
		return REQ_ID;
	}
	public void setREQ_ID(String rEQ_ID) {
		REQ_ID = rEQ_ID;
	}
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}
	public String getPRO_NAME() {
		return PRO_NAME;
	}
	public void setPRO_NAME(String pRO_NAME) {
		PRO_NAME = pRO_NAME;
	}
	public String getPERCENT() {
		return PERCENT;
	}
	public void setPERCENT(String pERCENT) {
		PERCENT = pERCENT;
	}
	public Date getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(Date rEG_DT) {
		REG_DT = rEG_DT;
	}
	
	
	@Override
	public String toString() {
		return "ProjectVo [REQ_ID=" + REQ_ID + ", MEM_ID=" + MEM_ID + ", PRO_NAME=" + PRO_NAME + ", PERCENT=" + PERCENT
				+ ", REG_DT=" + REG_DT + "]";
	}
	
	
}
