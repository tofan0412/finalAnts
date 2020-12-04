package ants.com.board.memBoard.mapper;

import java.util.List;

import ants.com.board.memBoard.model.ReplyVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memBoardMapper")
public interface memBoardMapper {

	// 댓글 입력
	public int insertreply(ReplyVo replyVo);
	
	// 댓글 삭제
	public int delreply(String replyId);
	
	// 댓글 목록 조회
	public List<ReplyVo> replylist(ReplyVo replyVo);
}
