package ants.com.board.vote.model;

public class VoteItemVo {
	
	
	private String voteitemId;
	private String voteitemName;
	private String voteId;
	
	
	public String getVoteitem_id() {
		return voteitemId;
	}
	public void setVoteitem_id(String voteitem_id) {
		this.voteitemId = voteitem_id;
	}
	public String getVoteitem_name() {
		return voteitemName;
	}
	public void setVoteitem_name(String voteitem_name) {
		this.voteitemName = voteitem_name;
	}
	public String getVote_id() {
		return voteId;
	}
	public void setVote_id(String vote_id) {
		this.voteId = vote_id;
	}
	
	
	@Override
	public String toString() {
		return "VoteItemVo [voteitem_id=" + voteitemId + ", voteitem_name=" + voteitemName + ", vote_id=" + voteId
				+ "]";
	}
	
	
}
