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
.lic{
	width : 200px;
}
#di{
	margin-top: 13%;
	margin-left: 25%;
	margin-bottom : 18%;
	width: 525px;
	height: 300px;
}	
</style> 				
<body>	
	<div id="di" style="border:1px solid white;">
		비밀번호 변경(이메일)<br>
		<input type="text" class="ke" id="uid" value="${uuid}" style="display:none"><br>
		
		<form id="passup" action="/member/passupdate">
			<input type="text" id="memId" name="memId" value="${memId}" style="display:none"><br>
			<input type="text" class="ke" id="keyval" style="display:none"><br>
			
			<div>	
				<label class="lic" style="float:left;">새로 변경할 비밀번호</label> 
				<div style="float:left; margin-left:20px;" >		
					<input type="text" id="newpass1" style="float:left; width:300px;" name="memPass" value="${memPass}" onkeyup="chkPW()" placeholder="8자리 ~ 20자리  영문,숫자,특수문자를 혼합"/>
					<div id="checkPass1" class="indiv" style="float:left;"></div>
				</div>	
			</div>			
							
			<br><br>	
			<div>		
				<label class="lic" style="float:left;">새로 변경할 비밀번호 확인 </label> 
				<div style="float:left; margin-left:20px;" >
					<input type="text" id="newpass2" style="float:left; width:300px;" name="newpass2" onkeyup="unityPW()" placeholder="패스워드"/>
					<div id="checkPass2" class="indiv" style="float:left;"></div>	
				</div>
			</div>	
		</form>	
		
		<br><br><br><br>		
		<div style="float:right;">	
			<button id="sub">확인</button>
			<button>취소</button>
		</div>
	</div>	
</body>

<script>
//비밀번호 정규식
function chkPW(){
		
	 var pw = document.getElementById('newpass1').value;
	 var num = pw.search(/[0-9]/g);
	 var eng = pw.search(/[a-z]/ig);
	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
 	
	 if(pw.length < 8 || pw.length > 20){
	  $('#checkPass1').html('<p style="color:red">8자리 ~ 20자리 이내로 입력해주세요.</p>');
	  return false;
	 } 
	 else if(pw.search(/\s/) != -1){
	  $('#checkPass1').html('<p style="color:red">비밀번호는 공백 없이 입력해주세요.</p>');
	  return false;
	 }
	 else if(num < 0 || eng < 0 || spe < 0 ){
	  $('#checkPass1').html('<p style="color:red">영문,숫자, 특수문자를 혼합하여 입력해주세요.</p>');
	  return false;
	 }
	 else {
	  $('#checkPass1').html('<p style="color:blue">사용 가능한 비밀번호 입니다.</p>');
	    return true;
	 }

}
	
// 비밀번호 일치 확인
function unityPW(){
	var pw1 = document.getElementById('newpass1').value;
	var pw2 = document.getElementById('newpass2').value;
	
	if(pw1 != pw2){ 
		$('#checkPass2').html('<p style="color:red">비밀번호가 일치하지 않습니다.</p>'); 
	} else { 
		$('#checkPass2').html('<p style="color:blue"></p>');
	}
			
} 

$(document).ready(function(){
	$("#sub").on('click', function(){
		
		var newpass1 = document.getElementById('newpass1');
		var newpass2 = document.getElementById('newpass2');
			
		if(newpass1.value == newpass2.value){
			$('#passup').submit();	
		}else{
			alert("비밀번호가 일치하지 않습니다.")
		}
			
	});
});

</script>

</html>