package ants.com.board.memBoard.model;

public class BookmarkVo {
	
	
	private String bookId;
	private String issueId;
	private String reqId;
	private String memId;
	
	public String getBookId() {
		return bookId;
	}
	public void setBookId(String bookId) {
		this.bookId = bookId;
	}
	public String getIssueId() {
		return issueId;
	}
	public void setIssueId(String issueId) {
		this.issueId = issueId;
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
		return "BookmarkVo [bookId=" + bookId + ", issueId=" + issueId + ", reqId=" + reqId + ", memId=" + memId + "]";
	}
}
