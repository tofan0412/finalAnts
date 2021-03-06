<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
<style>
body{
	min-width:1000px;
}
.ghgh{
	width:100%;
}
.card{
	padding-top:8%;
	padding-bottom:6%;
}
.content{
	margin-left:42.1%;	
}
.input{ 		
	padding:10px;
	padding-left:20px;
	width:330px;
	height:50px;
	border-radius:80px;
	outline:none;
}
#basicimg{
	height:30px;
	width:150px;	
	background-color:#00a495;
	color:white;
}	
.imgc{
	width:100px; 
	height:100px; 
	cursor:pointer;
}	
#checkbtn{
	height:42px;
}
.indiv{
	margin-left:20px;
}	
.phoneNumber{
	padding:10px;
	padding-left:20px;
	width:330px;
	height:50px;
	border-radius:80px;	
	outline:none;
}	
.balloon {
	position:relative;
	width:240px;		
	height:30px;	
	background:lightblue;	
	border-radius: 10px;
	margin-left:370px;	
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
	<div class="register-card-body" style="width:750px;">	
				
		<div class="login-logo">
			<b>프로필 수정</b>
		</div>		
			
		<div class="card card-primary card-outline">
			<div class="card-body box-profile">
					
				<form id="fmin" role="form" class="form-horizontal" action="/member/profileupdate" method="POST" enctype="multipart/form-data">
				<!-- action="/member/memberRegist" method="POST" enctype="multipart/form-data -->
					
				<input name="memFilepath" type="hidden" value="${memberVo.memFilepath}">
				<div class="balloon"><b style="font-size:13px; margin-left:7px;">이미지를 클릭하면 변경할 수 있어요!</b></div>	
				<div class="text-center" title="이미지를 클릭하면 변경할 수 있어요!">
					<div class="mailbox-attachment-icon has-img" id="pictureView" style="border: 1px solid white; height: 200px; width:140px; margin: 0 auto;">
					<c:if test="${fn:substring(memberVo.memFilepath,0 ,1) eq '/' }">									
						<img id="pictureViewImg"  style="width: 100%; height: 100%;" class="profile-user-img img-fluid img-circle" src="${memberVo.memFilepath}" /><br>
					</c:if>
					<c:if test="${fn:substring(memberVo.memFilepath,0 ,2) eq 'D:' }">		
						<img id="pictureViewImg" style="width: 100%; height: 100%;" class="profile-user-img img-fluid img-circle" src="/profileImgView?memId=${memberVo.memId}" />
					</c:if>
<!-- 						<img class="profile-user-img img-fluid img-circle" id="pictureViewImg" style="width: 100%; height: 100%;"/> -->
					</div><br>		 
					<div class="content">
						
					</div>
				</div> 	
								
				<h3 class="profile-username text-center">
					<input class="profile-username text-center" type="text" class="form-control" placeholder="" style="border:none; outline:none;" readonly/>
				</h3>
				<p class="text-muted text-right">
					<input class="profile-username text-center" type="text" class="form-control" placeholder="" style="border:none; outline:none; display:none;" readonly/>
				</p>
										
				<hr>	
				<div style="width:340px; float:left;">
					<span style="color: red; font-weight: bold;">*</span><b>아이디</b><br>	
					<div id="checkid" class="indiv"></div>		
					<div id="checkMsg" class="indiv"></div>	
				</div>
							
				<div style="float:right;">				
					<input class="input" name="memId" type="email" id="memId" placeholder="사용중인 이메일을 입력해 주세요" value="${memberVo.memId}" readonly/><br>
				</div> 				 		
				<br><br><br>							 	  						
				<hr>	
						
					
				<div style="width:340px; float:left;">
					<span style="color: red; font-weight: bold;">*</span><b>이름</b>
				</div>
				<div style="float:right;">				
					<input class="input" name="memName" type="text" id="memName" placeholder="이름" value="${memberVo.memName}"/>
				</div> 				 		
				<br><br><br>								 	  						
				<hr>		
					
				<div style="width:340px; float:left;">
					<span style="color: red; font-weight: bold;">*</span><b>비밀번호</b>
					<div id="checkPass1" class="indiv"></div>
				</div>
				<div style="float:right;">				
					<input class="input" name="memPass" style="float:left" type="password" id="memPass" onkeyup="chkPW()" placeholder="8자리 ~ 20자리  영문,숫자,특수문자를 혼합" value="${memberVo.memPass}"/>
				</div> 				 		
				<br><br><br>								 	  						
				<hr>

				<div style="width:340px; float:left;">
					<span style="color: red; font-weight: bold;">*</span><b>비밀번호 확인</b>
					<div id="checkPass2" class="indiv"></div>
				</div>
				<div style="float:right;">				
					<input class="input" type="password" style="float:left" id="memPass2" placeholder="패스워드" onkeyup="unityPW()" value="${memberVo.memPass}"/>
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
					<button type="button" style="height:40px; margin-right:20px;" id="registBtn">등록</button>
					<button type="button" style="height:40px;" id="cancelBtn" onclick="window.history.back()">취소</button>
				</div>	
					
				<div style="display:none;">					
					알람 : <input class="form-control" name="memAlert" type="text" id="memAlert" placeholder="알람" value="${memberVo.memAlert}" readonly><br> 
					삭제여부:   <input class="form-control" name="del" type="text" id="del" placeholder="삭제여부" value="${memberVo.del}" readonly><br> 
					멤버구분 :  <input class="form-control" name="memType" type="text" id="memType" placeholder="멤버구분" value="${memberVo.memType}" readonly><br>
					이미지 경로: <input class="form-control" name="imgname" type="text" id="imgname" placeholder="파일경로" value="${memberVo.memFilepath}" readonly>
					사진 : <img id="pict" style="width: 30px; height: 30px;" src="/profileImgView?memId=${memberVo.memId}" />
					기본이미지 : <img id="imge" style="width: 30px; height: 30px;" src="${memberVo.memFilepath}" /><br>
				</div>	
		
				<div class="container">	
				  <!-- Modal -->
				  <div class="modal fade" id="myModal" role="dialog">
				    <div class="modal-dialog modal-lg" style="width:450px;">
				    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">	
				          <h4 class="modal-title">기본 이미지</h4>
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				        </div>		
				        <div class="modal-body" style="width:450px;">	
					          <img src="/profile/user-1.png" id="img1" name="img1" class="imgc">
					          <img src="/profile/user-2.png" id="img2" name="img2" class="imgc"/>
					          <img src="/profile/user-3.png" id="img3" name="img3" class="imgc"/>
					          <img src="/profile/user-4.png" id="img4" name="img4" class="imgc"/>
					          <img src="/profile/user-5.png" id="img5" name="img5" class="imgc"/>
					          <img src="/profile/user-6.png" id="img6" name="img6" class="imgc"/>
					          <img src="/profile/user-7.png" id="img7" name="img7" class="imgc"/>
					          <img src="/profile/user-8.png" id="img8" name="img8" class="imgc"/>
				        </div>	
				        <hr>					
				        <div>
				        	<hr>										
				        	<h5 class="modal-title" style="padding-left:15px;">파일 선택</h5><br>		
				        	<input id="picture" type="file" name="Filename" accept=".gif, .jpg, .png" style="height: 37px; float:left; padding-left:15px;" />	<br><br>
				        	<button type="button" id="closemodal" class="close" data-dismiss="modal" style="height:25px; margin-right:20px;">닫기</button>	
				        	<button type="button" class="close" data-dismiss="modal" style="height:25px; margin-right:15px;">확인</button><br><br>		
				    	</div>
				      </div>	
				      
				    </div>
				  </div>
				  
				</div>
			
				</form>	
					 
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

//핸드폰 번호 정규식
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
 
		
		$(document).ready(function(){
			// 기본이미지 선택하면 파일 값 초기화
			var picture = document.getElementById('picture');
			picture.value = null;
				
			// 파일의 경로값을 꺼냄
			$("#picture").change(function(){ 
				readURL(this);
			});
			
		});
	
		// 이미지 뷰어 src속성에 등록
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
			  
				reader.onload = function (e) {
					$('#pictureViewImg').attr('src', e.target.result);  
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		
		
		// 패스워드 2개 입력한것 값 비교
		var newpass1 = document.getElementById('memPass');	
		var newpass2 = document.getElementById('memPass2');
		
		// 등록버튼시 미입력 된것 있으면 경고창
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
				} else if(chkPW()) {	// 누락없을때		
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
		
		 
		// 기본이미지 선택  
		// 기본이미지 모달창 띄으기
		$(document).ready(function(){
			$('#pictureView').click(function(){
				$("#myModal").modal();
			})
			
			$('#img1').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img1').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img2').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img2').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img3').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img3').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img4').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img4').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img5').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img5').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img6').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img6').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img7').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
					
				imgsrc = document.getElementById('img7').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img8').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img8').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})	
		
		})	
</script>