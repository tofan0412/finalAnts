package ants.com.member.service;

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

	// 이슈글 리스트
	public List<IssueVo> issuelist(IssueVo issueVo) {
		return mapper.issuelist(issueVo);
	}

	// 각 이슈글 내용
	public IssueVo geteachissue(String issueId) {
		return mapper.geteachissue(issueId);
	}

	// 이슈글 작성하기
	public String insertissue(IssueVo issueVo) {
		mapper.insertissue(issueVo);
		return issueVo.getIssueId();
	}

	// 이슈글 수정하기
	public int updateissue(IssueVo issueVo) {

		return mapper.updateissue(issueVo);
	}

	// 이슈글 삭제하기
	public int delissue(String issueId) {
		return mapper.delissue(issueId);
	}

	// 회원이 사용가능한 카테고리 조회
	public List<CategoryVo> categorylist(String memId) {
		return mapper.categorylist(memId);
	}

	// 회원이 사용가능한 카테고리 조회
	public int issuePagingListCnt(IssueVo issueVo) {
		return mapper.issuePagingListCnt(issueVo);
	}

	// left바 프로젝트명 불러오는 메서드
	public List<ProjectVo> memInProjectList(String memId) {
		return mapper.memInProjectList(memId);
	}

	// reqId 이용해서 프로젝트에 참여하는 회원 리스트 뽑아오기
	public List<ProjectMemberVo> proMemList(String reqId) {
		return mapper.proMemList(reqId);
	}
}
