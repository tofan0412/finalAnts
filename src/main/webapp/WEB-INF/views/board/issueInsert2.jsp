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
		        ],
				  minHeight: null,             				// 최소 높이
				  maxHeight: null,             				// 최대 높이
				  focus: true,                  			// 에디터 로딩후 포커스를 맞출지 여부
				  lang: "ko-KR",							// 한글 설정
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
// 				alert('취소')
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
//      	$('#insertbtn').on('click', function(){
//      		// 업로드할 파일이 존재하지 않을시
//      		if($('.uploadifive-queue-item').length ==0){    			
//      			if($('#kindselect').val() == 'issue'){
//      	     		if($('#issueTitle').val() != ''){		     	     		
//      					$('#todoselect').val() != '' ? $('#frm').submit() : alert('선택해주세요');	    					    			
//      				}
//      			}else if($('#kindselect').val() == 'notice'){
//      				if($('#issueTitle').val() != ''){					
//      					$('#frm').submit();
//      				}
//      			}	
//      		// 업드로할 파일이 존재할 시
//      		}else{
//      			$('#file_upload').uploadifive('upload');
//      		}	
//      	})     	
     	// 업로드된 파일의 수와 사용자가 올린 파일의 수가 같을 시 from 전송
     	function insert(){
     		if(uploadCnt == $('.uploadifive-queue-item').length){
     			$('#frm').submit();     		

        	}else{
        	}

    	}
     	
     	
     	
	     // 제목 글자수 계산
	   	$('#issueTitle').keyup(function (e){
	   	    var content = $(this).val();   		
	   		if (content.length > 66){
	   	        alert("최대 66자까지 입력 가능합니다.");
	   	     	$(this).val(content.substring(0, 65));
	   	    }
	   	});
     	
     	
     	
     	// 이슈/공지사항 선택시
     	$('#kindselect').on('change',function(){
     		if($('#kindselect').val() !='issue'){
     			$('.warningTodo').text(""); 			
     		}
     	
     	})
     	
    	
     	// 작성 버튼 클릭시 파일 업로드 호출
     	$('#insertbtn').on('click', function(){		
     		cnt = 0;
     		
			// 각 칸이 빈칸인지 아닌지를 확인해야 한다.
			if ($('#kindselect').val() != 'issue' && $('#kindselect').val() != 'notice' ){
				$('.warningKind').text("종류를 선택해 주세요.");
				cnt++;
			}else{
				$('.warningKind').text("");
			}
			
			
			if ($('#issueTitle').val().length == 0){
				$('.warningTitle').text("제목을 작성해 주세요.");
				cnt++;
			}else{
				$('.warningTitle').text("");
			}
			
     		if($('#kindselect').val() =='issue'){
				if ($('#todoselect').val()==''){
					$('.warningTodo').text("일감을 선택해 주세요.");
					cnt++;
				}else{
					$('.warningTodo').text("");
				}
     		}
     		
			if (cnt == 0){				
				if($('.uploadifive-queue-item').length ==0){ //첨부파일이 하나도 없을시
					$('#frm').submit();
				}else{
	     			$('#file_upload').uploadifive('upload'); // 첨부파일이 존재할시
	     		}
			}
     	})
      
 	})
 	

 	
 	// 로그인한 사람의 todolist출력
 	function mytodolist(){
	 	$.ajax({url :"${pageContext.request.contextPath}/projectMember/mytodolist",
				 method : "get",
				 success :function(data){	
					 console.log(data.todolist)
					
					 
					 html  =  '<label for="todoId" class="col-sm-2 control-label jg">일감 </label>'
				     html +=  '<select name="todoId" id="todoselect"  class ="col-sm-4 form-control" style="display: inline-block;" required>'		
				     html +=  '<option value="">선택</option>'
				   
				     for( i = 0 ; i< data.todolist.length; i++){		
					     html +=  '	 <option value='+data.todolist[i].todoId+'>'+data.todolist[i].todoTitle+'</option>'	
				     }
				     html +=  '	</select>'
				     
				     
				    	
				     
				     $("#todolist").html(html);
				 }
		 	})
	}
	
	
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
	


</style>
</head>
<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
	  <div class="card-body">
		<div style="padding-left: 30px;">
			<h3 class="jg">협업이슈 작성하기</h3>
			<br>
			<form id="frm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/projectMember/insertissue"   >	
				
			<input type="hidden" name="issueId" value="${issueSeq }">
			
			 <div class="form-group">
					<label for="issueKind" class="col-sm-2 control-label jg">이슈종류</label> 
					<select name="issueKind" id="kindselect" class ="col-sm-3 form-control" style="display:inline-block; width: 200px;" required>
					    <option value="">선택</option>
					    <option  value="issue">이슈</option>
					    <option  value="notice">공지사항</option>
					</select>
				</div>
				<div class="jg" style=" padding-left: 10px;"><span class="jg warningKind" style="color : red;"></span></div>
				
				<div class="form-group" id="todolist">

				</div>
				 <div class="jg" style=" padding-left: 10px;"><span class="jg warningTodo" style="color : red;"></span></div>
				
				<div class="form-group">
					<label for="issueTitle" class="col-sm-2 control-label jg">이슈제목</label>
					<input class="form-control" type="text" name="issueTitle" style="display:inline-block; width: 70%;" id="issueTitle" required>
				<div class="jg" style=" padding-left: 10px;"><span class="jg warningTitle" style="color : red;"></span></div>
				</div>
				
				<div class="form-group" style="width: 90%;">
					<label for="issueCont" class="col-sm-2 control-label jg">이슈 내용</label>
					<textarea  id="summernote" name="issueCont" id="issueCont"></textarea>
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