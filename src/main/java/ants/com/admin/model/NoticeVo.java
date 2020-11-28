package ants.com.admin.model;

import java.util.Date;

public class NoticeVo {
	
	
	private String noticeId;
	private String noticeTitle;
	private String noticeCont;
	private String regDt;
	private String adminId;
	private String del;
	
	public String getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeCont() {
		return noticeCont;
	}
	public void setNoticeCont(String noticeCont) {
		this.noticeCont = noticeCont;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	
	@Override
	public String toString() {
		return "NoticeVo [noticeId=" + noticeId + ", noticeTitle=" + noticeTitle + ", noticeCont=" + noticeCont
				+ ", regDt=" + regDt + ", adminId=" + adminId + ", del=" + del + "]";
	}
	
	
	
	
	
	
}
