<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
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
/* 	padding: 10%; */
/* 	color: white; */
}

.login {
/*  	height: 50px;  */
	background-color: #F3F6F9;
	border-color: #F3F6F9;
	height: auto !important;
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
	padding-top : 7%;
	padding-bottom : 7%;
}

.loginBox{
	background-color : #FAFAFA;
	width : 35%; 
	height : 100%;
	float : right;
	margin-right : 10%;
	margin-top: 2%;
	padding : 50px; 15px; 35px; 35px;
	-webkit-animation: fadein 1s; /* Safari and Chrome */
	border-radius: 0.7rem;
}
.imgBox{
	float : left;
	width : 45%;
	height : 100%;
	position : absolute;
	top : 0;
	left : 0;
/* 	background-image : url('${pageContext.request.contextPath}/resources/dist/loginimage.png'); */
	-webkit-animation: fadein 1.5s; /* Safari and Chrome */
	filter : brightness(100%);
	background-size: 105% ;
	background-color: #F3F6F9;
	
 	
}

@-webkit-keyframes fadein { /* Safari and Chrome */
    from {
        opacity:0;
    }
    to {
        opacity:1;
    }
}
</style>
<script type="text/javascript">
$(function(){
	$("#mainBtn").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/member/mainView');
	})
})

$(document).ready(function(){
	// 로그인했다가 뒤로 가기 하면 아이디 값 남아있는것 제거 
	$("#adminId").val('');
	
	// rememberMe cookie 값 남아 있는지 확인, 남아있으면 가져옴		
	if(Cookies.get("rememberMe") == "Y"){
		$("#rememberMe").prop("checked",true);	// rememberMe 체크
		$("#adminId").val(Cookies.get("SADMIN"));// SMEMBER 쿠키값 가져옴
	}else{
		$("#rememberMe").prop("checked",false);
	}
	
	// 로그인 버튼 클릭시	쿠키 설정
	$('#loginBtn').on('click',function(){						
		if($('input:checkbox[id="rememberMe"]').is(":checked") == true){	// 아이디 기억하기 체크 되있으면
			setCookie("rememberMe", "Y", 7);				// rememberMe 값 Y로	7일간 저장
			setCookie("SADMIN", $("#adminId").val(), 7);	// SMEMBER 저장		7일간 저장
		}else{	// 체크 안되있을때	// 쿠키값 삭제
			Cookies.remove("rememberMe");	
			Cookies.remove("SADMIN");
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
	
	// 메일 전송시 알림창
// 	$('#mailsub').on('click',function(){
// 		alert('메일을 확인해 주세요');
// 		$('#mailform').submit();
// 	});
	
	// ??? 뭐지?
// 	loginAlert = '${flashAlert}';
// 	if (loginAlert != ''){
// 		alert(loginAlert);
// 	}

	// 엔터버튼으로 전송	
	$("body").keyup(function(e){
		if(e.keyCode == 13){
			$('#loginBtn').trigger("click");
		}
	})
	
	// 비밀번호 변경 모달창 열기
// 	$("#myBtn").click(function(){
//     	$("#myModal").modal();
//     });
		
 
	//로그인시 회원가입 안한 멤버 거르기
	/* action="/member/loginFunc" method="POST" */
	$('#loginBtn').click(function(e) {
		
		e.stopPropagation();    // 이벤트전달? 실행 중지                       
			e.preventDefault();		// 폼전송 정지
		
		var adminId = $('#adminId').val();
	 	var adminPass = $('#adminPass').val();
	 		
		$.ajax({
			type : "GET",
	        url : "/admin/adlogincheck",
 	        data: { "adminId" : $('#adminId').val(),
	        		"adminPass" : $('#adminPass').val()},
	        dataType : "text",
	        success : function(data) {
	         	$('#lform').submit();
	        },  
	        error : function(error) {
	        	$('#sp').html('일치하는 관리자정보가 없습니다.'); 
	        }
		}) 
		//return false;
	});
})



</script>
 	
<body class="loginContainer fadein" style="background-color: #FAFAFA">

	<!-- 왼쪽 이미지화면 -->
	<div class="imgBox">
		<img alt="이미지" src="${pageContext.request.contextPath}/resources/dist/img/addpl2.png"
		style="width: 100%; padding-top: 22%">
		
	</div>
	
	<div class="loginBox">
		<div>
			<h2 class="jg" style="line-height: 25px;color: #0BB783">
				<a href="/member/mainView" style="color : #0BB783; text-decoration:none;" >Ants</a> 
			</h2>
			<h3 class="jg">
				관리자 페이지 입니다.
			</h3>
		</div>	
		<br>
		
		<!-- onsubmit="return false;"  페이지 새로고침 막기 -->
		<form id="lform" action="/admin/adloginFunc" method="POST" >
			<div class="form-group has-feedback">
					<header class="jg" style="font-size: 1.2em;">
						ID<br>
					</header>
					<input type="email" class="form-control login" id="adminId" name="adminId" value="" style="border: 0; outline: 0;">
			</div>

			<div class="form-group has-feedback">
				<div>
					<header class="jg" style="font-size: 1.2em;">
						Password<br>
					</header>
				</div>
				<input type="password" class="form-control login" id="adminPass" name="adminPass" value="" style="border: 0; outline: 0;" >
			</div>
			
			<div class="row" >
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
					<div style="float: right">
						<span id="sp" style="color:red"></span>
						<button type="button" id="loginBtn" class="jg loginBtn" style="width: 100px;">LOGIN</button>
					</div>
				</div>
				<!-- /.col -->
			</div>
		</form>
	</div>
</body>
