<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">		
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/dist/js/js.cookie-2.2.1.min.js"></script>
		<!-- 정적자원 매핑처리 하지 말것 	 resources -> ${pageContext.request.contextPath} 바꾸면 서버 실행 초기에 쿠키 못찾음 -->
						
<style>	
.ff {
	width: 100vw;
	height: 100vh;
}

.col-sm-4 {
	height: 100vh;
	width: 40vw;
}	

.col-sm-6 {
	height: 100vh;
	width: 60vw;
}

.center {
	padding: 30%;
}

.login {
	background-color: #F3F6F9;
	border-color: #F3F6F9;
	height: 60px !important;
	padding: 1.5rem !important;
	border-radius: 0.85rem !important;
}

.loginBtn {
	height: 50px;
	background-color: #0BB783;
	border-color: #0BB783;
	color: white;
	border: 0;
	outline: 0;
	margin: 10px 10px 10px 10px;
	border-radius: 0.85rem !important;
}

.loginContainer{
	width : 100%; 
	height : 100%; 
	padding-top : 13%;
	padding-bottom : 13%;
}

.loginBox{
	background-color : white;
	width : 30%; 
	height : 100%;
	float : right;
	margin-right : 15%;
	padding : 15px 15px 35px 35px;
	-webkit-animation: fadein 1s; /* Safari and Chrome */
	border-radius: 0.7rem;
}
.imgBox{
	float : left;
	width : 40%;
	height : 100%;
	position : absolute;
	top : 0;
	left : 0;
/* 	background-image : url('${pageContext.request.contextPath}/resources/dist/loginimage.png'); */
	-webkit-animation: fadein 1.5s; /* Safari and Chrome */
	filter : brightness(100%);
	background-size: 105%;
	background-color: #F3F6F9;
}

@-webkit-keyframes fadein { /* Safari and Chrome */
    from {
        opacity:0;
    }
    to {
        opacity:1;
    }
.search_in{display: block;margin: 4px 79px 0 10px;} 파란색으로 조절한다. 
.search_in input{width:100%}
}	
.ptag {white-space: nowrap;}
	
#checkbtn:active{		
	transform: scale(0.96);			
}
#telsub:active{		
	transform: scale(0.96);			
}
#closemd:active{		
	transform: scale(0.96);			
}		
#mailsub:active{		
	transform: scale(0.96);			
}

.passviewdiv i{
    position: absolute;
    left: 91%;		
    top: 42px;							
    color: AAAAAA;	
}			
</style>

<script>

// 메일 전송 버튼 클릭	
				
 	$(document).ready(function(){		
														/* 쿠키 설정 */		
		// 로그인했다가 뒤로 가기 하면 아이디 값 남아있는것 제거 
		$("#memId").val('');		
		
		// rememberMe cookie 값 남아 있는지 확인, 남아있으면 가져옴		
		if(Cookies.get("rememberMe") == "Y"){
			$("#rememberMe").prop("checked",true);	// rememberMe 체크
			$("#memId").val(Cookies.get("SMEMBER"));// SMEMBER 쿠키값 가져옴
		}else{
			$("#rememberMe").prop("checked",false);
		}
			
		// 로그인 버튼 클릭시	쿠키 설정
		$('#loginBtn').on('click',function(){						
			if($('input:checkbox[id="rememberMe"]').is(":checked") == true){	// 아이디 기억하기 체크 되있으면
				setCookie("rememberMe", "Y", 7);				// rememberMe 값 Y로	7일간 저장
				setCookie("SMEMBER", $("#memId").val(), 7);	// SMEMBER 저장		7일간 저장
			}else{	// 체크 안되있을때	// 쿠키값 삭제
				Cookies.remove("rememberMe");	
				Cookies.remove("SMEMBER");
			}		
		});	
			
		// 쿠키 날짜 설정		SMEMBER		noylit		07 Oct 2020 00:38:35 GMT
		function setCookie(cookieName, cookieValue, expires){
			var today = new Date();
			today.setDate(today.getDate() + expires);	// 현재 날짜에서 미래로  + expires 만큼 한 날짜 구하기
										  							   // expires= 가 쿠키 날짜 저장 변수이름임
			document.cookie = cookieName + "=" + cookieValue + "; path=/; expires=" + today.toGMTString(); // toGMTString 표준시를 사용하여 문자열로 변환된 일자를 반환
															   // path=/; 값은 작동할  url 주소 값임 / 로 저장하면 모든 url에서 쿠키 사용가능
		}
		
				
		// 메일 전송 버튼 클릭
 		$('#mailsub').on('click',function(){
 			if($('#pwidhidden').val() == $('#mailId').val()){
		 		if(chkID()){
		 			//alert('메일을 발송했습니다. 메일을 확인해 주세요');	
		 	 		$('#mailform').submit();	
		 		} else {	
		 			alert('아이디(이메일)를 확인해주세요');
		 		}		
 			}else{
 				alert('본인확인 이메일 주소와 입력한 이메일 주소가 같지 않습니다.');
 			}
 		});
		
		// 문자 전송 버튼 클릭
 		$('#telsub').on('click',function(){
 			if($('#pwtelhidden').val() == $('#mailtel').val()){
 				if($('#pwidhidden').val() == $('#mailId2').val()){
 			 		if(chkID2()){
 			 			alert('문자를 발송했습니다. 핸드폰을 확인해 주세요');	
 			 	 		$('#smsform').submit();
 			 		} else {	
 			 			alert('아이디(이메일)를 확인해주세요');
 			 		}		
 	 			}else{
 	 				alert('본인확인 아이디와 입력한 아이디가 같지 않습니다.');
 	 			}	
 			}else{	
 				alert('회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같지 않습니다.');
 			}	
 		});	
 			
 		// ??? 뭐지?
 		loginAlert = '${flashAlert}';
 		if (loginAlert != ''){
 			alert(loginAlert);
 		}
 		
 		// 엔터버튼으로 전송
 		$("body").keyup(function(e){
 			if(e.keyCode == 13){
 				$('#loginBtn').trigger("click");
 			}
 		})
 		
 		// 비밀번호 보이기 버튼
 		$('.passviewdiv i').on('click',function(){
 	        $('input').toggleClass('active');
 	        if($('input').hasClass('active')){	
 	            $(this).attr('class',"fa fa-unlock")
 	            .prev('input').attr('type',"text");
 	        }else{	
 	            $(this).attr('class',"fa fa-lock")
 	            .prev('input').attr('type','password');
 	        }	
 	    });		
 		
 		// 비밀번호 변경 모달창 열기
		$("#myBtn").click(function(){
	    	$("#idinputModal").modal();
	    });
 		
 		//로그인시 회원가입 안한 멤버 거르기
		/* action="/member/loginFunc" method="POST" */
		$('#loginBtn').click(function(e) {
			
			e.stopPropagation();    // 이벤트전달? 실행 중지                       
 			e.preventDefault();		// 폼전송 정지
			
			var memId = $('#memId').val();
		 	var memPass = $('#memPass').val();
		 		
			$.ajax({
				type : "GET",	
		        url : "/member/logincheck",
	 	        data: { 'memId' : $('#memId').val(),	
		        		'memPass' : $('#memPass').val()},
		        dataType : "json",	
		        async: false,	// false로 설정하게되면 동기식방식으로 이제 ajax를 호출하여 서버에서 응답을 기다렸다가 응답을 모두 완료한 후 다음 로직을 실행하는 동기식으로 변경
		        success : function(data) {	
		         	if(data.memId == $('#memId').val()){
			        	$('#lform').submit();			
		         	}else{
			        	$('#sp').html('일치하는 회원정보가 없습니다.'); 
		         	}
		        },  
		        error : function(error) {
		        	$('#sp').html('일치하는 회원정보가 없습니다.'); 
		        }
			})
			//return false;
		});
 				
 		// 비밀번호 찾을때 아이디 찾기	
	 	$('#checkbtn').on('click', function(){ 
	 				
	 		$.ajax({
				type : "GET",			
		        url : "/member/getmember",	
	 	        data: { 'memId' : $('#mailck').val() },	
		        dataType : "json",	
		        async: false,	// false로 설정하게되면 동기식방식으로 이제 ajax를 호출하여 서버에서 응답을 기다렸다가 응답을 모두 완료한 후 다음 로직을 실행하는 동기식으로 변경
		        success : function(data) {	
		         	if(data.memId == $('#mailck').val()){
		         		
		         		// 이메일 마스킹
		         		email = data.memId.split('.')[0]	// poiqqw@naver
		         		emailStr = email.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-])/gi);	// 이메일 정규식
		         			
		         		// poiqqw@naver => po****@n****
		         		strLength = emailStr.toString().split('@')[0].length - 3; 	 
		         		splitmail = email.toString().replace(new RegExp('.(?=.{0,' + strLength + '}@)', 'g'), '*').replace(/.{4}$/, "****"); 
		         			
		         		/// po****@n****.com
		         		maskingmail = splitmail + '.' + data.memId.split('.')[1];
		         		
		         		// input 태그 글자갯수에 맞춰 크기조절	
		         		var starcnt1 = maskingmail.match(/\*/g).length;	
		         		// (po@n.com + 기본공백 = width 85) - (기본공백 8) + (기본공백 + * = 14) + (별갯수-1는  완전히보이는크기 더했으니까 1개 빼줌)*6(별하나크기) 	(** 크기 20, *1개당 6, 14-*= 8 기본공백크기)	
		         		document.getElementById("pwid").style.width = 85 - 8 + 14 + ((starcnt1-1)*6) + 'px';
		         		document.getElementById("pwid").value = maskingmail;
		         		document.getElementById("pwidhidden").value = data.memId;
		         				
		         					
		         		// 전화번호 마스킹	입력해둔 전화번호가 있을때만 
		         		if(data.memTel != null && data.memTel != ''){
			         		phoneStr = data.memTel.match(/\d{3}-\d{3,4}-\d{4}/gi); 
			         			
			         		if(/-[0-9]{3}-/.test(phoneStr)) {
			         			// 000-000-0000 
			         			first = data.memTel.split('-')[0].substring(0,2);
		 						second = data.memTel.split('-')[1].substring(0,1);
		 						third = data.memTel.split('-')[2].substring(0,1);
		 						// 00*-0**-0*** 
		 						maskingnum = first + '*-' + second + '**-' + third + '***';
		 						
		 						// input 태그 글자갯수에 맞춰 크기조절	
		 						var starcnt2 = maskingmail.match(/\*/g).length;	
		 												// 01-4-7 width 기본값 55
				         		document.getElementById("pwtel").style.width = 85 - 8 + 14 + ((starcnt2-1)*6) + 'px';
		 					} else if(/-[0-9]{4}-/.test(phoneStr)) {
		 						// 000-0000-0000	
		 						first = data.memTel.split('-')[0].substring(0,2);
		 						second = data.memTel.split('-')[1].substring(0,1);
		 						third = data.memTel.split('-')[2].substring(0,1);
		 						// 00*-0***-0***
		 						maskingnum = first + '*-' + second + '***-' + third + '***';
		 						
		 						// input 태그 글자갯수에 맞춰 크기조절	
		 						var starcnt2 = maskingmail.match(/\*/g).length;	
		 												  // 01-4-7 width 기본값 55
				         		document.getElementById("pwtel").style.width = 55 - 8 + 14 + ((starcnt2-1)*6) + 'px';
				         		document.getElementById("pwtel").value = maskingnum;
				         		document.getElementById("pwtelhidden").value = data.memTel;
	 						}	
		         		} else{
		         			document.getElementById("teldiv").style.display='none';
		         		}
		         										
		         		
		         		$("#idinputModal").modal('toggle');
		         		
									         		
			        	$("#passModal").modal();			
		         	}else{
		         		alert('입력하신 아이디를 찾을 수 없습니다.');
		         	}	
		        },  		
		        error : function(error) {
		        	alert('입력하신 아이디를 찾을 수 없습니다.');
		        }
			})	
	 		return false;	/* 페이지 새로고침 막기 */
	 	}); //end on 
	})
	
function chkID(){	
	var emailRule = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			
	if($('#mailId').val() == null || $('#mailId').val() == '') {          
		 $('#checkMsg').html('<p></p>');	
		 return false;	
	} else if(!emailRule.test($('#mailId').val())){
		 $('#checkMsg').html('<p style="color:red">이메일 형식이 맞지 않습니다.</p>');
		 return false;
	} else {			
		 $('#checkMsg').html('<p></p>'); 
		return true;
	}	
}
	
function chkID2(){	
 	var emailRule = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
 	
	if($('#mailId2').val() == null || $('#mailId2').val() == '') {          
		 $('#checkMsg2').html('<p></p>');	
		 return false;	
	} else if(!emailRule.test($('#mailId2').val())){
		 $('#checkMsg2').html('<p style="color:red">이메일 형식이 맞지 않습니다.</p>');
		 return false;
	} else {			
		 $('#checkMsg2').html('<p></p>'); 
		return true;
	}
}
	
$(document).on("keyup", "#mailtel", function() { 
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
});	
</script>	
	
<body class="loginContainer fadein">
	<div class="imgBox">
		<img alt="img" src="${pageContext.request.contextPath}/resources/dist/img/loginimage.png" style="width : 100%; padding-top : 30%;">
	</div>
	<div class="loginBox">
		<div>
			<h2 class="jg" style="line-height: 25px;">
				<a href="/member/mainView" style="color : #0BB783;">Ants</a>에 오신 걸 환영합니다 !
			</h2>
			<h4 class="jg">
				새로 오신 분인가요 ? <a href="/member/memberRegistview" style="color: #0BB783;"><strong>새계정을 만드세요.</strong></a>
			</h4>
		</div>	
		<br>
					<!-- onsubmit="return false;"  페이지 새로고침 막기 -->
		<form id="lform" action="/member/loginFunc" method="POST" >
			<div class="form-group has-feedback">
				<header class="jg" style="font-size: 1.2em;">
					Email<br>
				</header>
				<input type="email" class="form-control login" id="memId" name="memId" value="" style="border: 0; outline: 0;">
			</div>	
		
			<div class="form-group has-feedback">
				<div>
					<header class="jg" style="font-size: 1.2em; float: left;">
						Password<br>
					</header>
				</div>
				<div>
					<header class="jg" style="font-size: 1.0em; float: right; color: #0BB783;">
						<a id="myBtn">비밀번호를 잊으셨나요?</a><br>
					</header>
				</div>	
								
				<div class="passviewdiv">
					<input type="password" class="form-control login" id="memPass" name="memPass" value="" style="display: inline-block; border:none; outline:0; float:left;">
					<i class="fa fa-lock"  style="font-size:30px;"></i>	
				</div>		
									
																		
			</div>		
					
			<div class="row">
				<div class="col-sm-8">
					<div class="checkbox icheck">
						<label> <input type="checkbox" id="rememberMe"
							name="rememberMe" value=""> 아이디 기억하기
						</label>
					</div>
				</div>
				<!-- /.col -->
				<div>
					<br> <br>
					<div style="float: right;">
						<span id="sp" style="color:red"></span>
						<button type="button" id="loginBtn" class="jg loginBtn" style="width: 100px;">로그인</button>
					</div>
				</div>
				<!-- /.col -->
			</div>
		</form>
	</div>
	
	
	
	<div class="container">
	
		<!-- 아이디 입력 모달 -->		
		<div class="modal fade" id="idinputModal" role="dialog">
		    <div class="modal-dialog">	
		    	<div class="modal-content">	
			        <div class="modal-header">
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
			            <h4>비밀번호 찾기</h4>
			            <div style="float:right;">	
			           		<a style="color:green; font-size:7px;">01. 아이디 입력</a><b style="font-size:7px;">>02. 본인 확인>03. 비밀번호 재설정</b>	
			        	</div>				
			        </div>					
			        <div class="modal-body">
			        	<p style="font-size:15px;">비밀번호를 찾고자 하는 아이디를 입력해 주세요.</p><br>
			        	<label for="usrname" style="width:500px;">아이디</label> 
			        	<input class="form-control" name="memId" type="email" id="mailck" placeholder="Enter email" onkeyup="chkID()" style="width:100%;"/><br>
			        </div>					
			        <div class="modal-footer">		
			            <button type="button" id="closemd" style="float:right; margin-left:5px;" data-dismiss="modal">닫기</button>
			        	<button type="submit" id="checkbtn" style="float:right;">다음</button>
			        </div>
		        </div>				
		    </div>		
		</div>				
						
		<!-- 비번찾기 모달 -->
		<div class="modal fade" id="passModal" role="dialog">
			<div class="modal-dialog">							
				<div class="modal-content">										
					<div class="modal-header"">	
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
						<h4>비밀번호 찾기</h4>		
						<div style="float:right;">		
			           		<b style="font-size:7px;">01. 아이디 입력></b><a style="color:green; font-size:7px;">02. 본인 확인</a><b style="font-size:7px;">>03. 비밀번호 재설정</b>	
			        	</div>			
					</div>					
					<div class="modal-body" style="width:max-width: 100%; width: auto;">
						<div class="panel-group" id="accordion"	style="width:max-width: 100%; width: auto;">
		
							<div class="panel panel-default" style="width:max-width: 100%; width: auto;">	
								<div class="panel-heading" style="width:max-width: 100%; width: auto; background-color:white">	
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#accordion" href="#collapse1">
										<li>본인확인 이메일로 인증 ( <input type="text" id="pwid" style="border:none; outline:none;" readonly> )</li>
										<input type="text" id="pwidhidden" style="display:none;" readonly>
										</a>								
									</h4>						
																		
												
								</div>		
								<div id="collapse1" class="panel-collapse collapse in" style="width:max-width: 100%; width: auto;">
									<div class="panel-body" style="width:max-width: 100%; width: auto;">
	
										<form id="mailform" role="form" action="/member/mailsender">
							
											<div class="form-group" style="width:max-width: 100%; width: auto;">	
												<p style="font-size:10px;">본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p><br>
												<label for="usrname" style="width:500px;">이메일</label> 
												<input type="email" name="memId" class="form-control" id="mailId" placeholder="Enter email" onkeyup="chkID()">	
												<div id="checkMsg" class="indiv"></div>	
											</div>	
						
											<input id="mailsub" type="button" value="확인">
											<button type="button" data-dismiss="modal">취소</button>
										</form>

									</div>
								</div>
							</div>	
									
 										
							<div class="panel panel-default" id="teldiv" style="width:100%;">
								<div class="panel-heading" style="width:max-width: 100%; width: auto; background-color:white">	
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#accordion" href="#collapse2">
										<li>회원정보에 등록한 휴대전화로 인증 ( <input type="text" id="pwtel" style="border:none; outline:none;" readonly/> )</li>
										<input type="text" id="pwtelhidden" style="display:none;" readonly>
										</a>		
									</h4>	
								</div>
								<div id="collapse2" class="panel-collapse collapse">
									<div class="panel-body">

										<form id="smsform" role="form" action="/member/sendSms">
					
											<div class="form-group">
												<p style="font-size:10px;">회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야, 인증번호를 받을 수 있습니다.<p><br>
												<label for="usrname" style="width:500px;">아이디</label> 
												<input type="email" name="memId" class="form-control" id="mailId2" placeholder="Enter email" onkeyup="chkID2()">
												<div id="checkMsg2" class="indiv"></div>
													
												<label for="usrname" style="width:500px;">전화번호</label> 
												<input type="tel" name="memTel" class="form-control" id="mailtel" placeholder="Enter phone number">
											</div>
		
											<input type="button" id="telsub" value="확인">
											<button type="button" data-dismiss="modal">취소</button>
										</form>

									</div>
								</div>
							</div>
		
						</div>
						<br>	
						<hr>					
						<button type="button" id="closemd" style="float:right; margin-left:5px;" data-dismiss="modal">닫기</button>
						<br>
					</div>
				</div>
			</div>	
		</div>
		
	</div>
</body>
