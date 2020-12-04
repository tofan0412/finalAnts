package ants.com.board.memBoard.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.mapper.memBoardMapper;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.member.model.MemberVo;

@Service("memBoardService")
public class memBoardService{
	
	@Resource(name="memBoardMapper")
	private memBoardMapper mapper;
	
	// 댓글 입력
	public int insertreply(ReplyVo replyVo) throws SQLException, IOException {
		return mapper.insertreply(replyVo);
	}
	
	// 댓글 삭제
	public int delreply(String replyId) throws SQLException, IOException {
		return mapper.delreply(replyId);
	}
	
	// 댓글 목록 출력
	public List<ReplyVo> replylist (ReplyVo replyVo) throws SQLException, IOException {
		return mapper.replylist(replyVo);
	}
}
