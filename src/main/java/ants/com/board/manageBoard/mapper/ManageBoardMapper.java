package ants.com.board.manageBoard.mapper;

import java.util.List;

import ants.com.board.manageBoard.model.TodoLogVo;
import ants.com.board.manageBoard.model.TodoVo;
import ants.com.member.model.MemberVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manageBoardMapper")
public interface ManageBoardMapper {

	// 일감 등록
	public int todoInsert(TodoVo todoVo);

	// 일감리스트 조회
	public List<TodoVo> getTodoList(TodoVo todoVo);

	// 한개의 일감 조회
	public TodoVo getTodo(TodoVo todoVo);

	// 팀원 조회
	public List<MemberVo> projectMemList(TodoVo todoVo);
	
	// 일감 수정
	public int todoupdate(TodoVo todoVo);
	
	// 일감 삭제
	public int tododelete(TodoVo todoVo);
	
	// 인수인계
	public int todoChangeMem(TodoLogVo todoLogVo);
	
}
