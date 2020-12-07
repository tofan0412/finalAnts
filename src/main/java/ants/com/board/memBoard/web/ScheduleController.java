package ants.com.board.memBoard.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/schedule")
@Controller
public class ScheduleController {
	
	// 캘린더 화면 출력
	@RequestMapping("/clendarView")
	public String clendarView() {
		return "member/calendar";
	}
}
