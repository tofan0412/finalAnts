package ants.com.board.manageBoard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.manageBoard.mapper.ManageBoardMapper;
import ants.com.board.manageBoard.model.TodoVo;
import ants.com.member.model.ProjectMemberVo;

@Service("manageBoardService")
public class ManageBoardService{
	
	@Resource(name="manageBoardMapper")
	private ManageBoardMapper mapper;
	
	public int todoInsert(TodoVo todoVo) {
		return mapper.todoInsert(todoVo);
	}

	public List<TodoVo> getTodo(String req_id) {
		return mapper.getTodo(req_id);
	}

	public List<ProjectMemberVo> projectMemList(String req_id) {
		return mapper.projectMemList(req_id);
	}

}
