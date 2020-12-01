package ants.com.board.manageBoard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.manageBoard.mapper.ManageBoardMapper;
import ants.com.board.manageBoard.model.TodoLogVo;
import ants.com.board.manageBoard.model.TodoVo;
import ants.com.member.model.MemberVo;

@Service("manageBoardService")
public class ManageBoardService{
	
	@Resource(name="manageBoardMapper")
	private ManageBoardMapper mapper;
	
	public int todoInsert(TodoVo todoVo) {
		return mapper.todoInsert(todoVo);
	}

	public List<TodoVo> getTodoList(TodoVo todoVo) {
		return mapper.getTodoList(todoVo);
	}

	public List<MemberVo> projectMemList(TodoVo todoVo) {
		return mapper.projectMemList(todoVo);
	}
	
	public TodoVo getTodo(TodoVo todoVo) {
		return mapper.getTodo(todoVo);
	}

	public int todoupdate(TodoVo todoVo) {
		return mapper.todoupdate(todoVo);
	}

	public int tododelete(TodoVo todoVo) {
		return mapper.tododelete(todoVo);
	}
	
	public int todoChangeMem(TodoLogVo todoLogVo) {
		return mapper.todoChangeMem(todoLogVo);
	}

}
