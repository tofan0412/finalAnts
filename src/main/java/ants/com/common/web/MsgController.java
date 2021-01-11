package ants.com.common.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ants.com.board.memBoard.model.SuggestVo;
import ants.com.common.model.MsgVo;
import ants.com.common.service.MsgService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/msg")
@Controller
public class MsgController {

	@Resource(name="msgService")
	MsgService msgService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping("/insertMsg")
	@ResponseBody
	public int insertMsg(MsgVo msgVo) {
		return msgService.insertMsg(msgVo);
	}
	
	@RequestMapping("/msgList")
	public String msgList(@ModelAttribute("msgVo") MsgVo msgVo, Model model, HttpSession session){
		
		msgVo.setPageUnit(propertiesService.getInt("pageUnit"));
		msgVo.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(msgVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(msgVo.getPageUnit());
		paginationInfo.setPageSize(msgVo.getPageSize());

		msgVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		msgVo.setLastIndex(paginationInfo.getLastRecordIndex());
		msgVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<MsgVo> result = msgService.msgList(msgVo);
		model.addAttribute("msgList", result);
		
		int totCnt = msgService.msgPagingCnt(msgVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		session.setAttribute("pageIndex", msgVo.getPageIndex());
		
		return "admin.tiles/admin/adminMsgList";
	}
	
	@RequestMapping("/msgUpdate")
	public String msgUpdate(MsgVo msgVo) {
		int result = msgService.msgUpdate(msgVo);
		if (result > 0) {
			return "redirect:/msg/msgList";
		}else {
			return "admin.tiles/admin/adcontentmain";
		}
	}
	
	@RequestMapping("/myMsgList")
	@ResponseBody
	public List<MsgVo> myMsgList(MsgVo msgVo){
		return msgService.myMsgList(msgVo); 
	}
	
}
