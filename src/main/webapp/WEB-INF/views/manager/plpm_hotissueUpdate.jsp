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
<link rel="stylesheet" href="/plugins/summernote/summernote-bs4.min.css">
<script src="/plugins/summernote/summernote-bs4.min.js"></script>
<script src="/plugins/summernote/lang/summernote-ko-KR.js"></script>
<script src="/resources/upload/jquery.uploadifive.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/resources/upload/uploadifive.css">
	
<script type="text/javascript">
	$(document).ready(function(){
		
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
	        ]	      
	 })
	 	
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
	    
	    var QueueCnt = 0;
	    var uploadCnt = 0;
     	//파일 업로드
     	$('#file_upload').uploadifive({
			'uploadScript'     : '/hotissueFile/insertHotissueFile',
			'fileObjName'     : 'file',    
			'formData'         : {
									'hissueId'     : '${hotIssueVo.hissueId}'
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
     		cnt = 0;
     		if ($('#hissueTitle').val().length == 0){
				$('.warninghissueTitle').text("제목을 작성해 주세요.");  
				cnt++;
     		}else{
				$('.warninghissueTitle').text('');
			}
     		if(cnt == 0){
        		 delfiles();	     	
        	}
     	})
     	
     	// 업로드된 파일의 수와 사용자가 올린 파일의 수가 같을 시 from 전송
     	function insertcheck(){
     		if(uploadCnt == $('.uploadifive-queue-item').length){
     			$("#hissueform").submit();
        	}
    	}
	      
	
	// 삭제할 파일 
	function delfiles(){
		console.log($('#delfile').val());
	 	$.ajax({url :"${pageContext.request.contextPath}/hotissueFile/delhotfiles",
	 			 data : {delfile : $('#delfile').val() },
				 method : "post",
				 success :function(data){	
					 
					// 업로드할 파일이 존재하지 않을시 update전송
		     		if($('.uploadifive-queue-item').length ==0){    	
		     			$("#hissueform").submit();
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
	 	
		// 제목 글자수 계산
        $('#hissueTitle').keyup(function (e){
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
	#dragdiv {
		text-align: center;
		color: darkgray;
		line-height: 170px;
	}
	input[type=search]{
		display : inline-block;
		border: none; 
		background: transparent;
		 padding-bottom:  .5em;
		 padding-top:  .5em;
		 width: 350px;
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
				<form method="post" action="${pageContext.request.contextPath }/hotIssue/updatehissue" id="hissueform"  >    
                <div class="form-group">
                  <input class="form-control" name="hissueTitle" value="${hotIssueVo.hissueTitle }" id="hissueTitle">
                  <div class="jg" style=" padding-left: 10px;"><span class="jg warninghissueTitle" style="color : red;"></span></div><br>
                  <input type="hidden" name="writer" value="${SMEMBER.memId }">
                  <input type="hidden" name="hissueParentid" value="${hissueP }">
                  <input type="hidden" name="hissueId" value="${hotIssueVo.hissueId }">
                </div>
                <div class="form-group">
                <textarea id="summernote" name="hissuetCont">${hotIssueVo.hissuetCont }</textarea>
                </div>
               
               <div class="form-group">
					<label id ="filelabel" for="files" class="col-sm-2 control-label ns">첨부파일</label>		
					<div id ="file" class="col-sm-10" style="padding-left: 20px;">
						<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1">
							<input class="jg" type="search" name="${files.hissuefId}" value="${files.hissuefFilename}" disabled >
		   	   				<button type="button" id="btnMinus" class="btn btn-light filebtn" style="margin-left: 5px; outline: 0; border: 0;">
								<i class="fas fa-fw fa-minus" style=" font-size:10px;"></i> 
							</button><br>
						</c:forEach>								
					</div>
					<input type="hidden" id="delfile" name="delfile" value="">	
				</div>
        </form>
		
 <form style="padding-left: 1%; padding-right: 1%;">
		<div id="queue">			
					<div id ="dragdiv" class="jg"><img src="/fileFormat/addfile.png" style="width:30px; height:30px;">마우스로 파일을 끌어오세요</div>
				</div>
			<input id="file_upload" name="file" type="file" multiple="true"/>
		<br><br>
		<div class="card-footer" >		
			<input type="button" class="btn btn-default jg float-left" id="updatebtn" value="수정완료">
			<button type="button" class="btn btn-default jg float-right" id="back">취소</button>
		</div>
	</form>
		</div>
	</div>
</div>	
</html>