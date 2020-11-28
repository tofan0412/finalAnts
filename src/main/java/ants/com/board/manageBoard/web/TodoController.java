package ants.com.board.manageBoard.web;

import javax.annotation.Resource;
import javax.enterprise.inject.Model;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.service.ManageBoardServiceI;

@RequestMapping("/todo")
@Controller
public class TodoController {
	@Resource(name="manageBoardService")
	ManageBoardServiceI managerSerive;
	
	// 일감 등록 화면 출력 메서드
	@RequestMapping("/todoInsertView")
	public String todoInsertView() {
		return "tiles/manager/pl_toInsertView";
	}

	// 일감 등록 메서드
	@RequestMapping("/todoInsert")
	public String todoInsert(Model model, TodoVo todoVo) {
		return "";
	}
	 
	// 일감 조회 메서드
	@RequestMapping("/todoList")
	public String todoListView() {
		return "tiles/manager/Pl-todoList";
	}
	
	
	
	
}
