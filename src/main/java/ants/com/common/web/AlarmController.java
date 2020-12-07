package ants.com.common.web;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ants.com.common.model.AlarmVo;
import ants.com.common.service.AlarmService;
import ants.com.member.model.MemberVo;
import ants.com.member.web.ReqController;

@Controller
public class AlarmController {
	private static final Logger logger = LoggerFactory.getLogger(ReqController.class);
	
	@Resource(name="alarmService")
	private AlarmService alarmService;
	
	@RequestMapping("/alarmCount")
	public String alarmCount(Model model,AlarmVo alarmVo) {
		alarmVo = alarmService.alarmCount(alarmVo);
		model.addAttribute("alarmVo",alarmVo );
		return "jsonView";
	}
	
	@RequestMapping("/alarmInsert")
	public String alarmInsert(@RequestBody AlarmVo alarmData, Model model) {
		
		int cnt = alarmService.alarmInsert(alarmData);
		model.addAttribute("cnt",cnt);
		return "jsonView";
	}
	
	@RequestMapping("/alarmList")
	public String alarmList(@ModelAttribute("alarmVo") AlarmVo alarmVo, Model model) {
		return "tiles/alarm/alarm";
	}
	

}
