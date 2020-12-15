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
<script type="text/javascript" src="/dist/js/js.cookie-2.2.1.min.js"></script>


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
	padding: 10%;
	color: white;
}

.login {
	height: 50px;
	width: 40%;
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
</style>
<script type="text/javascript">
$(function(){
	$("#mainBtn").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/member/mainView');
	})
})
</script>
</head>

<title>Ants - 관리자로그인</title>
<body>

	<div class="ff">

		<div class="col-sm-4">
			<img src="../dist/img/addpl.png"  height="60%" width="100%" style="margin-top: 100px">
		</div>
		
		

		<div class="col-sm-6" style="background-color: rgb(39, 9, 73);">
			<div class="center">
				<div>
					<h1 class="jg" style="line-height: 25px;">Welcome Admin!</h1>
					<br>
					<h4>
					I don't have anything to say,<br>
					so I'm writing anything to make it look fun.<br>
					I don't think I can use this much,<br>
					so I have to write more, but I don't know what to say.<br>
					Thank you for your hard work on the final project.<br>
					This is the administrator login page.<br>
					
					<br><br>
					
					ants1000@ants.com<br>
					010-1000-1001<br>
					</h4>
				</div>
				
				
				
				
				
				
				
				<br>
							<!-- onsubmit="return false;"  페이지 새로고침 막기 -->
				<form id="lform" action="/admin/adloginFunc" method="POST" >
					<div class="form-group has-feedback">
						<header class="jg" style="font-size: 1.2em;">
							Please enter admin ID<br>
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
									name="rememberMe" value=""> RememberMe
								</label>
							</div>
						</div>
						<!-- /.col -->
						<div>
							<br> <br>
							<div style="float: right">
								<span id="sp" style="color:red"></span>
								<button type="button" id="mainBtn" class="jg loginBtn" style="width: 100px;">MAIN</button>
								<button type="button" id="loginBtn" class="jg loginBtn" style="width: 100px;">LOGIN</button>
<!-- 								<input type="submit" id="loginBtn" class="jg loginBtn" value="로그인"> -->
							</div>
						</div>
						<!-- /.col -->
					</div>
				</form>
			</div>
		</div>
		
	</form>
	
	</div>

	
	<script>
 	$(document).ready(function(){
 		
		
		
		$(function(){ 
			// remember me cookie 확인
			if(Cookies.get("rememberMe")=="Y"){
				$("input[type=checkbox]").prop("checked",true);
				//$("input[type=checkbox]").attr("checked","checked");
				$("#adminId").val(Cookies.get("SADMIN"))
				//console.log("체크");
			} 
      		
			
			// sign in b버튼이 클릭 되엇을때 이벤크 핸들러
			$("button").on('click',function(){
				console.log("button_click");
			
				if($("input[type=checkbox]").prop("checked") == true){
					Cookies.set("rememberMe","Y");
					Cookies.set("SADMIN", $("#adminId").val());
				}else{
					Cookies.remove("rememberMe");
					Cookies.remove("adminId");
				}
			})
		})
		
		
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
	
		
	    if($("#adminId").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	        $("#rememberMe").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	    
	    
	    $("#rememberMe").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#rememberMe").is(":checked")){ // ID 저장하기 체크했을 때,
	            setCookie("key", $("#adminId").val(), 7); // 7일 동안 쿠키 보관 
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("key");
	        }
	    });
	    
	    
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("#adminId").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#rememberMe").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            setCookie("key", $("#adminId").val(), 7); // 7일 동안 쿠키 보관 
	        }
	    });

	    
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
		        	$('#sp').html('No matching administrator information found.'); 
		        }
			}) 
// 			return false;
		});
		
		
	})
</script>

</body>
</html>
