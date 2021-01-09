<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="registerFlag" value="${empty reqVo.reqId ? 'create' : 'modify'}"/>

<link rel="stylesheet" href="/plugins/summernote/summernote-bs4.min.css">
<script src="/plugins/summernote/summernote-bs4.min.js"></script>
<script src="/plugins/summernote/lang/summernote-ko-KR.js"></script>
<script src="/resources/upload/jquery.uploadifive.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/resources/upload/uploadifive.css">
<style>
 	input[type=search]{
		display : inline-block;
		border: none; 
		background: transparent;
		padding-bottom:  .5em;
		padding-top:  .5em;
		width: 350px;
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
	#reqPeriod{
		width: 200px;
	}
}

</style>
<script>
	
toastr.options = {
		  "closeButton": false,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": false,
		  "positionClass": "toast-top-center",
		  "preventDuplicates": true,
		  "onclick": null,
		  "showDuration": "300",
		  "hideDuration": "1000",
		  "timeOut": "5000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		}
	function checkInputNum(){
		if ((event.keyCode < 48) || (event.keyCode > 57)){
	          event.returnValue = false;
	      }
	  }
	
	var uploadCnt = 0;
    var QueueCnt = 0;
	
	$(function (){
		$('#reqPeriod').keyup(function(e){
			if (e.keyCode > 57 
					|| e.keyCode < 48
					&& e.keyCode != 8	// Backspace
					&& e.keyCode != 9	// Tab
					&& e.keyCode != 13	// Enter
					&& e.keyCode != 16	// shift
					&& e.keyCode != 17	// Ctrl
					&& e.keyCode != 27	// ESC
					&& e.keyCode != 37	// 왼쪽 방향키	
					&& e.keyCode != 38	// 윗 방향키
					&& e.keyCode != 39	// 오른쪽 방향키
					&& e.keyCode != 40	// 아래 방향키
					){
				toastr["warning"]("숫자만 입력할 수 있습니다.");
				$(this).val('');
			} 
		})
		
		reqId2 = "${reqVo.reqId}";
	  	// Summernote
		$('#summernote').summernote({
		  height: 400,                 				// 에디터 높이
		  minHeight: null,             				// 최소 높이
		  maxHeight: null,             				// 최대 높이
		  focus: true,                  			// 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",							// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'		//placeholder 설정
		});
	  	//파일 업로드
		$('#file_upload').uploadifive({
			'uploadScript'     : '/file/insertfile',
			'fileObjName'     : 'file',    
			'formData'         : {
								   'categoryId' : "7"
								   
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
				 reqDetail(reqId2);
				 
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
	  
	    
     	// 작성 버튼 클릭시 요구사항정의서,프로젝트 등록
     	$('#insertbtn').on('click', function(event){
     		cnt = 0;
     		if ($('#reqTitle').val().length == 0 && $('#reqPeriod').val().length == 0){
     			toastr["warning"]("제목, 기간은 필수 입력사항입니다.");
				cnt++;
			}
     		else if ($('#reqPeriod').val().length == 0){
     			toastr["warning"]("기간은 필수 입력사항입니다.");
				cnt++;
			}else if($('#reqTitle').val().length == 0){
     			toastr["warning"]("제목은 필수 입력사항입니다.");
				cnt++;
				
			}
     		if(cnt == 0){
     			$.ajax({
						url : "/req/reqInsert",
						method : "post",
						data : $('#saveForm').serialize(),
						dataType : 'json', 
						success : function(data){
								if($('.uploadifive-queue-item').length>0){
									reqId2 = data.reqVo.reqId;
									fileUpload(data.reqVo);
								}else{
									reqDetail(data.reqVo.reqId);
								}
						},
						error:function(request,status,error){
							document.location = "/req/reqList";
					    }
				 });
				 event.preventDefault();	     	
        	}
     		
     	});
     	// 수정 버튼 클릭시 요구사항정의서 수정
     	$('#updatebtn').on('click', function(event){
     		cnt = 0;
     		if ($('#reqTitle').val().length == 0){
				$('.warningreqTitle').text("제목을 입력해 주세요.");  
				cnt++;
			}
     		if ($('#reqPeriod').val().length == 0){
				$('.warningreqPeriod').text("기간을 입력해 주세요.");  
				cnt++;
			}
     		if(cnt == 0){
				 $.ajax({
						url : "/req/reqUpdate",
						method : "post",
						data : $('#saveForm').serialize(),
						dataType : 'json', 
						success : function(data){
							var delfile = $('#delfile').val();
							//삭제할 파일 존재하면
							if(delfile != null && delfile != ''){
								delfiles(data.reqVo);
							 }else{
								//삭제없고 업로드파일만 있으면
								if($('.uploadifive-queue-item').length>0){
									fileUpload(data.reqVo);
								}else{
									reqDetail(data.reqVo.reqId);
								}
							 }
						},
						error:function(request,status,error){
					        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					       }
				 });
				 event.preventDefault();
     		}
     	});
	    
	
		
	  	/* 파일 업로드 */
	 	function fileUpload(reqVo){
	 		var reqId = reqVo.reqId;
	 		var someId = reqVo.reqId;
	 		
	 		$('#file_upload').data('uploadifive').settings.formData = { 'reqId' : reqId , 'someId' : someId , 'categoryId' : '7' };
	 		$('#file_upload').uploadifive('upload');
	 	}
	  	
	 	/* 파일 삭제버튼 클릭 */
		$(document).on("click", "#btnMinus", function(event){
				var id = $(this).prev().attr('name')
				$('#delfile').append(id + ",");
				
				var a = $('#delfile').text();
				$('#delfile').val(a);
				
				$(this).prev().prev().remove();
	     	    $(this).prev().remove();
	     	    $(this).remove();
	     	   event.preventDefault();
	     });
	 	
		/* 파일삭제 */ 
		function delfiles(reqVo){
			console.log($('#delfile').val());
		 	$.ajax({url :"${pageContext.request.contextPath}/file/delfiles",
		 			 data : {delfile : $('#delfile').val() },
					 method : "post",
					 success :function(data){
						//삭제하고 업로드파일 있으면
						if($('.uploadifive-queue-item').length>0){
							fileUpload(reqVo);
						}else{
							reqDetail(reqVo.reqId);
						}
					 }
			 });
		}

	/* 요구사항정의서 목록으로 이동 */
	function reqDetail(reqId){
			document.location = "/req/reqDetail?reqId="+reqId;   		
	}
		
}); //document.ready
	
	
	
</script>
</head>


<title>협업관리프로젝트</title>
	<section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
          	<c:if test="${registerFlag == 'create' }"><h1>요구사항 정의서 등록</h1></c:if>
          	<c:if test="${registerFlag == 'modify' }"><h1>요구사항 정의서 수정</h1></c:if>
            
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Text Editors</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
		<div class="row" style="padding-left: 20px; padding-right:20px;">
	        <div class="col-md-12">
	          <div class="card card-outline card-info">
				<form:form commandName="reqVo" id="saveForm" name="saveForm">
		            <div class="card-header">
		                 <div class="form-group row col-md-6">
		                    <label for="inputEmail3" class="col-sm-2 col-form-label">제 목</label>
		                    <div class="col-sm-10">
		                      <form:input path="reqTitle" id="reqTitle" placeholder="제목을 입력하세요" class="form-control"/>
		                      <form:hidden path="reqId" />
		                	</div>
		                      <div class="jg" style=" padding-left: 10px;"><span class="jg warningreqTitle" style="color : red;"></span></div>
	                  	</div>
		            </div>
		            <!-- /.card-header -->
		            <div class="card-body">
		              <div class="form-group row col-md-2">
		                  <label>기간 (days):</label>
		
		                  <div class="input-group">
		                    <div class="input-group-prepend">
		                      <span class="input-group-text"><i class="far fa-clock"></i></span>
		                    </div>
		                    <form:input path="reqPeriod"  class="form-control" id="reqPeriod" placeholder="60일이면 60만 적으세요." onkeyPress="javascript:checkInputNum();"/><br>
		                  </div>
		                  <!-- /.input group -->
		               </div>
		                  <div class="jg" style=" padding-left: 10px;"><span class="jg warningreqPeriod" style="color : red;"></span></div><br>
		              <div class="row col-md-2">
		                  <label>내용 :</label>
		              </div>
		              <form:textarea path="reqCont" id="summernote" style="display: none;"/>
		              <!-- 파일첨부 -->
					</div>
				</form:form>
				<c:if test="${registerFlag == 'modify' }">
					<div class="form-group" style="padding-left: 15px;">
						<label id ="filelabel" for="files" class="col-sm-2 control-label">첨부파일</label>		
						<div id ="file" class="col-sm-10">
						
							<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1">
							<img name="link" src="/fileFormat/${fn:toLowerCase(files.pubExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
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
				</c:if>
				
				
				
				<form>
					<div style="padding-left: 20px;">
						<c:if test="${registerFlag == 'create' }">
							<label  for="file" class="col-sm-2 control-label">첨부파일</label>
						</c:if>
						<div id="queue">
							<div id ="dragdiv" class="jg"><img src="/fileFormat/addfile.png" style="width:30px; height:30px;">마우스로 파일을 끌어오세요</div>
						</div>
						<input id="file_upload" name="file" type="file" multiple="true"/>
						
					</div>
					<br><br>
					<input type="hidden" value="7" name="categoryId">
					<input type="hidden" value="${reqVo.reqId }" name="reqId">
					<br>	
					<div class="card-footer">
				     <div class="row">
					     <div class="col-12">
					       <a href="/req/reqList" class="btn btn-secondary" id="back">취소</a>
					       <c:choose>
						       	<c:when test="${registerFlag == 'modify' }">
						       		<input type="button" class="btn btn-success float-right insertbtn" id="updatebtn" value="수정">
						       	</c:when>
						       	<c:when test="${registerFlag == 'create' }">
						       		<input type="button" class="btn btn-success float-right insertbtn" id="insertbtn" value="저장">
						       	</c:when>
					       </c:choose>
					     </div>
					 </div>
	            </div>
					
					
				</form>
	            </div>
	            
	          </div>
	        </div>
	        <!-- /.col-->
	

</body>
</html>
