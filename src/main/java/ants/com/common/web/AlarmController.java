package ants.com.common.web;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String alarmCount(Model model,MemberVo memberVo) {
		int count = alarmService.alarmCount(memberVo);
		model.addAttribute("cnt", count+"");
		return "jsonView";
	}
	
	@RequestMapping("/alarmInsert")
	public String alarmInsert(@RequestBody AlarmVo alarmData, Model model) {
		logger.debug("알림데이터:{}",alarmData);
		
		int cnt = alarmService.alarmInsert(alarmData);
		model.addAttribute("cnt",cnt);
		return "jsonView";
	}
	

}
