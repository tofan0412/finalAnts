package ants.com.common.model;

import java.util.Date;

public class QnaVo {
	
	
	private String QNA_ID;
	private String QNA_TITLE;
	private String QNA_CONT;
	private Date REG_DT;
	private String MEM_ID;
	private String QNA_PARENTID;
	private String QNA_LEVEL;
	private String QNA_STATUS;
	private String DEL;
	
	
	public String getQNA_ID() {
		return QNA_ID;
	}
	public void setQNA_ID(String qNA_ID) {
		QNA_ID = qNA_ID;
	}
	public String getQNA_TITLE() {
		return QNA_TITLE;
	}
	public void setQNA_TITLE(String qNA_TITLE) {
		QNA_TITLE = qNA_TITLE;
	}
	public String getQNA_CONT() {
		return QNA_CONT;
	}
	public void setQNA_CONT(String qNA_CONT) {
		QNA_CONT = qNA_CONT;
	}
	public Date getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(Date rEG_DT) {
		REG_DT = rEG_DT;
	}
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}
	public String getQNA_PARENTID() {
		return QNA_PARENTID;
	}
	public void setQNA_PARENTID(String qNA_PARENTID) {
		QNA_PARENTID = qNA_PARENTID;
	}
	public String getQNA_LEVEL() {
		return QNA_LEVEL;
	}
	public void setQNA_LEVEL(String qNA_LEVEL) {
		QNA_LEVEL = qNA_LEVEL;
	}
	public String getQNA_STATUS() {
		return QNA_STATUS;
	}
	public void setQNA_STATUS(String qNA_STATUS) {
		QNA_STATUS = qNA_STATUS;
	}
	public String getDEL() {
		return DEL;
	}
	public void setDEL(String dEL) {
		DEL = dEL;
	}
	
	
	@Override
	public String toString() {
		return "QnaVo [QNA_ID=" + QNA_ID + ", QNA_TITLE=" + QNA_TITLE + ", QNA_CONT=" + QNA_CONT + ", REG_DT=" + REG_DT
				+ ", MEM_ID=" + MEM_ID + ", QNA_PARENTID=" + QNA_PARENTID + ", QNA_LEVEL=" + QNA_LEVEL + ", QNA_STATUS="
				+ QNA_STATUS + ", DEL=" + DEL + "]";
	}
	
	
	
}
