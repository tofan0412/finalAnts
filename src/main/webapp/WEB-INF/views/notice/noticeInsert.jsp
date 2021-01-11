<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="/resources/upload/jquery.uploadifive.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/resources/upload/uploadifive.css">

<script type="text/javascript">
	$(document).ready(function() {
		
		 $('#summernote').summernote({
		        placeholder: 'Hello stand alone ui',
		        tabsize: 2,
		        height: 300,
		        toolbar: [
		          ['style', ['style']],
		          ['font', ['bold', 'underline', 'clear']],
		          ['color', ['color']],
		          ['para', ['ul', 'ol', 'paragraph']],
		          ['table', ['table']],
		          ['insert', ['link', 'picture', 'video']],
		          ['view', ['fullscreen', 'codeview', 'help']]
		        ]	      
		      })
		// 뒤로가기
		$("#back").on("click", function() {
			window.history.back();
		});
		 
		 
		// 제목 글자수 계산
	   	$('#noticeTitle').keyup(function (e){
	   	    var content = $(this).val();   		
	   		if (content.length > 66){
	   	        alert("최대 66자까지 입력 가능합니다.");
	   	     	$(this).val(content.substring(0, 65));
	   	    }
	   	}); 
		
	 	// 작성 버튼 클릭시 파일 업로드 호출
     	$('#regBtn').on('click', function(){
     		cnt = 0;
     		// 각 칸이 빈칸인지 아닌지를 확인해야 한다.
 			if ($('#noticeTitle').val().length == 0){
				$('.warningTitle').text("제목을 작성해 주세요.");  
				cnt++;
			}else{
				$('.warningTitle').text("");
				$('#noticeform').submit();		
			}
     	});
	 	
 	});
	
</script>
</head>
<%-- <%@include file="../layout2/ad_contentmenu.jsp"%> --%>

<div class="col-sm-12 ns">
	<div class="card card-success card-outline ">
		<form method="post" action="${pageContext.request.contextPath}/admin/insertnotice" id="noticeform"  >	
			<div class="card-body">
				<div style="padding-left: 30px;">
					<h3>공지사항 작성하기</h3>
					<br>
					<!-- 제목라인 -->
					<div class="form-group">
	                	<input class="form-control " placeholder="Subject:" id="noticeTitle" name="noticeTitle">
	                	<div class="jg" style=" padding-left: 10px;">
	                		<span class="jg warningTitle" style="color : red;"></span>
	                	</div>
	                </div>
	                <!-- note라인 -->
	                <div class="form-group">
	                	<textarea id="summernote" name="noticeCont" placeholder="할일:"></textarea>
	                </div>
	                <!-- 설정 라인 -->
	                <div class="form-group">
	                <label for="status-select" class="col-sm-1 control-label ns">우선순위</label>
	        			<select name="importance" id="status-select">
	           			 <option class="jg" value="gen">일반</option>
	           			 <option class="jg" value="emg">필독</option>
	        			</select>
	                </div>
	                <br>
	                <form>
						<div class="float-left">
<!-- 							<input type="submit" class="btn btn-default" id="insertbtn" value="작성"> -->
<!-- 							<input type="button" class="btn btn-default" id="insertbtn" value="작성"> -->
							<button type="button" class="btn btn-default jg" id="regBtn">등록</button>
<!-- 							<button type="submit" class="btn btn-default jg" id="regBtn">등록2</button> -->
<!-- 							<button type="button" class="btn btn-default jg" id="back">취소</button> -->
						</div>
					</form>
				</div>
			</div>
		</form>
	</div>      
</div>
</html>