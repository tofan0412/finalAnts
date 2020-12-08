package ants.com.board.memBoard.mapper;

import java.util.List;

import ants.com.board.memBoard.model.AllBookMarkVo;
import ants.com.board.memBoard.model.BookmarkVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.model.ScheduleVo;
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
	public int delreply(ReplyVo replyVo);
	
	// 댓글 목록 조회
	public List<ReplyVo> replylist(ReplyVo replyVo);
	
	
	
	// 일정 등록
	public int scheduleInsert(ScheduleVo scheduleVo);
	
	// 일정 리스트
	public List<ScheduleVo> schedulelist(ScheduleVo scheduleVo);

	// 일정 리스트 갯수
	public int schedulelistCount(ScheduleVo scheduleVo);

	// 일정 상세페이지
	public ScheduleVo scheduleSelect(ScheduleVo scheduleVo);
	
	// 일정 업데이트
	public int scheduleUpdate(ScheduleVo scheduleVo);

	// 일정 삭제
	public int scheduleDelete(ScheduleVo scheduleVo);

	
	// 일정 리스트(캘린더용)
	public List<ScheduleVo> showCalendar(ScheduleVo scheduleVo);

	// 일정 등록(캘린더용)
	public int calendarInsert(ScheduleVo scheduleVo);

	// 일정 수정(캘린더용)
	public int calendarUpdate(ScheduleVo scheduleVo);

	
}
