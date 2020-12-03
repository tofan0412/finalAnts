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
		 
		$("#kindselect option").each(function() {
			var $this = $(this);		
			if($this.val() == '${issueVo.issueKind }')				
			$this.prop('selected', 'selected');
		});
		
		 
		
		fileSlotCnt = "${filelist.size() }";
		console.log(fileSlotCnt)
		maxFileSlot =5;
		 
		$(document).on("click", "#btnMinus", function(){
				var id = $(this).prev().attr('name')
				$('#delfile').append(id + ",");
				
				var a = $('#delfile').text();
				$('#delfile').val(a);
				
				fileSlotCnt++;
				$(this).prev().prev().remove();
	     	    $(this).prev().remove();
	     	    $(this).remove();
	    	    
	    	    if($('input[type=seach]').length >= 5){
	      			 $('#addbtn').hide()
	      		}else{
	      			 $('#addbtn').show()
	      		}
	       	    
	     });
        
	    $('#addbtn').on('click', function(){

   	  	    fileSlotCnt++;
     		console.log(fileSlotCnt);
    	    var html = '<br><input type="file" name="file" id="fileBtn">'
   				    +'<button type="button" id="btnMinus" class="btn btn-light filebtn" style="margin-left: 5px; outline: 0; border: 0;">'
					+'<i class="fas fa-fw fa-minus" style=" font-size:10px;"></i>'
				    +'</button>';
		    $(this).next().next().append(html); 
	  	
			 
	    	if(fileSlotCnt >= maxFileSlot){
				 $('#addbtn').hide();
				 alert("파일은 총 "+maxFileSlot+"개 까지만 첨부가능합니다.");
		   	}else{
		   		$('#addbtn').show()
		   	}
    	  
	    	   
	     })
		 
		      
 	});
	
</script>
<style>
	input[type=search]{
		display : inline-block;
		border: none; 
		background: transparent;
		 padding-bottom:  .5em;
		 padding-top:  .5em;
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
</style>
</head>
<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
		<div style="padding-left: 30px;">
			<h3>협업이슈 수정하기</h3>
			<br>
			<form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/projectMember/updateissue" id="todoform"  >	
			
				<label for="issueTitle" class="col-sm-2 control-label">이슈종류 </label>
				<select name="issueKind" id="kindselect">
				    <option value="issue">이슈</option>
				    <option value="notice">공지사항</option>
				</select><br><br>
				<label for="issueTitle" class="col-sm-2 control-label">이슈제목 </label>
				<input type="text" name="issueTitle" style="width: 580px;" value="${issueVo.issueTitle }" id="issueTitle"><br><br>
				
				<div style="width: 80%;">
					<label for="todoCont" class="col-sm-2 control-label">이슈 내용</label>
					<textarea id="summernote" name="issueCont" id="issueCont">${issueVo.issueCont }</textarea>
				</div>
				<br><br>
				
				
				<label id ="filelabel" for="file" class="col-sm-2 control-label">첨부파일</label>
				<button type="button" id="addbtn" class="btn btn-light filebtn" style="outline: 0; border: 0;">
					<i class="fas fa-fw fa-plus" style=" font-size:10px;"></i>
				</button> <br>
				<div id ="file" class="col-sm-10">
				
					<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1">
						<input type="search" name="${files.pubId}" value="${files.pubFilename}" disabled >
	   	   				<button type="button" id="btnMinus" class="btn btn-light filebtn" style="margin-left: 5px; outline: 0; border: 0;">
							<i class="fas fa-fw fa-minus" style=" font-size:10px;"></i>
						</button><br>
					</c:forEach>								
					
					<input type="hidden" id="delfile" name="delfile" value="">	
				</div>
		
		
				<br><br>
				 <input type="hidden" value="${issueVo.issueId }" name="issueId">
				<input type="hidden" name="categoryId" value="${issueVo.categoryId }">
				<input type="submit" class="btn btn-default" id="updateBtn" value="수정하기">
			</form>
		</div>
	   </div>
	 </div>      
</div>
</html>