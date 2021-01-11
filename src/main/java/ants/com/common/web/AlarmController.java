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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.board.manageBoard.service.ManageBoardService;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.common.model.AlarmVo;
import ants.com.common.service.AlarmService;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.web.ReqController;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AlarmController {
	private static final Logger logger = LoggerFactory.getLogger(ReqController.class);
	
	@Resource(name="alarmService")
	private AlarmService alarmService;
	
	@Resource(name="manageBoardService")
	private ManageBoardService manageBoardService;
	
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
	
	@RequestMapping("/getAlarmPage")
	public String getAlarmPage(AlarmVo alarmVo ,RedirectAttributes re, HttpSession session ) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		ProjectVo projectVo = new ProjectVo();
		projectVo.setMemId(memId);
 		projectVo.setReqId(alarmVo.getReqId());
		//PM, MEM 일때
		if(memberVo.getMemType().equals("PM")) {
			projectVo = manageBoardService.pmProjectList(projectVo);
		}
		else {
			projectVo = manageBoardService.projectList(projectVo);
		}
		session.setAttribute("projectVo", projectVo);
		session.setAttribute("projectId", alarmVo.getReqId());
		session.setAttribute("pageIndex", 1);
		re.addAttribute("reqId", alarmVo.getReqId());

		// 댓글
		if(alarmVo.getAlarmType().matches("reply.*")) {
			// issue댓글
			if(alarmVo.getAlarmType().equals("reply-3")) {
				session.setAttribute("categoryId", "3");
				re.addAttribute("issueId", alarmVo.getId());
				return "redirect:/projectMember/eachissueDetail";
			}
			// 투표댓글
			else if(alarmVo.getAlarmType().equals("reply-10")) {
				session.setAttribute("categoryId", "10");
				re.addAttribute("voteId", alarmVo.getId());
				return "redirect:/vote/voteDetail";
			}
			// 일정댓글
			else if(alarmVo.getAlarmType().equals("reply-6")) {
				session.setAttribute("categoryId", "6");
				re.addAttribute("scheId", alarmVo.getId());
				return "redirect:/schedule/scheduleSelect";
			}
		}
		
		//건의사항
		if(alarmVo.getAlarmType().matches(".*suggest")) {
			session.setAttribute("categoryId", "4");
			re.addAttribute("sgtId", alarmVo.getId());
			return "redirect:/suggest/suggestDetail";
		}
		//답글
		if(alarmVo.getAlarmType().equals("posts")) {
			session.setAttribute("categoryId", "5");
			re.addAttribute("hissueId", alarmVo.getId());
			return "redirect:/hotIssue/hissueDetailView";
		}
		
		
		return null;
	}

}
