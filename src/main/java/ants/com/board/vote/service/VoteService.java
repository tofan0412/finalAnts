package ants.com.board.vote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.vote.mapper.VoteMapper;
import ants.com.board.vote.model.VoteItemVo;
import ants.com.board.vote.model.VoteResultVo;
import ants.com.board.vote.model.VoteVo;

@Service("voteService")
public class VoteService{
	@Resource(name="voteMapper")
	private VoteMapper mapper; 
	
	//해당 프로젝트의 투표목록
	public List<VoteVo> votelist(VoteVo votevo){
		return mapper.votelist(votevo);
	}
	
	// 해당 프로젝트의 투표목록 개수
	public int votePagingListCnt(VoteVo votevo) {
		return mapper.votePagingListCnt(votevo);
	}
	
	// 다음 투표 id조회
	public String getvoteid() {
		return mapper.getvoteid();
	}
	
	// 투표테이블 등록
	public int insertvote(VoteVo voteVo) {
		return mapper.insertvote(voteVo);
	}
	
	// 투표아이템 테이블 등록
	public int insertvoteitem(VoteItemVo voteitemVo) {
		return mapper.insertvoteitem(voteitemVo);
	}
	
	// 투표아이템 상세보기
	public List<VoteItemVo> voteitemDetail(VoteVo voteVo){
		return mapper.voteitemDetail(voteVo);
	}
	
	// 해당 투표 상세
	public VoteVo voteDetail(VoteVo voteVo) {
		return mapper.voteDetail(voteVo);
	}
	
	// 해당 투표 상세
	public VoteResultVo voteresDetail(VoteVo voteVo) {
		return mapper.voteresDetail(voteVo);
	}
	
	// 멤버 투표
	public int voteMember(VoteResultVo voteresultvo) {
		int insertCnt = mapper.voteMember(voteresultvo);
		int j,k =0;
		if(insertCnt>0) {			
			j = mapper.cntupdate(voteresultvo);// 투표 카운트 update
			if(j>0) {
				k = mapper.fullstatusupdate(voteresultvo);// 투표기간 지난 투표상태 변경
			}
		}	
		return k;
	}
			
	// 투표기간 지난 투표상태 변경
	public int paststatusupdate() {
		return mapper.paststatusupdate();
	}
	
	// 투표 삭제
	public int delvote(VoteVo voteVo) {
		return mapper.votedel(voteVo);
	}
	
}
