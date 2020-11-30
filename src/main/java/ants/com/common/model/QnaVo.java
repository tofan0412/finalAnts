package ants.com.common.model;

import java.util.Date;

public class QnaVo {
	
	
	private String qnaId;
	private String qnaTitle;
	private String qnaCont;
	private Date regDt;
	private String memId;
	private String qnaParentid;
	private String qnaLevel;
	private String qnaStatus;
	private String del;
	public String getQnaId() {
		return qnaId;
	}
	public void setQnaId(String qnaId) {
		this.qnaId = qnaId;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getQnaCont() {
		return qnaCont;
	}
	public void setQnaCont(String qnaCont) {
		this.qnaCont = qnaCont;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getQnaParentid() {
		return qnaParentid;
	}
	public void setQnaParentid(String qnaParentid) {
		this.qnaParentid = qnaParentid;
	}
	public String getQnaLevel() {
		return qnaLevel;
	}
	public void setQnaLevel(String qnaLevel) {
		this.qnaLevel = qnaLevel;
	}
	public String getQnaStatus() {
		return qnaStatus;
	}
	public void setQnaStatus(String qnaStatus) {
		this.qnaStatus = qnaStatus;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	@Override
	public String toString() {
		return "QnaVo [qnaId=" + qnaId + ", qnaTitle=" + qnaTitle + ", qnaCont=" + qnaCont + ", regDt=" + regDt
				+ ", memId=" + memId + ", qnaParentid=" + qnaParentid + ", qnaLevel=" + qnaLevel + ", qnaStatus="
				+ qnaStatus + ", del=" + del + "]";
	}
	
}
