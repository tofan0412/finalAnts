<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<style>
.ke{
	width : 300px;
}
</style>
<body>
	비밀번호 변경페이지(이메일)<br><br><br><br>
	<input type="text" class="ke" id="uid" value="${uuid}" style="display:none"><br>
	
	<form id="passup" action="/member/passupdate">
		<input type="text" id="memId" name="memId" value="${memId}" style="display:none"><br>
		코드 : <input type="text" class="ke" id="keyval"><br>
		새로 변경할 비밀번호 : <input type="text" id="newpass1" name="memPass"><br>
		새로 변경할 비밀번호 확인 : <input type="text" id="newpass2" name="newpass2"><br>
	</form>
	
	<button id="sub">확인</button>
	<button>취소</button>
</body>

<script>
$(document).ready(function(){
	$("#sub").on('click', function(){
 		var uid = document.getElementById('uid');
 		var keyval = document.getElementById('keyval');
		
		if(uid.value==keyval.value){
			var newpass1 = document.getElementById('newpass1');
			var newpass2 = document.getElementById('newpass2');
			
			if(newpass1.value == newpass2.value){
				$('#passup').submit();	
			}else{
				alert("비밀번호가 일치하지 않습니다.")
			}
			
		}else{
			alert('코드값이 일치하지 않습니다.')
		}
		
	
	});
});

</script>

</html>