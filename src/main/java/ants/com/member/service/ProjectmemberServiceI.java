package ants.com.member.service;

import java.util.List;

import ants.com.board.memBoard.model.IssueVo;

public interface ProjectmemberServiceI {

	// 이슈리스트
	public List<IssueVo> issuelist(String reqId);
	
	// 해당 이슈
	public IssueVo geteachissue(String issueId);
	
	// 이슈게시글 작성
	public int insertissue(IssueVo issueVo);
		
	// 이슈게시글 수정
	public int updateissue(IssueVo issueVo);
	
	// 이슈게시글 삭제
	public int delissue(String issueId);
}
