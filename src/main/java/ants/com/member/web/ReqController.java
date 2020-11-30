package ants.com.member.web;



import java.util.List;

import javax.annotation.Resource;
import javax.enterprise.inject.New;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ants.com.member.model.ReqVo;
import ants.com.member.service.ReqService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@RequestMapping("/req")
@Controller
public class ReqController {
	private static final Logger logger = LoggerFactory.getLogger(ReqController.class); 
	
	@Resource(name="reqService")
	private ReqService reqService;
	
	/**
	 * 요구사항정의서 목록을 조회한다
	 * @param reqVo 사용자 아이디와 일치하는 요구사항정의서
	 * @param model 
	 * @param memId 사용자 아이디
	 * @return
	 */
	@RequestMapping("/reqList")
	public String selectReqList(@ModelAttribute("reqVo") ReqVo reqVo, ModelMap model, @RequestParam(name="memID",required=false) String memId) {
		//member_id 
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
		
		logger.debug("--reqVo 페이지정보:{},{}",reqVo.getFirstIndex(),reqVo.getLastIndex());

		List<?> reqList = reqService.reqList(reqVo);
		model.addAttribute("reqList", reqList);
		logger.debug("reqList:{}",reqList);

		int totCnt = reqService.reqListCount(reqVo);
		logger.debug("totCnt:{}",totCnt);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "tiles/member/reqList";
	}
	
	@RequestMapping(value="/reqInsert", method= RequestMethod.GET)
	public String insertReqView(@ModelAttribute("reqVo") ReqVo reqVo, Model model) {
		model.addAttribute("reqVo",reqVo);
		return "tiles/member/reqInsert";
	}
	
	@RequestMapping(value="/reqInsert", method= RequestMethod.POST)
		public String insertReq(@ModelAttribute("reqVo") ReqVo reqVo) {
			
			int cnt = reqService.reqInsert(reqVo);
			
			if(cnt==1) {
				return "redirect:tiles/member/reqList";
			}else {
				return "tiles/member/reqInsert";
			}
		}
	
	
	

	
}
