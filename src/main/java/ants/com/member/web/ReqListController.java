package ants.com.member.web;



import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ants.com.common.model.PageVO;
import ants.com.member.model.ReqVo;
import ants.com.member.service.PmServiceI;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@RequestMapping("/req")
@Controller
public class ReqListController {
	private static final Logger logger = LoggerFactory.getLogger(ReqListController.class);
	
	@Resource(name="pmService")
	private PmServiceI pmService;
	
	@RequestMapping("/reqList")
	public String selectReqList(@ModelAttribute("reqVo") ReqVo reqVo, ModelMap model
								) {
		//member_id 
		String memId = "pm1";
		reqVo.setMemId(memId);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(reqVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(reqVo.getPageUnit());
		paginationInfo.setPageSize(reqVo.getPageSize());

		reqVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		reqVo.setLastIndex(paginationInfo.getLastRecordIndex());
		reqVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> reqList = pmService.reqList(reqVo);
		model.addAttribute("reqList", reqList);

		int totCnt = pmService.reqListCount(reqVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		
		return "tiles/member/pmReqList";
	}

	
}
