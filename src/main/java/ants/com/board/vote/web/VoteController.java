package ants.com.board.vote.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.board.vote.model.VoteItemVo;
import ants.com.board.vote.model.VoteResultVo;
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
	
	@Resource(name="memBoardService")
	memBoardService memBoardService;
	
	
	// 나의 이슈리스트 출력
	@RequestMapping("/votelist")
	public String getvotelist(@ModelAttribute("voteVo") VoteVo voteVo, HttpSession session, Model model) throws Exception{
		
		String reqId = (String)session.getAttribute("projectId");
		voteVo.setReqId(reqId);
		
		voteService.paststatusupdate();//시간 지난 투표 finish로
		
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
		
		System.out.println("마감 :" + voteVo.getVoteDeadline());
		
		voteService.insertvote(voteVo);
		
		return "jsonView";
	}
	
	// 투표아이템 테이블에 등록
	@RequestMapping("/voteiteminsert")
	public String insertvoteitem(String voteitemName, String voteId, VoteItemVo voteitemVo, Model model){
		
		voteService.insertvoteitem(voteitemVo);
		
		return "jsonView";
	}
	
	// 해당 투표조회(상세보기)
	@RequestMapping("/voteDetail")
	public String voteDetail(VoteVo voteVo, Model model, HttpSession session) throws SQLException, IOException{
		
		String reqId = (String)session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		voteVo.setMemId(memId);
		
		List<VoteItemVo> itemlist = voteService.voteitemDetail(voteVo);
		VoteVo dbvoteVo = voteService.voteDetail(voteVo);
		VoteResultVo voteres = voteService.voteresDetail(voteVo);
		
		ReplyVo replyVo = new ReplyVo(voteVo.getVoteId(), "10", reqId, memId);	//댓글 조회
		List<ReplyVo> replylist= memBoardService.replylist(replyVo);
		
		model.addAttribute("replylist", replylist);
		
		model.addAttribute("itemlist", itemlist);
		model.addAttribute("voteVo", dbvoteVo);
		model.addAttribute("voteres", voteres);
		
		return "tiles/vote/voteDetail";
	}
	
	// 멤버 투표
	@RequestMapping("/voteMember")
	public String voteMember(VoteResultVo voteresultVo, Model model, HttpSession session, RedirectAttributes ra){
		
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		voteresultVo.setMemId(memId);
		
		voteService.voteMember(voteresultVo);
		
		ra.addAttribute("voteId", voteresultVo.getVoteId());
		
		return "redirect:/vote/voteDetail";
	}
	
	// 투표 삭제
	@RequestMapping("/delVote")
	public String voteDel(VoteVo voteVo, Model model, HttpSession session, RedirectAttributes ra){
		
		voteService.delvote(voteVo);
		
		return "redirect:/vote/votelist";
	}
	
	
	
}
