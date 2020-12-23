package ants.com.file.view;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView{
	
	// 파일 다운로드 뷰
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String realfilename = (String)model.get("pubFilename");
		String fileName = URLEncoder.encode(realfilename,"UTF-8").replaceAll("\\+", "%20");
		String filepath = (String)model.get("pubFilepath");

		String extension = filepath.substring(filepath.lastIndexOf(".")+1);
		
		response.setHeader("Content-Disposition", "attachment; filename=\""+fileName+"."+extension+"\"");
		response.setContentType("application/octet-stream utf-8");//파일을 다운로드할때는 octet-stream을 사용한다.
	
		// 경로 확인 후 파일 입출력을 통해 응답 생성
		// 1. 파일 읽기   
		// 2. 응답 생성
		File f = new File(filepath);
		if(f.exists()) {		
			FileInputStream fis = new FileInputStream(filepath);
			ServletOutputStream sos = response.getOutputStream();
			
			byte[] buffer = new byte[512];
			while(fis.read(buffer) != -1) {
				sos.write(buffer);
			}
			
			fis.close();
			sos.flush(); // 혹시 응답이 안간것이 있으면 마지막으로 보내라
			sos.close();
		}
	}
	
}
