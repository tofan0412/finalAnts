<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>	
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<style>
body{
	min-width: 1000px;
}
.ghgh{
	width:100%;
}
.card{
	padding-top: 8%;
	padding-bottom: 6%;
}
.content{
	margin-left:43.4%;
}	
.input{ 	
	padding : 10px;
	padding-left : 20px;
	width: 330px;
	height : 50px;
	border-radius: 80px;	
	outline: none;
}
#basicimg{
	height : 30px;
	width : 100px;
	font-size:13px;		
}
.imgc{
	width: 100px; 
	height: 100px; 
	cursor: pointer;
}	
#checkbtn{	
	height : 42px;
}
.indiv{
	margin-left: 7px;	
} 				
.phoneNumber{
	padding : 10px;
	padding-left : 20px;
	width: 330px;
	height : 50px;
	border-radius: 80px;	
	outline: none;
}	
#pictureView{
	height: 200px;
}	

.balloon {
	position:relative;
	width:240px;		
	height:30px;	
	background:lightblue;	
	border-radius: 10px;
	margin-left:470px;
	padding-left:7px;			
	padding-top:2px;						
}									
.balloon:after {
	border:1px solid black;	
	border-top:15px solid lightblue;	
	border-left: 0px solid transparent;
	border-right: 15px solid transparent;
	border-bottom: 0px solid transparent;
	content:"";					
	position:absolute;		
	top:25px;		
	left:10px;		
}						
</style>			
	
<body>	
<div class="wrapperdd" style="margin-left:25%; margin-right:25%; margin-top:25px;">
	<div class="register-card-body">	
				
		<div class="login-logo">
			<b>회원가입</b>
		</div>		
												
		<div class="card card-primary card-outline">
			<div class="card-body box-profile">
						
				<form id="fmin" role="form" class="form-horizontal" action="/member/memberRegist" method="POST" enctype="multipart/form-data">
				<!-- action="/member/memberRegist" method="POST" enctype="multipart/form-data -->
				<div class="balloon"><b style="font-size:13px; margin-left:7px;">이미지를 클릭하면 변경할 수 있어요!</b></div>				
				<div class="text-center">	
					<div class="mailbox-attachment-icon has-img" id="pictureView" style="border:1px solid white; height: 200px; width:140px; margin: 0 auto;">
						<img class="profile-user-img img-fluid img-circle" id="pictureViewImg" style="width: 100%; height: 100%;" src="/profile/user-1.png"/>
					</div><br>						
					<div class="content">				
						<input type="text" id="imgname" name="imgname" style="display: none">	
					</div>	
				</div> 			
											
				<h3 class="profile-username text-center">
					<!-- 경로 미리보기용 <div id="clickmsg">경로 : </div>	<hr>  -->
					<input class="profile-username text-center" type="text" class="form-control"  style="border:none; outline:none;" readonly/>
				</h3>
				<p class="text-muted text-right">	
				</p>
											
				<hr>	
				<div style="width:340px; float:left;">
					<span style="color: red; font-weight: bold;">*</span><b>아이디</b><br>	
					<b style="font-size:13px; margin-left:7px;">( 중복확인이 되어야 등록버튼이 활성화 됩니다. )</b>		
					<div id="checkid" class="indiv"></div>	
					<div id="checkMsg" class="indiv"></div>	
					<span style="color:red;"><form:errors path="memberVo.memId"/></span>		
				</div>
							
				<div style="float:right;">				
					<input class="input" name="memId" type="email" id="memId" placeholder="사용중인 이메일을 입력해 주세요" onkeyup="chkID()" value="${memberVo.memId}"/><br>
					<div style="margin-top:10px;">	
						<button type="submit" id="checkbtn" style="float:right; height:30px; width:120px; background:white; color:black; border:1px solid black; font-size:14px; margin-right:20px;">중복확인</button>
					</div>
				</div> 				 		
				<br><br><br><br>								 	  						
				<hr>
						
				<div style="width:340px; float:left;">
					<span style="color: red; font-weight: bold;">*</span><b>이름</b><br>	
					<span style="color:red;"><form:errors path="memberVo.memName"/></span>
				</div>
				<div style="float:right;">					
					<input class="input" name="memName" type="text" id="memName" placeholder="이름" value="${memberVo.memName}"/>
				</div> 				 		
				<br><br><br>								 	  						
				<hr>	
					
				<div style="width:340px; float:left;">
					<span style="color: red; font-weight: bold;">*</span><b>비밀번호</b>
					<div id="checkPass1" class="indiv"></div>
					<span style="color:red;"><form:errors path="memberVo.memPass"/></span>
				</div>
				<div style="float:right;">				
					<input class="input" name="memPass" style="float:left" type="password" id="memPass" onkeyup="chkPW()" placeholder="8자리 ~ 20자리  영문,숫자,특수문자를 혼합"/>
				</div> 				 		
				<br><br><br>								 	  						
				<hr>

				<div style="width:340px; float:left;">
					<span style="color: red; font-weight: bold;">*</span><b>비밀번호 확인</b>
					<div id="checkPass2" class="indiv"></div>
				</div>
				<div style="float:right;">				
					<input class="input" type="password" style="" id="memPass2" placeholder="패스워드" onkeyup="unityPW()" />
				</div> 				 		
				<br><br><br>								 	  						
				<hr>
							
				<div style="width:340px; float:left;">
					<b>전화번호</b><br>		
					<b style="font-size:13px;">( 전화번호는 비밀번호 분실시 <br>전화번호 인증용으로 사용됩니다. )</b>	
					<div id="checkTel" class="indiv"></div>
				</div>						
				<div style="float:right;">				
					<input class="phoneNumber" name="memTel" type="tel" id="memTel" placeholder="숫자만 입력" value="${memberVo.memTel}"/>
				</div> 				 		
				<br><br><br>								 	  						
				<hr>					
														
				<div style="float:right;">				
					<button type="button" style="height:40px; margin-right:20px;" id="registBtn" disabled="disabled">등록</button>
					<button type="button" style="height:40px;" id="cancelBtn" onclick="window.history.back()">취소</button>
				</div>	
						
				<div style="display:none;">					
					<input class="input" type="text" name="memAlert" value="Y" placeholder="알람" /><br>
					<input class="input" type="text" name="del" value="N" placeholder="삭제" /><br>
					<input class="input" type="text" name="memType" value="MEM" placeholder="타입" /><br>
				</div>	
			
				</form>	
					 
			</div>
		</div>
	</div>
</div>	
			
	
<div class="container">

	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog modal-lg" style="width:450px;">
    	
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">		
          <h5 class="modal-title">기본 이미지</h5>	
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>	
        <div class="modal-body" style="width:450px;">	
			<img src="/profile/user-1.png" id="img1" name="img1" class="imgc"/>	
			<img src="/profile/user-2.png" id="img2" name="img2" class="imgc"/>
			<img src="/profile/user-4.png" id="img4" name="img4" class="imgc"/>
			<img src="/profile/user-3.png" id="img3" name="img3" class="imgc"/>	
			<img src="/profile/user-5.png" id="img5" name="img5" class="imgc"/>
			<img src="/profile/user-6.png" id="img6" name="img6" class="imgc"/>
			<img src="/profile/user-7.png" id="img7" name="img7" class="imgc"/>
			<img src="/profile/user-8.png" id="img8" name="img8" class="imgc"/>
        </div>
        <hr>			
        <div>	
        	<h5 class="modal-title" style="padding-left:15px;">파일 선택</h5><br>	
        	<input id="picture" type="file" name="memFilename" accept=".gif, .jpg, .png" style="height:37px; float:left; padding-left:30px;"/><br><br>	
        	<button type="button" id="closemodal" class="close" data-dismiss="modal" style="height:25px; margin-right:20px;">닫기</button>	
        	<button type="button" class="close" data-dismiss="modal" style="height:25px; margin-right:15px;">확인</button><br><br>		
    	</div>
	</div>			
    	  																
		</div>
	</div>
  
</div>
</body>

<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/bootstrap/dist/js/adminlte.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

// 이메일 형식 정규식
function chkID(){
	var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
	if($('#memId').val() == null || $('#memId').val() == '') {          	
		 $('#checkMsg').html('<p></p>');
		 return false;	
	}
		
	if(!emailRule.test($('#memId').val())){
		 $('#checkMsg').html('<p style="color:red">이메일 형식이 맞지 않습니다.</p>');
		 return false;
	} else if(emailRule.test($('#memId').val())){
		 $('#checkMsg').html('<p></p>');
		 return true;	
	} 					
}				

// 핸드폰 번호 정규식
$(document).on("keyup", ".phoneNumber", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
});

// 비밀번호 정규식
function chkPW(){
	 var pw = document.getElementById('memPass').value;
	 var num = pw.search(/[0-9]/g);
	 var eng = pw.search(/[a-z]/ig);
	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
 	
	 // 비밀번호 일치 확인
	 var pw1 = document.getElementById('memPass').value;
	 var pw2 = document.getElementById('memPass2').value;
		
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
	var pw1 = document.getElementById('memPass').value;
	var pw2 = document.getElementById('memPass2').value;
	
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
 	
//등록버튼시 미입력 된것 있으면 경고창
$(document).ready(function() {
	$("#registBtn").on('click', function() {
		var memId = document.getElementById('memId');
		var memName = document.getElementById('memName');
		var memPass = document.getElementById('memPass');
		
		// 누락있을때
		if (memId.value == "" || memName.value == "" || memPass.value == "") {
			alert("필수입력 사항을 입력해주세요.")
		} else if(!chkPW() && !chkID()){
			alert("다시 확인해주세요.")
		} else if(chkPW() && chkID()) {	// 누락없을때		
			// 비밀번호 일치시 
			if(newpass1.value == newpass2.value){
				$('#fmin').submit();
			}else{
				alert("비밀번호가 일치하지 않습니다.");
			}	
		}else{
			alert("다시 확인해주세요.")
		}
	})
})	
/*	
$(document).ready(function() {
	$("#registBtn").on('click', function() {
		$('#fmin').submit();
	})
})	
*/	
// 중복검사	
var newpass1 = document.getElementById('memPass');
var newpass2 = document.getElementById('memPass2');
$(document).ready(function(){ 
	$('#checkbtn').on('click', function(){ 
		$.ajax({ type: 'POST', 
			url: '/member/checkSignup', 
			dataType : 'json',
			data: { "memId" : $('#memId').val() }, 
			success: function(data){	
				btn = document.getElementById('registBtn');
				if($.trim(data) == 1){ 			
					$('#checkid').html('<p style="color:red">중복된 아이디 입니다.</p>');
					btn.disabled = true;
				}else if($.trim(data) == 0 && $('#memId').val() != "" && chkID()){ 
					$('#checkid').html('<p style="color:blue">사용가능한 아이디 입니다.</p>');
					btn.disabled = false;
				}else if($('#memId').val() == null || $('#memId').val()== ''){	
					$('#checkid').html('<p style="color:red">아이디를 입력해주세요.</p>');
					btn.disabled = true;	
				}			
			}			
		}); //end ajax 
		return false;	/* 페이지 새로고침 막기 */
	}); //end on 
}); 
		
// 기본이미지 - 파일 중 1선택 
$(document).ready(function(){
			
	// 기본이미지 선택하면 파일 값 날리기
	var picture = document.getElementById('picture');
	picture.value = null;
	// picture input의 파일 변경시 이벤트 
	$("#picture").change(function(){
		readURL(this);
		
	});	
});

// 파일의 경로 읽어서 이미지뷰에 보이게 하기
function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
			  
		reader.onload = function (e) {
			$('#pictureViewImg').attr('src', e.target.result);  
		}
		reader.readAsDataURL(input.files[0]);
	}
}
												/* 기본이미지 선택  */
		// 기본이미지 모달창 띄으기
		$(document).ready(function(){
			$('#pictureViewImg').click(function(){
				$("#myModal").modal();
			});	
			
			$('#img1').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img1').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
					
				$("#myModal").modal('hide');					// 모달창 닫기
			});
			$('#img2').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img2').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			});
			$('#img3').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img3').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			});
			$('#img4').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img4').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			});
			
				
			
			$('#img5').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img5').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			});
			$('#img6').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img6').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			});
			$('#img7').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img7').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			});
			$('#img8').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img8').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			});
			
				
			// 파일 선택후 취소시 기본 이미지로 보여주기	
			$('#closemodal').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
					
				imgsrc = document.getElementById('img1').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가			
			});	
		});
</script>	
