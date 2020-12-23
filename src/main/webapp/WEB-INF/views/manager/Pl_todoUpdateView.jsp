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
<script src="/resources/upload/jquery.uploadifive.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/resources/upload/uploadifive.css">

<script type="text/javascript">
	$(document).ready(function() {
		$("#memChangecomment").hide();
		$('#summernote').summernote();
		
		// db일자 가져오기
		var todo_start = $('#todo_start').val();
		var todo_end = $('#todo_end').val();
		document.getElementById('todoStart').value = new Date(todo_start).toISOString().substring(0, 10);
 		document.getElementById('todoEnd').value = new Date(todo_end).toISOString().substring(0, 10);
 		
 		//파일
		fileSlotCnt = "${filelist.size() }";
		console.log(fileSlotCnt)
		maxFileSlot =5;
		// 파일 삭제 버튼클릭
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
		    $(this).next().append(html); 
	  	
			 
	    	if(fileSlotCnt >= maxFileSlot){
				 $('#addbtn').hide();
				 alert("파일은 총 "+maxFileSlot+"개 까지만 첨부가능합니다.");
		   	}else{
		   		$('#addbtn').show()
		   	} 	   
	    })
	    
	    
	    var uploadCnt = 0;
     	//파일 업로드
     	$('#file_upload').uploadifive({
			'uploadScript'     : '/file/insertfile',
			'fileObjName'     : 'file',    
			'formData'         : {
								   'categoryId' : "1",
								   'someId'     : '${todoVo.todoId }'
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
				insertcheck(); 
			},
			'onCancel': function (file) {
				alert('실패')
			} // 파일이 큐에서 취소되거나 제거 될 때 트리거됩니다.
		});
     	
     	
     	// 업데이트 버튼 클릭시 파일 삭제 호출
     	$('#updatebtn').on('click', function(){
     		$("#mem-select").remove();
     		cnt = 0;
     		// 각 칸이 빈칸인지 확인
     		if ($('#todoTitle').val().length == 0){
				$('.warningtodoTitle').text("제목을 작성해 주세요.");  
				cnt++;
			}
     		if ($('#todoStart').val().length == 0){
				$('.warningtodoStart').text("시작일을 지정해 주세요.");  
				cnt++;
			}
     		if ($('#todoEnd').val().length == 0){
				$('.warningtodoEnd').text("마감일을 지정해 주세요.");  
				cnt++;
			}
     		if ($('#memChangeComment2').val().length == 0){
				$('.warningmemChangeComment').text("인수인계 내용을 입력해주세요.");  
				cnt++;
			}
     		if(cnt == 0){
     		 delfiles();	     	
     		}
     		
     	})
     	
     	// 업로드된 파일의 수와 사용자가 올린 파일의 수가 같을 시 from 전송
     	function insertcheck(){
     		if(uploadCnt == $('.uploadifive-queue-item').length){
     			$("#mem-select").remove();
     			$('#todoform').submit(); 
        	}
    	}
	      
	
	// 삭제할 파일 
	function delfiles(){
		console.log($('#delfile').val());
	 	$.ajax({url :"${pageContext.request.contextPath}/file/delfiles",
	 			 data : {delfile : $('#delfile').val() },
				 method : "post",
				 success :function(data){	
					 console.log(data);
					// 업로드할 파일이 존재하지 않을시 update전송
		     		if($('.uploadifive-queue-item').length ==0){    	
		     			$("#mem-select").remove();
		     			 $('#todoform').submit();	    					    					     			
		     		// 업로드할 파일이 존재시 파일 등록 호출
		     		}else{
		     			$('#file_upload').uploadifive('upload');
		     		}
				 }
		 	})
		}
 		
 		
 		//파일끝
 		
 		// 뒤로가기
		$("#back").on("click", function() {
			window.history.back();
		});
		
 		// 담당자 변경
		$("#memChange").on("click", function() {
			$("#changemem").val('${todoVo.memId }');
			$("#memChangecomment").show();
			$("#mem-select").remove();
		
		});
 		
		$('#todoTitle').keyup(function (e){
            var content = $(this).val();           
            if (content.length > 66){
                alert("최대 66자까지 입력 가능합니다.");
                 $(this).val(content.substring(0, 65));
            }
        });
 	});

</script>
<style type="text/css">
#filelabel{
		display: inline-block;
		width: 100px;
	}
	#fileBtn{
		 display: inline-block;
		 padding-bottom:  .5em;
		 padding-top:  .5em;
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

</style>
</head>

		<%@include file="../layout/contentmenu.jsp"%>
			
		<div class="card card-primary card-outline">
			<div class="card-header">
	                <h3 class="card-title jg">일감 수정</h3>
	        </div>
	        <div class="card-body">
			<form method="post" action="${pageContext.request.contextPath }/todo/updatetodo" id="todoform"  enctype="multipart/form-data">	
		        <div class="form-group">
				<input type="hidden" name="todoId" value="${todoVo.todoId }">
				<label for="todoTitle" class="col-sm-1 control-label ns">제목</label>
				<input  class="ns" type="text" name="todoTitle" style="width: 1000px;" id="todoTitle" value="${todoVo.todoTitle }">
				<div class="jg" style=" padding-left: 10px; display: inline;"><span class="jg warningtodoTitle" style="color : red;"></span></div><br><br>
                
				<div style="width: 80%;">
				<label for="todoCont" class="col-sm-1 control-label ns">할일</label>
				<textarea id="summernote" name="todoCont" id="todoCont">${todoVo.todoCont }</textarea>
				</div>
				<br><br>
				<label for="mem-select" class="col-sm-1 control-label ns">담당자</label>
				<input  class="ns" type="text" id="mem-select" name="memId" value="${todoVo.memId }" readonly="readonly">
				<input  class="ns" type="button" id="memChange" value="인수인계">
                
				<div id="memChangecomment">
				<label for="memChangeComment" class="col-sm-1 control-label ns">인수인계 내용</label>
				<input  class="ns" type="text" id="memChangeComment2" name ="logComment"/>
				<div class="jg" style=" padding-left: 10px; display: inline;"><span class="jg warningmemChangeComment" style="color : red;"></span></div>
                
				<label for="mem-select" class="col-sm-1 control-label ns">변경 담당자</label>
				<select name="memId" id="mem-select2">
				<c:forEach items="${promemList}" var="mem">
					<c:if test="${mem.memId ne todoVo.memId }">
				<option  class="ns" value="${mem.memId}">${mem.memName}</option></c:if>
		 		</c:forEach>
		 		</select>
		 		<div class="jg" style=" padding-left: 10px;"><span class="jg warningmem-select2" style="color : red;"></span></div>
                
				</div>
				<br><br>
				<input type="hidden" name="changemem" id="changemem" />
				<label for="status-select" class="col-sm-1 control-label ns">우선순위</label>
				<select class="ns" name="todoImportance" id="status-select">
				    <c:if test="${todoVo.todoImportance eq 'gen' }">
				    <option class="jg" value="gen">보통</option>
				    <option class="jg" value="emg">긴급</option>
				    </c:if>
				    <c:if test="${todoVo.todoImportance eq 'emg' }">
				    <option class="jg"  value="emg">긴급</option>
				    <option class="jg" value="gen">보통</option>
				    </c:if>
				</select><br><br>
				
				<label for="todoPercent" class="col-sm-1 control-label ns">진행도</label>
				<input class="ns" type="text" id="todoPercent" name="todoPercent" value="${todoVo.todoPercent }" readonly="readonly"/><br><br>
				
				<label for="todoStart" class="col-sm-1 control-label ns">시작 일</label>
				<input class="ns" type='date' id='todoStart' name="todoStart"/>
				<div class="jg" style=" padding-left: 10px; display: inline;"><span class="jg warningtodoStart" style="color : red;"></span></div><br><br>
				<input type="hidden" id='todo_start' value="${todoVo.todoStart}">
                
				<label for="todoEnd" class="col-sm-1 control-label ns">종료 일</label>
				<input class="ns" type='date' id='todoEnd' name="todoEnd"/>
				<div class="jg" style=" padding-left: 10px; display: inline;"><span class="jg warningtodoEnd" style="color : red;"></span></div><br><br>
				<input type="hidden" id='todo_end' value="${todoVo.todoEnd}">
                
				</div>
				
				<div class="form-group">
					<label id ="filelabel" for="files" class="col-sm-2 control-label ns">첨부파일</label>		
					<div id ="file" class="col-sm-10">
					
						<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1">
							<input type="search" name="${files.pubId}" value="${files.pubFilename}" disabled >
		   	   				<button type="button" id="btnMinus" class="btn btn-light filebtn" style="margin-left: 5px; outline: 0; border: 0;">
								<i class="fas fa-fw fa-minus" style=" font-size:10px;"></i> 
							</button><br>
						</c:forEach>								
						
					</div>
					<input type="hidden" id="delfile" name="delfile" value="">	
				</div>
	</form>
	
 <form style="padding-left: 2%;">
		<div id="queue"></div>
			<input id="file_upload" name="file" type="file" multiple="true"/>
		<br><br>
		<div class="float-right" >		
			<input type="button" class="btn btn-default jg" id="updatebtn" value="수정하기">
				<button type="button" class="btn btn-default jg" id="back">뒤로가기</button>
		</div>
	</form>
		</div>
	</div>
</div>	
</html>