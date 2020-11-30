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
	public List<IssueVo> issuelist(String reqId) {
		
		return sqlSession.selectList("issue.getissuelist", reqId);
	}
	
	// 각 이슈게시글 내용
	@Override
	public IssueVo geteachissue(String issueId) {
		
		return sqlSession.selectOne("issue.geteachissue", issueId);
	}


	// 이슈게시글 작성하기
	@Override
	public int insertissue(IssueVo issueVo) {
		return sqlSession.insert("issue.insertissue", issueVo);
	}

	// 이슈게시글 수정하기
	@Override
	public int updateissue(IssueVo issueVo) {
		
		return sqlSession.update("issue.updateissue", issueVo);
	}

	@Override
	public int delissue(String issueId) {
		
		return sqlSession.update("issue.delissue", issueId);
	}

}
