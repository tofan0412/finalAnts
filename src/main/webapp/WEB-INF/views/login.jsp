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
	$("#loginBtn").on('click', function(){
		var mem_id ="java";
		var mem_pass ="java";
		$(location).attr('href', '${pageContext.request.contextPath}/member/loginFunc?mem_id='+mem_id+"&mem_pass="+mem_pass);
	})
})

</script>
</head>
<body>
	<h3>로그인</h3>
	이메일 : 123@naver.com <br>
	비밀번호 : **** <br>
	
	<input type="checkbox" name="email" id="remember">이메일기억하기
	<input type="button" id="loginBtn" value="로그인" >
	<input type="button" value="비밀번호 찾기" >
</body>
</html>