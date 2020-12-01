<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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
.loginBtn{
	height : 50px;
    background-color: #0BB783;
    border-color: #0BB783;
    color : white;
    border : 0;	
    outline : 0;
    margin : 10px 10px 10px 10px;
    border-radius: 0.85rem !important; 
}
</style>
<script type="text/javascript">
	$(function(){
		$("#loginBtn").on('click',function(){
			$("#lform").submit();
		})	
	})
</script>
</head>

<title>Bootstrap Example</title>
<body>

	<div class="ff">

		<div class="col-sm-4" style="background-color: lavender;">
			<img src="../dist/loginimage.png" height="100%" width="100%"
				alt="Avatar">
		</div>



		<div class="col-sm-6" style="background-color: white;">
			<div class="center">
				<div>
					<h2 class="jg" style="line-height: 25px;">Ants에 오신 걸 환영합니다 !</h2>
					<h4 class="jg">
						새로 오신 분인가요 ? <a href="#" style="color: #0BB783;"><strong>새
								계정을 만드세요.</strong></a>
					</h4>
				</div>
				<br>
				<form id="lform" action="/member/loginFunc" method="POST">
					<div class="form-group has-feedback">
						<header class="jg" style="font-size: 1.2em;">
							Email<br>
						</header>
						<input type="email" class="form-control login" name="memId"
							value="hsj@thousandOfAnts.com"
							style="border : 0; outline : 0;">
					</div>
			
					<div class="form-group has-feedback">
						<div>
							<header class="jg" style="font-size: 1.2em; float : left;">
								Password<br>
							</header>
						</div>
						<div>
							<header class="jg" style="font-size: 1.0em; float : right; 
							color: #0BB783;">
								<a id="myBtn">비밀번호를 잊으셨나요?</a><br>
							</header>
						</div>
						<input type="password" class="form-control login" name="memPass" value="123"
						style="border : 0; outline : 0;">
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
						<br>
						<br>
							<div style="float : right;">
								<button type="button" id="loginBtn" class="jg loginBtn"
								style="width : 100px;">로그인</button>
							</div> 
						</div>
						<!-- /.col -->
					</div>
				</form>
			</div>
		</div>
		
	</div>
	
	
	
	
	<div class="container">
  <h2>Modal Login Example</h2>
  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-default btn-lg" id="myBtn">Login</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4>비밀번호가 생각나지 않으시나요?</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
        
        
          <form role="form" action="/member/mailsender" >
          
            <div class="form-group">
              <label for="usrname"><span class="glyphicon glyphicon-user"></span> 이메일 주소를 입력해주세요</label>
              <input type="text" name="memId" class="form-control" id="memId" placeholder="Enter email">
            </div>
            
           <button type="submit" >확인</button>
          <button type="submit" data-dismiss="modal">취소</button>
          </form>
          
          <br>
          <hr>
          <br>
          
          <form role="form" action="/member/sendSms" >
          
            <div class="form-group">
              <label for="usrname"><span class="glyphicon glyphicon-user"></span> 전화번호를 입력해주세요</label>
              <input type="text" name="from" class="form-control" id="memTel" placeholder="Enter phone number">
              <textarea name="text"></textarea>
            </div>
            
           <button type="submit" >확인</button>
          <button type="submit" data-dismiss="modal">취소</button>
          </form>
          
          
        </div>
      </div>
      
    </div>
  </div> 
</div>
 

	<script>
	
	$(document).ready(function(){
	  $("#myBtn").click(function(){
	    $("#myModal").modal();
	  });
	});
	
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
	})
</script>

</body>
</html>
