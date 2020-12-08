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
import ants.com.board.memBoard.model.ScheduleVo;
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
	public int delreply(ReplyVo replyVo) throws SQLException, IOException {
		return mapper.delreply(replyVo);
	}
	
	// 댓글 목록 출력
	public List<ReplyVo> replylist (ReplyVo replyVo) throws SQLException, IOException {
		return mapper.replylist(replyVo);
	}
	
	

	// 일정 등록
	public int scheduleInsert(ScheduleVo scheduleVo) {
		return mapper.scheduleInsert(scheduleVo);
	}
	
	// 일정 리스트
	public List<ScheduleVo> schedulelist(ScheduleVo scheduleVo){
		return mapper.schedulelist(scheduleVo);
	}

	// 일정 리스트 갯수
	public int schedulelistCount(ScheduleVo scheduleVo) {
		return mapper.schedulelistCount(scheduleVo);
	}

	// 일정 상세페이지
	public ScheduleVo scheduleSelect(ScheduleVo scheduleVo) {
		return mapper.scheduleSelect(scheduleVo);
	}
	
	// 일정 업데이트
	public int scheduleUpdate(ScheduleVo scheduleVo) {
		return mapper.scheduleUpdate(scheduleVo);
	}
	
	// 일정 삭제
	public int scheduleDelete(ScheduleVo scheduleVo) {
		return mapper.scheduleDelete(scheduleVo);
	}
	
	// 일정 리스트(캘린더용)
	public List<ScheduleVo> showCalendar(ScheduleVo scheduleVo){
		return mapper.showCalendar(scheduleVo);
	}
	
	// 일정 등록(캘린더용)
	public int calendarInsert(ScheduleVo scheduleVo) {
		return mapper.calendarInsert(scheduleVo);
	}

	// 일정 수정(캘린더용_드래그)
	public int calendarUpdate(ScheduleVo scheduleVo) {
		return mapper.calendarUpdate(scheduleVo);
	}
	
	// 일정 삭제(캘린더용)
	public int calendarDelete(ScheduleVo scheduleVo) {
		return mapper.calendarDelete(scheduleVo);
	}
	
	// 일정 상세(캘린더용)
	public ScheduleVo calendarDetail(ScheduleVo scheduleVo) {
		return mapper.calendarDetail(scheduleVo);
	}
	

}
