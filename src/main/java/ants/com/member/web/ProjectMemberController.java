package ants.com.member.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.member.model.MemberVo;
import ants.com.member.service.MemberServiceI;
import ants.com.member.service.ProjectmemberServiceI;

@RequestMapping("/projectMember")
@Controller
public class ProjectMemberController {
	private static final Logger logger = LoggerFactory.getLogger(ProjectMemberController.class);
	
	@Resource(name="memberService")
	MemberServiceI memberService;
	
	@Resource(name="promemService")
	ProjectmemberServiceI promemService;
	
	@RequestMapping("/loginView")
	public String loginView() {
		logger.debug("로그인뷰 진입 ...");
		return "login";
	}
	
	@RequestMapping("/loginFunc")
	public String login(String mem_id, String mem_pass,HttpSession session, Model model) {
		logger.debug("로그인 메서드 진입 ...{}", mem_id);
		Map<String, String> memInfo = new HashMap<>();
		memInfo.put("mem_id", mem_id);
		memInfo.put("mem_pass", mem_pass);
		
		MemberVo memberVo = memberService.getMember(mem_id);
		
		logger.debug("DB에서 찾은 값은 ? {}", memberVo);
		if (memberVo != null && memberVo.getMemPass().equals(memberVo.getMemPass())) {
			session.setAttribute("s_member", memberVo);
			
			return "content/project";
		}
		return "login";
	}
	
	
	@RequestMapping("/project")
	public String projectmain() {
		
		return "content/project";
	}
	
	
	@RequestMapping("/eachproject")
	public String eachproject(HttpSession session) {
		
		return "board/eachproject";
	}
	
	
	@RequestMapping("/issuelist")
	public String getissuelist(HttpSession session, Model model) {
		
		String reqId = (String)session.getAttribute("reqId");
		
		List<IssueVo> issuelist = promemService.issuelist(reqId);		
		model.addAttribute("issuelist", issuelist);
		 
		return "board/issuelist";
	}
	
	// 각 이슈 상세보기
	@RequestMapping("/eachissueDetail")
	public String geteachissue(String issueId, HttpSession session, Model model) {
		
		IssueVo issuevo = promemService.geteachissue(issueId);
		
		model.addAttribute("issuevo", issuevo);
		 
		return "board/issueDetail";
	}
	
	// 이슈 작성 View
	@RequestMapping("/insertissueView")
	public String insertissueView(HttpSession session) {

		return "board/issueInsert";
	}
	
	// 이슈 작성
	@RequestMapping("/insertissue")
	public String insertissue(IssueVo issueVo, HttpSession session, Model model) {
		
		String reqId = (String)session.getAttribute("reqId");
		issueVo.setReqId(reqId);
		issueVo.setMemId("cony@naver.com");
		
//		System.out.println(issueVo);
		int insertCnt = promemService.insertissue(issueVo);

		if(insertCnt>0) {		
			return "redirect:/projectMember/issuelist";
		}else {
			return "redirect:/projectMember/insertissueView";
			
		}
	}
	
	// 이슈 update View
	@RequestMapping("/updateissueView")
	public String updateissueView(String issueId, HttpSession session, Model model) {
		
		IssueVo issuevo = promemService.geteachissue(issueId);
		model.addAttribute("issueVo", issuevo);
		
		return "board/issueUpdate";
	}
	
	// 이슈 update 
	@RequestMapping("/updateissue")
	public String updateissue(IssueVo issueVo, HttpSession session, Model model) {
		
		String reqId = (String)session.getAttribute("reqId");
		issueVo.setReqId(reqId);
		issueVo.setMemId("cony@naver.com");
		
		int insertCnt = promemService.insertissue(issueVo);
		
		if(insertCnt>0) {		
			return "redirect:/projectMember/issuelist";
		}else {
			return "redirect:/projectMember/updateissueView";
			
		}
	}
	
	
	// 이슈 delete 
	@RequestMapping("/delissue")
	public String delissue(String issueId, HttpSession session, Model model) {
		
		
		int delCnt = promemService.delissue(issueId);
		System.out.println(delCnt);
		
		if(delCnt>0) {		
			return "redirect:/projectMember/issuelist";
		}else {
			return "redirect:/projectMember/eachissueDetail?issue="+issueId;
		}
	}
	
	
}
