package ants.com.file.view;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.support.MultipartFilter;

import java.util.UUID;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.file.model.PrivateFileVo;
import ants.com.file.model.PublicFileVo;
import ants.com.file.service.FileService;
import ants.com.member.model.MemberVo;
import ants.com.member.web.MemberController;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@MultipartConfig
@RequestMapping("/privatefile")
@Controller
public class PrivateFileController {
	 
	@Resource(name ="fileService")
	private FileService fileService;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	
	// 개인 파일함리스트
	@RequestMapping(path ="/privatefileView")
	public String privatefile(HttpSession session, Model model, @ModelAttribute("privatefileVo") PrivateFileVo privatefileVo)  {
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		privatefileVo.setMemId(memberVo.getMemId());
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();			// 스프링 지원 태그
		paginationInfo.setCurrentPageNo(privatefileVo.getPageIndex());	// privatefileVo에 BaseVo 상속
		paginationInfo.setRecordCountPerPage(privatefileVo.getPageUnit());
		paginationInfo.setPageSize(privatefileVo.getPageSize());

		privatefileVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		privatefileVo.setLastIndex(paginationInfo.getLastRecordIndex());
		privatefileVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		logger.debug("paginationInfo : {}", paginationInfo);
		logger.debug("privatefileVo : {}", privatefileVo);
		
		
		// 리스트 목록
		List<PrivateFileVo> privatefileList = fileService.privatefileList(privatefileVo);
		model.addAttribute("privatefileList", privatefileList);
		logger.debug("privatefileList : {}", privatefileList);
		
		//리스트 갯수
		int totCnt = fileService.privatefilelistCount(privatefileVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		logger.debug("totCnt : {}", totCnt);
		
		return "tiles/privatefile/privatefileView";
	}
	
	
	
	// 파일등록	(파일 버튼 추가/제거 버전)
	@RequestMapping("/privateInsert0")
	public String todoView(PrivateFileVo privatefileVo, BindingResult br, @RequestPart(value="privFilepath", required=false)  List<MultipartFile> file, Model model, HttpSession session) {
		
		List<PrivateFileVo> list = new ArrayList<>();   
		
		for(int i=0; i<file.size(); i++) {
			
			PrivateFileVo privateVo = new PrivateFileVo();
			
			MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
			privateVo.setMemId(memberVo.getMemId());
			
			
			String Filepath = "";
			String Filename = "";
			String Filesize = "";
			
			if(!file.get(i).getOriginalFilename().equals("") && !file.get(i).getOriginalFilename().equals(null)) {
					
		
				if (br.hasErrors()) {
	//				return "main.tiles/member/memberRegist";
				}
				
				String filekey = UUID.randomUUID().toString();
				
				/*+ filekey + "\\"*/
				Filepath = "D:\\upload\\" + file.get(i).getOriginalFilename();
				Filename = file.get(i).getOriginalFilename();
				File uploadFile = new File(Filepath);
				Filesize = String.valueOf(file.get(i).getSize());
				
				
				try {
					file.get(i).transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				logger.debug("---------------------통과-------------------");
				
				
				privateVo.setPrivFilepath(Filepath);
				privateVo.setPrivFilename(Filename);
				privateVo.setPrivSize(Filesize);
				
				list.add(privateVo);
			}
		}
		
	    int todoInsert = fileService.privateInsert(list);
		
		return "redirect:/privatefile/privatefileView";
	}
	
	
	
	// 파일 업로드
	@RequestMapping(path ="/privateInsert")
	public String insertfile(PrivateFileVo privatefileVo, Model model, HttpSession session, MultipartHttpServletRequest multirequest)  {
		
		List<PrivateFileVo> list = new ArrayList<>(); 
		
		int count= 0;
		List<MultipartFile> files = multirequest.getFiles("file");
		for(int i=0 ; i < files.size() ; i++) {
			
			PrivateFileVo privateVo = new PrivateFileVo();
			
			MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
			privateVo.setMemId(memberVo.getMemId());
		
			if(files.get(i).getSize()>0) {
				
				double size = ((double) files.get(i).getSize()/1024);				
				double filesize = Math.round(size *100)/100.0;
				
				String Filepath = "D:\\upload\\" + files.get(i).getOriginalFilename();
				String Filename = files.get(i).getOriginalFilename();
				
				File uploadFile = new File(Filepath);
				try {
					files.get(i).transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
				}
				
				privateVo.setPrivFilepath(Filepath);
				privateVo.setPrivFilename(Filename);
				privateVo.setPrivSize(String.valueOf(filesize));
				
				list.add(privateVo);
				
				
			}
		
		}
		
		int todoInsert =  fileService.privateInsert(list);	
		
		return "redirect:/privatefile/privatefileView";
	}
	
	
	// 해당 파일 다운로드
	@RequestMapping(path ="/privatefileDown")
	public String getfileDown(PrivateFileVo privatefileVo, HttpSession session, Model model)  {

		PrivateFileVo privateVo = fileService.privateSelect(privatefileVo);
		
		model.addAttribute("pubFilename" ,privateVo.getPrivFilename());
		model.addAttribute("pubFilepath" ,privateVo.getPrivFilepath());

		return "FileDownloadView";
	}
	
	
	
	
	// 게시글의 파일 삭제하기
	@RequestMapping(path ="/privatefileDelete")
	public String delfiles(PrivateFileVo privatefileVo)  {
		
		if(!privatefileVo.equals("null") || privatefileVo !=null || !privatefileVo.equals("")) {
			fileService.privateDelete(privatefileVo);
		}
		
		return "redirect:/privatefile/privatefileView";
	}
	
	
/*	// 해당 파일 상세보기
	@RequestMapping(value ="/privatefileSelect",  method = RequestMethod.GET)
	public String privatefileSelect(PrivateFileVo privatefileVo, BindingResult br, HttpSession session, Model model, HttpServletRequest request)  {
		
		PrivateFileVo privateVo = fileService.privateSelect(privatefileVo);
		request.setAttribute("privateVo", privateVo);
		
		return "privatefile/privatefileView";
	}*/
	
}
