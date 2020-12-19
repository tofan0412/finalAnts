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
	 		document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
	 		
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
	 	 var QueueCnt = 0;
     	 var uploadCnt = 0;
     	//파일 업로드
     	$('#file_upload').uploadifive({
			'uploadScript'     : '/file/insertfile',
			'fileObjName'     : 'file',    
			'formData'         : {
								   'categoryId' : "1",
								   'someId'     : '${todoSeq}'
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
     	$('#regBtn').on('click', function(){
     		// 업로드할 파일이 존재하지 않을시
     		if($('.uploadifive-queue-item').length ==0){    			
     			$("#todoform").submit();
     		// 업드로할 파일이 존재할 시
     		}else{
     			$('#file_upload').uploadifive('upload');
     		}	
     	})
     	
     	function insert(){
     		if(uploadCnt == $('.uploadifive-queue-item').length){
     			$('#todoform').submit();     		
        	}else{
        	}

    	}
	 		//파일끝

	 		
	 		// 하위 일감 등록
			$("#creatChildBtn").on("click", function() {

				$("#todoform").attr("action", "${pageContext.request.contextPath }/todo/todoChildInsert");
				
				// 업로드할 파일이 존재하지 않을시
	     		if($('.uploadifive-queue-item').length ==0){    			
	     			$("#todoform").submit();
	     		// 업드로할 파일이 존재할 시
	     		}else{
	     			$('#file_upload').uploadifive('upload');
	     		}	
	     	});
			
	 		
			// 뒤로가기
			$("#back").on("click", function() {
				window.history.back();
			});
	 	});
</script>
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
	#dragdiv {
		text-align: center;
		color: darkgray;
		line-height: 170px;
	}
</style>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
	<div class="col-md-12 ns">
		<div class="card card-primary card-outline"> 	
			<div class="card-header">
               <h3 class="card-title jg"><c:out value="${projectVo.proName}"/></h3>
            </div>
	    <form method="post" action="${pageContext.request.contextPath }/todo/todoInsert" id="todoform" enctype="multipart/form-data" >
	   		<input type="hidden" name="todoId" value="${todoSeq }">
        <div class="card-body">
                <div class="form-group">
                  <input class="form-control " placeholder="Subject:" name="todoTitle">
                </div>
                <div class="form-group">
                <textarea id="summernote" name="todoCont" placeholder="할일:"></textarea>
                </div>
                <div class="form-group">
                <label for="mem-select" class="col-sm-1 _control-label ns">담당자</label>
        			<select name="memId" id="mem-select">
            			<option class="jg" value="">담당자 선택</option>
            			<c:forEach items="${promemList}" var="mem">
                		<option class="jg" value="${mem.memId}">${mem.memName}</option>
            			</c:forEach>
       				 </select>
                </div>
                <div class="form-group">
                <label for="status-select" class="col-sm-1 control-label ns">우선순위</label>
        			<select name="todoImportance" id="status-select">
           			 <option class="jg" value="gen">보통</option>
           			 <option class="jg" value="emg">긴급</option>
        			</select>
                </div>
                <div class="form-group">
                <label for="currentDate" class="col-sm-1 control-label ns">시작 일</label>
        			<input type='date' id='currentDate' name="todoStart"/><br><br>
        			<label for="todoEnd" class="col-sm-1 control-label ns">종료 일</label>
        			<input type='date' id='todo_end' name="todoEnd"/>
                </div>
                <div class="form-group" hidden="hidden">
                	<c:if test="${not empty todoVo.todoParentid}">
			        <input type="hidden" name="todoParentid" value="${todoVo.todoParentid}">
			        <input type="hidden" name="todoLevel" value="2">  
			        </c:if>      
			        <c:if test="${empty todoVo.todoParentid}">
			        <input type="hidden" name="todoLevel" value="1">        
			        </c:if>
                </div>
        </div>   
    </form>
    <form style="padding-left: 1%;">
    <label for="file" class="col-sm-2 control-label ns">첨부파일</label>
	<div id="queue">
		<div id ="dragdiv" class="jg"><img src="/fileFormat/addfile.png" style="width:30px; height:30px;">마우스로 파일을 끌어오세요</div>
	</div>
	<input id="file_upload" name="file" type="file" multiple="true"/>
				<br><br>
        	<div class="float-right">
        		<input type="hidden" value="3" name="categoryId">
        	
		        <button type="button" class="btn btn-default jg" id="regBtn">등록</button>
		        <c:if test="${ empty todoVo.todoParentid}">
		        <button type="button" class="btn btn-default jg" id="creatChildBtn">등록 후 하위일감 생성</button>
		        </c:if>
		        <button type="button" class="btn btn-default jg" id="back">뒤로가기</button>
        	</div>
	</form>
</div>
</div>
</html>