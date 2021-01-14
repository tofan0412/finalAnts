<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">
<link rel="stylesheet" href="/plugins/summernote/summernote-bs4.min.css">
<script src="/plugins/summernote/summernote-bs4.min.js"></script>
<script src="/plugins/summernote/lang/summernote-ko-KR.js"></script>

	
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
		        ],
		      minHeight: null,   // 최소 높이
			  maxHeight: null,   // 최대 높이
			  focus: true,       // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",	 // 한글 설정
		 })
		 
		 
		// 뒤로가기
		$("#back").on("click", function() {
			window.history.back();
		});
		 
		// 제목 글자수 계산
	   	$('#noticeTitle').keyup(function (e){
	   	    var content = $(this).val();   		
	   	    if (content.length > 66){
// 	   	        alert("최대 66자까지 입력 가능합니다.");
	   	     	$(this).val(content.substring(0, 65));
	   	    }
	   	});
		
	 // 작성 버튼 클릭시 파일 업로드 호출
     	$('#updateBtn').on('click', function(){
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
<style>
	input[type=search]{
		display : inline-block;
		border: none; 
		background: transparent;
		 padding-bottom:  .5em;
		 padding-top:  .5em;
		 width: 350px;
	}
	#filelabel{
		display: inline-block;
		width: 100px;
	}
	#fileBtn{
		 display: inline-block;
		 padding-bottom:  .5em;
		 padding-top:  .5em;
	}
	label{	
		height: auto;
		font-size: 1.1em;
	}
	#fileBtn{
		 display: inline-block;
		 padding-bottom:  .5em;
		 padding-top:  .5em;
	}
	
	.uploadifive-button {
		float: left;
		margin-right: 10px;
		
	}
	
	#queue {
		border: 1px solid #E5E5E5;
		height: 177px;
		width : 450px;
		overflow: auto;
		margin-bottom: 10px;
		padding: 0 3px 3px;
	
	}
	#uploadifive-file_upload{
		width : 200px;
		height: 30px;
	}
	#dragdiv {
		text-align: center;
		color: darkgray;
		line-height: 170px;
	}
	
</style>
</head>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
	  <div class="card-body">
		<div style="padding-left: 30px;">
			<h4 class="jg">공지사항 수정하기</h4>
			<br>
			<form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/updatenotice" id="noticeform"  >	
				
				<div class="form-group" >
					<label for="noticeTitle" class="col-sm-2 control-label jg">제목 </label>
					<input  class="form-control col-sm-8" type="text" class="jg" name="noticeTitle" style=" display: inline-block;" value="${noticeVo.noticeTitle }" id="noticeTitle"><br><br>
					<div class="jg" style=" padding-left: 10px;">
	                	<span class="jg warningTitle" style="color : red;"></span>
	                </div>
				</div>
				
				<div class="form-group jg" style="width: 90%;">
					<label for="noticeCont" class="col-sm-2 control-label jg">내용</label>
					<textarea class="jg" id="summernote" name="noticeCont" id="noticeCont">${noticeVo.noticeCont }</textarea>
				</div>
				
				<div class="form-group" >
					<input type="hidden" name="changemem" id="changemem" />
					<label for="status-select" class="col-sm-1 control-label ns">우선순위</label>
					<select class="ns" name="importance" id="status-select">
					    <c:if test="${noticeVo.importance eq 'gen' }">
					    <option class="jg" value="gen">일반</option>
					    <option class="jg" value="emg">필독</option>
					    </c:if>
					    <c:if test="${noticeVo.importance eq 'emg' }">
					    <option class="jg"  value="emg">필독</option>
					    <option class="jg" value="gen">일반</option>
					    </c:if>
					</select><br><br>
				</div>
		
				<div class="float-right" >
					<input type="hidden" value="${noticeVo.noticeId }" name="noticeId">
<!-- 					<input type="submit" class="btn btn-default  jg" id="updateBtn" value="수정하기"> -->
					<button type="button" class="btn btn-default jg" id="updateBtn">수정하기</button>
					<button type="button" class="btn btn-default  jg" id="back">뒤로가기</button>
				</div>
				
			</form>
		</div>
	   </div>
	 </div>      
</div>
</html>