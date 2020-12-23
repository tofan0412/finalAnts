package ants.com.file.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
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
		paginationInfo.setPageSize(privatefileVo.getPageSize());
	
		if(privatefileVo.getType() != null && privatefileVo.getType().equals("imageicon")) {	
			paginationInfo.setRecordCountPerPage(20);
			System.out.println("type333 : " + paginationInfo.getRecordCountPerPage());

		}else {
			paginationInfo.setRecordCountPerPage(privatefileVo.getPageUnit());
		}
		
		System.out.println("type222 : " + privatefileVo.getType());
		
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
		
		// 개인파일함 총 사용량
		String totalSize = fileService.privatefiletotalSize(privatefileVo);
		model.addAttribute("totalSize", totalSize);
		session.setAttribute("imagetype", privatefileVo.getType());
		
		return "tiles/privatefile/privatefileView";
	}
	
	
	
	// 파일등록(파일 버튼 추가/제거 버전)
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
				
				String filename = UUID.randomUUID().toString();
				String extension = file.get(i).getOriginalFilename().split("\\.")[1];
				Filepath = "C:\\upload\\" + filename +"."+extension;
				Filename = file.get(i).getOriginalFilename();
				File uploadFile = new File(Filepath);
				Filesize = String.valueOf(file.get(i).getSize());
				
				
				try {
					file.get(i).transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				logger.debug("---------------------통과-------------------");
				
				
				privateVo.setPrivExtension(extension);	
				privateVo.setPrivFilepath(Filepath);
				privateVo.setPrivFilename(Filename);
				privateVo.setPrivSize(Filesize);
				
				list.add(privateVo);
			}
		}
		
	    int todoInsert = fileService.privateInsert(list);
		
		return "redirect:/privatefile/privatefileView";
	}
	
	// 파일 복사
	@RequestMapping(path="/copyfile")
	public String copyfile(PublicFileVo pubfilevo, HttpSession session) throws IOException {
		
		List<PrivateFileVo> list = new ArrayList<>(); 
		
		PublicFileVo filevo = fileService.getfile(pubfilevo.getPubId()); // 파일 조회

		//원본 파일경로
        String oriFilePath = filevo.getPubFilepath();
		
        String filename = UUID.randomUUID().toString();
		String extension = filevo.getPubFilepath().substring(filevo.getPubFilepath().lastIndexOf(".")+1);
			
        //복사될 파일경로
        String copyFilePath = "C:\\profile\\"+filename+"."+extension;	
	    	
        //파일객체생성
        File oriFile = new File(oriFilePath);
        //복사파일객체생성
        File copyFile = new File(copyFilePath);
        
        try {
            
            FileInputStream fis = new FileInputStream(oriFile); //읽을파일
            FileOutputStream fos = new FileOutputStream(copyFile); //복사할파일
            
            int fileByte = 0; 
            // fis.read()가 -1 이면 파일을 다 읽은것
            while((fileByte = fis.read()) != -1) {
                fos.write(fileByte);
            }
            //자원사용종료
            fis.close();
            fos.close();
            
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
	      
        
      
        PrivateFileVo privateVo = new PrivateFileVo();
        MemberVo memberVo = (MemberVo) session.getAttribute("SMEMBER");
		privateVo.setMemId(memberVo.getMemId());
		
        privateVo.setPrivFilepath(copyFilePath);
		privateVo.setPrivFilename(filevo.getPubFilename());
		privateVo.setPrivSize(String.valueOf(filevo.getPubSize()));			
		privateVo.setPrivExtension(extension);

		
		list.add(privateVo);
		
		fileService.privateInsert(list);	
		
		return "redirect:/file/publicfileview";
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
				
				String filename = UUID.randomUUID().toString();
				String originName = files.get(i).getOriginalFilename();			
				int pos = originName .lastIndexOf(".");
				String realfileName = originName.substring(0, pos);
				
				String extension = originName.substring(originName.lastIndexOf(".")+1);
			
				String Filepath = "C:\\upload\\" + filename +"."+extension;
				
				File uploadFile = new File(Filepath);
				try {
					files.get(i).transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
				}	
				
				privateVo.setPrivExtension(extension);
				privateVo.setPrivFilepath(Filepath);
				privateVo.setPrivFilename(realfileName);
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
