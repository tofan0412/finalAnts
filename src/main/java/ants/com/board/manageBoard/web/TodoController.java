package ants.com.board.manageBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.service.ManageBoardService;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.model.MemberVo;

@RequestMapping("/todo")
@Controller
public class TodoController {
	private static final Logger logger = LoggerFactory.getLogger(TodoController.class);
	@Resource(name = "manageBoardService")
	private ManageBoardService manageBoardService;

	// 프로젝트명 클릭시 세션저장
	@RequestMapping("/projectgetReq")
	public String projectgetReq(HttpSession session) {
		session.setAttribute("reqId", "1");
		return "redirect:/todo/todoList";
	}

	// 일감 등록 화면 출력 메서드
	@RequestMapping("/todoInsertView")
	public String todoInsertView(Model model, TodoVo todoVo, HttpSession session, @RequestParam(name="todoParentid", required=false)String todoParentid) {
		String reqId = (String) session.getAttribute("reqId");
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
		String reqId = (String) session.getAttribute("reqId");
		todoVo.setReqId(reqId);
		int todoInsert = manageBoardService.todoInsert(todoVo);
		if (todoInsert > 0) {
			return "redirect:/todo/todoList?reqId=" + todoVo.getReqId();
		} else {
			return "redirect:/todo/todoInsertView?reqId=" + todoVo.getReqId();
		}
	}

	// 일감 리스트 조회 메서드
	@RequestMapping("/todoList")
	public String todoListView(Model model, TodoVo todoVo, HttpSession session) {
		String reqId = (String) session.getAttribute("reqId");
		todoVo.setReqId(reqId);
		List<TodoVo> todoList = manageBoardService.getTodoList(todoVo);
		model.addAttribute("todoList", todoList);
		return "tiles/manager/Pl_todoList";
	}


	// 한개의 일감 조회 메서드
	@RequestMapping("/onetodoView")
	public String todoView(Model model, TodoVo todoVo) {
		TodoVo dbtodoVo = manageBoardService.getTodo(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		return "tiles/manager/Pl_Onetodo";
	}
	

	// 일감 수정 화면 출력
	@RequestMapping("/updatetodoView")
	public String todoupdateView(TodoVo todoVo, Model model) {
		TodoVo dbtodoVo = manageBoardService.getTodo(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		return "tiles/manager/Pl_todoUpdateView";
	}

	// 일감 수정
	@RequestMapping("/updatetodo")
	public String todoupdate(TodoVo todoVo, Model model) {
		int dbtodoVo = manageBoardService.todoupdate(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		return "tiles/manager/Pl_todoUpdateView";
	}

	// 일감 삭제
	@RequestMapping("/deletetodo")
	public String tododelete(TodoVo todoVo, Model model) {
		int delTodoCnt = manageBoardService.tododelete(todoVo);
		if (delTodoCnt > 0) {
			return "redirect:/todo/todoList?reqId=" + todoVo.getReqId();
		} else {
			return "redirect:/todo/updatetodoView?todoId=" + todoVo.getTodoId();
		}
	}
}
