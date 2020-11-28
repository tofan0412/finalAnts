<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="/resources/bootstrap.jsp"%>
<script>
	$(document).ready(function(){
		function setCookie(cookieName, value, exdays){
		    var exdate = new Date();
		    exdate.setDate(exdate.getDate() + exdays);
		    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		    document.cookie = cookieName + "=" + cookieValue;
		}
		 
		function deleteCookie(cookieName){
		    var expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() - 1);
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}
		 
		function getCookie(cookieName) {
		    cookieName = cookieName + '=';
		    var cookieData = document.cookie;
		    var start = cookieData.indexOf(cookieName);
		    var cookieValue = '';
		    if(start != -1){
		        start += cookieName.length;
		        var end = cookieData.indexOf(';', start);
		        if(end == -1)end = cookieData.length;
		        cookieValue = cookieData.substring(start, end);
		    }
		    return unescape(cookieValue);
	}
</script>
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
</style>

</head>

<title>Ants - 로그인</title>
<body>

	<div class="ff">

		<div class="col-sm-4" style="background-color: lavender;">
			<img src="../dist/loginimage.png" height="100%" width="100%"
				alt="Avatar">
		</div>

		<div class="col-sm-6" style="background-color: white;">
			<div class="center">
				<form action="/member/loginFunc" method="get">
					<div class="form-group has-feedback">
						<input type="email" class="form-control" name="mem_id" id="mem_id"
							placeholder="이메일을 입력하세요" value="hsj@thousandOfAnts.com">
						<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
					</div>

					<div class="form-group has-feedback">
						<input type="password" class="form-control" name="mem_pass"
							placeholder="패스워드를 입력하세요" value="123"> <span
							class="glyphicon glyphicon-lock form-control-feedback"></span>
					</div>

					<div class="row">
						<div class="col-sm-8">
							<div class="checkbox icheck">
								<label> <input type="checkbox" id="rememberMe"
									name="rememberMe" value=""> Remember Me
								</label>
							</div>
						</div>
						<!-- /.col -->
						<div class="form-group has-feedback">

							<br>
							<br>
							<br> <a href="/member/memberRegistview"><button
									type="button" class="btn btn-primary btn-block btn-flat">회원가입</button></a>
							<button type="submit" class="btn btn-primary btn-block btn-flat">로그인</button>
						</div>
						<!-- /.col -->
					</div>
				</form>
			</div>
		</div>

	</div>
</body>
</html>
