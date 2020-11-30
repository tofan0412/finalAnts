package ants.com.board.manageBoard.mapper;

import java.util.List;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.member.model.MemberVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manageBoardMapper")
public interface ManageBoardMapper {

	// 일감 등록
	public int todoInsert(TodoVo todoVo);

	// 일감리스트 조회
	public List<TodoVo> getTodoList(String req_id);

	// 한개의 일감 조회
	public TodoVo getTodo(String todo_id);

	// 팀원 조회
	public List<MemberVo> projectMemList(String req_id);
}
