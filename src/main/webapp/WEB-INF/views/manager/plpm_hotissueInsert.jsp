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
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
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
	$(document).ready(function(){
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
	 	
	 	//파일
 		fileSlotCnt = 1;
 		
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
 	
 	 var uploadCnt = 0;
 	//파일 업로드
 	$('#file_upload').uploadifive({
		'uploadScript'     : '/hotissueFile/insertHotissueFile',
		'fileObjName'     : 'file',    
		'formData'         : {
							   'hissueId'     : '${hissueSeq}'
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
		 'onUploadComplete' : function(file, data) { 
		
			uploadCnt +=1;
			
			console.log(data); 
			console.log(data.publicFileVo); 
			console.log(data.count); 
			insert();
		},
		'onCancel': function (file) {
		} 
	});
 		
 	// 작성 버튼 클릭시 파일 업로드 호출
 	$('#regBtn').on('click', function(){
 		// 업로드할 파일이 존재하지 않을시
 		if($('.uploadifive-queue-item').length ==0){    			
 			if("${hissueParentid}" != null){
	 			saveMsg();
	 		}
			$("#hissueform").submit();
 		// 업드로할 파일이 존재할 시
 		}else{
 			$('#file_upload').uploadifive('upload');
 		}	
 	})
 	
 	function insert(){
 		if(uploadCnt == $('.uploadifive-queue-item').length){
 			if("${hissueParentid}" != null){
	 			saveMsg();
	 		}
			$("#hissueform").submit();    		
    	}else{}
	}
 	//파일끝
	 	
 		
	 	// 뒤로가기
		$("#back").on("click", function() {
			window.history.back();
		});
	});
	
	//답글 알림 db저장, 소켓에 메세지보내기
	function saveMsg(){
		var alarmData = {
							"alarmCont" : "${hotIssueVo.hissueId}&&${SMEMBER.memName}&&${SMEMBER.memId}&&/hotIssue/hissueList?reqId=${projectId}&&${hotIssueVo.hissueTitle}&&"+ $('#hissueTitle').val(),
							"memId" 	: "${hotIssueVo.memId}",
							"alarmType" : "posts"
		}
		console.log(alarmData);
		
		$.ajax({
				url : "/alarmInsert",
				data : JSON.stringify(alarmData),
				type : 'POST',
				contentType : "application/json; charset=utf-8",
				dataType : 'text',
				success : function(data){
					
					let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memId +"&&"+ alarmData.alarmType;
					socket.send(socketMsg);
					
					
				},
				error : function(err){
					console.log(err);
				}
		});
	}

	
</script>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<style type="text/css">
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
</style>	 		
</head>

		<%@include file="../layout/contentmenu.jsp"%>
			
		<div class="col-md-12 ns">
			<div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title jg"><c:out value="${projectVo.proName}"/></h3>
              </div>
              <div class="card-body">
                <div class="form-group">
				<form method="post" action="${pageContext.request.contextPath }/hotIssue/hissueInsert" id="hissueform" >    
                <input type="hidden" name="hissueId" value="${hissueSeq }">
                  <input class="form-control" placeholder="Subject:" name="hissueTitle" id="hissueTitle"><br>
                  <input type="hidden" name="writer" value="${SMEMBER.memId }">
                  <input type="hidden" name="hissueParentid" value="${hissueParentid}">
                <textarea id="summernote" name="hissuetCont"></textarea>
       			 </form>
              	</div>
             
				 <form style="padding-left: 2%;">
				    <label  for="file" class="col-sm-2 control-label ns">첨부파일</label>
					<div id="queue"></div>
					<input id="file_upload" name="file" type="file" multiple="true"/>
								<br><br>
				        	<div class="float-right">
						        <button type="button" class="btn btn-default jg" id="regBtn">등록</button>
						        <button type="button" class="btn btn-default jg" id="back">뒤로가기</button>
				        	</div>
				</form>
			</div>
		</div>
	</div>
</html>