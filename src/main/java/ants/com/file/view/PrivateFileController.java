package ants.com.file.view;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import java.util.UUID;

import ants.com.board.manageBoard.model.TodoVo;
import ants.com.file.model.PrivateFileVo;
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
	@RequestMapping(path ="/privatefileList")
	public String privatefile(HttpSession session, Model model, @ModelAttribute("privatefileVo") PrivateFileVo privatefileVo)  {
		
		
		MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		privatefileVo.setMemId(memberVo.getMemId());
		logger.debug("memberVo : {}", memberVo);
		
		
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
		
		return "tiles/privatefile/privatefileList";
	}
	
	
	
	// 파일등록
	@RequestMapping("/privateInsert")
	public String todoView(Model model, PrivateFileVo privatefileVo, HttpSession session, MultipartHttpServletRequest mhsq) {
		
		List<PrivateFileVo> list = new ArrayList<>();   
		
		logger.debug("privatefileVo : {}", privatefileVo);
		logger.debug("MultipartHttpServletRequest : {}", mhsq);
		
		String memId = (String) session.getAttribute("memId");
		privatefileVo.setMemId(memId);
		
		 String realFolder = "D:\\upload\\";
	        File dir = new File(realFolder);
	        if (!dir.isDirectory()) {
	            dir.mkdirs();
	        }
	        
	        // 넘어온 파일을 리스트로 저장
	        List<MultipartFile> mf = mhsq.getFiles("uploadFile");
	        if (mf.size() == 1 && mf.get(0).getOriginalFilename().equals("")) {
	             
	        } else {
	            for (int i = 0; i < mf.size(); i++) {
	                // 파일 중복명 처리
	                String genId = UUID.randomUUID().toString();
	                // 본래 파일명
	                String originalfileName = mf.get(i).getOriginalFilename();
	                 
	                String saveFileName = genId + "." + originalfileName.split(".")[1];
	                // 저장되는 파일 이름
	                
	                String savePath = realFolder + saveFileName; // 저장 될 파일 경로
	 
	                long fileSize = mf.get(i).getSize(); // 파일 사이즈
	 
	                
	                try {
						mf.get(i).transferTo(new File(savePath));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					} 
	                
	                // 파일 저장
	                privatefileVo.setPrivFilename(originalfileName);
	                privatefileVo.setPrivFilepath(savePath);
	                privatefileVo.setPrivSize(String.valueOf(fileSize));
	                
	                list.set(i, privatefileVo);
	            }
	        }
	    
	        
	    int todoInsert = fileService.privateInsert(list);
		
		return "tiles/privatefile/privatefileList";
	}
	
	
	
}
