
package ants.com.member.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.manageBoard.service.ManageBoardService;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.model.SuggestVo;
import ants.com.board.vote.model.VoteVo;
import ants.com.file.model.PublicFileVo;
import ants.com.member.model.MemberVo;
import ants.com.member.model.ProjectMemberVo;
import ants.com.member.model.ProjectVo;
import ants.com.member.model.ReqVo;
import ants.com.member.service.ProjectService;
import ants.com.member.service.ReqService;

@RequestMapping("/project")
@Controller
public class ProjectController {

	@Resource(name = "projectService")
	private ProjectService projectService;

	@Resource(name = "reqService")
	private ReqService reqService;

	@Resource(name = "manageBoardService")
	private ManageBoardService manageBoardService;

	@RequestMapping("/readReqList")
	// 나에게 요청된 요구사항정의서 목록을 살펴본다.
	public String readReqList(HttpSession session, Model model) {

		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		String plId = memberVo.getMemId();

		List<ReqVo> reqList = projectService.readReqList(plId);

		model.addAttribute("reqList", reqList);
		return "tiles/project/projectList";
	}

	// 요구사항 정의서에 대한 프로젝트를 생성한다 in DB
	@RequestMapping(value = "/updateProject")
	@ResponseBody
	public String updateProject(ProjectVo projectVo, Model model, HttpSession session) {
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		projectVo.setRegDt(sdf.format(today));
		
		int result = projectService.updateProject(projectVo);
		if (result > 0) {
			
			// left 세션 업데이트
			MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
			String memId = memberVo.getMemId();
			List<ProjectVo> pro_pL = projectService.plInProjectList(memId);
			if (pro_pL.size() != 0) {
				session.setAttribute("plInProjectList", pro_pL); 
			}
			
			return "success";
		} else {
			return "fail";
		}

	}

	@ResponseBody
	@RequestMapping("/userSearch")
	public List<MemberVo> userSearch(String keyword) {
		List<MemberVo> memList = projectService.userSearch(keyword);
		return memList;
	}

	@ResponseBody
	@RequestMapping("/chkMemId")
	public String chkMemId(String memId) {
		// 사용자 아이디를 통해 DB에 존재하는지 확인한다.
		MemberVo memberVo = projectService.chkMemId(memId);
		if (memberVo != null) {
			return "accept";
		} else {
			return "deny";
		}
	}

	@ResponseBody
	@RequestMapping("/insertPjtMember")
	public String insertPjtMember(@RequestParam(value = "inviteMemList[]") List<String> inviteMemList,
			@RequestParam(value = "reqId") String reqId, @RequestParam(value = "memId") String memId) {

		int cnt = 0;
		// 프로젝트 초대 회원수만큼, DB에 입력한다.
		for (int i = 0; i < inviteMemList.size(); i++) {
			ProjectMemberVo pjtMem = new ProjectMemberVo();
			pjtMem.setReqId(reqId);
			pjtMem.setMemName(inviteMemList.get(i).split(":")[0]);
			pjtMem.setMemId(inviteMemList.get(i).split(":")[1]);

			// 내가 아닌 다른 회원인 경우에는 상태를 'WAIT'으로 설정하지만,
			// 나 자신은 PL이면서 프로젝트 멤버이므로, 'IN'으로 설정한다.
			if (inviteMemList.get(i).split(":")[1].equals(memId)) { // 만약 memId가 null이면 무조건 true..
				pjtMem.setPromemStatus("IN");
			} else {
				pjtMem.setPromemStatus("WAIT");
			}

			pjtMem.setPromemId("trashValue");
			int result = projectService.insertPjtMember(pjtMem);
			cnt += result;
		}

		if (inviteMemList.size() == cnt) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	@RequestMapping("requestPjtMember")
	public String requestPjtMember(HttpSession session, Model model) {
		//data setting
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		List<ProjectMemberVo> pjtMemberList = projectService.requestPjtMember(memberVo);
		model.addAttribute("pjtMemberList", pjtMemberList);
		
		// left 세션 업데이트
		MemberVo memberVo2 = (MemberVo) session.getAttribute("SMEMBER");
		String memId = memberVo2.getMemId();
		List<ProjectVo> proList = projectService.memInProjectList(memId);
		if (proList.size() != 0) {
			session.setAttribute("memInProjectList", proList); 
		}
		
		return "tiles/project/pjtMemberList";
	}
	
	@RequestMapping("updatePjtMember")
	public String updatePjtMember(ProjectMemberVo projectMemberVo,HttpSession session) {
		//data setting
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		projectMemberVo.setMemId(memberVo.getMemId());
		projectMemberVo.setPromemStatus("IN");
		
		projectService.updatePjtMember(projectMemberVo);
		return "jsonView";
	}
	@RequestMapping("deletePjtMember")
	public String deletePjtMember(ProjectMemberVo projectMemberVo,HttpSession session) {
		
		projectService.deletePjtMember(projectMemberVo);
		return "jsonView";
	}

	
	@RequestMapping("/acceptOrReject")
	public String acceptOrReject(ReqVo reqVo, HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");

		if ("ACCEPT".equals(reqVo.getStatus())) {
			// PL이 요청 사항에 대해 승인 처리한 경우 -> STATUS만 업데이트 한다. (PL_ID는 전송한 시점에서 바로 업데이트 된다.)

			reqService.reqUpdate(reqVo);

			// 프로젝트 찾아서 memId를 등록해 준다.
			ProjectVo projectVo = new ProjectVo();
			projectVo.setMemId(memberVo.getMemId()); // PL 이름 등록
			projectVo.setReqId(reqVo.getReqId()); // 해당 프로젝트를 ReqId로 찾기.

			projectService.updateProject(projectVo);
			
			String memId = memberVo.getMemId();
			List<ProjectVo> pro_pL = projectService.plInProjectList(memId);
			if (pro_pL.size() != 0) {
				session.setAttribute("plInProjectList", pro_pL); 
			}
		} else {
			// PL이 요청 사항에 대해 반려 처리한 경우 -> STATUS만 REJECT로 수정한다.
			reqService.reqUpdate(reqVo);
		}

		return "redirect:/project/readReqList";
	}

	// 할일등록, 할일삭제, 할일 진행도 수정시 프로젝트 진행도 수정
	@RequestMapping(path = "/propercentChange")
	public int propercentChange(ProjectVo projectVo) {

		int res = projectService.propercentChange(projectVo);

		return res;

	}

	// 프로젝트 버튼 클릭시 세션저장
	@RequestMapping("/projectgetReq")
	public String projectgetReq(HttpSession session, String reqId) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		ProjectVo projectVo = new ProjectVo();
		projectVo.setMemId(memId);
		projectVo.setReqId(reqId);
		ProjectVo sessionVo = manageBoardService.projectList(projectVo);
		session.setAttribute("projectVo", sessionVo);
		session.setAttribute("projectId", reqId);
		return "redirect:/project/outlineView";
	}
	
	// 프로젝트 버튼 클릭시 세션저장
	@RequestMapping("/pmProjectgetReq")
	public String pmProjectgetReq(HttpSession session, String reqId) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		ProjectVo projectVo = new ProjectVo();
		projectVo.setMemId(memId);
		projectVo.setReqId(reqId);
		ProjectVo sessionVo = manageBoardService.pmProjectList(projectVo);
		session.setAttribute("projectVo", sessionVo);
		session.setAttribute("projectId", reqId);
		return "redirect:/project/outlineView";
	}

	//개요페이지
	@RequestMapping("/outlineView")
	public String outlineView(HttpSession session, Model model) {
		String reqId = (String) session.getAttribute("projectId");
		ReqVo dbreqvo = reqService.getoutlinereq(reqId);
		ProjectVo dbprojectvo = projectService.getoutlinepro(reqId);
		List<ProjectMemberVo> dbpromemvo = projectService.getoutlinepromem(reqId);
		VoteVo dbvotevo = projectService.getoutlinevote(reqId);
		PublicFileVo dbfilevo = projectService.getoutlinefiles(reqId);
		ReplyVo dbreplyvo = projectService.getoutlinereply(reqId);
		SuggestVo dbsuggestvo = projectService.getoutlinsuggest(reqId);
		List<TodoVo> dbtodovo = projectService.getoutlindeadline(reqId);
		model.addAttribute("req", dbreqvo);
		model.addAttribute("pro", dbprojectvo);
		model.addAttribute("promem", dbpromemvo);
		model.addAttribute("dbvotevo", dbvotevo);
		model.addAttribute("dbfilevo", dbfilevo);
		model.addAttribute("dbreplyvo", dbreplyvo);
		model.addAttribute("dbsuggestvo", dbsuggestvo);
		model.addAttribute("dbtodovo", dbtodovo);
		return "tiles/layout/outline";
	}

	// 차트 뷰
	@RequestMapping("/chartView")
	public String chartView(Model model, TodoVo todoVo, HttpSession session) {
		return "tiles/chart/chartmain";
	}

	// 팀원별 할일 진행도
	@RequestMapping("/stackedbarchart")
	public String stackedbarchart(Model model, TodoVo todoVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		List<TodoVo> todoVoList = manageBoardService.todostackchart(reqId);
		model.addAttribute("todoVoList", todoVoList);
		int Size = todoVoList.size();
		model.addAttribute("size", Size);
		return "jsonView";
	}

	// 팀원별 할일 비중도
	@RequestMapping("/donutChart")
	public String donutChart(Model model, TodoVo todoVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		todoVo.setReqId(reqId);
		List<TodoVo> donutChartList = manageBoardService.donutChart(reqId);
		model.addAttribute("donutChartList", donutChartList);
		int Size = donutChartList.size();
		model.addAttribute("dsize", Size);
		return "jsonView";
	}

	// 건의사항 수용, 거절, 대기 율
	@RequestMapping("/donutSuggestAccept")
	public String donutSuggestAccept(Model model, SuggestVo suggestVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		SuggestVo dAccept = projectService.getoutlinsuggest(reqId);
		SuggestVo dReject = projectService.getoutlinsuggestreject(reqId);
		SuggestVo dbsuggestvo = new SuggestVo();
		dbsuggestvo.setAcceptpercent(dAccept.getAcceptpercent());
		dbsuggestvo.setRejectpercent(dReject.getRejectpercent());
		model.addAttribute("dbsuggestvo", dbsuggestvo);
		return "jsonView";
	}

	// 팀원별 건의사항 작성 수
	@RequestMapping("/barchartSuggestCnt")
	public String chartsuggestcnt(Model model, SuggestVo suggestVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<SuggestVo> suggestlist = projectService.chartsuggestcnt(reqId);
		int size = suggestlist.size();
		model.addAttribute("suggestlist", suggestlist);
		model.addAttribute("dbsize", size);
		return "jsonView";
	}

	// 전체 투표 참여율
	@RequestMapping("/donutchartvotetotal")
	public String donutchartvotetotal(Model model, VoteVo voteVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		voteVo = projectService.getoutlinevote(reqId);
		model.addAttribute("voteVo", voteVo);
		return "jsonView";
	}

	// 개인별 투표참여율
	@RequestMapping("/barchartvoteindi")
	public String barchartvoteindi(Model model, VoteVo voteVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<VoteVo> VoteList = projectService.barchartvoteindi(reqId);
		int size = VoteList.size();
		model.addAttribute("VoteList", VoteList);
		model.addAttribute("dbsize", size);
		return "jsonView";
	}
	
	// 일별 파일 업로드용량
	@RequestMapping("/chartfilesday")
	public String chartfilesday_mb(Model model, PublicFileVo publicFileVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<PublicFileVo> publicFileList = projectService.chartfilesday(reqId);
		int size = publicFileList.size();
		model.addAttribute("publicFileList", publicFileList);
		model.addAttribute("dbsize", size);
		return "jsonView";
	}
	
	// 월별 파일 업로드 용량
	@RequestMapping("/chartfilesmonth")
	public String chartfilesmonth(Model model, PublicFileVo publicFileVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<PublicFileVo> publicFileList = projectService.chartfilesmonth(reqId);
		int size = publicFileList.size();
		model.addAttribute("publicFileList", publicFileList);
		model.addAttribute("dbsize", size);
		return "jsonView";
	}
	
	// 확장자별 업로드 수
	@RequestMapping("/chartextension")
	public String chartfilesextension(Model model, PublicFileVo publicFileVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<PublicFileVo> publicFileList = projectService.chartfilesextension(reqId);
		int size = publicFileList.size();
		model.addAttribute("publicFileList", publicFileList);
		model.addAttribute("dbsize", size);
		return "jsonView";
	}
	
	// 일별 이슈 작성수
	@RequestMapping("/chartIssuesday")
	public String chartIssuesday(Model model,IssueVo issueVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<IssueVo> issueList = projectService.chartIssuesday(reqId);
		int size = issueList.size();
		model.addAttribute("issueList", issueList);
		model.addAttribute("dbsize", size);
		return "jsonView";
	}
	
	// 월별 이슈 작성수
	@RequestMapping("/chartIssuesmonth")
	public String chartIssuesmonth(Model model, IssueVo issueVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<IssueVo> issueList = projectService.chartIssuesmonth(reqId);
		int size = issueList.size();
		model.addAttribute("issueList", issueList);
		model.addAttribute("dbsize", size);
		return "jsonView";
	}
	
	// 팀원별 이슈 작성수
	@RequestMapping("/chartIssuesCnt")
	public String chartIssuesCnt(Model model, IssueVo issueVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<IssueVo> issueList = projectService.chartIssuesCnt(reqId);
		int size = issueList.size();
		model.addAttribute("issueList", issueList);
		model.addAttribute("dbsize", size);
		return "jsonView";
	}
	// 일별 프로젝트 진행도
	@RequestMapping("/chartproday")
	public String chartproday(Model model, ProjectVo projectVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		List<ProjectVo> projectList = projectService.chartproday(reqId);
		int size = projectList.size();
		model.addAttribute("projectList", projectList);
		model.addAttribute("dbsize", size);
		return "jsonView";
	}
	
	//  프로젝트 진행도
	@RequestMapping("/donutChartproper")
	public String donutChartproper(Model model, ProjectVo projectVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		projectVo = projectService.getoutlinepro(reqId);
		model.addAttribute("projectVo", projectVo);
		return "jsonView";
	}
	
	//  프로젝트 진행도
	@RequestMapping("/projectManage")
	public String projectManage(Model model, ProjectVo projectVo, HttpSession session) {
		int res = projectService.projectManage(projectVo);
		model.addAttribute("data", res);
		
		// session에 저장해야 한다 !!
		ProjectVo sessionVo = (ProjectVo) session.getAttribute("projectVo");
		sessionVo.setProStatus(projectVo.getProStatus());
		session.setAttribute("projectVo", sessionVo);
		
		return "jsonView";
	}
	
	// PM이 되려면 현재 진행중인 프로젝트 중 내가 PL인 프로젝트가 없어야 한다.
	@RequestMapping("/checkPM")
	@ResponseBody
	public String checkPM(MemberVo memberVo) {
		List<ProjectVo> projectList = projectService.checkPM();
		
		for (int i = 0 ; i < projectList.size() ; i++) {
			if (projectList.get(i).getMemId().equals(memberVo.getMemId())){
				return "fail";
			}
		}
		return "pass";
	}
}
