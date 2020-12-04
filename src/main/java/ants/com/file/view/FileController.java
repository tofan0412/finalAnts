package ants.com.file.view;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.file.mapper.FileMapper;
import ants.com.file.model.PublicFileVo;

@RequestMapping("/file")
@Controller
public class FileController {
	
	
	@Resource(name ="fileMapper")
	private FileMapper mapper;
	
	
	// 해당 게시글 파일 다운로드
	@RequestMapping(path ="/publicfileDown")
	public String getfileDown(String pubId, HttpSession session, Model model)  {

		PublicFileVo filevo = mapper.getfileDetail(pubId);
		
		model.addAttribute("pubFilename" ,filevo.getPubFilename());
		model.addAttribute("pubFilepath" ,filevo.getPubFilepath());

		return "FileDownloadView";
	}
		
	
	
	
	// 파일 업로드
	@RequestMapping(path ="/insertfile")
	public String insertfile(PublicFileVo pfv, Model model, MultipartHttpServletRequest multirequest)  {
		
		
		int count= 0;
		List<MultipartFile> files = multirequest.getFiles("file");
		for(int i=0 ; i < files.size() ; i++) {
		
		
			if(files.get(i).getSize()>0) {
				
				double size = ((double) files.get(i).getSize()/1024);				
				double filesize = Math.round(size *100)/100.0;

				String filename = UUID.randomUUID().toString();
				String extension = files.get(i).getOriginalFilename().split("\\.")[1];
				String filepath = "E:\\profile\\" + filename +"."+ extension;
				File uploadFile = new File(filepath);
				try {
					files.get(i).transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
				}
				
				PublicFileVo filevo = new PublicFileVo(filepath, files.get(i).getOriginalFilename(), extension,
														pfv.getCategoryId(), pfv.getSomeId(), "1",String.valueOf(filesize));
				System.out.println(filevo);
				//PublicFileVo(String pubFilepath, String pubFilename, String pubExtension, String categoryId, String someId,
									//String reqId, String pubSize)
				
				count = mapper.insertfile(filevo);	
				
			}
		
		}
		
		return "";
	}
	
	
	// 게시글에 해당하는 파일 가져오기
	@RequestMapping(path ="/getfiles")
	public String getfiles(PublicFileVo pfv, Model model)  {
	
		List<PublicFileVo> filelist =  mapper.getfiles(pfv);
		
		model.addAttribute("filelist" , filelist);
		
		return "";
	}
	
	
	// 게시글의 파일 삭제하기
	@RequestMapping(path ="/defiles")
	public String delfiles(String delfile)  {
		
		System.out.println("defile : " + delfile);
		
		if(!delfile.equals("null") || delfile !=null || !delfile.equals("")) {
			String[] pubId = delfile.split(",");
			for(int i=0; i<pubId.length;i++) {
				
				mapper.delfiles(pubId[i]);
			}		
		}
		
//		ra.addAttribute("PublicFileVo", pfv);
		
		return "";
	}
	

	
}
