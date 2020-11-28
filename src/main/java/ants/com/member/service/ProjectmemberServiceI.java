package ants.com.member.service;

import java.util.List;

import ants.com.board.memBoard.model.IssueVo;

public interface ProjectmemberServiceI {

	// 이슈리스트
	public List<IssueVo> issuelist(String req_id);
	
	// 해당 이슈
	public IssueVo geteachissue(String issue_id);
}
