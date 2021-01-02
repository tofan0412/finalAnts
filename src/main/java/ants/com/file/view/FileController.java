package ants.com.file.view;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import ants.com.file.model.PrivateFileVo;
import ants.com.file.model.PublicFileVo;
import ants.com.file.service.FileService;
import ants.com.member.model.MemberVo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/file")
@Controller
public class FileController {
	
	
	@Resource(name ="fileService")
	private FileService fileService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	// 해당 게시글 파일 다운로드
	@RequestMapping(path ="/publicfileDown")
	public String getfileDown(String pubId, HttpSession session, Model model)  {

		PublicFileVo filevo = fileService.getfile(pubId);
		
		model.addAttribute("pubFilename" ,filevo.getPubFilename());
		model.addAttribute("pubFilepath" ,filevo.getPubFilepath());
		
		return "FileDownloadView";
	}
		
	// 프로젝트 파일함 View
	@RequestMapping(path ="/publicfileview")
	public String publicfileview(@ModelAttribute("publicFileVo") PublicFileVo publicFileVo, HttpSession session, Model model)  {

		String reqId = (String)session.getAttribute("projectId");
		publicFileVo.setReqId(reqId);
		session.setAttribute("categoryId", "2");
		
		/** EgovPropertyService.sample */
		publicFileVo.setPageUnit(propertiesService.getInt("pageUnit"));
		publicFileVo.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(publicFileVo.getPageIndex());
		paginationInfo.setRecordCountPerPage(publicFileVo.getPageUnit());
		paginationInfo.setPageSize(publicFileVo.getPageSize());

		publicFileVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		publicFileVo.setLastIndex(paginationInfo.getLastRecordIndex());
		publicFileVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<PublicFileVo> pubfilelist = fileService.pubfilelist(publicFileVo);
		model.addAttribute("pubfilelist", pubfilelist);
		
		if(publicFileVo.getSort() == null || publicFileVo.getSort().equals("1")) {
			model.addAttribute("sort", "1");
		}else {
			model.addAttribute("sort", "2");
		}
		
		int totCnt = fileService.pubfilePagingListCnt(publicFileVo);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
					
//		session.setAttribute("searchKeyword","");
//		session.setAttribute("searchCondition","");
		session.setAttribute("pageIndex",1);
	
				
		return "tiles/board/pubfilelist";
	}
	
	
	
	// 파일 업로드
	@RequestMapping(path ="/insertfile")
	public String insertfile(PublicFileVo pfv, Model model, MultipartHttpServletRequest multirequest, HttpSession session)  {
		String reqId = "";
		
		if(pfv.getReqId() == null) {
			reqId = (String)session.getAttribute("projectId");
		}else {
			reqId = pfv.getReqId();
		}
		
		MemberVo memberVo = (MemberVo)session.getAttribute("SMEMBER");
		String memId = memberVo.getMemId();
		
		String fileId = "";
		List<MultipartFile> files = multirequest.getFiles("file");
		for(int i=0 ; i < files.size() ; i++) {
		
		
			if(files.get(i).getSize()>0) {
				
				double size = ((double) files.get(i).getSize()/1024);				
				double filesize = Math.round(size *100)/100.0;

				String filename = UUID.randomUUID().toString();
			
				String originName = files.get(i).getOriginalFilename();			
				int pos = originName .lastIndexOf(".");
				String realfileName = originName.substring(0, pos);
				
				String extension = originName.substring(originName.lastIndexOf(".")+1);
				String filepath = "C:\\profile\\" + filename +"."+ extension;
				File uploadFile = new File(filepath);
				try {
					files.get(i).transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
				}
				
				PublicFileVo filevo = new PublicFileVo(filepath, realfileName, extension,
														pfv.getCategoryId(), pfv.getSomeId(), reqId, String.valueOf(filesize), memId);
				System.out.println(filevo);
				fileId +=  fileService.insertFile(filevo);
				
			}
		
		}
		pfv.setPubId(fileId);

		
		return "jsonView";
	}
	
	
	// 게시글에 해당하는 파일 가져오기
	@RequestMapping(path ="/getfiles")
	public String getfiles(PublicFileVo pfv, Model model)  {
	
		List<PublicFileVo> filelist =  fileService.filelist(pfv);
		
		model.addAttribute("filelist" , filelist);
		
		return "";
	}
	

	
	
	// 게시글의 파일 삭제하기
	@RequestMapping(path ="/delfiles",   method=RequestMethod.POST)
	public String delfiles(String delfile)  {
		
		if(!delfile.equals("null") && delfile !=null && !delfile.equals("")) {

			String[] pubId = delfile.split(",");
			for(int i=0; i<pubId.length;i++) {
				
				PublicFileVo dbfilevo = fileService.getfile(pubId[i]);
				String serverFilepath = dbfilevo.getPubFilepath();
				File f = new File(serverFilepath);
			    if(!f.isDirectory()) {
			       f.delete();   //파일이면 바로 삭제
			    }
			    
				fileService.defiles(pubId[i]);
			}		
		}
		
		return "jsonView";
	}
	

	
}
