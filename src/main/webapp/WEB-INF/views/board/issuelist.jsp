<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
	table {
		border : 1 solid black;
	}
</style>
</head>
<body>
	<h3>협업이슈 리스트</h3>
	<table border="1">
		<tr>
			<td>  이슈 제목</td> 
			<td>   작성자 </td>
			<td>   날짜   </td>
		</tr>
	 <c:forEach items = "${issuelist }" var ="issue">
		<tr>
		
			<td><a href="${pageContext.request.contextPath}/projectMember/eachissue?issue_id=${issue.issue_id}"> ${issue.issue_title }</a> </td>
			<td> ${issue.mem_id }</td>
			<td> <fmt:formatDate value="${issue.reg_dt }" pattern="yyyy-MM-dd"/></td>
			 
		</tr>
	 </c:forEach> 
	
	</table>

	
	
	
	
	
</body>
</html>