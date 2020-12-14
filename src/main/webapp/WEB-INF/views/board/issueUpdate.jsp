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
		          ['para', ['ul', 'ol']],
		          ['table', ['table']],
		          ['insert', ['link', 'picture']],
		          ['view', [ 'help']]
		        ]	      
		})
		
		if('${issueVo.issueKind }' == 'issue'){
			$("#kindselect").val('이슈')
			mytodolist();		
		}else{
			$("#kindselect").val('공지사항')
		}
		
		 
		
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
	    var QueueCnt = 0;
     	//파일 업로드
     	$('#file_upload').uploadifive({
			'uploadScript'     : '/file/insertfile',
			'fileObjName'     : 'file',    
			'formData'         : {
								   'categoryId' : "3",
								   'someId'     : '${issueVo.issueId }'
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
     	
     	
     	// 업데이트 버튼 클릭시 파일 삭제 호출
     	$('#updatebtn').on('click', function(){
     		 delfiles();	     	
     	})
     	
     	// 업로드된 파일의 수와 사용자가 올린 파일의 수가 같을 시 from 전송
     	function insertcheck(){
     		if(uploadCnt == $('.uploadifive-queue-item').length){
     			$('#updateform').submit();     		

        	}

    	}
	      
 	});
	
	
	
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
		     			 $('#updateform').submit();	    					    					     			
		     		// 업로드할 파일이 존재시 파일 등록 호출
		     		}else{
		     			$('#file_upload').uploadifive('upload');
		     		}
		     		
				 }
		 	})
	}
	
	
	
	
	
	// 내 일감 리스트
	function mytodolist(){
	 	$.ajax({url :"${pageContext.request.contextPath}/projectMember/mytodolist",
				 method : "get",
				 success :function(data){	
					 console.log(data.todolist)
					
					
					 for( i = 0 ; i< data.todolist.length; i++){
						 if(data.todolist[i].todoId == '${issueVo.todoId}'){
							 title = data.todolist[i].todoTitle;
							 id = data.todolist[i].todoId
						 }
					  }
					 
					 html  =  '<label for="todoId" class="col-sm-2 control-label">일감 </label>'
				     html +=  '<select name="todoId" id="todoselect"  class ="col-sm-4" required>'		
				     
					 for( i = 0 ; i< data.todolist.length; i++){
							 html +=  '	<option value='+data.todolist[i].todoId+'>'+data.todolist[i].todoTitle+'</option>'	
				     }
				     html +=  '	</select>'	
				     
				     $("#todolist").html(html);
				     
				     $('#todoselect option').each(function(){
				    		var $this = $(this);	
				    		if($this.val() ==  '${issueVo.todoId}')
				    		$this.prop('selected', 'selected');
				    })
				    
				 }
		 	})
	}
	
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
<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
		<div style="padding-left: 30px;">
			<h3>협업이슈 수정하기</h3>
			<br>
			<form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/projectMember/updateissue" id="updateform"  >	
			
				<div class="form-group" >
					<label for="issueTitle" class="col-sm-2 control-label">이슈종류 </label>
					<input type="text" name="issueKind" id="kindselect" disabled>
				</div>	
				   
				<div class="form-group" id="todolist" >
				
				</div>
					
					
				<div class="form-group" >
				
					<label for="issueTitle" class="col-sm-2 control-label">이슈제목 </label>
					<input type="text" name="issueTitle" style="width: 450px;" value="${issueVo.issueTitle }" id="issueTitle">
					
				</div>
				
				<div class="form-group" style="width: 90%;">
				
					<label for="todoCont" class="col-sm-2 control-label">이슈 내용</label>
					<textarea class="control-label"  id="summernote" name="issueCont" id="issueCont">${issueVo.issueCont }</textarea>
				</div>
				
				
				<div class="form-group">
					<label id ="filelabel" for="files" class="col-sm-2 control-label">첨부파일</label>		
					<div id ="file" class="col-sm-10">
					
						<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1">
							<input type="search" name="${files.pubId}" value="${files.pubFilename}" disabled >
		   	   				<button type="button" id="btnMinus" class="btn btn-light filebtn" style="margin-left: 5px; outline: 0; border: 0;">
								<i class="fas fa-fw fa-minus" style=" font-size:10px;"></i> 
							</button><br>
						</c:forEach>								
						
					</div>
					<input type="hidden" id="delfile" name="delfile" value="">	
					<input type="hidden" value="${issueVo.issueId }" name="issueId">
					<input type="hidden" value="3" name="categoryId" value="${issueVo.categoryId }">
				</div>
		
			</form>
			
			<form>
				<div id="queue">			
					<div id ="dragdiv"><img src="/fileFormat/addfile.png" style="width:30px; height:30px;">마우스로 파일을 끌어오세요</div>
				</div>
				
				<input id="file_upload" name="file" type="file" multiple="true"/>
			
				<br><br>
				<div class="card-footer clearfix " >
					
					<input type="button" class="btn btn-default float-right" id="updatebtn" value="수정하기">
				</div>
				
			</form>
			
			
		</div>
	   </div>
	 </div>      
</div>
</html>