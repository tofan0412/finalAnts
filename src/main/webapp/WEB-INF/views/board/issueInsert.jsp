<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="icon" href="../../favicon.ico">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
    src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link
    href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
    rel="stylesheet">
<script
    src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    
<style type="text/css">
	.sort{
	
		width : 120px;
		height : 30px;
	}
</style>

<script type="text/javascript">

$(document).ready(function() {
       
    $('#summernote').summernote();
 
 });
	

</script>

</head>


<%@include file="./issuecontentmenu.jsp"%>
<%-- <%@include file="./eachproject.jsp"%> --%>

<body>


<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
	
	
			
			<h3>협업이슈 작성하기</h3>
			<form id="frm"  class="form-horizontal" method="post" 
										    action="${pageContext.request.contextPath}/projectMember/insertissue" >
										    
				<div class="form-group">
					<label for="bo_title" class="col-sm-2 control-label">이슈제목</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="issueTitle" name="issueTitle" ><br><br>
<%-- 						<input type="text" name="lbo_id" value="${lbo_id}"> --%>
						
												
					</div>
				</div>
				
				
				<div class="form-group">
					<label for="userNm" class="col-sm-2 control-label">이슈 내용</label>
					<div class="col-sm-10">
						<textarea id ="summernote" name="issueCont"></textarea><br><br>
					</div>
				</div>
				<br><br>
					
				<div class="form-group">
					<label for="file" class="col-sm-2 control-label">첨부파일</label>
					<div id ="file" class="col-sm-10">
					<input type="button" id="add" value="+">
						<input type="file" id="file1" name="file1" >
						<input type="hidden" id="file2" name="file2" >											
						<input type="hidden" id="file3" name="file3" >											
						<input type="hidden" id="file4" name="file4" >											
						<input type="hidden" id="file5" name="file5" >											
					</div>
				</div>
				
				
				
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						 <input type ="button" id = "insertbtn"  value="등록하기"> 
					</div>
				</div>	    						    
										    
										    
										    
				<input type="text" value="issue" name="issueKind">		
				<input type="text" value="3" name="categoryId">
								    
<!-- 				<table> -->
<!-- 					<tr> -->
<!-- 						<td class="sort" >이슈제목 </td> 			 -->
<!-- 						<td><input type="text" value="" name="issueTitle"></td> 						 -->
<!-- 					</tr> -->
					
<!-- 					<tr> -->
<!-- 						<td class="sort">이슈 내용  </td> 			 -->
						
<!-- 						<td><input type="text" value="" name="issueCont"></td> 						 -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td class="sort">이슈 종류</td> 			 -->
<!-- 						<td><input type="text" value="issue" name="issueKind"></td> 						 -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td class="sort">카테고리</td> 			 -->
<!-- 						<td><input type="text" value="3" name="categoryId"></td> 						 -->
<!-- 					</tr> -->
					
<!-- 					<tr> -->
<!-- 						<td class="sort"></td> 			 -->
<!-- 						<td><input type="submit" name="작성하기"></td> 						 -->
<!-- 					</tr> -->
					
<!-- 				</table> -->
			</form>
				
				     
	   </div>
	 </div>      
</div>
	
</body>
</html>