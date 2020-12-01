<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>

#box{
	border-bottom: solid 1px black;
	margin-left: 40%;
	margin-top: 10%;
	height: 300px;
	width: 300px;
	background-color: white;
}
.inp{
	width: 300px;
}

</style>  


<title>Insert title here</title>
</head>
<body>


<div id="box">
	<ul class="nav nav-tabs">
	  <li class="active"><a data-toggle="tab" href="#email">이메일로 찾기</a></li>
	  <li><a data-toggle="tab" href="#phone">전화번호로 찾기</a></li>
	</ul>
	
	<div class="tab-content">
	  <div id="email" class="tab-pane fade in active">
	    <h3>이메일로 찾기</h3>
	    <br>   
	       이메일 입력<br>
	    <input type="text" class="inp">
	    <a href="/member/mailsender"><input type="button" value="제출"></a>
	  </div>
	  <div id="phone" class="tab-pane fade">
	    <h3>전화번호로 찾기</h3>
	    <br>
	       전화번호 입력 <br>
	    <input type="text" class="inp">
	    <input type="button" value="제출">
	  </div>
	</div>
	
</div>

</body>
</html>