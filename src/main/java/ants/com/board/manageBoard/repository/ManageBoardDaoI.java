package ants.com.board.manageBoard.repository;

import ants.com.board.manageBoard.model.TodoVo;

public interface ManageBoardDaoI {

	// 일감 등록
	public int todoInsert(TodoVo todoVo);
}
