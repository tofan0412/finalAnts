package ants.com.board.manageBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.manageBoard.model.HotIssueVo;
import ants.com.board.manageBoard.service.ManageBoardService;
import ants.com.file.model.HotIssueFileVo;
import ants.com.file.view.HotIssueFileController;
import ants.com.member.model.MemberVo;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/hotIssue")
@Controller
public class HotIssueController {

	
	@Resource(name = "manageBoardService")
	private ManageBoardService manageBoardService;

	@Autowired
	HotIssueFileController hotIssueFileController ;

	
	// 핫이슈 조회
	@RequestMapping("/hissueList")
	public String hissueList(@ModelAttribute("hotIssueVo") HotIssueVo hotIssueVo, ModelMap model, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		if(reqId != null) {
			hotIssueVo.setReqId(reqId);
		}
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(hotIssueVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(hotIssueVo.getPageUnit());
		paginationInfo.setPageSize(hotIssueVo.getPageSize());

		hotIssueVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		hotIssueVo.setLastIndex(paginationInfo.getLastRecordIndex());
		hotIssueVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> hotIssueList = manageBoardService.gethissueList(hotIssueVo);
		model.addAttribute("hotIssueList", hotIssueList);
		int totCnt = manageBoardService.issueListCount(hotIssueVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		if(hotIssueVo.getSearchKeyword() != null) {			
			session.setAttribute("searchKeyword", hotIssueVo.getSearchKeyword());
			session.setAttribute("searchCondition",hotIssueVo.getSearchCondition());
			session.setAttribute("pageIndex", hotIssueVo.getPageIndex());
		}
		
		return "tiles/manager/plpm_hotissueList";
	}
	
	
	// 핫이슈 상세보기
	@RequestMapping("/hissueDetailView")
	public String hissueDetail(Model model, HotIssueVo hotIssueVo) {
		List<HotIssueVo> hotlist = manageBoardService.gethissueandchild(hotIssueVo);
		int size = hotlist.size();
		if(size==2) {
			String p_hissId = hotlist.get(0).getHissueId();
			String c_hissId = hotlist.get(1).getHissueId();
			HotIssueFileVo pfv = new HotIssueFileVo(p_hissId);
			HotIssueFileVo pfv2 = new HotIssueFileVo(c_hissId);
			hotIssueFileController.getfiles(pfv, model);
			hotIssueFileController.getfiles2(pfv2, model);			
			
		}
		if(size==1) {
			String p_hissId = hotlist.get(0).getHissueId();
			HotIssueFileVo pfv = new HotIssueFileVo(p_hissId);
			hotIssueFileController.getfiles(pfv, model);
		}
		
		model.addAttribute("hotlist", hotlist);
		model.addAttribute("dbsize", size);
		return "tiles/manager/plpm_hissueDetail";
	}
	
	
	// 핫이슈 등록 화면 출력
	@RequestMapping("/hissueInsertView")
	public String todoInsertView(@ModelAttribute("hotIssueVo") HotIssueVo hotIssueVo, Model model) {
		String hissueId = manageBoardService.gethissueId();
		model.addAttribute("hissueSeq", hissueId);
		// 부모 게시글정보
		if(hotIssueVo.getHissueParentid() != null) {
			String hissueParentid = hotIssueVo.getHissueParentid();
			hotIssueVo.setHissueId(hissueParentid);
			hotIssueVo = manageBoardService.gethissue(hotIssueVo);
			model.addAttribute("hissueParentid", hissueParentid);
		}
		
		model.addAttribute("hotIssueVo", hotIssueVo);
		return "tiles/manager/plpm_hotissueInsert";
	}
	
	// 핫이슈 등록
	@RequestMapping("/hissueInsert")
	public String hissueInsert(Model model, HotIssueVo hotIssueVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		hotIssueVo.setReqId(reqId);
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		hotIssueVo.setWriter(memId);
		int hissueInsert = manageBoardService.hissueInsert(hotIssueVo);
		if (hissueInsert  > 0) {
			return "redirect:/hotIssue/hissueList";
		} else {
			return "redirect:/hotIssue/hissueInsertView";
		}
	}
	
	// 핫이슈 답글 등록
	@RequestMapping("/hissueInsertChild")
	public String hissueInsertChild(Model model, HotIssueVo hotIssueVo, HttpSession session) {
		String reqId = (String) session.getAttribute("projectId");
		hotIssueVo.setReqId(reqId);
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		hotIssueVo.setWriter(memId);
		int hissueInsert = manageBoardService.hissueInsert(hotIssueVo);
		if (hissueInsert  > 0) {
			return "redirect:/hotIssue/hissueList";
		} else {
			return "redirect:/hotIssue/hissueInsertView";
		}
	}
	
	
	// 핫이슈 수정
	@RequestMapping("/updatehissue")
	public String updatehissue(HotIssueVo hotIssueVo, Model model) {
		int updateCnt = manageBoardService.hIssueupdate(hotIssueVo);
		if (updateCnt > 0) {
			return "redirect:/hotIssue/hissueDetailView?hissueId="+hotIssueVo.getHissueId();
		} else {
			return "redirect:/hotIssue/updatehissueView";
		}
	}
	
    // 핫이슈 수정 화면 출력	
	@RequestMapping("/updatehissueView")
	public String updatehissueView(Model model, HotIssueVo hotIssueVo) {
		hotIssueVo.setHissueId(hotIssueVo.getHissueId());;
		HotIssueVo dbVo = manageBoardService.gethissue(hotIssueVo);
		HotIssueFileVo pfv = new HotIssueFileVo(hotIssueVo.getHissueId());
		hotIssueFileController.getfiles(pfv, model);
		model.addAttribute("hotIssueVo", dbVo);
		return "tiles/manager/plpm_hotissueUpdate";
	}
	
	
	// 핫이슈 삭제
	@RequestMapping("/hotissuedel")
	public String hotissuedel(HotIssueVo hotIssueVo, Model model) {
		int delTodoCnt = manageBoardService.hIssuedelete(hotIssueVo);
		if (delTodoCnt > 0) {
			return "redirect:/hotIssue/hissueList";
		} else {
			return "redirect:/hotIssue/hissueDetailView?hissueId="+hotIssueVo.getHissueId();
		}
	}
}
