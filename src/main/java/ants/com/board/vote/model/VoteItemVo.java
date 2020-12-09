package ants.com.board.vote.model;

public class VoteItemVo {
	
	
	private String voteitemId;
	private String voteitemName;
	private String voteId;
	
	public String getVoteitemId() {
		return voteitemId;
	}
	public void setVoteitemId(String voteitemId) {
		this.voteitemId = voteitemId;
	}
	public String getVoteitemName() {
		return voteitemName;
	}
	public void setVoteitemName(String voteitemName) {
		this.voteitemName = voteitemName;
	}
	public String getVoteId() {
		return voteId;
	}
	public void setVoteId(String voteId) {
		this.voteId = voteId;
	}
	@Override
	public String toString() {
		return "VoteItemVo [voteitemId=" + voteitemId + ", voteitemName=" + voteitemName + ", voteId=" + voteId + "]";
	}
	
	
	

	
	
}
