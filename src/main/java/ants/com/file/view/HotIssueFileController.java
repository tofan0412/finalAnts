package ants.com.file.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.board.manageBoard.model.HotIssueVo;
import ants.com.board.memBoard.model.IssueVo;
import ants.com.file.mapper.FileMapper;
import ants.com.file.model.HotIssueFileVo;
import ants.com.file.model.PrivateFileVo;
import ants.com.file.model.PublicFileVo;
import ants.com.file.service.FileService;
import ants.com.member.model.MemberVo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("hotissueFile")
@Controller
public class HotIssueFileController {@Resource(name = "fileService")
	private FileService fileService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	
	 // 파일 다운로드
	 @RequestMapping(path ="/hotfileDown")
	 public String getfileDown(String hissuefId, HttpSession session, Model model) {
	
	 HotIssueFileVo filevo = fileService.gethotfile(hissuefId);	
	 model.addAttribute("pubFilename" ,filevo.getHissuefFilename());
	 model.addAttribute("pubFilepath" ,filevo.getHiussefFilepath());
	
	 return "FileDownloadView";
	 }

	// // 핫이슈 파일함 View
	 @RequestMapping(path ="/hotissuefileview")
	 public String publicfileview(@ModelAttribute("hotIssueFileVo") HotIssueFileVo
	 hotIssueFileVo, HttpSession session, Model model) {
	
	 String reqId = (String)session.getAttribute("projectId");
	 hotIssueFileVo.setHissueId(reqId);
	 /** EgovPropertyService.sample */
	 hotIssueFileVo.setPageUnit(propertiesService.getInt("pageUnit"));
	 hotIssueFileVo.setPageSize(propertiesService.getInt("pageSize"));
	
	 /** pageing setting */
	 PaginationInfo paginationInfo = new PaginationInfo();
	 paginationInfo.setCurrentPageNo(hotIssueFileVo.getPageIndex());
	 paginationInfo.setRecordCountPerPage(hotIssueFileVo.getPageUnit());
	 paginationInfo.setPageSize(hotIssueFileVo.getPageSize());
	
	 hotIssueFileVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
	 hotIssueFileVo.setLastIndex(paginationInfo.getLastRecordIndex());
	 hotIssueFileVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
	 List<?> hotissuefileList = fileService.hotissuefileList(hotIssueFileVo);
	 model.addAttribute("hotissuefileList", hotissuefileList);
	
	 int totCnt = fileService.hotissuefilePagingListCnt(reqId);
	 paginationInfo.setTotalRecordCount(totCnt);
	 model.addAttribute("paginationInfo", paginationInfo);
	
	 return "tiles/manager/plpm_hotissueFileView";
	 }

	// 파일 업로드
	@RequestMapping(path = "/insertHotissueFile")
	public String insertfile(HotIssueFileVo pfv, Model model, MultipartHttpServletRequest multirequest,
			HttpSession session) {
		String hissueId = pfv.getHissueId();
		String fileId = "";
		List<MultipartFile> files = multirequest.getFiles("file");
		for (int i = 0; i < files.size(); i++) {

			if (files.get(i).getSize() > 0) {

				double size = ((double) files.get(i).getSize() / 1024);
				double filesize = Math.round(size * 100) / 100.0;

				String filename = UUID.randomUUID().toString();
				String extension = files.get(i).getOriginalFilename().split("\\.")[1];
				String filepath = "D:\\hotissue\\" + filename + "." + extension;
				File uploadFile = new File(filepath);
				try {
					files.get(i).transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
				}

				HotIssueFileVo fileVo = new HotIssueFileVo(hissueId, filepath, files.get(i).getOriginalFilename(), extension,
						String.valueOf(filesize));
				fileId += fileService.insertHotissueFile(fileVo);
			}
		}
		 pfv.setHissuefId(fileId);
		return "jsonView";
	}
	
	// // 게시글에 해당하는 파일 가져오기
	 @RequestMapping(path ="/gethotfiles")
	 public String getfiles(HotIssueFileVo pfv, Model model) {
	
	 List<HotIssueFileVo> filelist = fileService.gethotfiles(pfv);
	
	 model.addAttribute("filelist" , filelist);
	
	 return "";
	 }
	 @RequestMapping(path ="/gethotfiles2")
	 public String getfiles2(HotIssueFileVo pfv, Model model) {
		 
		 List<HotIssueFileVo> filelist = fileService.gethotfiles(pfv);
		 
		 model.addAttribute("filelist2" , filelist);
		 
		 return "";
	 }
	

	// // 게시글의 파일 삭제하기
	 @RequestMapping(path ="/delhotfilesT")
	 public String delhotfilesT(String hissuefId) {
		 int res = fileService.delhotfiles(hissuefId);
		 if (res > 0) {
			 return "redirect:/hotissueFile/hotissuefileview";
			} else {
				return "redirect:/hotissueFile/hotissuefileview";
			}
	 }
	 
	 // // 게시글의 파일 삭제하기
	 @RequestMapping(path ="/delhotfiles", method=RequestMethod.POST)
	 public String delhotfiles(String delfile) {
		 
		 
		 if(!delfile.equals("null") || delfile !=null || !delfile.equals("")) {
			 String[] hissuefId = delfile.split(",");
			 for(int i=0; i<hissuefId.length;i++) {
				 
				 fileService.delhotfiles(hissuefId[i]);
			 }
		 }
		 
		 return "jsonView";
	 }

	
	
}
