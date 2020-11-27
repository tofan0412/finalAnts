package ants.com.board.memBoard.model;

public class BookmarkVo {
	
	
	private String book_id;
	private String issue_id;
	private String req_id;
	private String mem_id;
	
	
	public String getBook_id() {
		return book_id;
	}
	public void setBook_id(String book_id) {
		this.book_id = book_id;
	}
	public String getIssue_id() {
		return issue_id;
	}
	public void setIssue_id(String issue_id) {
		this.issue_id = issue_id;
	}
	public String getReq_id() {
		return req_id;
	}
	public void setReq_id(String req_id) {
		this.req_id = req_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	
	@Override
	public String toString() {
		return "BookmarkVo [book_id=" + book_id + ", issue_id=" + issue_id + ", req_id=" + req_id + ", mem_id=" + mem_id
				+ "]";
	}
	
	
}
