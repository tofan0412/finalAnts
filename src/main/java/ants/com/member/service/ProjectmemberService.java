package ants.com.member.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.CategoryVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.mapper.ProjectmemberMapper;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.model.ProjectVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("promemService")
public class ProjectmemberService extends EgovAbstractServiceImpl {

	@Resource(name = "promemMapper")
	private ProjectmemberMapper mapper;

	// 해당 프로젝트에 본인이 참여하고 있는 일감조회
	public List<TodoVo> mytodolist(ProjectMemberVo promemVo) {
		return mapper.mytodolist(promemVo);
	}

	// 나의 이슈글 리스트
	public List<IssueVo> myissuelist(IssueVo issueVo) {
		return mapper.myissuelist(issueVo);
	}
	
	// 해당 프로젝트 이슈글 리스트
	public List<IssueVo> issuelist(IssueVo issueVo) {
		return mapper.issuelist(issueVo);
	}

	// 각 이슈글 내용
	public IssueVo geteachissue(String issueId) {
		return mapper.geteachissue(issueId);
	}
	// 이슈글 다음 index가져오기
	public String getissueid() {
		return mapper.getissueid();
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
	
	// 해당 프로젝트의 이슈글 개수
	public int issuePagingListCnt(IssueVo issueVo) {
		return mapper.issuePagingListCnt(issueVo);
	}
	
	// 내가 작성한 이슈글 개수
	public int myissuePagingListCnt(IssueVo issueVo) {
		return mapper.myissuePagingListCnt(issueVo);
	}

	// 회원이 사용가능한 카테고리 조회
	public List<CategoryVo> categorylist(String memId) {
		return mapper.categorylist(memId);
	}

	// left바 프로젝트명 불러오는 메서드
	public List<ProjectVo> memInProjectList(String memId) {
		return mapper.memInProjectList(memId);
	}

	// reqId 이용해서 프로젝트에 참여하는 회원 리스트 뽑아오기
	public List<ProjectMemberVo> proMemList(String reqId) {
		return mapper.proMemList(reqId);
	}
	
	/**
	 * 프로젝트 참여 멤버리스트조회
	 * @param reqId
	 * @return 상태 IN인 projectMemberVo객체
	 */
	public List<ProjectMemberVo> proMemListIn(String reqId) {
		return mapper.proMemListIn(reqId);
	}
	
	public int promemUpdate(ProjectMemberVo projectMemberVo) {
		return mapper.promemUpdate(projectMemberVo);
	}
		
	// 프로젝트 멤버 이름 업데이트
	public int projectmembernameupdate(ProjectMemberVo projectmembervo) {
		return mapper.projectmembernameupdate(projectmembervo);
	}	
	
	public int PlUpdate(ProjectMemberVo projectMemberVo) throws SQLException{
		return mapper.PlUpdate(projectMemberVo);
	}
}
