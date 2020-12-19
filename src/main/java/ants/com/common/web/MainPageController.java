package ants.com.common.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.memBoard.model.ScheduleVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.common.model.IpHistoryVo;
import ants.com.file.view.FileController;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.service.MemberService;
import ants.com.member.service.ProjectService;
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

	@Resource(name = "memberService")
	private MemberService memberService;
	
	@Resource(name = "projectService")
	private ProjectService projectService;
	
	@Autowired
	FileController filecontroller;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	// 메인페이지 정보 전달
	@RequestMapping("/maindata")
	public String mainClendar(HttpSession session, Model model, String reqId, String proName) {
		
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
		model.addAttribute("proName", proName);
		
		/* 캘린더 */
		ScheduleVo scheduleVo = new ScheduleVo();
		
		scheduleVo.setReqId(reqId);
		List<ScheduleVo> showCalendar = memBoardService.showCalendar(scheduleVo);
		model.addAttribute("showSchedule", showCalendar);
		return "tiles/layout/contentmain";
	}
	
	
	// 메인 이미지 버튼 눌렀을때 
	@RequestMapping(path = "/mainreconnection")
	public String loginFunc(MemberVo memberVo, HttpSession session, Model model, String memId) {
		
		memberVo.setMemId(memId);	
		MemberVo dbMember = memberService.getMember(memberVo);
		
		List<ScheduleVo> showCalendar = new ArrayList<>(); // 캘린더 목록 선언 및 초기화
		List<IssueVo> resultList = new ArrayList<>(); // 공지사항 목록 선언 및 초기화

		// 회원 타입이 MEM일 때만 조회
		if (dbMember.getMemType().equals("MEM")) {
			// 로그인 한 회원 프로젝트 리스트 가져옴
			List<ProjectVo> proList = projectService.memInProjectList(dbMember.getMemId());

			// MEM의 프로젝트 리스트가 있을때만
			if (proList.size() != 0) {
				session.setAttribute("memInProjectList", proList); // 프로젝트 리스트 세션에 저장

				// 로그인
				/* 캘린더 초기값 */
				ScheduleVo scheduleVo = new ScheduleVo();
				scheduleVo.setReqId(proList.get(proList.size() - 1).getReqId()); // 가져온 프로젝트 리스트 중에 첫번째리스트에 있는 캘린더 보여줄거
				showCalendar = memBoardService.showCalendar(scheduleVo); // 첫번째 프로젝트 번호 가져가서 캘린더 가져옴
					
				/* 공지사항 초기값 */
				IssueVo issueVo = new IssueVo();
				issueVo.setMemId(dbMember.getMemId());
				issueVo.setReqId(proList.get(proList.size()-1).getReqId()); // 첫번째 프로젝트의 이슈 가져오기
				issueVo.setCategoryId("3"); // 카테고리 번호 (3번이 이슈)
				issueVo.setIssueKind("notice"); // 이슈 말머리 선택 (공지사항)
				model.addAttribute("reqId", proList.get(proList.size()-1).getReqId()); // 기본 프로젝트 번호 jsp로 넘겨주기
				model.addAttribute("proName", proList.get(proList.size()-1).getProName());	// 프로젝트 이름
				
				/** pageing setting */
				PaginationInfo paginationInfo = new PaginationInfo();
				paginationInfo.setCurrentPageNo(issueVo.getPageIndex());
				paginationInfo.setRecordCountPerPage(issueVo.getPageUnit());
				paginationInfo.setPageSize(issueVo.getPageSize());

				issueVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
				issueVo.setLastIndex(paginationInfo.getLastRecordIndex());
				issueVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

				resultList = promemService.issuelist(issueVo);

			}

			List<ProjectVo> pro_pL = projectService.plInProjectList(dbMember.getMemId());// 프로젝트 리스트 조회

			// PL의 프로젝트 리스트가 있을때만
			if (pro_pL.size() != 0) {
				session.setAttribute("plInProjectList", pro_pL); // 프로젝트 리스트 세션에 저장
			}
		}

		// 회원 타입이 PM일 때만 조회
		if (dbMember.getMemType().equals("PM")) {
			List<ProjectVo> prp_pm = projectService.pmInProjectList(dbMember.getMemId());// 프로젝트 리스트 조회

			// PM의 프로젝트 리스트가 있을때만
			if (prp_pm.size() != 0) {
				session.setAttribute("pmInProjectList", prp_pm); // 프로젝트 리스트 세션에 저장

				// 로그인
				/* 캘린더 초기값 */
				ScheduleVo scheduleVo = new ScheduleVo();
				scheduleVo.setReqId(prp_pm.get(prp_pm.size()-1).getReqId()); // 가져온 프로젝트 리스트 중에 첫번째리스트에 있는 캘린더 보여줄거
				showCalendar = memBoardService.showCalendar(scheduleVo); // 첫번째 프로젝트 번호 가져가서 캘린더 가져옴

				/* 공지사항 초기값 */
				IssueVo issueVo = new IssueVo();
				issueVo.setMemId(dbMember.getMemId());
				issueVo.setReqId(prp_pm.get(prp_pm.size()-1).getReqId()); // 첫번째 프로젝트의 이슈 가져오기
				issueVo.setCategoryId("3"); // 카테고리 번호 (3번이 이슈)
				issueVo.setIssueKind("notice"); // 이슈 말머리 선택 (공지사항)
				model.addAttribute("reqId", prp_pm.get(prp_pm.size()-1).getReqId()); // 기본 프로젝트 번호 jsp로 넘겨주기
				model.addAttribute("proName", prp_pm.get(prp_pm.size()-1).getProName());	// 프로젝트 이름
				
				/** pageing setting */
				PaginationInfo paginationInfo = new PaginationInfo();
				paginationInfo.setCurrentPageNo(issueVo.getPageIndex());
				paginationInfo.setRecordCountPerPage(issueVo.getPageUnit());
				paginationInfo.setPageSize(issueVo.getPageSize());

				issueVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
				issueVo.setLastIndex(paginationInfo.getLastRecordIndex());
				issueVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

				resultList = promemService.issuelist(issueVo);
			}
		}

		// 캘린더 전송 // 캘린더는 있든 없든 전송해야함
		model.addAttribute("showSchedule", showCalendar);
		// 공지사항 전송
		model.addAttribute("issuelist", resultList);

		return "tiles/layout/contentmain";
		
	}

}