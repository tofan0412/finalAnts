package ants.com.board.manageBoard.web;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.service.ManageBoardServiceI;

@RequestMapping("/todo")
@Controller
public class TodoController {
	private static final Logger logger = LoggerFactory.getLogger(TodoController.class);
	@Resource(name = "manageBoardService")
	ManageBoardServiceI managerSerive;

	// 일감 등록 화면 출력 메서드
	@RequestMapping("/todoInsertView")
	public String todoInsertView() {
		return "tiles/manager/pl_toInsertView";
	}

	// 일감 등록 메서드
	@RequestMapping("/todoInsert")
	public String todoInsert(Model model, TodoVo todoVo) {
		int todoInsert = managerSerive.todoInsert(todoVo);
		return "";
	}

	// 일감 조회 메서드
	@RequestMapping("/todoList")
	public String todoListView(String req_id, Model model) {
		List<TodoVo> todoList = managerSerive.getTodo(req_id);
		model.addAttribute("todoList", todoList);
		logger.debug("나오니:{}",todoList);
		logger.debug("나오니2:{}",req_id);
		return "tiles/manager/Pl_todoList";
	}

}
