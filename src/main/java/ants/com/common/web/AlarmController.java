package ants.com.common.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

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
		//project member초대
		if(alarmData.getMemIds() != null) {
			for(String memId : alarmData.getMemIds()) {
				alarmData.setMemId(memId);
				int cnt = alarmService.alarmInsert(alarmData);
				model.addAttribute("cnt",cnt);
			}
			
		}else {
			int cnt = alarmService.alarmInsert(alarmData);
			model.addAttribute("cnt",cnt);
		}
		
		return "jsonView";
	}
	
	@RequestMapping("/alarmList")
	public String alarmList(@ModelAttribute("alarmVo") AlarmVo alarmVo, Model model, HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		alarmVo.setMemId(memberVo.getMemId());
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(alarmVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(alarmVo.getPageUnit());
		paginationInfo.setPageSize(alarmVo.getPageSize());
		
		alarmVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		alarmVo.setLastIndex(paginationInfo.getLastRecordIndex());
		alarmVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> alarmList = alarmService.alarmList(alarmVo);
		model.addAttribute("alarmList",alarmList);
		
		int totCnt = alarmService.alarmListCount(alarmVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "tiles/alarm/alarm";
	}
	
	@RequestMapping("/alarmUpdate")
	public String alarmUpdate(@ModelAttribute("alarmVo") AlarmVo alarmVo) {
		alarmService.alarmUpdate(alarmVo);
		return "jsonView";
	}
	
	@RequestMapping("/alarmDelete")
	public String alarmDelete(@RequestBody ArrayList<String> deleteData, Model model) {
		
		int cnt = alarmService.alarmDelete(deleteData);
		model.addAttribute("cnt", cnt);
		return "jsonView";
	}

}
