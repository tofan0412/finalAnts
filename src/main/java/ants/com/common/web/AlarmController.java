package ants.com.common.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.common.model.AlarmVo;
import ants.com.common.service.AlarmService;

@Controller
public class AlarmController {
	
	@Resource(name="alarmService")
	private AlarmService alarmService;
	
	@RequestMapping("/alarmCount")
	public String alarmCount(Model model) {
		
		return "jsonView";
	}
	
	@RequestMapping("/alarmInsert")
	public String alarmInsert(AlarmVo alarmVo) {
		
		return "jsonView";
	}
	

}
