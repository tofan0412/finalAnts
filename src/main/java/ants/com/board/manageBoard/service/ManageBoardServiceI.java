package ants.com.board.manageBoard.service;

import java.util.List;

import ants.com.board.manageBoard.model.TodoVo;

public interface ManageBoardServiceI {

	// 일감 등록
	public int todoInsert(TodoVo todoVo);
	
	// 일감 조회
	public List<TodoVo> getTodo(String req_id);
}
