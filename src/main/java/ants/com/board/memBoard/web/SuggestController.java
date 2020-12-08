package ants.com.board.memBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ants.com.board.memBoard.model.SuggestVo;
import ants.com.board.memBoard.service.SuggestService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/suggest")
@Controller
public class SuggestController {
	
	@Resource(name ="suggestService")
	private SuggestService suggestService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping("/readSuggestList")
	public String readSuggestList(@ModelAttribute("suggestVo") SuggestVo suggestVo ,
			HttpSession session, Model model) {
		
		String reqId = (String) session.getAttribute("projectId");
		suggestVo.setReqId(reqId);
		suggestVo.setPageUnit(propertiesService.getInt("pageUnit"));
		suggestVo.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(suggestVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(suggestVo.getPageUnit());
		paginationInfo.setPageSize(suggestVo.getPageSize());

		suggestVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		suggestVo.setLastIndex(paginationInfo.getLastRecordIndex());
		suggestVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<SuggestVo> suggestList = suggestService.readSuggestList(suggestVo);
		model.addAttribute("suggestList", suggestList);
		
		int totCnt = suggestList.size();
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "tiles/suggest/suggestList";
	}
	
}
