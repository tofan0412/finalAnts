package ants.com.board.memBoard.mapper;

import java.util.List;

import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.model.ScheduleVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memBoardMapper")
public interface memBoardMapper {

	// 댓글 입력
	public int insertreply(ReplyVo replyVo);
	
	// 댓글 삭제
	public int delreply(String replyId);
	
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
}
