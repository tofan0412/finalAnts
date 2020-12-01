package ants.com.member.mapper;

import java.util.List;

import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.model.ProjectVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("promemMapper")
public interface ProjectmemberMapper {
	
	// 이슈리스트
	public List<IssueVo> issuelist(IssueVo issueVo);
	
	// 해당 이슈
	public IssueVo geteachissue(String issueId);
	
	// 이슈게시글 작성
	public int insertissue(IssueVo issueVo);
	
	// 이슈게시글 수정
	public int updateissue(IssueVo issueVo);
	
	// 이슈게시글 삭제
	public int delissue(String issueId);
	
	// 회원이 사용가능한 카테고리 조회
	public List<CategoryVo> categorylist(String memId);
	
	
	// 회원이 사용가능한 카테고리 조회
	public int issuePagingListCnt(IssueVo issueVo);
	
	//프로젝트명 불러오기
	public List<ProjectVo> memInProjectList(String memId);
}
