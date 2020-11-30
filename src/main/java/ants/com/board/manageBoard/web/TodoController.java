package ants.com.board.manageBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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

	// 일감 등록 화면 출력 메서드
	@RequestMapping("/todoInsertView")
	public String todoInsertView(Model model, TodoVo todoVo) {
		List<MemberVo> promemList = manageBoardService.projectMemList(todoVo);
		model.addAttribute("promemList", promemList);
		return "tiles/manager/pl_todoInsertView";
	}

	// 일감 등록 메서드
	@RequestMapping("/todoInsert")
	public String todoInsert(Model model, TodoVo todoVo) {
		int todoInsert = manageBoardService.todoInsert(todoVo);
		if (todoInsert > 0) {
			return "redirect:/todo/todoList?reqId="+todoVo.getReqId();
		} else {
			return "redirect:/todo/todoInsertView?reqId="+todoVo.getReqId();
		}
	}

	// 일감 리스트 조회 메서드
	@RequestMapping("/todoList")
	public String todoListView(Model model, TodoVo todoVo) {
		List<TodoVo> todoList = manageBoardService.getTodoList(todoVo);
		model.addAttribute("todoList", todoList);
		return "tiles/manager/Pl_todoList";
	}

	// 한개의 일감 조회 메서드
	@RequestMapping("/onetodo")
	public String todoView(Model model, TodoVo todoVo) {
		TodoVo dbtodoVo = manageBoardService.getTodo(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		return "jsonView";
	}

	// 일감 수정 화면 출력
	@RequestMapping("/updatetodoView")
	public String todoupdateView(TodoVo todoVo, Model model) {
		TodoVo dbtodoVo = manageBoardService.getTodo(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		return "tiles/manager/Pl_todoUpdateView";
	}
	
	// 일감 수정 
	@RequestMapping("/updatetodoView")
	public String todoupdate(TodoVo todoVo, Model model) {
		TodoVo dbtodoVo = manageBoardService.todoupdate(todoVo);
		model.addAttribute("todoVo", dbtodoVo);
		return "tiles/manager/Pl_todoUpdateView";
	}
	
	// 일감 삭제
	@RequestMapping("/deletetodo")
	public String tododelete(TodoVo todoVo, Model model) {
		int delTodoCnt = manageBoardService.tododelete(todoVo);
		if (delTodoCnt > 0) {
			return "redirect:/todo/todoList?reqId="+todoVo.getReqId();
		} else {
			return "redirect:/todo/updatetodoView?todoId="+todoVo.getTodoId();
		}
	}
}
