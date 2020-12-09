package ants.com.board.vote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.vote.mapper.VoteMapper;
import ants.com.board.vote.model.VoteItemVo;
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
	
	// 투표 상세보기
	public List<VoteItemVo> voteDetail(VoteVo voteVo){
		return mapper.voteDetail(voteVo);
	}
}
