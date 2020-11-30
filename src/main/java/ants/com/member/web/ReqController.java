package ants.com.member.web;



import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
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

	
}
