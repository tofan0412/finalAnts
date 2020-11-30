package ants.com.board.manageBoard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.manageBoard.mapper.ManageBoardMapper;
import ants.com.board.manageBoard.model.TodoVo;
import ants.com.member.model.MemberVo;

@Service("manageBoardService")
public class ManageBoardService{
	
	@Resource(name="manageBoardMapper")
	private ManageBoardMapper mapper;
	
	public int todoInsert(TodoVo todoVo) {
		return mapper.todoInsert(todoVo);
	}

	public List<TodoVo> getTodoList(String req_id) {
		return mapper.getTodoList(req_id);
	}

	public List<MemberVo> projectMemList(String req_id) {
		return mapper.projectMemList(req_id);
	}
	
	public TodoVo getTodo(String todo_id) {
		return mapper.getTodo(todo_id);
	}

}
