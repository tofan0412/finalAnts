<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>협업이슈 상세내역</h3>
	
	<table>
		<tr>
			<td>작성자</td> 			
			<td>${issuevo.mem_id }</td> 						
		</tr>
		<tr>
			<td>이슈제목</td> 			
			<td>${issuevo.issue_title}</td> 						
		</tr>
		<tr>
			<td>작성일</td> 			
			<td><fmt:formatDate value="${issuevo.reg_dt }" pattern="yyyy-MM-dd"/></td> 						
		</tr>
		<tr>
			<td>이슈 내용</td> 			
			<td>${issuevo.issue_cont }</td> 						
		</tr>
		
	</table>
	
		<p>파일 : (파일 존재시 다운로드)  </p>
		<p><input type="button" value="다운로드" id="filedown"></p>
	
</body>
</html>