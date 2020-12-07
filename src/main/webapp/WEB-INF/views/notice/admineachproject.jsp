<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#noticebtn").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/admin/noticelist');
	})
	$("#ipbtn").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/admin/iplist');
	})
	$("#memberlistbtn").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/admin/admemberlist');
	})
})
</script>


</head>
<body>
	<h3>관리자 관리 시스템</h3>
	<input type="button" value="공지사항" id="noticebtn">
	<input type="button" value="IP리스트" id="ipbtn">
	<input type="button" value="회원리스트" id="memberlistbtn">
</body>
</html>