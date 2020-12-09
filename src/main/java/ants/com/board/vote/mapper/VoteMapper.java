package ants.com.board.vote.mapper;

import java.util.List;

import ants.com.board.vote.model.VoteItemVo;
import ants.com.board.vote.model.VoteVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("voteMapper")
public interface VoteMapper {

	// 해당 프로젝트의 투표내역
	public List<VoteVo> votelist(VoteVo votevo);
	
	// 해당 프로젝트의 투표목록 수
	public int votePagingListCnt(VoteVo votevo);
	
	// 다음 투표 아이디 조회
	public String getvoteid();
	
	// 투표테이블 등록
	public int insertvote(VoteVo voteVo);
	
	// 투표아이템 테이블 등록
	public int insertvoteitem(VoteItemVo voteitemVo);
	
	// 투표 상세보기
	public List<VoteItemVo> voteDetail(VoteVo voteVo);
	
	
}
