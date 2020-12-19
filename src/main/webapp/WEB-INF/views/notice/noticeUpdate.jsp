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
 	});
	
</script>
</head>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
		<div style="padding-left: 30px;">
			<h3>공지사항 수정하기</h3>
			<br>
			<form method="post" action="${pageContext.request.contextPath}/admin/updatenotice" id="noticeform"  >	

				<label for="noticeTitle" class="col-sm-2 control-label jg">제목 </label>
				<input class="jg" type="text" name="noticeTitle" style="width: 400px;" value="${noticeVo.noticeTitle }" id="noticeTitle"><br><br>
				
				<div style="width: 80%;">
				<label for="noticeCont" class="col-sm-2 control-label jg">내용</label>
				<textarea class="jg" id="summernote" name="noticeCont" id="noticeCont">${noticeVo.noticeCont }</textarea>
				</div>
				<br><br>
				
				
		
				
				 <input type="hidden" value="${noticeVo.noticeId }" name="noticeId">
				<input type="submit" class="btn btn-default float-right jg" id="updateBtn" value="수정하기">
			</form>
		</div>
	   </div>
	 </div>      
</div>
</html>