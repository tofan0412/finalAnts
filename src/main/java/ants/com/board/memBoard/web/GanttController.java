package ants.com.board.memBoard.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GanttController {
	
	@RequestMapping("/ganttView")
	public String ganttView() {
		return "tiles/gantt/gantt2";
	}
	
}
