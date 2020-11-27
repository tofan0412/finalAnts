package ants.com.board.vote.model;

public class VoteResultVo {
	
	
	private String VOTERES_ID;
	private String VOTEITEM_ID;
	private String MEM_ID;
	
	
	public String getVOTERES_ID() {
		return VOTERES_ID;
	}
	public void setVOTERES_ID(String vOTERES_ID) {
		VOTERES_ID = vOTERES_ID;
	}
	public String getVOTEITEM_ID() {
		return VOTEITEM_ID;
	}
	public void setVOTEITEM_ID(String vOTEITEM_ID) {
		VOTEITEM_ID = vOTEITEM_ID;
	}
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}
	
	
	@Override
	public String toString() {
		return "VoteResultVo [VOTERES_ID=" + VOTERES_ID + ", VOTEITEM_ID=" + VOTEITEM_ID + ", MEM_ID=" + MEM_ID + "]";
	}
	
	
}
