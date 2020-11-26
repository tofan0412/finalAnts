package ants.com.admin.model;

import java.util.Date;

public class NoticeVo {
	
	
	private String NOTICE_ID;
	private String NOTICE_TITLE;
	private String NOTICE_CONT;
	private Date REG_DT;
	private String ADMIN_ID;
	private String DEL;
	
	
	public String getNOTICE_ID() {
		return NOTICE_ID;
	}
	public void setNOTICE_ID(String nOTICE_ID) {
		NOTICE_ID = nOTICE_ID;
	}
	public String getNOTICE_TITLE() {
		return NOTICE_TITLE;
	}
	public void setNOTICE_TITLE(String nOTICE_TITLE) {
		NOTICE_TITLE = nOTICE_TITLE;
	}
	public String getNOTICE_CONT() {
		return NOTICE_CONT;
	}
	public void setNOTICE_CONT(String nOTICE_CONT) {
		NOTICE_CONT = nOTICE_CONT;
	}
	public Date getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(Date rEG_DT) {
		REG_DT = rEG_DT;
	}
	public String getADMIN_ID() {
		return ADMIN_ID;
	}
	public void setADMIN_ID(String aDMIN_ID) {
		ADMIN_ID = aDMIN_ID;
	}
	public String getDEL() {
		return DEL;
	}
	public void setDEL(String dEL) {
		DEL = dEL;
	}
	
	
	@Override
	public String toString() {
		return "NoticeVo [NOTICE_ID=" + NOTICE_ID + ", NOTICE_TITLE=" + NOTICE_TITLE + ", NOTICE_CONT=" + NOTICE_CONT
				+ ", REG_DT=" + REG_DT + ", ADMIN_ID=" + ADMIN_ID + ", DEL=" + DEL + "]";
	}
	
	
	
}
