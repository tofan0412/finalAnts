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
		 
		fileSlotCnt = 1;
		 
	    // 최대 첨부파일 수
	    maxFileSlot = 5;
	    $('#filediv').on('click', '#btnMinus', function(){
	     	   if(fileSlotCnt > 1){
	     		   fileSlotCnt--;
	     		   console.log(fileSlotCnt);
	     	   }
	     	   console.log("minus clicked!!");
	     	   $(this).prev().prev().remove();
	     	   $(this).prev().remove();
	     	   $(this).remove();
	     	   $('#addbtn').show();
	     	   
	        })
	        
	         $('#addbtn').on('click', function(){
	    	 
				   fileSlotCnt++;
		    	   console.log("click!!");
		    	   var html = '<br><input type="file" name="file" id="fileBtn">'
		    	   				+'<button type="button" id="btnMinus" class="btn btn-light filebtn" style="margin-left: 5px; outline: 0; border: 0;">'
									+'<i class="fas fa-fw fa-minus" style=" font-size:10px;"></i>'
								+'</button>';
		    	   $(this).next().next().append(html);  
		    	   
		    	   if(fileSlotCnt >= maxFileSlot){
		    		   $(this).hide();
	 	    		   alert("파일은 총 "+maxFileSlot+"개 까지만 첨부가능합니다.");
		    	   }
	    	   
	     })

		      
		      
 	});
	
</script>
<style>
 /*	.btn-link {  
		  background-color: #868a8929;
 	    border-color: #868a8929; 
 	} 
*/
/*	.filebtn { 
 	    color: black; 
 	    background-color: #868a8947;
 	    border-color: #868a8947; 
 	    box-shadow: none;
 	    width : 30px;
 	    height: 30px;
 	} */
	input[type=text]{
		hieght : 100px;
	}
	#fileBtn{
		 display: inline-block;
		 padding-bottom:  .5em;
		 padding-top:  .5em;
/*		 color: #fff;
		 font-size: inherit;
		 line-height: normal;
		 vertical-align: middle;
		 background-color: #868a8929;
		 cursor: pointer;
		 border: 1px solid #4cae4c;
		 border-radius: .25em;
		 -webkit-transition: background-color 0.2s;
		 transition: background-color 0.2s;
		 */
	}
}

</style>
</head>
<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
		<div style="padding-left: 30px;">
			<h3>협업이슈 작성하기</h3>
			<br>
			<form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/projectMember/insertissue" id="todoform"  >	
				<label for="issueTitle" class="col-sm-2 control-label">이슈제목 </label>
				<input type="text" name="issueTitle" style="width: 580px;" id="issueTitle"><br><br>
				
				<div style="width: 80%;">
				<label for="issueCont" class="col-sm-2 control-label">이슈 내용</label>
				<textarea id="summernote" name="issueCont" id="issueCont"></textarea>
				</div>
				<br><br>
				
				<label for="todoTitle" class="col-sm-2 control-label">일감</label>
				<select name="todoTitle" id="todoselect">
					
				    <option value="">선택</option>
					<c:forEach items="${todolist }" var="todo" begin ="0" varStatus="vs" end="${todolist.size() }" step="1" >
						<option value="${todo.todoId }">${todo.todoTitle }</option>			
					</c:forEach>			
				</select><br><br>
				
				<label for="file" class="col-sm-2 control-label">첨부파일</label>
				<button type="button" id="addbtn" class="btn btn-light filebtn" style="outline: 0; border: 0;">
						<i class="fas fa-fw fa-plus" style=" font-size:10px;"></i>
					</button> <br>
				
				<div id ="filediv" class="col-sm-10">
					<input type="file" name="file" id="fileBtn">	
								
				</div>
		
				
				<br><br>
				<input type="hidden" value="issue" name="issueKind">		
				<input type="hidden" value="3" name="categoryId">
				<input type="submit" class="btn btn-default" id="insertbtn" value="작성하기"> 
			</form>
		</div>
	   </div>
	 </div>      
</div>
</html>