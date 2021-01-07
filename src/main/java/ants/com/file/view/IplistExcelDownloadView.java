package ants.com.file.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

public class IplistExcelDownloadView extends AbstractView{
	
	// 파일 다운로드 뷰
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		List<String> header = (List<String>) model.get("header");
		List<Map<String, String>> data = (List<Map<String, String>>)model.get("data");
		
		// excel 파일 contentType : application/vnd.ms-excel; UTF-8
		response.setContentType("application/vnd.ms-excel; utf-8");
		
		// 첨부파일임을 암시(다운로드기능)
		response.setHeader("Content-Dispotition", "attachment; filename=test.xlsx");
		
		// poi 라이브러리를 이용해서 엑셀파일을 생성
		Workbook workbook = new XSSFWorkbook();
		
		// 헤더 스타일
	    Font headerFont = workbook.createFont();
		headerFont.setFontName("Yu Gothic UI Semibold");
		headerFont.setFontHeight((short)(12*20)); //사이즈
		headerFont.setBold(true);
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setFillForegroundColor(IndexedColors.LIME.getIndex());
//		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);	    
//		headerStyle.setBorderTop(BorderStyle.THIN);
//		headerStyle.setBorderLeft(BorderStyle.THIN); 
//		headerStyle.setBorderRight(BorderStyle.THIN);
		headerStyle.setFont(headerFont);
	    
		// 목록들 스타일
		Font bodyFont = workbook.createFont();
		bodyFont.setFontName("Yu Gothic UI Semibold");
	    CellStyle bodyStyle = workbook.createCellStyle();
	    bodyStyle.setFont(bodyFont);
//	    bodyStyle.setBorderBottom(BorderStyle.THIN); 
//	    bodyStyle.setBorderLeft(BorderStyle.THIN); 
//	    bodyStyle.setBorderRight(BorderStyle.THIN); 
//	    bodyStyle.setBorderTop(BorderStyle.THIN);
//	    bodyStyle.setAlignment(HorizontalAlignment.LEFT);
	    
	    // 회원목록 표시 스타일
	    Font headerFont2 = workbook.createFont();
	    headerFont2.setFontName("Yu Gothic UI Semibold");
	    headerFont2.setFontHeight((short)(12*20)); //사이즈
	    headerFont2.setBold(true);		
  		CellStyle mergeRowStyle2 = workbook.createCellStyle();
  		mergeRowStyle2.setFont(headerFont2);
	    mergeRowStyle2.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());  // 배경색
//	    mergeRowStyle2.setFillPattern(FillPatternType.SOLID_FOREGROUND);
//	    mergeRowStyle2.setAlignment(HorizontalAlignment.CENTER);
//	    mergeRowStyle2.setVerticalAlignment(VerticalAlignment.CENTER);
	 

	    
		// 시트생성
		Sheet sheet = workbook.createSheet("IP리스트");
		
		// 열 폭 수정
		sheet.setColumnWidth(1, 5000);
		sheet.setColumnWidth(2, 6500);
		sheet.setColumnWidth(3, 5000);

		
		//행설정
		int rownum = 0;
		int colnum = 0;
		Row row = sheet.createRow(rownum++);
		
		
		
		Cell cell = null;
		
		// 목록 병합 작업
		for(int i=0; i<4; i++) {
		    cell = row.createCell(i);
		    row.createCell(i).setCellValue("최근 접속 IP 목록 (500개)");
		    cell.setCellStyle(mergeRowStyle2);
		}
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
		
		
		row = sheet.createRow(rownum++);
		// 헤더 설정
		for(String h : header) {
			cell = row.createCell(colnum++);
			cell.setCellValue(h);
			cell.setCellStyle(headerStyle);
		} 
		
		
		int num =0;
	    cell = null;
		
		// 데이터 설정
		for(Map<String, String> map : data) {
			row = sheet.createRow(rownum++);
			
			colnum=0;
			num++;
			cell = row.createCell(colnum++);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(num);		
			
			cell = row.createCell(colnum++);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(map.get("ip"));
			
			cell = row.createCell(colnum++);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(map.get("memid"));	
			
			cell = row.createCell(colnum++);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(map.get("regDt"));
	
		}
		
		OutputStream os = response.getOutputStream();
		workbook.write(os);
		
		os.flush();
		os.close();
	}
	
}
