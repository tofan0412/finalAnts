package ants.com.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.mapper.ProjectmemberMapper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("promemService")
public class ProjectmemberService extends EgovAbstractServiceImpl{
	
	@Resource(name ="promemMapper")
	private ProjectmemberMapper mapper;
	
	
	// 이슈글 리스트
	public List<IssueVo> issuelist(String reqId) {
		return mapper.issuelist(reqId);
	}

	// 각 이슈글 내용
	public IssueVo geteachissue(String issueId) {
		return mapper.geteachissue(issueId);
	}

	// 이슈글 작성하기
	public int insertissue(IssueVo issueVo) {
		return mapper.insertissue(issueVo);
	}

	// 이슈글 수정하기
	public int updateissue(IssueVo issueVo) {
		
		return mapper.updateissue(issueVo);
	}

	// 이슈글 삭제하기
	public int delissue(String issueId) {
		return mapper.delissue(issueId);
	}
}
