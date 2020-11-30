<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.sort{
	
		width : 120px;
		height : 30px;
	}
</style>

</head>
<body>
	<h3>협업이슈 작성하기</h3>
	<form id="frm"  class="form-horizontal" method="post" 
								    action="${pageContext.request.contextPath}/projectMember/insertissue" >
		<table>
			<tr>
				<td class="sort" >이슈제목 </td> 			
				<td><input type="text" value="" name="issueTitle"></td> 						
			</tr>
			
			<tr>
				<td class="sort">이슈 내용  </td> 			
				<td><input type="text" value="" name="issueCont"></td> 						
			</tr>
			<tr>
				<td class="sort">이슈 종류</td> 			
				<td><input type="text" value="issue" name="issueKind"></td> 						
			</tr>
			<tr>
				<td class="sort">카테고리</td> 			
				<td><input type="text" value="3" name="categoryId"></td> 						
			</tr>
			
			<tr>
				<td class="sort"></td> 			
				<td><input type="submit" name="작성하기"></td> 						
			</tr>
			
		</table>
	</form>
		<p>파일 : (파일 존재시 다운로드)  </p>
		<p><input type="button" value="다운로드" id="filedown"></p>
	
</body>
</html>