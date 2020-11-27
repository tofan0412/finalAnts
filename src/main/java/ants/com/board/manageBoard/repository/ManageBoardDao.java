package ants.com.board.manageBoard.repository;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import ants.com.board.manageBoard.model.TodoVo;

@Repository("manageBoardDao")
public class ManageBoardDao implements ManageBoardDaoI{

	@Resource(name="SqlSessionTemplate")
	SqlSessionTemplate sqlSession;
	
	@Override
	public int todoInsert(TodoVo todoVo) {
		return sqlSession.insert("manager.todoInsert",todoVo);
	}

}
