package ants.com.board.memBoard.model;

import java.util.Date;

public class SuggestVo {

	
	private String sgtId;
	private String sgtTitle;
	private String sgtCont;
	private Date regDt;
	private String sgtStatus;
	private String categoryId;
	private String todoId;
	private String del;
	public String getSgtId() {
		return sgtId;
	}
	public void setSgtId(String sgtId) {
		this.sgtId = sgtId;
	}
	public String getSgtTitle() {
		return sgtTitle;
	}
	public void setSgtTitle(String sgtTitle) {
		this.sgtTitle = sgtTitle;
	}
	public String getSgtCont() {
		return sgtCont;
	}
	public void setSgtCont(String sgtCont) {
		this.sgtCont = sgtCont;
	}
	public Date getRegDt() {
		return regDt;
	}
	public void setRegDt(Date regDt) {
		this.regDt = regDt;
	}
	public String getSgtStatus() {
		return sgtStatus;
	}
	public void setSgtStatus(String sgtStatus) {
		this.sgtStatus = sgtStatus;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getTodoId() {
		return todoId;
	}
	public void setTodoId(String todoId) {
		this.todoId = todoId;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	@Override
	public String toString() {
		return "SuggestVo [sgtId=" + sgtId + ", sgtTitle=" + sgtTitle + ", sgtCont=" + sgtCont + ", regDt=" + regDt
				+ ", sgtStatus=" + sgtStatus + ", categoryId=" + categoryId + ", todoId=" + todoId + ", del=" + del
				+ "]";
	}
	
}
