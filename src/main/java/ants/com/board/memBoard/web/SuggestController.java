package ants.com.board.memBoard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.SuggestVo;
import ants.com.board.memBoard.service.SuggestService;
import ants.com.member.model.MemberVo;
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
	
	@RequestMapping("/searchTodo")
	@ResponseBody
	public List<TodoVo> searchTodo(TodoVo todoVo, String keyword, HttpSession session){
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER"); 
		
		// 검색할 일감은 로그인한 유저의 일감이어야 하고, 키워드를 통해 제목을 검색해야 한다.
		todoVo.setMemId(memberVo.getMemId());
		if (("@").equals(keyword)) {
			todoVo.setTodoTitle("%%");
		}else {
			todoVo.setTodoTitle(("%").concat(keyword).concat("%"));
		}
		
		return suggestService.searchTodo(todoVo);
		
	}
	
	@RequestMapping("/suggestInsert")
	public String suggestInsert(@ModelAttribute("suggestVo") SuggestVo suggestVo, 
			RedirectAttributes ra) {
		
		// todoId를 먼저 가공해야 한다.
		String[] todoArr = suggestVo.getTodoId().split(":");
		todoArr[0] = todoArr[0].replace("@", "");
		todoArr[0] = todoArr[0].replace("[", "");
		todoArr[0] = todoArr[0].replace("]", "");
		suggestVo.setTodoId(todoArr[0]);
		suggestVo.setCategoryId("4");
		suggestVo.setDel("N");
		suggestVo.setSgtStatus("WAIT");
		
		suggestService.suggestInsert(suggestVo);
		
		ra.addFlashAttribute("msg","건의사항을 작성하였습니다.");
		return "redirect:/suggest/readSuggestList";
	}
	
	@RequestMapping("/suggestDetail")
	public String suggestDetail(SuggestVo suggestVo, Model model) {
		SuggestVo result = suggestService.suggestDetail(suggestVo);
		result.setMemId(suggestVo.getMemId());
		
		model.addAttribute("suggestVo",result);
		return "tiles/suggest/suggestDetail";
	}
	
	@RequestMapping("/suggestMod")
	public String suggestMod(@ModelAttribute("suggestVo") SuggestVo suggestVo, 
							Model model, HttpSession session) {
		// todoId를 먼저 가공해야 한다.
		String[] todoArr = suggestVo.getTodoId().split(":");
		todoArr[0] = todoArr[0].replace("@", "");
		todoArr[0] = todoArr[0].replace("[", "");
		todoArr[0] = todoArr[0].replace("]", "");
		suggestVo.setTodoId(todoArr[0]);
		
		int result = suggestService.suggestMod(suggestVo);
		
		// 수정하기, 삭제하기 버튼 표시 위해 memId를 세션에서 가져온다.
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		suggestVo.setMemId(memberVo.getMemId());
		
		// 수정한 내용이 포함되어 있는 애를 다시 redirect
		return suggestDetail(suggestVo, model);
	}
	
}
