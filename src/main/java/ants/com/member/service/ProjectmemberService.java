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
	public List<IssueVo> issuelist(String req_id) {
		
		
		return projectmemdao.issuelist(req_id);
	}

	// 각 이슈글 내용
	@Override
	public IssueVo geteachissue(String issue_id) {
		return projectmemdao.geteachissue(issue_id);
	}

}
