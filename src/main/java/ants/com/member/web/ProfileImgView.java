package ants.com.member.web;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

public class ProfileImgView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		FileInputStream fis = null;
		
		try {
		fis = new FileInputStream((String) model.get("filepath"));
		}catch(FileNotFoundException e) {
			
		}
		
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] buffer = new byte[512];
		
		try {
			while(fis.read(buffer) != -1) {
				sos.write(buffer);
			}
			
			fis.close();
			sos.flush();
			sos.close();
		}catch(NullPointerException e) {
			
		}
		
	}
		
}
