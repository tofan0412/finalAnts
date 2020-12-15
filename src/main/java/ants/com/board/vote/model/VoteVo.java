package ants.com.board.vote.model;


import ants.com.base.model.BaseVo;

public class VoteVo extends BaseVo {
	
	
	private String voteId;
	private String voteTotalno;
	private String voteDeadline;
	private String voteStatus;
	private String categoryId;
	private String reqId;
	private String memId;
	private String memName;
	private String del;
	private String voteTitle;
	private String votedNo;
	private String remain;
	private String votepercent;
	
	
	public String getVotepercent() {
		return votepercent;
	}



	public void setVotepercent(String votepercent) {
		this.votepercent = votepercent;
	}



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



	public String getVoteDeadline() {
		return voteDeadline;
	}



	public void setVoteDeadline(String voteDeadline) {
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



	public String getVoteTitle() {
		return voteTitle;
	}



	public void setVoteTitle(String voteTitle) {
		this.voteTitle = voteTitle;
	}

	

	public String getVotedNo() {
		return votedNo;
	}



	public void setVotedNo(String votedNo) {
		this.votedNo = votedNo;
	}



	public String getRemain() {
		return remain;
	}



	public void setRemain(String remain) {
		this.remain = remain;
	}

	

	public String getMemName() {
		return memName;
	}



	public void setMemName(String memName) {
		this.memName = memName;
	}



	@Override
	public String toString() {
		return "VoteVo [voteId=" + voteId + ", voteTotalno=" + voteTotalno + ", voteDeadline=" + voteDeadline
				+ ", voteStatus=" + voteStatus + ", categoryId=" + categoryId + ", reqId=" + reqId + ", memId=" + memId
				+ ", memName=" + memName + ", del=" + del + ", voteTitle=" + voteTitle + ", votedNo=" + votedNo
				+ ", remain=" + remain + ", votepercent=" + votepercent + "]";
	}



	


	
	

	
	
}
