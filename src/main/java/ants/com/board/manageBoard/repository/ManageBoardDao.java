package ants.com.board.manageBoard.repository;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.member.model.ProjectMemberVo;

@Repository("manageBoardDao")
public class ManageBoardDao implements ManageBoardDaoI{

	@Resource(name="SqlSessionTemplate")
	SqlSessionTemplate sqlSession;
	
	@Override
	public int todoInsert(TodoVo todoVo) {
		return sqlSession.insert("todo.todoInsert",todoVo);
	}

	@Override
	public List<TodoVo> getTodo(String req_id) {
		return sqlSession.selectList("todo.getTodo", req_id);
	}

	@Override
	public List<ProjectMemberVo> projectMemList(String req_id) {
		return sqlSession.selectList("projectMember.projectMemList", req_id);
	}
	
}
