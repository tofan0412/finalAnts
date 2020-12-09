package ants.com.member.web;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@RequestMapping(value="/insertProject")
	@ResponseBody
	public String insertProject(ProjectVo projectVo, Model model, HttpSession session) {
		
		int result = projectService.insertProject(projectVo);
		if (result > 0) {
			return "success";
		}
		else {
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
		}else {
			return "deny";
		}
	}
	
	@ResponseBody
	@RequestMapping("/insertPjtMember")
	public String insertPjtMember(@RequestParam(value="inviteMemList[]")String[] inviteMemList, 
								  @RequestParam(value="reqId") String reqId, 
								  @RequestParam(value="memId") String memId) {
		
		int cnt = 0; 
		// 프로젝트 초대 회원수만큼, DB에 입력한다. 
		for (int i = 0 ; i < inviteMemList.length ; i++) {
			ProjectMemberVo pjtMem = new ProjectMemberVo();
			pjtMem.setReqId(reqId);
			pjtMem.setMemId(inviteMemList[i]);
			
			// 내가 아닌 다른 회원인 경우에는 상태를 'WAIT'으로 설정하지만, 
			// 나 자신은 PL이면서 프로젝트 멤버이므로, 'IN'으로 설정한다.
			if (inviteMemList[i] != memId) {	// 만약 memId가 null이면 무조건 true..
				pjtMem.setPromemStatus("WAIT");
			}else {
				pjtMem.setPromemStatus("IN");
			}
			
			pjtMem.setPromemId("trashValue");
			int result = projectService.insertPjtMember(pjtMem);
			cnt += result;
		}
		
		if (inviteMemList.length == cnt) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@RequestMapping("/acceptOrReject")
	public String acceptOrReject(ReqVo reqVo, HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		
		if ("ACCEPT".equals(reqVo.getStatus())) {
			// PL이 요청 사항에 대해 승인 처리한 경우 -> STATUS, plId를 업데이트한다. 
			reqVo.setPlId(memberVo.getMemId());
			
			reqService.reqUpdate(reqVo);
			
		}else {
			// PL이 요청 사항에 대해 반려 처리한 경우 -> STATUS만 REJECT로 수정한다.
			reqService.reqUpdate(reqVo);
		}
		
		return "redirect:/project/readReqList";
	}
	
	
}
