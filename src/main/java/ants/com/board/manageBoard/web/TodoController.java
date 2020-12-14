package ants.com.board.manageBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ants.com.board.manageBoard.model.TodoLogVo;
import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.service.ManageBoardService;
import ants.com.file.model.PublicFileVo;
import ants.com.file.view.FileController;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.web.ProjectController;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/todo")
@Controller
public class TodoController {

	@Resource(name = "manageBoardService")
	private ManageBoardService manageBoardService;

	@Autowired
	FileController filecontroller;

	@Autowired
	ProjectController projectController;


	// 차트 뷰
	@RequestMapping("/chartView")
	public String chartView(Model model, TodoVo todoVo, HttpSession session ) {
		
		return "tiles/chart/baniChart";
	}
	
	// 차트 뷰
	@RequestMapping("/stackedbarchart")
	public String stackedbarchart(Model model, TodoVo todoVo, HttpSession session ) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		List<TodoVo> todoVoList = manageBoardService.todostackchart(reqId);
		model.addAttribute("todoVoList", todoVoList);
		int Size = todoVoList.size();
		model.addAttribute("size", Size);
		return "jsonView";
	}
	
	// 차트 뷰
	@RequestMapping("/donutChart")
	public String donutChart(Model model, TodoVo todoVo, HttpSession session ) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		List<TodoVo> donutChartList = manageBoardService.donutChart(reqId);
		model.addAttribute("donutChartList", donutChartList);
		int Size = donutChartList.size();
		model.addAttribute("dsize", Size);
		return "jsonView";
	}
	
	
	// 일감 등록 화면 출력 메서드
	@RequestMapping("/todoInsertView")
	public String todoInsertView(Model model, TodoVo todoVo, HttpSession session,
			@RequestParam(name = "todoParentid", required = false) String todoParentid) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		List<MemberVo> promemList = manageBoardService.projectMemList(todoVo);
		String todoId = manageBoardService.gettodoId();
		model.addAttribute("promemList", promemList);
		model.addAttribute("todoSeq", todoId);
		if (todoParentid != null) {
			model.addAttribute("todoVo", todoVo);
		}
		return "tiles/manager/pl_todoInsertView";
	}
	
	// 일감 등록 메서드
	@RequestMapping("/todoInsert")
	public String todoInsert(Model model, TodoVo todoVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);

		int todoInsert = manageBoardService.todoInsert(todoVo);
		if (todoInsert > 0) {
			String proper = (String) manageBoardService.proPerChangebytodo(todoVo);
			ProjectVo projectVo = new ProjectVo();
			projectVo.setPercent(proper);
			projectVo.setReqId(reqId);
			int res = projectController.propercentChange(projectVo);
			if (res > 0) {
				return "redirect:/todo/todoList?reqId=" + todoVo.getReqId();
			} else {
				return "redirect:/todo/todoInsertView?reqId=" + todoVo.getReqId();
			}
		} else {
			return "redirect:/todo/todoInsertView?reqId=" + todoVo.getReqId();
		}
	}

	// 상위 등록 하고 바로 하위 등록 메서드
	@RequestMapping("/todoChildInsert")
	public String todoChildInsert(Model model, TodoVo todoVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);

		int todoInsert = manageBoardService.todoInsert(todoVo);
		String todoId = todoVo.getTodoId();
		if (todoInsert > 0) {
			String proper = (String) manageBoardService.proPerChangebytodo(todoVo);
			ProjectVo projectVo = new ProjectVo();
			projectVo.setPercent(proper);
			projectVo.setReqId(reqId);
			int res = projectController.propercentChange(projectVo);
			if (res > 0) {
				return "redirect:/todo/todoInsertView?todoParentid=" + todoId;
			} else {
				return "redirect:/todo/todoInsertView?reqId=" + todoVo.getReqId();
			}
		} else {
			return "redirect:/todo/todoInsertView?reqId=" + todoVo.getReqId();
		}
	}

	// 일감 리스트 조회 메서드(전체)
	@RequestMapping("/todoList")
	public String todoListView(@ModelAttribute("todoVo") TodoVo todoVo, ModelMap model, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(todoVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(todoVo.getPageUnit());
		paginationInfo.setPageSize(todoVo.getPageSize());

		todoVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		todoVo.setLastIndex(paginationInfo.getLastRecordIndex());
		todoVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> todoList = manageBoardService.getTodoList(todoVo);
		model.addAttribute("todoList", todoList);
		int totCnt = manageBoardService.todoListCount(todoVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		return "tiles/manager/Pl_todoList";
	}

	// 한개의 일감 조회 Ajax
	@RequestMapping("/onetodo")
	public String todoDetailView(Model model, TodoVo todoVo, HttpSession session) {

		List<TodoVo> dbtodoVo = manageBoardService.getTodo(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		String todoId = todoVo.getTodoId();
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		PublicFileVo pfv = new PublicFileVo("1", todoId, reqId);
		filecontroller.getfiles(pfv, model);
		return "jsonView";
	}

	// 한개의 일감조회 화면 출력
	@RequestMapping("/onetodoView")
	public String todoView() {
		return "tiles/manager/Pl_Onetodo";
	}

	// 한개의 일감 조회 Ajax
	@RequestMapping("/myonetodo")
	public String mytodoDetailView(Model model, TodoVo todoVo) {
		TodoVo dbtodoVo = manageBoardService.mygetTodo(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		String todoId = dbtodoVo.getTodoId();
		String reqId = dbtodoVo.getReqId();
		PublicFileVo pfv = new PublicFileVo("1", todoId, reqId);
		filecontroller.getfiles(pfv, model);
		return "jsonView";
	}

	// 한개의 일감조회 화면 출력
	@RequestMapping("/myonetodoView")
	public String mytodoView() {
		return "tiles/board/MY_Onetodo";
	}

	// 일감 수정 화면 출력
	@RequestMapping("/updatetodoView")
	public String todoupdateView(Model model, TodoVo todoVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		List<MemberVo> promemList = manageBoardService.projectMemList(todoVo);
		TodoVo dbtodoVo = manageBoardService.mygetTodo(todoVo);
		PublicFileVo pfv = new PublicFileVo("1", todoVo.getTodoId(), reqId);
		filecontroller.getfiles(pfv, model);
		model.addAttribute("todoVo", dbtodoVo);
		model.addAttribute("promemList", promemList);
		return "tiles/manager/Pl_todoUpdateView";
	}

	// 일감 수정
	@RequestMapping("/updatetodo")
	public String todoupdate(TodoVo todoVo, Model model,
			@RequestParam(name = "changemem", required = false) String changemem,
			@RequestParam(name = "logComment", required = false) String logComment) {
		if (!changemem.equals(todoVo.getMemId())) {
			TodoLogVo todoLogVo = new TodoLogVo();
			todoLogVo.setBeforeId(changemem);
			todoLogVo.setAfterId(todoVo.getMemId());
			todoLogVo.setLogComment(logComment);
			todoLogVo.setTodoId(todoVo.getTodoId());
			manageBoardService.todoChangeMem(todoLogVo);
		}
		int updateCnt = manageBoardService.todoupdate(todoVo);
		if (updateCnt > 0) {
			return "redirect:/todo/todoList?reqId=" + todoVo.getReqId();
		} else {
			return "redirect:/todo/updatetodoView?todoId=" + todoVo.getTodoId();
		}
	}

	// 진행도 수정
	@RequestMapping("/progressChange")
	public String progressChange(TodoVo todoVo, Model model) {
		String reqId = todoVo.getReqId();
		int proChangeCnt = manageBoardService.progressChange(todoVo);
		
		if (proChangeCnt > 0) {
			String proper = (String) manageBoardService.proPerChangebytodo(todoVo);
			ProjectVo projectVo = new ProjectVo();
			projectVo.setPercent(proper);
			projectVo.setReqId(reqId);
			int res = projectController.propercentChange(projectVo);
			if (res > 0) {
				return "redirect:/todo/MytodoList";
			} else {
				return "redirect:/todo/updatetodoView?todoId=" + todoVo.getTodoId();
			}
		} else {
			return "redirect:/todo/updatetodoView?todoId=" + todoVo.getTodoId();
		}
	}

	// 일감 삭제
	@RequestMapping("/deletetodo")
	public String tododelete(TodoVo todoVo, Model model) {
		String reqId = todoVo.getReqId();
		int delTodoCnt = manageBoardService.tododelete(todoVo);
		if (delTodoCnt > 0) {
			String proper = (String) manageBoardService.proPerChangebytodo(todoVo);
			ProjectVo projectVo = new ProjectVo();
			projectVo.setPercent(proper);
			projectVo.setReqId(reqId);
			int res = projectController.propercentChange(projectVo);
			if(res >0) {
				return "redirect:/todo/todoList?reqId=" + reqId;
			}else {
				return "redirect:/todo/updatetodoView?todoId=" + todoVo.getTodoId();
			}
		} else {
			return "redirect:/todo/updatetodoView?todoId=" + todoVo.getTodoId();
		}
	}

	// 내일감 보기(로그인한 멤버의 일감조회)
	@RequestMapping("/MytodoList")
	public String mytodoListView(@ModelAttribute("todoVo") TodoVo todoVo, ModelMap model, HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setMemId(memberVo.getMemId());
		todoVo.setReqId(reqId);

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(todoVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(todoVo.getPageUnit());
		paginationInfo.setPageSize(todoVo.getPageSize());

		todoVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		todoVo.setLastIndex(paginationInfo.getLastRecordIndex());
		todoVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> todoList = manageBoardService.getMyTodoList(todoVo);
		model.addAttribute("todoList", todoList);
		int totCnt = manageBoardService.todoMyListCount(todoVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		return "tiles/board/MY_todoList";
	}
	
	@RequestMapping("/getAllTodo")
	public String getAllTodo(Model model, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<TodoVo> todoList = manageBoardService.getAllTodo(reqId);
		model.addAttribute("todoList", todoList);
		return "jsonView";
	}

}
