package ants.com.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.repository.ProjectmemberDaoI;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("promemService")
public class ProjectmemberService extends EgovAbstractServiceImpl implements ProjectmemberServiceI{
	
	@Resource(name ="promemRepository")
	ProjectmemberDaoI projectmemdao;
	
	
	// 이슈글 리스트
	@Override
	public List<IssueVo> issuelist(String reqId) {
		
		return projectmemdao.issuelist(reqId);
	}

	// 각 이슈글 내용
	@Override
	public IssueVo geteachissue(String issueId) {
		return projectmemdao.geteachissue(issueId);
	}

	// 이슈글 작성하기
	@Override
	public int insertissue(IssueVo issueVo) {
		
		return projectmemdao.insertissue(issueVo);
	}

	// 이슈글 수정하기
	@Override
	public int updateissue(IssueVo issueVo) {
		
		return projectmemdao.updateissue(issueVo);
	}

	@Override
	public int delissue(String issueId) {
		return projectmemdao.delissue(issueId);
	}

}
