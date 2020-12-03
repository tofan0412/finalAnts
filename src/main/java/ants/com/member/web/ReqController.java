package ants.com.member.web;

import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import ants.com.member.model.MemberVo;
import ants.com.member.model.ReqVo;
import ants.com.member.service.MemberService;
import ants.com.member.service.ReqService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/req")
@Controller
public class ReqController {
	private static final Logger logger = LoggerFactory.getLogger(ReqController.class);

	@Resource(name = "reqService")
	private ReqService reqService;
	
	@Resource(name = "memberService")
	private MemberService memberService;

	/**
	 * 요구사항정의서 목록을 조회한다
	 * 
	 * @param reqVo 사용자 아이디와 일치하는 요구사항정의서
	 * @param model
	 * @param memId 사용자 아이디
	 * @return
	 */
	@RequestMapping("/reqList")
	public String selectReqList(@ModelAttribute("reqVo") ReqVo reqVo, ModelMap model,
			HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER"); 
		reqVo.setMemId(memberVo.getMemId());
		logger.debug("받아온 reqVo:{}",reqVo);

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(reqVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(reqVo.getPageUnit());
		paginationInfo.setPageSize(reqVo.getPageSize());

		reqVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		reqVo.setLastIndex(paginationInfo.getLastRecordIndex());
		reqVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> reqList = reqService.reqList(reqVo);
		model.addAttribute("reqList", reqList);
		logger.debug("결과reqVo...........:{}",reqVo);

		int totCnt = reqService.reqListCount(reqVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "tiles/member/reqList";
	}
	
	@RequestMapping(value="/reqDetail")
	public String reqDetail(@RequestParam(name="selectedId", required= false) String id,@ModelAttribute("reqVo") ReqVo reqVo, Model model) {
		if(id != null) {
			reqVo.setReqId(id);
		}
		reqVo = reqService.getReq(reqVo);
		model.addAttribute("reqVo", reqVo);
		
		return "tiles/member/reqDetail";
	}

	/**
	 * 요구사항정의서 등록화면을 조회한다
	 * 
	 * @param reqVo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/reqInsertView")
	public String insertReqView(@ModelAttribute("reqVo") ReqVo reqVo, Model model) {
		reqVo.setReqId(null);
		model.addAttribute("reqVo", reqVo);

		return "tiles/member/reqInsert";
	}

	/**
	 * 요구사항정의서를 등록한다.
	 * 
	 * @param reqVo - 등록할 요구사항정의서정보가 담긴 Vo
	 * @return 성공: 요구사항리스트  실패:등록화면
	 */
	@RequestMapping(value = "/reqInsert", method = RequestMethod.POST)
	public String reqInsert(@ModelAttribute("reqVo") ReqVo reqVo, Model model, HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		reqVo.setMemId(memberVo.getMemId());
		
		int cnt = reqService.reqInsert(reqVo);

		if (cnt == 1) {
			return "redirect:/req/reqList";
		} else {
			model.addAttribute(reqVo);
			return "tiles/member/reqInsert";
		}
	}
	
	/**
	 * 요구사항정의서 수정화면을 조회한다
	 * 
	 * @param reqVo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/reqUpdateView")
	public String reqUpdateView(@ModelAttribute("reqVo") ReqVo reqVo, Model model, HttpSession session, @RequestParam(name="selectedId", required= false) String id) {
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		reqVo.setMemId(memberVo.getMemId());
		reqVo.setReqId(id);
		reqVo = reqService.getReq(reqVo);
		model.addAttribute("reqVo", reqVo);
		
		return "tiles/member/reqInsert";
	}
	
	/**
	 * 요구사항정의서 수정
	 * @param reqVo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/reqUpdate", method = RequestMethod.POST)
	public String reqUpdate(@ModelAttribute("reqVo") ReqVo reqVo, Model model, RedirectAttributes ra) {
		
		int cnt = reqService.reqUpdate(reqVo);
		
		if (cnt == 1) {
			ra.addFlashAttribute("reqVo", reqVo);
			return "redirect:/req/reqDetail";
		} else {
			model.addAttribute("reqVo",reqVo);
			return "tiles/member/reqInsert";
		}
	}
	
	/**
	 * 요구사항정의서 삭제
	 * @param reqId 요구사항정의서 id
	 * @param model 실패메세지담기
	 * @return 요구사항정의서 리스트
	 */
	@RequestMapping(value = "/reqDelete")
	public String reqDelete(@RequestParam(name="selectedId", required= false) String id, Model model) {

		int cnt = reqService.reqDelete(id);

		if (cnt == 0) {
			model.addAttribute("msg", "삭제에 실패했습니다.");
		}
		return "redirect:/req/reqList";
	}

	@RequestMapping(path = "/addPL")
	public String addPLView() {
		return "tiles/member/addPL";
	}
	
	/**
	 * memId 자동완성기능
	 * @param locale
	 * @param model
	 * @param term 입력한 검색키워드(memId에서 검색)
	 * @return 검색조건에 해당하는 memberVo타입의 list
	 */
	@RequestMapping(value = "/json", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String json(Locale locale, Model model, String term) {	
		List<MemberVo> memList = memberService.getAllMember(term); 
		Gson gson = new Gson();
		
	    return gson.toJson(memList);
	}
	
	@RequestMapping(value="/memIdCheck")
	public String memIdCheck(MemberVo memberVo, Model model) {
		//조회된 회원정보
		memberVo = memberService.getMember(memberVo);
		model.addAttribute("memberVo", memberVo);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/plDelete")
	public String plDelete(ReqVo reqVo, @RequestParam(name="selectedId", required= false) String id) {
		reqVo.setReqId(id);
		int cnt = reqService.plDelete(reqVo);
		
		return "redirect:/req/reqList";
	}
	

	

}
