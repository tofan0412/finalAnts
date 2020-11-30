package ants.com.board.manageBoard.web;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ants.com.board.manageBoard.mapper.ManageBoardMapper;
import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.service.ManageBoardService;
import ants.com.member.model.ProjectMemberVo;

@RequestMapping("/todo")
@Controller
public class TodoController {
	private static final Logger logger = LoggerFactory.getLogger(TodoController.class);
	@Resource(name = "manageBoardService")
	private ManageBoardService manageBoardService;

	// 일감 등록 화면 출력 메서드
	@RequestMapping("/todoInsertView")
	public String todoInsertView(String reqId, Model model ) {
		List<ProjectMemberVo> promemList = manageBoardService.projectMemList(reqId);
		model.addAttribute("promemList",promemList);
		return "tiles/manager/pl_todoInsertView";
	}

	// 일감 등록 메서드
	@RequestMapping("/todoInsert")
	public String todoInsert(Model model, TodoVo todoVo) {
		logger.debug("파라미터", todoVo.getTodoCont());
		// int todoInsert = managerSerive.todoInsert(todoVo);
		return "tiles/manager/pl_todoInsertView";
	}

	// 일감 조회 메서드
	@RequestMapping("/todoList")
	public String todoListView(String reqId, Model model) {
		List<TodoVo> todoList = manageBoardService.getTodo(reqId);
		model.addAttribute("todoList", todoList);
		return "tiles/manager/Pl_todoList";
	}

}
