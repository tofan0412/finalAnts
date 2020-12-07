package ants.com.board.memBoard.model;

public class ReplyVo {
	
	
	private String replyId;
	private String someId;
	private String replyCont;
	private String regDt;
	private String del;
	private String categoryId;
	private String reqId;
	private String memId;
	
	public ReplyVo() {
		// TODO Auto-generated constructor stub
	}	
	
	public ReplyVo(String someId, String categoryId, String reqId, String memId) {
		super();
		this.someId = someId;
		this.categoryId = categoryId;
		this.reqId = reqId;
		this.memId = memId;
	}
	
	public String getReplyId() {
		return replyId;
	}
	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}
	public String getSomeId() {
		return someId;
	}
	public void setSomeId(String someId) {
		this.someId = someId;
	}
	public String getReplyCont() {
		return replyCont;
	}
	public void setReplyCont(String replyCont) {
		this.replyCont = replyCont;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	
	@Override
	public String toString() {
		return "ReplyVo [replyId=" + replyId + ", someId=" + someId + ", replyCont=" + replyCont + ", regDt=" + regDt
				+ ", del=" + del + ", categoryId=" + categoryId + ", reqId=" + reqId + ", memId=" + memId + "]";
	}
	
	
}
