
package ants.com.member.web;

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

		int result = projectService.updateProject(projectVo);
		if (result > 0) {
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
			pjtMem.setMemId(inviteMemList.get(i));

			// 내가 아닌 다른 회원인 경우에는 상태를 'WAIT'으로 설정하지만,
			// 나 자신은 PL이면서 프로젝트 멤버이므로, 'IN'으로 설정한다.
			if (inviteMemList.get(i).equals(memId)) { // 만약 memId가 null이면 무조건 true..
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

	@RequestMapping("/insertProject")
	@ResponseBody
	public String insertProject(ReqVo reqVo) {
		ProjectVo projectVo = new ProjectVo();
		projectVo.setReqId(reqVo.getReqId());

		int result = projectService.insertProject(projectVo);

		if (result > 0) {
			return "success";
		} else {
			return "failure";
		}
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
		System.out.println(sessionVo);
		session.setAttribute("projectId", reqId);
		return "redirect:/project/outlineView";
	}

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

	// 차트 뷰
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

	// 차트 뷰
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
	
	// 차트 뷰
	@RequestMapping("/donutSuggestAccept")
	public String donutSuggestAccept(Model model, SuggestVo suggestVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		SuggestVo dAccept = projectService.getoutlinsuggest(reqId);
		SuggestVo dReject= projectService.getoutlinsuggestreject(reqId);
		SuggestVo dbsuggestvo = new SuggestVo();
		dbsuggestvo.setAcceptpercent(dAccept.getAcceptpercent());
		dbsuggestvo.setRejectpercent(dReject.getRejectpercent());
		model.addAttribute("dbsuggestvo", dbsuggestvo);
		return "jsonView";
	}
	
	
}
