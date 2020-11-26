package ants.com.board.vote.model;

import java.util.Date;

public class VoteVo {
	
	
	private String vote_id;
	private String vote_totalno;
	private Date vote_deadline;
	private String vote_status;
	private String category_id;
	private String req_id;
	private String mem_id;
	private String del;
	
	
	public String getVote_id() {
		return vote_id;
	}
	public void setVote_id(String vote_id) {
		this.vote_id = vote_id;
	}
	public String getVote_totalno() {
		return vote_totalno;
	}
	public void setVote_totalno(String vote_totalno) {
		this.vote_totalno = vote_totalno;
	}
	public Date getVote_deadline() {
		return vote_deadline;
	}
	public void setVote_deadline(Date vote_deadline) {
		this.vote_deadline = vote_deadline;
	}
	public String getVote_status() {
		return vote_status;
	}
	public void setVote_status(String vote_status) {
		this.vote_status = vote_status;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
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
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	
	
	@Override
	public String toString() {
		return "VoteVo [vote_id=" + vote_id + ", vote_totalno=" + vote_totalno + ", vote_deadline=" + vote_deadline
				+ ", vote_status=" + vote_status + ", category_id=" + category_id + ", req_id=" + req_id + ", mem_id="
				+ mem_id + ", del=" + del + "]";
	}
	
	
	
}
