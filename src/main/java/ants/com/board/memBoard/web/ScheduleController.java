package ants.com.board.memBoard.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.web.HotIssueController;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.model.ScheduleVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.file.model.PrivateFileVo;
import ants.com.file.service.FileService;
import ants.com.member.model.MemberVo;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RequestMapping("/schedule")
@Controller
public class ScheduleController {

	@Resource(name = "memBoardService")
	private memBoardService memBoardService;

	// 일정장소 게시판 이동
	@RequestMapping("/scheduleplaceView")
	public String scheduleplaceView(@ModelAttribute("scheduleVo") ScheduleVo scheduleVo, HttpSession session,
			Model model) {

		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		scheduleVo.setMemId(memberVo.getMemId());
		scheduleVo.setCategoryId("6");
		String projectId = (String) session.getAttribute("projectId");
		scheduleVo.setReqId(projectId);

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo(); // 스프링 지원 태그
		paginationInfo.setCurrentPageNo(scheduleVo.getPageIndex()); // privatefileVo에 BaseVo 상속
		paginationInfo.setRecordCountPerPage(scheduleVo.getPageUnit());
		paginationInfo.setPageSize(scheduleVo.getPageSize());

		scheduleVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		scheduleVo.setLastIndex(paginationInfo.getLastRecordIndex());
		scheduleVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// 리스트 목록
		List<ScheduleVo> schedulelist = memBoardService.schedulelist(scheduleVo);
		model.addAttribute("schedulelist", schedulelist);

		// 리스트 갯수memBoardService
		int totCnt = memBoardService.schedulelistCount(scheduleVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		if(scheduleVo.getSearchKeyword() != null) {			
			session.setAttribute("searchKeyword", scheduleVo.getSearchKeyword());
			session.setAttribute("searchCondition",scheduleVo.getSearchCondition());
			session.setAttribute("pageIndex", scheduleVo.getPageIndex());
		}
		
		return "tiles/schedule/scheduleplaceView";
	}

	// 일정장소 등록 페이지이동
	@RequestMapping("/scheduleInsertview")
	public String scheduleInsertview() {
		System.out.println("인서트으으");
		return "tiles/schedule/scheduleInsert";
	}

	// 일정장소 등록
	@RequestMapping("/scheduleInsert")
	public String scheduleInsert(ScheduleVo scheduleVo) {
		int cnt = memBoardService.scheduleInsert(scheduleVo);

		if (cnt >= 1) {
			return "redirect:/schedule/scheduleplaceView";
		} else {
			return "redirect:/schedule/scheduleInsert";
		}
	}

	// 일정장소 상세 페이지이동 scheId
	@RequestMapping("/scheduleSelect")
	public String scheduleSelect(ScheduleVo scheduleVo, Model model) {

		ScheduleVo schedule = memBoardService.scheduleSelect(scheduleVo);
		model.addAttribute("scheduleVo", schedule);

			
		ReplyVo replyVo = new ReplyVo(schedule.getScheId(), "6", schedule.getReqId());	//댓글 조회
		logger.debug("replyVo : {}",replyVo);	
		List<ReplyVo> replylist= memBoardService.schedulereplylist(replyVo);
			
		model.addAttribute("issuevo", schedule);	
		model.addAttribute("memId", schedule.getMemId());
		model.addAttribute("replylist", replylist);	
		logger.debug("schedulereplylist : {}",replylist);	
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

		if (updateCnt >= 1) {
			return "redirect:/schedule/scheduleSelect?scheId=" + scheduleVo.getScheId();
		} else {
			return "tiles/schedule/scheduleUpdate";
		}
	}

	// 일정장소 삭제
	@RequestMapping("/scheduleDelete")
	public String scheduleDelete(ScheduleVo scheduleVo, Model model) {

		int deleteCnt = memBoardService.scheduleDelete(scheduleVo);

		if (deleteCnt >= 1) {
			return "redirect:/schedule/scheduleplaceView";
		} else {
			return "redirect:/schedule/scheduleplaceView";
		}
	}
	
	
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(HotIssueController.class);
		
	// 댓글 작성
	@RequestMapping(path ="/scheduleinsertreply")
	public String scheduleinsertreply(ReplyVo replyVo, Model model, HttpSession session) throws SQLException, IOException {
		
		MemberVo membervo = (MemberVo) session.getAttribute("SMEMBER");
		replyVo.setMemId(membervo.getMemId());		
		replyVo.setCategoryId(replyVo.getCategoryId());	
			
		logger.debug("replyVo: {}", replyVo);
		memBoardService.scheduleinsertreply(replyVo);
		model.addAttribute("someId", replyVo.getSomeId());
		return "jsonView";
	}	
	
	
	// 댓글 삭제
	@RequestMapping(path ="/delreply")
	public String deleteapply(ReplyVo replyVo, Model model, HttpSession session) throws SQLException, IOException {
		
		memBoardService.delreply(replyVo);
		
		return "jsonView";
	}
	
	
	
	
	

	// 프로젝트용 캘린더
	// 캘린더 화면 출력
	@RequestMapping("/clendarView")
	public String clendarView(@ModelAttribute("scheduleVo") ScheduleVo scheduleVo, HttpSession session, Model model) {
		String projectId = (String) session.getAttribute("projectId");
		scheduleVo.setReqId(projectId);
		List<ScheduleVo> showCalendar = memBoardService.showCalendar(scheduleVo);
		model.addAttribute("showSchedule", showCalendar);
		return "tiles/member/calendar";
	}

	// 캘린더에서 일정추가
	@RequestMapping("/calendarInsert")
	public String calendarInsert(@ModelAttribute("scheduleVo") ScheduleVo scheduleVo, HttpSession session,
			Model model) {
		scheduleVo.setScheCont(scheduleVo.getScheTitle());
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		scheduleVo.setMemId(memberVo.getMemId());
		String projectId = (String) session.getAttribute("projectId");
		scheduleVo.setReqId(projectId);
		int insertCnt = memBoardService.calendarInsert(scheduleVo);
		if (insertCnt >= 1) {
			return "redirect:/schedule/clendarView";
		} else {
			return "redirect:/schedule/clendarView";
		}
	}

	// 캘린더에서 일정수정
	@RequestMapping("/calendarUpdate")
	public String calendarUpdate(@ModelAttribute("scheduleVo") ScheduleVo scheduleVo, HttpSession session,
			Model model) {
		scheduleVo.setScheCont(scheduleVo.getScheTitle());
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		scheduleVo.setMemId(memberVo.getMemId());
		String projectId = (String) session.getAttribute("projectId");
		scheduleVo.setReqId(projectId);
		int updateCnt = memBoardService.calendarUpdate(scheduleVo);
		if (updateCnt >= 1) {
			return "redirect:/schedule/clendarView";
		} else {
			return "redirect:/schedule/clendarView";
		}
	}
	
	// 캘린더에서 일정 보기
	@RequestMapping("/calendarDetail")
	public String calendarDetail(ScheduleVo scheduleVo, Model model) {
		ScheduleVo dbVo = memBoardService.calendarDetail(scheduleVo);
		model.addAttribute("scheduleVo", dbVo);
		return "jsonView";
	}

	// 캘린더에서 일정 삭제
	@RequestMapping("/calendarDelete")
	public String calendarDelete(ScheduleVo scheduleVo, Model model) {

		int deleteCnt = memBoardService.calendarDelete(scheduleVo);

		if (deleteCnt >= 1) {
			return "redirect:/schedule/clendarView";
		} else {
			return "redirect:/schedule/clendarView";
		}
	}

	// 개인 캘린더

	// 캘린더 화면 출력
	@RequestMapping("/MyclendarView")
	public String myclendarView(@ModelAttribute("scheduleVo") ScheduleVo scheduleVo, HttpSession session, Model model) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		scheduleVo.setMemId(memberVo.getMemId());
		List<ScheduleVo> showCalendar = memBoardService.showMyCalendar(scheduleVo);
		model.addAttribute("showSchedule", showCalendar);
		return "tiles/member/mycalendar";
	}

	// 캘린더에서 일정추가
	@RequestMapping("/MycalendarInsert")
	public String mycalendarInsert(@ModelAttribute("scheduleVo") ScheduleVo scheduleVo, HttpSession session,
			Model model) {
		scheduleVo.setScheCont(scheduleVo.getScheTitle());
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		scheduleVo.setMemId(memberVo.getMemId());
		int insertCnt = memBoardService.mycalendarInsert(scheduleVo);
		if (insertCnt >= 1) {
			return "redirect:/schedule/MyclendarView";
		} else {
			return "redirect:/schedule/MyclendarView";
		}
	}

	// 캘린더에서 일정수정(드래그)
	@RequestMapping("/MycalendarUpdate")
	public String mycalendarUpdate(@ModelAttribute("scheduleVo") ScheduleVo scheduleVo, HttpSession session,
			Model model) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		scheduleVo.setMemId(memberVo.getMemId());
		int updateCnt = memBoardService.mycalendarUpdate(scheduleVo);
		if (updateCnt >= 1) {
			return "redirect:/schedule/MyclendarView";
		} else {
			return "redirect:/schedule/MyclendarView";
		}
	}

	
	// 캘린더에서 일정수정(상세)
	@RequestMapping("/MycalendarUpdateDetail")
	public String MycalendarUpdateDetail(@ModelAttribute("scheduleVo") ScheduleVo scheduleVo, HttpSession session,
			Model model) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		scheduleVo.setMemId(memberVo.getMemId());
		int updateCnt = memBoardService.calendarUpdateDetail(scheduleVo);
		if (updateCnt >= 1) {
			return "redirect:/schedule/MyclendarView";
		} else {
			return "redirect:/schedule/MyclendarView";
		}
	}

	// 캘린더에서 일정 보기
	@RequestMapping("/MycalendarDetail")
	public String mycalendarDetail(ScheduleVo scheduleVo, Model model) {
		ScheduleVo dbVo = memBoardService.mycalendarDetail(scheduleVo);
		model.addAttribute("scheduleVo", dbVo);
		return "jsonView";
	}

	// 캘린더에서 일정 삭제
	@RequestMapping("/MycalendarDelete")
	public String mycalendarDelete(ScheduleVo scheduleVo, Model model) {

		int deleteCnt = memBoardService.calendarDelete(scheduleVo);

		if (deleteCnt >= 1) {
			return "redirect:/schedule/MyclendarView";
		} else {
			return "redirect:/schedule/MyclendarView";
		}
	}
	
}
