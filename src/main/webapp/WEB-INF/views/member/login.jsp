<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>Bootstrap Example</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <style>
  	 .ff{
		width: 100vw;
	  	height: 100vh;
  	 }
  	 .col-sm-4{
  		height: 100vh;
  		width: 40vw;
  	 }
  	 .col-sm-6{
  		height: 100vh;
  		width: 60vw;
  	 }
  	 .center{
  	 	padding: 30%;
  	 }
  </style>
  
</head>
<body>

<div class="ff">
 
    <div class="col-sm-4" style="background-color:lavender;">
    	<img src="../dist/loginimage.png" height="100%" width="100%" alt="Avatar">
    </div>
    
    <div class="col-sm-6" style="background-color:lavenderblush;">
    	<div class="center">
    			<form action="/member/loginFunc" method="get"> 
					<div class="form-group has-feedback">
						<input type="email" class="form-control" name="mem_id" id="mem_id" placeholder="이메일을 입력하세요" value="">  
						<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
					</div>	
					<div class="form-group has-feedback">
						<input type="password" class="form-control" name="mem_pass"
																placeholder="패스워드를 입력하세요" value=""> <span
							class="glyphicon glyphicon-lock form-control-feedback"></span>
					</div>
					<div class="row">
						<div class="col-sm-8">
							<div class="checkbox icheck">
								<label> <input type="checkbox" id="rememberMe" name="rememberMe" value=""> Remember Me
								</label>
							</div>
						</div>
						<!-- /.col -->
						<div class="form-group has-feedback">
						
							<br><br><br>
							<a href="/member/insertmemberview"><button type="button" class="btn btn-primary btn-block btn-flat">회원가입</button></a>
							<button type="submit" class="btn btn-primary btn-block btn-flat">로그인</button>
						</div>
						<!-- /.col -->
					</div>
				</form>
	    </div>
    </div>

</div>
	
	<script>
	$(document).ready(function(){
	 
		$('#rememberMe').click(function() {
			  if ($(this).is(':checked')) {
			    // Do stuff
			  }
			});
		
		
	    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	    $("#rememberMe").prop("checked", false);
	    var key = getCookie("key");
	    $("#mem_id").val(key); 
	     
		
	    if($("#mem_id").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	        $("#rememberMe").prop("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	    
	    
	    $("#rememberMe").change(function(){ // 체크박스에 변화가 있다면,
	    	alert("체크")
	        if($("#rememberMe").is(":checked")){ // ID 저장하기 체크했을 때,
	            setCookie("key", $("#mem_id").val(), 7); // 7일 동안 쿠키 보관 
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("key");
	        }
	    });
	    
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("#mem_id").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#rememberMe").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            setCookie("key", $("#mem_id").val(), 7); // 7일 동안 쿠키 보관 
	        }
	    });
	});
	
	
	
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
    
</body>
</html> 