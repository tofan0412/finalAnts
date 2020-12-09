package ants.com.board.vote.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.vote.model.VoteItemVo;
import ants.com.board.vote.model.VoteVo;
import ants.com.board.vote.service.VoteService;
import ants.com.member.model.MemberVo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/vote")
@Controller
public class VoteController{
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name ="voteService")
	private VoteService voteService;
	
	// 나의 이슈리스트 출력
	@RequestMapping("/votelist")
	public String getvotelist(@ModelAttribute("voteVo") VoteVo voteVo, HttpSession session, Model model) throws Exception{
		
		String reqId = (String)session.getAttribute("projectId");
		voteVo.setReqId(reqId);
		
		/** EgovPropertyService.sample */
		voteVo.setPageUnit(propertiesService.getInt("pageUnit"));
		voteVo.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(voteVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(voteVo.getPageUnit());
		paginationInfo.setPageSize(voteVo.getPageSize());

		voteVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		voteVo.setLastIndex(paginationInfo.getLastRecordIndex());
		voteVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<VoteVo> votelist = voteService.votelist(voteVo);
		model.addAttribute("votelist", votelist);

		int totCnt = voteService.votePagingListCnt(voteVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "tiles/vote/votelist";
	}
	
	// 투표 작성 모달 열기
	@RequestMapping("/voteinsertView")
	public String voteinsertView(Model model){
		
		String nextVoteId = voteService.getvoteid();
		System.out.println("nextVoteId : " +nextVoteId);
		model.addAttribute("nextSeq", nextVoteId);
		
		return "jsonView";
	}
	
	
	// 투표테이블에 등록
	@RequestMapping("/voteinsert")
	public String insertvote(VoteVo voteVo, Model model, HttpSession session){
		
		String reqId = (String)session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		voteVo.setMemId(memId);
		voteVo.setReqId(reqId);	
		
		voteService.insertvote(voteVo);
		
		return "jsonView";
	}
	
	// 투표아이템 테이블에 등록
	@RequestMapping("/voteiteminsert")
	public String insertvoteitem(String voteitemName, String voteId, VoteItemVo voteitemVo, Model model){
		
		voteService.insertvoteitem(voteitemVo);
		
		return "jsonView";
	}
	
	// 투표아이템 조회(상세보기)
	@RequestMapping("/voteDetail")
	public String voteDetail(VoteVo voteVo, Model model){
		
		System.out.println("VoteId : " + voteVo.getVoteId());
		List<VoteItemVo> itemlist = voteService.voteDetail(voteVo);
		model.addAttribute("itemlist", itemlist);
		
		System.out.println("itemlist : " + itemlist);
		return "tiles/vote/voteDetail";
	}
	
	
}
