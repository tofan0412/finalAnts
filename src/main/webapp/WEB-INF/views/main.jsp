<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- link 선언 -->
<link rel="stylesheet" href="../dist2/css/style.css">
<link rel="stylesheet" href="../dist2/css/style_index.css">
<link rel="stylesheet" href="../dist2/css/style_index2.css">
<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="../dist2/js/script.js"></script>
<title>Ant's</title>
</head>
<div class="chatbot_container">
		<ul class="chatbot">
			<li class="menu_chat"><a class="menu_title" href="#">챗봇</a></li>
		</ul>
	</div>
<body>
	<%@include file="./layout/main_header.jsp" %>
	
	
	<div class="main_container">


		<div class="conA">
			<div class="img1"><img src="../dist2/img/mainimg.jpg" res=""><a class="menu_title" href="#">회원가입</a></img></div>
		</div>
		
		<div class="conB">
			<div class="conB_title">
				<h4>Ants 주요기능</h4>
			</div>
			<div class="conB_container">
				<div class="conB_small_container">
					<div class="conB_icon">
						<i class="fas fa-chart-bar icon"></i>
					</div>
					<div class="conB_content">
						<h3>팀사용량</h3>
						<p>Index 1</p>
					</div>
				</div>
				<div class="conB_small_container">
					<div class="conB_icon">
						<i class="fas fa-users icon"></i>
					</div>
					<div class="conB_content">
						<h3>조직관리</h3>
						<p>Index 2</p>
					</div>
				</div>
				<div class="conB_small_container">
					<div class="conB_icon">
						<i class="fas fa-file-download icon"></i>
					</div>
					<div class="conB_content">
						<h3>다운로드</h3>
						<p>Index 3</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<%@include file="./layout/main_footer.jsp" %>
	
</body>
</html>
