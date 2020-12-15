<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/dist/js/js.cookie-2.2.1.min.js"></script>
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
	height: 50px;
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
	padding-top : 13%;
	padding-bottom : 13%;
}
.loginContainer::after{	/* 배경만 흐리게 하기 위한 가상 요소이다. */
	width: 100%;
  	height: 100%;
  	content: "";		/* 가상 요소이기 때문에 내용은 비워 놓는다. */
/*   	background-image : url('${pageContext.request.contextPath}/resources/img/background.jpg'); */
	background-color : white;
  	position : absolute;/* container와 동일한 위치에 있어야 하기 때문에 */
  	top : 0; 
  	left : 0;
  	z-index : -1;
	filter : blur(2px) brightness(100%);;
}

.loginBox{
	background-color : white;
	border : 1px solid lightgrey; 
	width : 30%; 
	margin : 0 auto;
	padding : 15px; 15px; 35px; 35px;
	box-shadow : 2px 2px black ;
	-webkit-animation: fadein 1s; /* Safari and Chrome */
	border-radius: 0.7rem;
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
<script>
 	$(document).ready(function(){
 		loginAlert = '${flashAlert}';
 		if (loginAlert != ''){
 			alert(loginAlert);
 		}
 		
 		$("body").keyup(function(e){
 			if(e.keyCode == 13){
 				$('#loginBtn').trigger("click");
 			}
 		})
 		
 		// 모달창 열기
		$("#myBtn").click(function(){
	    	$("#myModal").modal();
	    });
		
		$(function(){ 
			// remember me cookie 확인
			if(Cookies.get("rememberMe")=="Y"){
				$("input[type=checkbox]").prop("checked",true);
				//$("input[type=checkbox]").attr("checked","checked");
				$("#memId").val(Cookies.get("SMEMBER"))
				//console.log("체크");
			} 
			
			// sign in b버튼이 클릭 되엇을때 이벤크 핸들러
			$("button").on('click',function(){
				console.log("button_click");
			
				if($("input[type=checkbox]").prop("checked") == true){
					Cookies.set("rememberMe","Y");
					Cookies.set("SMEMBER", $("#memId").val());
				}else{
					Cookies.remove("rememberMe");
					Cookies.remove("memId");
				}
			})
		})
		// 엔터키 인식
		
		function getCookieValues(cookieName){
			
			var cookieString = document.cookie.split("; ")
			for(var i=0; i< cookies.length; i++){
				var cookie = cookies[i];
				var cookieArr = cookie.splie("=");

				if(cookieName == cookieArr[0]){
					return cookieArr[1];
				}
			}
			// 원하는 쿠키가 없는 경우
			return "";
		}	
 
		// 쿠키 날짜 설정
		function setCookie(cookieName, cookieValue, expires){
			//"USERNM=brown; path=/; expries=Wed, 07 Oct 2020 00:38:35 GMT;"
			var today = new Date();
			// 현재 날짜에서 미래로  + expires 만큼 한 날짜 구하기
			today.setDate( today.getDate() + expires );
			
			document.cookie = cookieName + "=" + cookieValue + "; path=/; expires=" + today.toGMTString();
			console.log(document.cookie);
		}
		
		// 해당 쿠키의 expires 속성을 과거 날짜로 변경
		function deleteCookie(cookieName){
			setCookie(cookieName, "", -1);	
		}
		
	    if($("#memId").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	        $("#rememberMe").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	    
	    $("#rememberMe").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#rememberMe").is(":checked")){ // ID 저장하기 체크했을 때,
	            setCookie("key", $("#memId").val(), 7); // 7일 동안 쿠키 보관 
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("key");
	        }
	    });
	    
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("#memId").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#rememberMe").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            setCookie("key", $("#memId").val(), 7); // 7일 동안 쿠키 보관 
	        }
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
	 	        data: { "memId" : $('#memId').val(),
		        		"memPass" : $('#memPass').val()},
		        dataType : "text",
		        success : function(data) {
		         	$('#lform').submit();
		        },  
		        error : function(error) {
		        	$('#sp').html('일치하는 회원정보가 없습니다.'); 
		        }
			}) 
			//return false;
		});
	})
</script>
</head>
<title>Ants - 로그인</title>
<body class="loginContainer fadein">
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
				<input type="password" class="form-control login" id="memPass" name="memPass" value="" style="border: 0; outline: 0;">
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
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>비밀번호가 생각나지 않으시나요?</h4>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<div class="panel-group" id="accordion">

							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#accordion"
											href="#collapse1"><li>이메일로 찾기</li></a>
									</h4>
								</div>
								<div id="collapse1" class="panel-collapse collapse in">
									<div class="panel-body">

										<form role="form" action="/member/mailsender">

											<div class="form-group">
												<label for="usrname"><span
													class="glyphicon glyphicon-user"></span> 이메일 주소를 입력해주세요</label> <input
													type="text" name="memId" class="form-control" id="memId"
													placeholder="Enter email">
											</div>

											<input type="submit" value="확인">
											<button type="button" data-dismiss="modal">취소</button>
										</form>

									</div>
								</div>
							</div>
 

							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#accordion"
											href="#collapse2"><li>전화번호로 찾기</li></a>
									</h4>
								</div>
								<div id="collapse2" class="panel-collapse collapse">
									<div class="panel-body">

										<form role="form" action="/member/sendSms">

											<div class="form-group">
												<label for="usrname"><span
													class="glyphicon glyphicon-user"></span> 아이디를 입력해주세요</label> <input
													type="text" name="memId" class="form-control" id="memId"
													placeholder="Enter phone number"> <label
													for="usrname"><span
													class="glyphicon glyphicon-user"></span> 전화번호를 입력해주세요</label> <input
													type="text" name="memTel" class="form-control" id="memTel"
													placeholder="Enter phone number">
											</div>

											<input type="submit" value="확인">
											<button type="button" data-dismiss="modal">취소</button>
										</form>

									</div>
								</div>
							</div>

						</div>
						<br>
						<hr>
						<br>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>