package ants.com.common.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.memBoard.model.ScheduleVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.file.view.FileController;
import ants.com.member.model.MemberVo;
import ants.com.member.service.ProjectmemberService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/mainpage")
@Controller
public class MainPageController {
		
	@Resource(name = "memBoardService")
	private memBoardService memBoardService;
	
	@Resource(name="promemService")
	ProjectmemberService promemService;
	
	@Autowired
	FileController filecontroller;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	
	// 메인페이지 정보 전달
	@RequestMapping("/maindata")
	public String mainClendar(HttpSession session, Model model, String reqId) {
		
		/* 공지사항 */
		IssueVo issueVo = new IssueVo();
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
			
		issueVo.setMemId(memId);
		issueVo.setReqId(reqId);
		issueVo.setCategoryId("3");
		issueVo.setIssueKind("notice");
				
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(issueVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(issueVo.getPageUnit());
		paginationInfo.setPageSize(issueVo.getPageSize());
		
		issueVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		issueVo.setLastIndex(paginationInfo.getLastRecordIndex());
		issueVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<IssueVo> resultList = promemService.issuelist(issueVo);
		model.addAttribute("issuelist", resultList);
		model.addAttribute("reqId", reqId);
				
		
		/* 캘린더 */
		ScheduleVo scheduleVo = new ScheduleVo();
		
		scheduleVo.setReqId(reqId);
		List<ScheduleVo> showCalendar = memBoardService.showCalendar(scheduleVo);
		model.addAttribute("showSchedule", showCalendar);
		return "tiles/layout/contentmain";
	}
	
}