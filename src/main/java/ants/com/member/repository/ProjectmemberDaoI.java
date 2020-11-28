package ants.com.member.repository;

import java.util.List;

import ants.com.board.memBoard.model.IssueVo;

public interface ProjectmemberDaoI {
	
	// 이슈리스트
	public List<IssueVo> issuelist(String req_id);
	
	// 해당 이슈
	public IssueVo geteachissue(String issue_id);
	
	// 이슈게시글 작성자 이름 가져오기
	public String getwritername(String mem_id);
}
