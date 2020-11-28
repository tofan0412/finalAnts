package ants.com.member.repository;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import ants.com.board.memBoard.model.IssueVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Repository("promemRepository")
public class ProjectmemberDao  implements ProjectmemberDaoI {

	@Resource(name="SqlSessionTemplate")
	SqlSessionTemplate sqlSession;
	
	// 이슈게시판리스트
	@Override
	public List<IssueVo> issuelist(String req_id) {
		
		return sqlSession.selectList("issue.getissuelist",req_id);
	}
	
	// 각 이슈게시글 내용
	@Override
	public IssueVo geteachissue(String issue_id) {
		
		return sqlSession.selectOne("issue.geteachissue", issue_id);
	}

	// 이슈게시글 작성자 이름 가져오기
	@Override
	public String getwritername(String mem_id) {
		
		return sqlSession.selectOne("issue.getwritername", mem_id);
	}

}
