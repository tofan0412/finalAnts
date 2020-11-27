package ants.com.board.vote.model;

public class VoteItemVo {
	
	
	private String voteitem_id;
	private String voteitem_name;
	private String vote_id;
	
	
	public String getVoteitem_id() {
		return voteitem_id;
	}
	public void setVoteitem_id(String voteitem_id) {
		this.voteitem_id = voteitem_id;
	}
	public String getVoteitem_name() {
		return voteitem_name;
	}
	public void setVoteitem_name(String voteitem_name) {
		this.voteitem_name = voteitem_name;
	}
	public String getVote_id() {
		return vote_id;
	}
	public void setVote_id(String vote_id) {
		this.vote_id = vote_id;
	}
	
	
	@Override
	public String toString() {
		return "VoteItemVo [voteitem_id=" + voteitem_id + ", voteitem_name=" + voteitem_name + ", vote_id=" + vote_id
				+ "]";
	}
	
	
}
