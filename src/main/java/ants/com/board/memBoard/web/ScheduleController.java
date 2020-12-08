package ants.com.board.memBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.memBoard.model.ScheduleVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.file.model.PrivateFileVo;
import ants.com.file.service.FileService;
import ants.com.member.model.MemberVo;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/schedule")
@Controller
public class ScheduleController {
	
	@Resource(name ="memBoardService")
	private memBoardService memBoardService;
	
	// 캘린더 화면 출력
	@RequestMapping("/clendarView")
	public String clendarView(@ModelAttribute("scheduleVo")ScheduleVo scheduleVo, HttpSession session, Model model) {
		String projectId = (String) session.getAttribute("projectId");
		scheduleVo.setReqId(projectId);
		List<ScheduleVo> showCalendar = memBoardService.showCalendar(scheduleVo);
		model.addAttribute("showSchedule", showCalendar);
		return "member/calendar";
	}
	
	
	// 일정장소 게시판 이동
	@RequestMapping("/scheduleplaceView")
	public String scheduleplaceView(@ModelAttribute("scheduleVo")ScheduleVo scheduleVo, HttpSession session, Model model) {
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		scheduleVo.setMemId(memberVo.getMemId());
		scheduleVo.setCategoryId("6");
		String projectId = (String) session.getAttribute("projectId");
		scheduleVo.setReqId(projectId);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();			// 스프링 지원 태그
		paginationInfo.setCurrentPageNo(scheduleVo.getPageIndex());	// privatefileVo에 BaseVo 상속
		paginationInfo.setRecordCountPerPage(scheduleVo.getPageUnit());
		paginationInfo.setPageSize(scheduleVo.getPageSize());

		scheduleVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		scheduleVo.setLastIndex(paginationInfo.getLastRecordIndex());
		scheduleVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 리스트 목록
		List<ScheduleVo> schedulelist = memBoardService.schedulelist(scheduleVo);
		model.addAttribute("schedulelist", schedulelist);
		
		//리스트 갯수memBoardService
		int totCnt = memBoardService.schedulelistCount(scheduleVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "tiles/schedule/scheduleplaceView";
	}
	
	
	// 일정장소 등록 페이지이동
	@RequestMapping("/scheduleInsertview")
	public String scheduleInsertview() {
		return "tiles/schedule/scheduleInsert";
	}	
	
	
	// 일정장소 등록
	@RequestMapping("/scheduleInsert")
	public String scheduleInsert(ScheduleVo scheduleVo) {
		int cnt = memBoardService.scheduleInsert(scheduleVo);
		
		if(cnt >= 1) {
			return "redirect:/schedule/scheduleplaceView";
		}else {
			return "redirect:/schedule/scheduleInsert";
		}
	}
	
	
	// 일정장소 상세 페이지이동 scheId
	@RequestMapping("/scheduleSelect")
	public String scheduleSelect(ScheduleVo scheduleVo, Model model) {
		
		ScheduleVo schedule = memBoardService.scheduleSelect(scheduleVo);
		model.addAttribute("scheduleVo", schedule);
		
		return "tiles/schedule/scheduleSelect";
	}	
	
	
	// 일정장소 수정 페이지로 이동
	@RequestMapping("/scheduleUpdateView")
	public String scheduleUpdateView(ScheduleVo scheduleVo, Model model) {
		
		ScheduleVo schedule = memBoardService.scheduleSelect(scheduleVo);
		model.addAttribute("scheduleVo", schedule);
			
		return "tiles/schedule/scheduleUpdate";
	}	
	
	
	// 일정장소 수정
	@RequestMapping("/scheduleUpdate")
	public String scheduleUpdate(ScheduleVo scheduleVo) {
			
		int updateCnt = memBoardService.scheduleUpdate(scheduleVo);
			
		if(updateCnt >= 1) {
			return "redirect:/schedule/scheduleSelect?scheId="+scheduleVo.getScheId();
		}else {
			return "tiles/schedule/scheduleUpdate";
		}
	}	
	
	
	// 일정장소 삭제
	@RequestMapping("/scheduleDelete")
	public String scheduleDelete(ScheduleVo scheduleVo, Model model) {
		
		int deleteCnt = memBoardService.scheduleDelete(scheduleVo);
			
		if(deleteCnt >=1) {
			return "redirect:/schedule/scheduleplaceView";
		}else {
			return "redirect:/schedule/scheduleplaceView";
		}
	}	
}
