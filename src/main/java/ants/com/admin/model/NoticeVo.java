package ants.com.admin.model;

import java.util.Date;

import ants.com.base.model.BaseVo;

public class NoticeVo extends BaseVo{
	
	
	private String noticeId; //인덱스 == issueId
	private String noticeTitle; //글제목 == issueTitle
	private String noticeCont; //글내용 == issueCont
	private String regDt; //작성일
	private String adminId; //작성자 == memId
	private String del; //삭제여부 == 어디갔지?
	private String importance; //긴급공지?
	private String main;
	
	
	public String getMain() {
		return main;
	}
	public void setMain(String main) {
		this.main = main;
	}
	public String getImportance() {
		return importance;
	}
	public void setImportance(String importance) {
		this.importance = importance;
	}
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
				+ ", regDt=" + regDt + ", adminId=" + adminId + ", del=" + del + ", importance=" + importance
				+ ", main=" + main + "]";
	}
	
	
	
	
	
	
}
