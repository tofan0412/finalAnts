package ants.com.board.manageBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ants.com.board.manageBoard.model.TodoLogVo;
import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.service.ManageBoardService;
import ants.com.member.model.MemberVo;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/todo")
@Controller
public class TodoController {
	private static final Logger logger = LoggerFactory.getLogger(TodoController.class);

	@Resource(name = "manageBoardService")
	private ManageBoardService manageBoardService;

	// 프로젝트명 클릭시 세션저장
	@RequestMapping("/projectgetReq")
	public String projectgetReq(HttpSession session, String reqId) {
		session.setAttribute("projectId", reqId);
		return "redirect:/todo/todoList";
	}

	// 일감 등록 화면 출력 메서드
	@RequestMapping("/todoInsertView")
	public String todoInsertView(Model model, TodoVo todoVo, HttpSession session, @RequestParam(name="todoParentid", required=false)String todoParentid) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		List<MemberVo> promemList = manageBoardService.projectMemList(todoVo);
		model.addAttribute("promemList", promemList);
		todoVo.setTodoParentid(todoParentid);
		model.addAttribute("todoVo",todoVo);
		return "tiles/manager/pl_todoInsertView";
	}
	

	// 일감 등록 메서드
	@RequestMapping("/todoInsert")
	public String todoInsert(Model model, TodoVo todoVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		int todoInsert = manageBoardService.todoInsert(todoVo);
		if (todoInsert > 0) {
			return "redirect:/todo/todoList?reqId=" + todoVo.getReqId();
		} else {
			return "redirect:/todo/todoInsertView?reqId=" + todoVo.getReqId();
		}
	}

	// 일감 리스트 조회 메서드(전체)
	@RequestMapping("/todoList")
	public String todoListView(@ModelAttribute("todoVo") TodoVo todoVo, ModelMap model, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		logger.debug("searchKeyword!!!!:{}",todoVo.getSearchKeyword());
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
	public String todoDetailView(Model model, TodoVo todoVo) {
		TodoVo dbtodoVo = manageBoardService.getTodo(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		return "jsonView";
	}
	
	// 한개의 일감조회 화면 출력
	@RequestMapping("/onetodoView")
	public String todoView() {
		return "tiles/manager/Pl_Onetodo";
	}

	// 일감 수정 화면 출력
	@RequestMapping("/updatetodoView")
	public String todoupdateView(Model model, TodoVo todoVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		List<MemberVo> promemList = manageBoardService.projectMemList(todoVo);
		TodoVo dbtodoVo = manageBoardService.getTodo(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		model.addAttribute("promemList", promemList);
		return "tiles/manager/Pl_todoUpdateView";
	}

	// 일감 수정
	@RequestMapping("/updatetodo")
	public String todoupdate(TodoVo todoVo, Model model, @RequestParam(name="changemem", required=false)String changemem, @RequestParam(name="logComment", required=false)String logComment) {
			if(!changemem.equals(todoVo.getMemId())) {
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

	// 일감 삭제
	@RequestMapping("/deletetodo")
	public String tododelete(TodoVo todoVo, Model model, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		int delTodoCnt = manageBoardService.tododelete(todoVo);
		if (delTodoCnt > 0) {
			return "redirect:/todo/todoList?reqId=" + reqId;
		} else {
			return "redirect:/todo/updatetodoView?todoId=" + todoVo.getTodoId();
		}
	}
}
