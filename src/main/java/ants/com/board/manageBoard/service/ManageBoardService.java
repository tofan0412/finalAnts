package ants.com.board.manageBoard.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.manageBoard.mapper.ManageBoardMapper;
import ants.com.board.manageBoard.model.HotIssueVo;
import ants.com.board.manageBoard.model.TodoLogVo;
import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.model.todoHistoryVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.model.ReqVo;

@Service("manageBoardService")
public class ManageBoardService {

	@Resource(name = "manageBoardMapper")
	private ManageBoardMapper mapper;

	// 할일기능
	public int todoInsert(TodoVo todoVo) {
		return mapper.todoInsert(todoVo);
	}

	public List<TodoVo> getTodoList(TodoVo todoVo) {
		return mapper.getTodoList(todoVo);
	}

	public int todoListCount(TodoVo todoVo) {
		return mapper.todoListCount(todoVo);
	}

	public int todoMyListCount(TodoVo todoVo) {
		return mapper.todoMyListCount(todoVo);
	}

	public List<MemberVo> projectMemList(TodoVo todoVo) {
		return mapper.projectMemList(todoVo);
	}

	public List<TodoVo> getTodo(TodoVo todoVo) {
		return mapper.getTodo(todoVo);
	}

	public TodoVo mygetTodo(TodoVo todoVo) {
		return mapper.mygetTodo(todoVo);
	}

	public int todoupdate(TodoVo todoVo) {
		return mapper.todoupdate(todoVo);
	}

	public int progressChange(TodoVo todoVo) {
		return mapper.progressChange(todoVo);
	}

	public int tododelete(TodoVo todoVo) {
		return mapper.tododelete(todoVo);
	}

	public int todoChangeMem(TodoLogVo todoLogVo) {
		return mapper.todoChangeMem(todoLogVo);
	}

	public List<TodoVo> getMyTodoList(TodoVo todoVo) {
		return mapper.getMyTodoList(todoVo);
	}
	
	public List<TodoLogVo> getTodolog(String todoId) {
		return mapper.getTodolog(todoId);
	}

	public ProjectVo projectList(ProjectVo projectVo) {
		return mapper.projectList(projectVo);
	}
	
	public ProjectVo pmProjectList(ProjectVo projectVo) {
		return mapper.pmProjectList(projectVo);
	}

	public String gettodoId() {
		return mapper.gettodoId();
	}
	
	public String proPerChangebytodo(TodoVo todoVo) {
		return mapper.proPerChangebytodo(todoVo);
	}

	
	
	// 핫이슈 기능
	public List<HotIssueVo> gethissueList(HotIssueVo hotIssueVo) {
		return mapper.gethissueList(hotIssueVo);
	}

	public int issueListCount(HotIssueVo hotIssueVo) {
		return mapper.issueListCount(hotIssueVo);
	}

	public HotIssueVo gethissue(HotIssueVo hotIssueVo) {
		return mapper.gethissue(hotIssueVo);
	}

	public int hissueInsert(HotIssueVo hotIssueVo) {
		return mapper.hissueInsert(hotIssueVo);
	}

	public int hIssueupdate(HotIssueVo hotIssueVo) {
		return mapper.hIssueupdate(hotIssueVo);
	}

	public int hIssuedelete(HotIssueVo hotIssueVo) {
		return mapper.hIssuedelete(hotIssueVo);
	}
	public String gethissueId() {
		return mapper.gethissueId();
	}

	public List<TodoVo> todostackchart(String reqId) {
		return mapper.todostackchart(reqId);
	}
	public List<TodoVo> donutChart(String reqId) {
		return mapper.donutChart(reqId);
	}

	public List<TodoVo> getAllTodo(String reqId) {
		return mapper.getAllTodo(reqId);
	}

	public int todoHistoryCnt(todoHistoryVo todoHistoryVo) {
		return mapper.todoHistoryCnt(todoHistoryVo);
	}

	public int todoHistoryfirst(todoHistoryVo historyVo) {
		return mapper.todoHistoryfirst(historyVo);
	}

	public List<HotIssueVo> gethissueandchild(HotIssueVo hotIssueVo) {
		return mapper.gethissueandchild(hotIssueVo);
	}

	public List<TodoVo> getSelectTodo(TodoVo todoVo) {
		return mapper.getSelectTodo(todoVo);
	}

	
}
