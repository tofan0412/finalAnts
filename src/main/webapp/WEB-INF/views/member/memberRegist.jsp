<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>
	body{
	    min-width: 1000px;
	}
	#butt{
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
		margin-left: 20px;
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
						
				<div class="text-center" title="이미지를 클릭하면 변경할 수 있어요!">
					<div class="mailbox-attachment-icon has-img" id="pictureView" style="border:1px solid white; height: 200px; width:140px; margin: 0 auto;">
						<img class="profile-user-img img-fluid img-circle" id="pictureViewImg" style="width: 100%; height: 100%;" src="http://localhost/profile/user-1.png"/>
					</div><br>	
					<div class="content">
						<input id="picture" type="file" name="memFilename" accept=".gif, .jpg, .png" style="height: 37px; float:left;" />	
						<input type="text" id="imgname" name="imgname" style="display: none">
					</div>
				</div> 	
							
									
				<h3 class="profile-username text-center">
					<!-- 경로 미리보기용 <div id="clickmsg">경로 : </div>	<hr>  -->
					<input class="profile-username text-center" type="text" class="form-control" placeholder=" " style="border: none" readonly/>
				</h3>
				<p class="text-muted text-right">
				</p>
						
										
				<ul class="list-group list-group-unbordered mb-3"> 
					<li class="list-group-item">	<span style="color: red; font-weight: bold;">*</span><b>아이디</b>  	
						<a class="float-right">
							<input class="input" name="memId" type="email" id="memId" placeholder="회원 id" onkeyup="chkID()"/><br>
							<div style="margin-top:10px;">	
								<div id="checkMsg" class="indiv" style="float:left;"></div>
								<div id="checkid" class="indiv" ></div>	
								<button type="submit" id="checkbtn" style="float:right; height:30px; width:120px; background:white; color:black; border:1px solid black; font-size:14px; margin-right:20px;">중복확인</button>
							</div>		
						</a>	 			 		
					</li>		   						
								
					<li class="list-group-item">	<span style="color: red; font-weight: bold;">*</span><b>이름</b> 
						<a class="float-right">
							<input class="input" name="memName" type="text" id="memName" placeholder="이름"/>
						</a>
					</li> 
					
					<li class="list-group-item">	<span style="color: red; font-weight: bold;">*</span><b>비밀번호</b>
						<a class="float-right">
							<input class="input" name="memPass" style="float:left" type="password" id="memPass" onkeyup="chkPW()" placeholder="8자리 ~ 20자리  영문,숫자,특수문자를 혼합"/>
							<div id="checkPass1" class="indiv"></div>
						</a>
					</li>			
								
					<li class="list-group-item">	<span style="color: red; font-weight: bold;">*</span><b>비밀번호</b> 
						<a class="float-right">
							<input class="input" type="password" style="" id="memPass2" placeholder="패스워드" onkeyup="unityPW()" />
							<div id="checkPass2" class="indiv"></div>	
						</a>
					</li>	
							
					<li class="list-group-item">	<b>전화번호</b> 
						<a class="float-right">
							<input class="phoneNumber" name="memTel" type="tel" id="memTel" placeholder="숫자만 입력"/>
							<div id="checkTel" class="indiv"></div>
						</a>
					</li>
				</ul>
						
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
	          <img src="/profile/user-1.png" id="img1" name="img1" class="imgc">
	          <img src="/profile/user-2.png" id="img2" name="img2" class="imgc"/>
	          <img src="/profile/user-4.png" id="img4" name="img4" class="imgc"/>
	          <img src="/profile/user-3.png" id="img3" name="img3" class="imgc"/>	
	          <img src="/profile/user-5.png" id="img5" name="img5" class="imgc"/>
	          <img src="/profile/user-6.png" id="img6" name="img6" class="imgc"/>
	          <img src="/profile/user-7.png" id="img7" name="img7" class="imgc"/>
	          <img src="/profile/user-8.png" id="img8" name="img8" class="imgc"/>
        </div>	
        <div class="modal-footer">
          <button type="button" class="close" data-dismiss="modal" style="height:25px; width:80px;">Close</button>
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
	var emailRule = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			
	if($('#memId').val() == null || $('#memId').val() == '') {          
		 $('#checkMsg').html('<p></p>');
		 return false;
	} else if(!emailRule.test($('#memId').val())){
		 $('#checkMsg').html('<p style="color:red">이메일 형식이 맞지 <br>않습니다.</p>');
		 return false;
	} else {	
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
	
	 if(pw1 != pw2){ 
		 $('#checkPass2').html('<p style="color:red">비밀번호가 일치하지 않습니다.</p>'); 
	 } else if(pw2 == null || pw2 == ''){
		 $('#checkPass2').html('<p></p>'); 
		 if(pw1 == null || pw1 == ''){
			 $('#checkPass1').html('<p></p>'); 
		 }
	 } else { 	
	 	 $('#checkPass2').html('<p style="color:blue">비밀번호 일치</p>'); 
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
	var pw1 = document.getElementById('memPass').value;
	var pw2 = document.getElementById('memPass2').value;
	
	if(pw1 != pw2){ 
		$('#checkPass2').html('<p style="color:red">비밀번호가 일치하지 않습니다.</p>'); 
	} else if(pw2 == null || pw2 == ''){
		 $('#checkPass2').html('<p></p>'); 
		 if(pw1 == null || pw1 == ''){
			 $('#checkPass1').html('<p></p>'); 
		 }
	} else { 
		$('#checkPass2').html('<p style="color:blue">비밀번호 일치</p>'); 
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
		}
	})
})	
	
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
				if($.trim(data) == 0 && $('#memId').val() != "" && chkID()){ 
					$('#checkMsg').html('<p style="color:blue">사용가능</p>'); 
					btn = document.getElementById('registBtn')
					btn.disabled = false;
				}else{ 
					$('#checkMsg').html('<p style="color:red">사용불가</p>'); 
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
			})
			
			
		/* 		
			$('#img0').click(function(){
				// 기본이미지 선택하면 파일 값 날리기
				var picture = document.getElementById('picture');
				picture.value = null;

				// 0번 이미지 경로 가져오기
				imgsrc = document.getElementById('img0').src
					
				$('#clickmsg').append(imgsrc); 		 		// 이미지 경로 미리보기
				$('#pictureViewImg').attr('src', imgsrc); 		// 이미지 뷰어에 보이기
				$('#imgname').attr('value', imgsrc);			// input 태그에 value값으로 경로 추가
				
				var pass = document.getElementById('imgname');	// img name 에 담긴 value값 가져오기
				alert(pass.value);								// img name 의 value 값 확인
				
 				// 모달창 닫기
				$("#myModal").modal('hide');
					
			})
			 */
			
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
	/* 		$('#img9').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img9').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			
			
			
			
			
			$('#img10').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img10').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img11').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img11').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img12').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img12').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img13').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img13').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img14').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img14').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			
			
			
			
			
			$('#img15').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img15').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img16').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img16').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img17').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img17').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img18').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img18').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img19').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img19').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
		
			
			
			
			
			
			
			$('#img20').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img20').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img21').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img21').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img22').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img22').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img23').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img23').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img24').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img24').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			
			
			
			
			
			
			
			$('#img25').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img25').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img26').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img26').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img27').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img27').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img28').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img28').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img29').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img29').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			
			
			
				
			
			
			$('#img30').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img30').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			}) */
		})
		
		
		
		/* 
				realsrc = document.getElementById('img'+1).src
				src = "/" + realsrc.split('/')[4]
				
				$('#clickmsg').append('src : ' + src);
				$('#memFilename').attr('value', src); 
				file = $('memFilename').val()
				file = src;
				$('#clickmsg').append('file : ' + file);
				
				
				$("#myModal").modal('hide');
		*/
		
		
		
		
		/* 	
		var imaMap = new Map();
		
		// 기본이미지 선택
	 	$(document).ready(function(){
			for(i=0; i<31; i++){
				b = '#img' + i;
				
				$(b).on('click', function(){
					var c = $(b).attr("src");
					
					$('#clickmsg').append(b); 
					$('#clickmsg').append(c); 
					
					imaMap.set(b,c);
					
				 	btn = document.getElementById('pictureViewImg');
				 	bt = document.getElementById('picture');
				 	rf = document.getElementById('real_filename');
					
				 	
				 	btn.src = c;
				 	
				 	bt.src = "/" + c.split('/')[1] + "/" + c.split('/')[2]
				 	rf.value = "/" + c.split('/')[1] + "/" + c.split('/')[2]
				 	
				//	$('#clickmsg').append(btn.src); 
					
				//	$('#clickmsg').append(btn.src); 
					
				//	$("#myModal").modal(imaMap.get('#img30')); 
					
					$("#myModal").modal('hide');
				})
			} 
	 	})			
	 	 */
	
		
</script>
