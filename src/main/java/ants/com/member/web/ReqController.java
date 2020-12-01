package ants.com.member.web;

import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

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
			@RequestParam(name = "memID", required = false) String memId) {
		// member_id
		memId = "pm1";
		reqVo.setMemId(memId);

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(reqVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(reqVo.getPageUnit());
		paginationInfo.setPageSize(reqVo.getPageSize());

		reqVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		reqVo.setLastIndex(paginationInfo.getLastRecordIndex());
		reqVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		logger.debug("--reqVo 페이지정보:{},{}", reqVo.getFirstIndex(), reqVo.getLastIndex());

		List<?> reqList = reqService.reqList(reqVo);
		model.addAttribute("reqList", reqList);
		logger.debug("reqList:{}", reqList);

		int totCnt = reqService.reqListCount(reqVo);
		logger.debug("totCnt:{}", totCnt);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "tiles/member/reqList";
	}
	
	@RequestMapping(value="/reqDetail")
	public String reqDetail(@ModelAttribute("reqVo") ReqVo reqVo, Model model) {
		reqVo = reqService.getReq(reqVo);
		model.addAttribute("reqVo", reqVo);
		logger.debug("요구사항 상세정보 :{}",reqVo);
		
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
		model.addAttribute("reqVo", reqVo);

		logger.debug("reqinsert Controller reqVo:{}",reqVo);
		return "tiles/member/reqInsert";
	}

	/**
	 * 요구사항정의서를 등록한다.
	 * 
	 * @param reqVo - 등록할 요구사항정의서정보가 담긴 Vo
	 * @return 성공: 요구사항리스트  실패:등록화면
	 */
	@RequestMapping(value = "/reqInsert", method = RequestMethod.POST)
	public String reqInsert(@ModelAttribute("reqVo") ReqVo reqVo, Model model) {
		logger.debug("등록할 요구사항 정의서 정보:{}", reqVo);

		int cnt = reqService.reqInsert(reqVo);
		logger.debug("요구사항정의서 등록 결과...:{}", cnt);

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
	public String reqUpdateView(@ModelAttribute("reqVo") ReqVo reqVo, Model model) {
		logger.debug("요구사항 정보가져올 reqVo:{}",reqVo);
		reqVo = reqService.getReq(reqVo);
		model.addAttribute("reqVo", reqVo);
		logger.debug("reqinsert Controller reqVo:{}",reqVo);
		
		return "tiles/member/reqInsert";
	}
	
	/**
	 * 요구사항정의서 수정
	 * @param reqVo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/reqUpdate", method = RequestMethod.POST)
	public String reqUpdate(@ModelAttribute("reqVo") ReqVo reqVo, Model model) {
		logger.debug("수정할 요구사항 정의서 정보:{}", reqVo);
		
		int cnt = reqService.reqUpdate(reqVo);
		logger.debug("요구사항정의서 등록 결과...:{}", cnt);
		
		if (cnt == 1) {
			return "redirect:/req/reqList";
		} else {
			model.addAttribute(reqVo);
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
	public String reqDelete(String reqId, Model model) {
		logger.debug("--삭제할 요구사항정의서 id : {}", reqId);

		int cnt = reqService.reqDelete(reqId);

		if (cnt == 0) {
			model.addAttribute("msg", "등록실패");
		}
		return "redirect:/req/reqList";
	}

	@RequestMapping(path = "/addPL")
	public String addPLView() {
		return "tiles/member/addPL";
	}
	
	@RequestMapping(value = "/json", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String json(Locale locale, Model model, String term) {	
		logger.debug("term:{}",term);
		List<MemberVo> memList = reqService.getAllMember(term); 
		logger.debug("멤버리스트  : {}",memList);
		Gson gson = new Gson();
		
	    return gson.toJson(memList);

	}

	

}
