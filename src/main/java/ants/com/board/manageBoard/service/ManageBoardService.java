package ants.com.board.manageBoard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.repository.ManageBoardDaoI;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.repository.MemberDaoI;

@Service("manageBoardService")
public class ManageBoardService implements ManageBoardServiceI{
	
	@Resource(name="manageBoardDao")
	ManageBoardDaoI managerDao;
	
	@Override
	public int todoInsert(TodoVo todoVo) {
		return managerDao.todoInsert(todoVo);
	}

	@Override
	public List<TodoVo> getTodo(String req_id) {
		return managerDao.getTodo(req_id);
	}

	@Override
	public List<ProjectMemberVo> projectMemList(String req_id) {
		return managerDao.projectMemList(req_id);
	}

}
