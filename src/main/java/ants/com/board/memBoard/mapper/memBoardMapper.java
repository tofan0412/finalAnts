package ants.com.board.memBoard.mapper;

import java.util.List;

import ants.com.board.memBoard.model.AllBookMarkVo;
import ants.com.board.memBoard.model.BookmarkVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.member.model.ProjectMemberVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memBoardMapper")
public interface memBoardMapper {

	// 로그인한 사람의 클릭한 프로젝트 북마크한 이력
	public List<BookmarkVo> getbookmark(ProjectMemberVo promemVo);
	
	// 로그인한 사람의 북마크 등록
	public int insertbookmark(BookmarkVo bookmarkVo);
	
	// 로그인한 사람의 북마크 삭제
	public int removebookmark(BookmarkVo bookmarkVo);
	
	// 로그인한 사람의 모든 북마크한 이력
	public List<BookmarkVo> getallbookmark(AllBookMarkVo allbookmarkVo);
	
	// 로그이한 사람의 북마크 수
	public int bookmarkPagingListCnt(AllBookMarkVo allbookmarkVo);
	
	// 댓글 입력
	public int insertreply(ReplyVo replyVo);
	
	// 댓글 삭제
	public int delreply(String replyId);
	
	// 댓글 목록 조회
	public List<ReplyVo> replylist(ReplyVo replyVo);
}
