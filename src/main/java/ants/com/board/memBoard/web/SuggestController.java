package ants.com.board.memBoard.web;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.board.memBoard.model.ReplyVo;
import ants.com.board.memBoard.model.SuggestVo;
import ants.com.board.memBoard.service.SuggestService;
import ants.com.board.memBoard.service.memBoardService;
import ants.com.file.model.PublicFileVo;
import ants.com.file.service.FileService;
import ants.com.member.model.MemberVo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/suggest")
@Controller
public class SuggestController {
	@Resource(name ="suggestService")
	private SuggestService suggestService;
	
	@Resource(name ="fileService")
	private FileService fileService;
	
	@Resource(name="memBoardService")
	memBoardService memBoardService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping("/readSuggestList")
	public String readSuggestList(@ModelAttribute("suggestVo") SuggestVo suggestVo ,
			HttpSession session, Model model) {
		
		String reqId = (String) session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		
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
		
		// 내가 이 프로젝트에서 맡은 일감도 검색한다. 
		TodoVo todoVo = new TodoVo();
		todoVo.setReqId(reqId);
		todoVo.setMemId(memberVo.getMemId());
		
		List<TodoVo> myTodoList = suggestService.searchTodo(todoVo);
		model.addAttribute("myTodoList", myTodoList);
		
		int totCnt = suggestService.suggestPagingListCnt(suggestVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		if(suggestVo.getSearchKeyword() != null) {			
			session.setAttribute("searchKeyword", suggestVo.getSearchKeyword());
			session.setAttribute("searchCondition",suggestVo.getSearchCondition());
			session.setAttribute("pageIndex", suggestVo.getPageIndex());
		}
		
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
	public String suggestInsert(@ModelAttribute("suggestVo") SuggestVo suggestVo, RedirectAttributes ra) {
		
		// todoId를 먼저 가공해야 한다.
		String[] todoArr = suggestVo.getTodoId().split(":");
		
		suggestVo.setTodoId(todoArr[0]);
		suggestVo.setCategoryId("4");
		suggestVo.setDel("N");
		suggestVo.setSgtStatus("WAIT");
		
		suggestService.suggestInsert(suggestVo);
		
		ra.addFlashAttribute("msg","건의사항을 작성하였습니다.");
		return "redirect:/suggest/readSuggestList";
	}
	
	@RequestMapping("/suggestDetail")
	public String suggestDetail(SuggestVo suggestVo, Model model, HttpSession session) throws SQLException, IOException {
		String reqId = (String)session.getAttribute("projectId");
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		SuggestVo result = suggestService.suggestDetail(suggestVo);
		result.setMemId(suggestVo.getMemId());
		
		// 파일 목록 불러오기
		List<PublicFileVo> suggestFileList = suggestService.suggestFileList(suggestVo);
				
		ReplyVo replyVo = new ReplyVo(suggestVo.getSgtId(), "4", reqId,memId);	//댓글 조회
		List<ReplyVo> replylist= memBoardService.replylist(replyVo);
		
		// 일감을 수정할 수 있으므로, 내 일감 목록도 불러와야 한다.
		TodoVo todoVo = new TodoVo();
		todoVo.setReqId(reqId);
		todoVo.setMemId(memberVo.getMemId());
		
		List<TodoVo> myTodoList = suggestService.searchTodo(todoVo);
		model.addAttribute("myTodoList", myTodoList);
		
		model.addAttribute("replylist", replylist);		
		model.addAttribute("suggestVo",result);
		model.addAttribute("suggestFileList",suggestFileList );
		return "tiles/suggest/suggestDetail";
	}
	
	@RequestMapping("/suggestMod")
	public String suggestMod(@ModelAttribute("suggestVo") SuggestVo suggestVo, 
							HttpSession session, RedirectAttributes ra ) {
		// todoId를 먼저 가공해야 한다.
		String[] todoArr = suggestVo.getTodoId().split(":");

		suggestVo.setTodoId(todoArr[0]);
		int result = suggestService.suggestMod(suggestVo);
		
		// 수정하기, 삭제하기 버튼 표시 위해 memId를 세션에서 가져온다.
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		suggestVo.setMemId(memberVo.getMemId());
		
		ra.addAttribute("sgtId", suggestVo.getSgtId());
		ra.addAttribute("memId", memberVo.getMemId());
		
		return "redirect:/suggest/suggestDetail";
	}
	
	@RequestMapping("/suggestFileMod")
	@ResponseBody
	public String suggestFileMod(@RequestParam(value="removeList[]")List<String> removeList) {
		// 파일 하나하나를 먼저 서버 저장 위치에서 삭제한다.
		List<PublicFileVo> fileList = new ArrayList<>();
		int delCnt = 0;
		
		PublicFileVo pfv = new PublicFileVo();
		for (int i = 0 ; i < removeList.size() ; i++) {
			pfv.setPubId(removeList.get(i));
			fileList.add(suggestService.suggestFile(pfv));
		}
		
		// 해당 경로 이용해서 파일 삭제하기..
		for (int i = 0; i < fileList.size(); i++) {
			String file_path = fileList.get(i).getPubFilepath();

			File file = new File(file_path);
			file.delete();
		}
		
		// 파일 정보를 DB에서 삭제하기.
		for(int i = 0 ; i < removeList.size() ; i++) {
			pfv.setPubId(removeList.get(i));
			int result = suggestService.suggestFileDel(pfv);
			delCnt += result;
		}
		
		if (delCnt == removeList.size()) {
			System.out.println("삭제 성공");
			return "jsonView";
		}else {
			return "jsonView";
		}
	}
	
	@RequestMapping("/delSuggest")
	public String delSuggest(SuggestVo suggestVo, HttpSession session, Model model) {
		int result = suggestService.delSuggest(suggestVo);
		if (result > 0) {
			return "redirect:/suggest/readSuggestList";
		
		// 삭제에 실패한 경우 해당 글로 돌아간다..
		}else{
			MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
			suggestVo.setMemId(memberVo.getMemId());
			model.addAttribute("suggestVo", suggestVo);
			return "redirect:tiles/suggest/suggestDetail";
		}
	}
	
	@RequestMapping("/suggestFileInsert")
	public String suggestFileInsert(MultipartHttpServletRequest mtfRequest, HttpSession session,
			Model model, String sgtId) {
		// 프로젝트 구별
		String reqId = (String)session.getAttribute("projectId");
		
		// 업로드한 사람 구별
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		String sgtSeq = "";
		
		List<MultipartFile> fileList = mtfRequest.getFiles("file");
		if (sgtId != null) {
			sgtSeq = sgtId; 
		}else {
			// someId를 위해 nextval을 가져와야 한다. 
			sgtSeq = suggestService.getSgtSeq();
		}

		for (int i = 0 ; i < fileList.size() ; i++) {
			if(fileList.get(i).getSize()>0) {
				
				double size = ((double) fileList.get(i).getSize()/1024);				
				double filesize = Math.round(size *100)/100.0;
				
				String filename = UUID.randomUUID().toString();
				
				String originName = fileList.get(i).getOriginalFilename();			
				int pos = originName .lastIndexOf(".");
				String realfileName = originName.substring(0, pos);
				
				String extension = originName.substring(originName.lastIndexOf(".")+1);
				String filepath = "C:\\profile\\" + filename +"."+ extension;
				File uploadFile = new File(filepath);
				try {
					fileList.get(i).transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
				
				}
				
				PublicFileVo filevo = new PublicFileVo(filepath, realfileName, extension,
						"4", sgtSeq, reqId, String.valueOf(filesize), memId);
				fileService.insertFile(filevo);
			}
		}
		model.addAttribute("sgtSeq", sgtSeq);
		return "jsonView";
	}
	
	// 건의사항 게시글 첨부 파일 다운로드
	@RequestMapping("/suggestFileDownload")
	public String suggestFileDownload(PublicFileVo publicFileVo, Model model) {
		
		PublicFileVo filevo = fileService.getfile(publicFileVo.getPubId());
		
		model.addAttribute("pubFilename" ,filevo.getPubFilename());
		model.addAttribute("pubFilepath" ,filevo.getPubFilepath());
		
		return "FileDownloadView";
	}
	
	// 관리자 : 건의사항 수락 또는 반려한다.
	@RequestMapping("/acceptOrReject")
	@ResponseBody
	public int acceptOrReject(SuggestVo suggestVo) {
		return suggestService.acceptOrReject(suggestVo);
	}
}
