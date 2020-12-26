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

<link rel="stylesheet" href="/plugins/summernote/summernote-bs4.min.css">
<script src="/plugins/summernote/summernote-bs4.min.js"></script>
<script src="/plugins/summernote/lang/summernote-ko-KR.js"></script>

<!-- <script src="/resources/upload/jquery.min.js" type="text/javascript"></script> -->
<script src="/resources/upload/jquery.uploadifive.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/resources/upload/uploadifive.css">

<script type="text/javascript">

	$(document).ready(function() {
		
		console.log('${issueKind}')
		
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
	        
     	 
     	 $('#kindselect').on('change', function(){
     		 
     		kind = $(this).val()
     		console.log(kind)
     		if(kind == 'issue'){     			
	     		mytodolist();
     		}else{
     			 $("#todolist").empty();
     		}
     	 })
     	 
     	var uploadCnt = 0;
	    var QueueCnt = 0;
     	//파일 업로드
     	$('#file_upload').uploadifive({
			'uploadScript'     : '/file/insertfile',
			'fileObjName'     : 'file',    
			'formData'         : {
								   'categoryId' : "3",
								   'someId'     : '${issueSeq}'
			                     },
			'auto'             : false,
			'queueID'          : 'queue',
			"fileType": '.gif, .jpg, .png, .jpeg, .bmp, .doc, .ppt, .xls, .xlsx, .docx, .pptx, .zip, .rar, .pdf',
			 "multi": true,
             "height": 30,
             "width": 100,
             "buttonText": "파일찾기",
             "fileSizeLimit": "20MB",
             "uploadLimit": 10,
			 'onUploadComplete' : function(file, data) { // 업로드 대기열이 완료되면 한 번 트리거됩니다.
			
				uploadCnt +=1;

				console.log(data); 
				console.log(data.publicFileVo); 
				console.log(data.count); 

				insert();
			},
			'onCancel': function (file) {// 파일이 큐에서 취소되거나 제거 될 때 트리거됩니다.
				alert('취소')
				QueueCnt--;
				if(QueueCnt == 0){
					$('#dragdiv').show();
				}
			}, 
			'onAddQueueItem'   : function(file) { // 대기열에 추가되는 각 파일에 대해 트리거됩니다.
				QueueCnt++;
				$('#dragdiv').hide();
			}
		});
	    
	    
	    
     	// 작성 버튼 클릭시 파일 업로드 호출
     	$('#insertbtn').on('click', function(){
     		// 업로드할 파일이 존재하지 않을시
     		if($('.uploadifive-queue-item').length ==0){    			    			
   	     		if($('#issueTitle').val() == ''){		     	     		
   	     			$('.warningTitle').text("제목을 작성해 주세요.");		    			
   				}else{
   				 	$('#frm').submit() ;	 
   				}
     			
     		// 업드로할 파일이 존재할 시
     		}else{
     			$('#file_upload').uploadifive('upload');
     		}	
     	})     	
     	// 업로드된 파일의 수와 사용자가 올린 파일의 수가 같을 시 from 전송
     	function insert(){
     		if(uploadCnt == $('.uploadifive-queue-item').length){
     			$('#frm').submit();     		

        	}else{
//         		alert('작성실패');
        	}

    	}
     	
      
 	})
 	

 	
	
	
</script>
<style>
 
	option{
		hieght : 100px;
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
	
}

</style>
</head>
<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
	  <div class="card-body">
		<div style="padding-left: 30px;">
			<h4 class="jg">협업이슈 작성하기</h4>
			<br>
			<form id="frm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/projectMember/insertissue"   >	
				
			<input type="hidden" name="issueId" value="${issueSeq }">
			<input type="hidden" name="todoId" value="${todoVo.todoId }">
			<input type="hidden" name="issueKind" value="issue">
				
			
				<div class="form-group">
					<label for="issueTitle" class="col-sm-2 control-label jg">일감제목</label>
					<input  type="text" name="todoId" style="background-color:transparent; border:none;" value="${todoVo.todoTitle }" disabled>
				</div>
				<div class="form-group">
					<label for="issueTitle" class="col-sm-2 control-label jg">이슈제목</label>
					<input  class="form-control" type="text" name="issueTitle" style="display:inline-block; width: 70%;" id="issueTitle" required>
					<div class="jg" style=" padding-left: 10px;"><span class="jg warningTitle" style="color : red;"></span></div>
				</div>
				
				<div class="form-group" style="width: 90%;">
					<label for="issueCont" class="col-sm-2 control-label jg">이슈 내용</label>
					<textarea id="summernote"  class="form-control" name="issueCont" id="issueCont"></textarea>
				</div>
						
			</form>
			
			
			
			<form>
				<label for="file" class="col-sm-2 control-label jg">첨부파일</label>
				<div id="queue">
					<div id ="dragdiv" class="jg"><img src="/fileFormat/addfile.png" style="width:30px; height:30px;">마우스로 파일을 끌어오세요</div>
				</div>
				<input id="file_upload" class="jg" name="file" type="file" multiple="true"/>

				<br><br>
				<div class="card-footer clearfix " >
					<input type="hidden" value="3" name="categoryId">
					<input type="button"  class="btn btn-default float-right jg" id="insertbtn" value="작성하기"> 
				</div>
				
			</form>
			
		</div>
	   </div>
	 </div>      
</div>
</html>