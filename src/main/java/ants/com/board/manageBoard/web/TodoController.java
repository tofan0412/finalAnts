package ants.com.board.manageBoard.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.manageBoard.service.ManageBoardServiceI;
import ants.com.member.service.MemberServiceI;

@RequestMapping("/todo")
@Controller
public class TodoController {
	@Resource(name="manageBoardService")
	ManageBoardServiceI managerSerive;
	
	// 일감 등록 화면 출력 메서드
	@RequestMapping("/todoInsertView")
	public String todoInsertView() {
		return "";
	}

	// 일감 등록
	@RequestMapping("/todoInsert")
	public String todoInsert() {
		return "";
	}

}
