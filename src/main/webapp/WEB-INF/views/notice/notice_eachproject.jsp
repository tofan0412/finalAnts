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
	$("#issuebtn").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/issuelist');
	})
})
</script>


</head>
<body>
	<h3>시스템</h3>
	<input type="button" value="공지사항" id="issuebtn">
	<input type="button" value="IP 리스트">
	<input type="button" value="회원정보">
</body>
</html>