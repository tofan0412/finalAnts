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
<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
		<div style="padding-left: 30px;">
			<h3>협업이슈 작성하기</h3>
			<br>
			<form method="post" action="${pageContext.request.contextPath}/projectMember/insertissue" id="todoform"  >	
				<label for="issueTitle" class="col-sm-2 control-label">이슈제목 </label>
				<input type="text" name="issueTitle" style="width: 580px;" id="issueTitle"><br><br>
				
				<div style="width: 80%;">
				<label for="todoCont" class="col-sm-2 control-label">이슈 내용</label>
				<textarea id="summernote" name="issueCont" id="issueCont"></textarea>
				</div>
				<br><br>
				
				<label for="file" class="col-sm-2 control-label">첨부파일</label>
				<div id ="file" class="col-sm-10">
				<input type="button" id="add" value="+"> <br>
					<input type="file" id="file1" name="file1" >
					<input type="hidden" id="file2" name="file2" >											
					<input type="hidden" id="file3" name="file3" >											
					<input type="hidden" id="file4" name="file4" >											
					<input type="hidden" id="file5" name="file5" >											
				</div>
		
				
				
				<input type="text" value="issue" name="issueKind">		
				<input type="text" value="3" name="categoryId">
				<input type="submit" class="btn btn-default" id="insertbtn" value="작성하기"> 
			</form>
		</div>
	   </div>
	 </div>      
</div>
</html>