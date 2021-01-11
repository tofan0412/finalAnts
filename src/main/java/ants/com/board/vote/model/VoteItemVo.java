package ants.com.board.vote.model;

public class VoteItemVo {
	
	
	private String voteitemId;
	private String voteitemName;
	private String voteId;
	private String voteCount;
	private String percent;
	
	
	
	public String getPercent() {
		return percent;
	}
	public void setPercent(String percent) {
		this.percent = percent;
	}
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
	
	public String getVoteCount() {
		return voteCount;
	}
	public void setVoteCount(String voteCount) {
		this.voteCount = voteCount;
	}
	@Override
	public String toString() {
		return "VoteItemVo [voteitemId=" + voteitemId + ", voteitemName=" + voteitemName + ", voteId=" + voteId
				+ ", voteCount=" + voteCount + "]";
	}

	
	
	

	
	
}
