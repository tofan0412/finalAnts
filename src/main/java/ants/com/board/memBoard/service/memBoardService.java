package ants.com.board.memBoard.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.mapper.memBoardMapper;
import ants.com.board.memBoard.model.AllBookMarkVo;
import ants.com.board.memBoard.model.BookmarkVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;

@Service("memBoardService")
public class memBoardService{
	
	@Resource(name="memBoardMapper")
	private memBoardMapper mapper;
	
	// 로그인한 사람의 해당 프로젝트의 북마크한 이력
	public List<BookmarkVo> getbookmark(ProjectMemberVo promemVo) throws SQLException, IOException{
		return mapper.getbookmark(promemVo);
	}
	
	// 로그인한 사람의 북마크 등록
	public int insertbookmark(BookmarkVo bookmarkVo) throws SQLException, IOException{
		return mapper.insertbookmark(bookmarkVo);
	}
	
	// 로그인한 사람의 북마크 삭제
	public int removebookmark(BookmarkVo bookmarkVo) throws SQLException, IOException{
		return mapper.removebookmark(bookmarkVo);
	}
	
	// 로그인한 사람의 모든 북마크한 이력
	public List<BookmarkVo> getallbookmark(AllBookMarkVo allbookmarkVo) throws SQLException, IOException{
		return mapper.getallbookmark(allbookmarkVo);
	}	
	
	// 로그인한 사람의 북마크 개수
	public int bookmarkPagingListCnt(AllBookMarkVo allbookmarkVo) throws SQLException, IOException{
		return mapper.bookmarkPagingListCnt(allbookmarkVo);
	}
	
	
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
