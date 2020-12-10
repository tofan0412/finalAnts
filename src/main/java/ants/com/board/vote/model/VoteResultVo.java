package ants.com.board.vote.model;

public class VoteResultVo {
	
	
	private String voteresId;
	private String voteitemId;
	private String memId;
	private String voteId;
	
	public String getVoteresId() {
		return voteresId;
	}
	public void setVoteresId(String voteresId) {
		this.voteresId = voteresId;
	}
	public String getVoteitemId() {
		return voteitemId;
	}
	public void setVoteitemId(String voteitemId) {
		this.voteitemId = voteitemId;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	
	public String getVoteId() {
		return voteId;
	}
	public void setVoteId(String voteId) {
		this.voteId = voteId;
	}
	@Override
	public String toString() {
		return "VoteResultVo [voteresId=" + voteresId + ", voteitemId=" + voteitemId + ", memId=" + memId + ", voteId="
				+ voteId + "]";
	}
	
	
	
}
