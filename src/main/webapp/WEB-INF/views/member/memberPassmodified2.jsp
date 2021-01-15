<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
body{
	min-width:1000px;
}
.ke{
	width : 300px;
}
.lic{
	width : 200px;
}
#di{
	margin-top: 10%;
	margin-left: 33.5%;
	margin-right: 33.5%;
	margin-bottom : 16%;	
	width: 900px;
	height: 320px;
	
}
</style>

<body>	
<div id="di" style="border:1px solid white;">
	<h3>비밀번호 변경 (전화번호)</h3>
		<div style="float:left; margin-left:33%;">					
			<b style="font-size:7px;">01. 아이디 입력>02. 본인 확인></b><a style="color:green; font-size:7px;">03. 비밀번호 재설정</a>	
		</div>	
	<input type="text" class="ke" id="uid" value="${uuid}" style="display:none"><br>
	
	<form id="passup" action="/member/passupdate">
		<input type="text" class="ke" name="memTel" value="${memTel}" style="display:none"><br>
		<label class="lic" style="display:none">아이디</label> <input type="text" id="memId" name="memId" value="${memId}"  style="display:none"><br>
		<div>
			
			
		<div>	
			<label class="lic" style="float:left;">인증번호</label> 
			<div style="float:left; margin-left:20px;" >
				<input type="text" class="ke" id="keyval"><br>
			</div>
		</div>
		
		<br><br>
		<div>		
			<label class="lic" style="float:left;">새로 변경할 비밀번호</label> 
			<div style="float:left; margin-left:20px;" >		
				<input type="password" id="newpass1" style="float:left; width:300px;" name="memPass" value="${memPass}" onkeyup="chkPW()" placeholder="8자리 ~ 20자리  영문,숫자,특수문자를 혼합"/>
				<div id="checkPass1" class="indiv" style="float:left; margin-left:20px; margin-top:2px;"></div>
			</div>	
		</div>			 	
					
		<br><br>	
		<div>		
			<label class="lic" style="float:left;">새로 변경할 비밀번호 확인 </label> 
			<div style="float:left; margin-left:20px;" >
				<input type="password" id="newpass2" style="float:left; width:300px;" name="newpass2" onkeyup="unityPW()" placeholder="패스워드"/>
				<div id="checkPass2" class="indiv" style="float:left; margin-left:20px; margin-top:2px;"></div>	
			</div>
		</div>
		</div>	
	</form>
	
	<br><br><br><br>		
	<div style="float:left; margin-left:327px;">	 
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
 	
	 // 비밀번호 일치 확인
	 var pw1 = document.getElementById('newpass1').value;
	 var pw2 = document.getElementById('newpass2').value;
	
	 if(pw1 == null || pw1 == ''){
		 	$('#checkPass1').html('<p></p>');
		 	return false;
	 } 	
	 	
	 if(pw.length < 8 || pw.length > 20){
	 	$('#checkPass1').html('<p style="color:red">8자리 ~ 20자리 이내로 입력해주세요.</p>');
	 	return false;
	 } 
	 else if(pw.search(/\s/) != -1){
	 	$('#checkPass1').html('<p style="color:red">비밀번호는 공백 없이 입력해주세요.</p>');
	 	return false;
	 }
	 else if(num < 0 || eng < 0 || spe < 0 ){
	 	$('#checkPass1').html('<p style="color:red">영문,숫자,특수문자를 혼합하여 <br>입력해주세요.</p>');
	 	return false;
	 }		
	 else {
	 	$('#checkPass1').html('<p style="color:blue">사용가능한 비밀번호 입니다.</p>');
	    return true;
	 }
}	
		
// 비밀번호 일치 확인
function unityPW(){
	var pw1 = document.getElementById('newpass1').value;
	var pw2 = document.getElementById('newpass2').value;
	
	if(pw2 == null || pw2 == ''){
	 	$('#checkPass2').html('<p></p>');
	 	return false;
 	} 	
		
	if(pw1 != pw2){
		$('#checkPass2').html('<p style="color:red">비밀번호가 일치하지 않습니다.</p>'); 
	} else { 	
		$('#checkPass2').html('<p style="color:blue">비밀번호가 일치합니다.</p>'); 
	}
}

$(document).ready(function(){
	$("#sub").on('click', function(){
		var uid = document.getElementById('uid');
        var keyval = document.getElementById('keyval');
		
		var newpass1 = document.getElementById('newpass1');
		var newpass2 = document.getElementById('newpass2');
			
		if(newpass1.value == "" || newpass2.value == ""){
			alert("비밀번호를 입력해주세요.")	
		}
		
		else if(!chkPW()){
			alert("다시 확인해주세요.")
		}
		
		// 누락없을때
		else if(chkPW()) {
						
			// 비밀번호 일치시 
			if(newpass1.value == newpass2.value){
				
				if(uid.value==keyval.value){
					var newpass1 = document.getElementById('newpass1');
			        var newpass2 = document.getElementById('newpass2');
			            
			        	if(newpass1.value == newpass2.value){
							alert("비밀번호 변경완료!");	
			                $('#passup').submit();    
			            }else{
			                alert("비밀번호가 일치하지 않습니다.")
			            }
			    }else{
			    	alert('코드값이 일치하지 않습니다.')
			    }
					
			}else{
				alert("비밀번호가 일치하지 않습니다.")
			}
			
		}
			
	});

});	
</script>
