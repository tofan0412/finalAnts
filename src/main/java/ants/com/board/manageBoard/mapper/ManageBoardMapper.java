package ants.com.board.manageBoard.mapper;

import java.util.List;

import ants.com.board.manageBoard.model.HotIssueVo;
import ants.com.board.manageBoard.model.TodoLogVo;
import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.model.todoHistoryVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.model.ReqVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("manageBoardMapper")
public interface ManageBoardMapper {

	// 일감 기능
	// 일감 등록
	public int todoInsert(TodoVo todoVo);

	// 일감리스트 조회
	public List<TodoVo> getTodoList(TodoVo todoVo);

	// 페이징 리스트 Count
	public int todoListCount(TodoVo todoVo);

	// 한개의 일감 조회
	public List<TodoVo> getTodo(TodoVo todoVo);

	// 한개의 일감 조회
	public TodoVo mygetTodo(TodoVo todoVo);

	// 팀원 조회
	public List<MemberVo> projectMemList(TodoVo todoVo);

	// 일감 수정
	public int todoupdate(TodoVo todoVo);

	// 담당자의 진행도 수정
	public int progressChange(TodoVo todoVo);

	// 일감 삭제
	public int tododelete(TodoVo todoVo);

	// 인수인계
	public int todoChangeMem(TodoLogVo todoLogVo);

	// 내 리스트 조회
	public List<TodoVo> getMyTodoList(TodoVo todoVo);

	// 페이징 리스트 Count
	public int todoMyListCount(TodoVo todoVo);

	// PL.프로젝트 리스트
	public ProjectVo projectList(ProjectVo projectVo);
	
	// PM.프로젝트 리스트
	public ProjectVo pmProjectList(ProjectVo projectVo);

	// 다음 index값 추출
	public String gettodoId();
	
	// 프로젝트진행율 계산
	public String proPerChangebytodo(TodoVo todoVo);
	
	//
	public List<TodoVo> todostackchart(String reqId);
	
	public List<TodoVo> donutChart(String reqId);
	
	public List<TodoLogVo> getTodolog(String todoId);
	
	
	
	// 핫이슈 기능
	// 핫이슈 리스트 조회
	public List<HotIssueVo> gethissueList(HotIssueVo hotIssueVo);

	// 페이징 리스트 Count
	public int issueListCount(HotIssueVo hotIssueVo);

	// 한개의 핫이슈 조회
	public HotIssueVo gethissue(HotIssueVo hotIssueVo);

	// 핫이슈 등록
	public int hissueInsert(HotIssueVo hotIssueVo);

	// 핫이슈 수정
	public int hIssueupdate(HotIssueVo hotIssueVo);

	// 핫이슈 삭제
	public int hIssuedelete(HotIssueVo hotIssueVo);
	// 다음 index값 추출
	public String gethissueId();
	// 전체 todoList
	public List<TodoVo> getAllTodo(String reqId);

	public int todoHistoryCnt(todoHistoryVo todoHistoryVo);

	public int todoHistoryfirst(todoHistoryVo historyVo);

	public List<HotIssueVo> gethissueandchild(HotIssueVo hotIssueVo);

	public List<TodoVo> getSelectTodo(TodoVo todoVo);
	
}
