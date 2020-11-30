package ants.com.board.vote.model;

import java.util.Date;

public class VoteVo {
	
	
	private String voteId;
	private String voteTotalno;
	private Date voteDeadline;
	private String voteStatus;
	private String categoryId;
	private String reqId;
	private String memId;
	private String del;
	public String getVoteId() {
		return voteId;
	}
	public void setVoteId(String voteId) {
		this.voteId = voteId;
	}
	public String getVoteTotalno() {
		return voteTotalno;
	}
	public void setVoteTotalno(String voteTotalno) {
		this.voteTotalno = voteTotalno;
	}
	public Date getVoteDeadline() {
		return voteDeadline;
	}
	public void setVoteDeadline(Date voteDeadline) {
		this.voteDeadline = voteDeadline;
	}
	public String getVoteStatus() {
		return voteStatus;
	}
	public void setVoteStatus(String voteStatus) {
		this.voteStatus = voteStatus;
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
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	@Override
	public String toString() {
		return "VoteVo [voteId=" + voteId + ", voteTotalno=" + voteTotalno + ", voteDeadline=" + voteDeadline
				+ ", voteStatus=" + voteStatus + ", categoryId=" + categoryId + ", reqId=" + reqId + ", memId=" + memId
				+ ", del=" + del + "]";
	}
	
}
