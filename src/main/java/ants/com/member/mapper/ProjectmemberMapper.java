package ants.com.member.mapper;

import java.util.List;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.model.ProjectVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("promemMapper")
public interface ProjectmemberMapper {
	
	// 해당 프로젝트에 본인이 참여하고 있는 일감조회
	public List<TodoVo> mytodolist(ProjectMemberVo promemVo);
	
	// 해당 프로젝트 이슈리스트
	public List<IssueVo> issuelist(IssueVo issueVo);
	
	// 해당 프로젝트의 이슈 개수
	public int issuePagingListCnt(IssueVo issueVo);
	
	// 해당 이슈
	public IssueVo geteachissue(String issueId);
	
	// 이슈게시글 다음 index값 추출
	public String getissueid();
	
	// 이슈게시글 작성
	public int insertissue(IssueVo issueVo);
	
	// 이슈게시글 수정
	public int updateissue(IssueVo issueVo);
	
	// 이슈게시글 삭제
	public int delissue(String issueId);
		
	
	// 나의 이슈리스트
	public List<IssueVo> myissuelist(IssueVo issueVo);
	
	// 내가 작성한 이슈 개수
	public int myissuePagingListCnt(IssueVo issueVo);
	
	// 회원이 사용가능한 카테고리 조회
	public List<CategoryVo> categorylist(String memId);
	
	
	//프로젝트명 불러오기
	public List<ProjectVo> memInProjectList(String memId);
	
	//reqId 이용해서 해당 프로젝트에 참여하고 있는 회원 조회하기
	public List<ProjectMemberVo> proMemList(String reqId);
	
	//reqId 이용해서 해당 프로젝트에 참여하고 있는 회원 조회하기(IN)
	public List<ProjectMemberVo> proMemListIn(String reqId); 
	
	// 프로젝트 멤버 상태 수정하기
	public int promemUpdate(ProjectMemberVo projectMemberVo);
		
	// 프로젝트 멤버 이름 업데이트
	public int projectmembernameupdate(ProjectMemberVo projectmembervo);
}
