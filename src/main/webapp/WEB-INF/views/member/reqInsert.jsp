<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	
	//뒤로가기
	$("#back").on("click", function() {
		window.history.back();
	});
	
	var uploadCnt = 0;
    var QueueCnt = 0;
	
	$(function (){
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
				 if($('#delfile').val()==""){
					insert();
				 }else{
					delfiles();
				 }
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
	    
     	// 작성 버튼 클릭시 요구사항정의서 등록
     	$('.insertbtn').on('click', function(){
     		fn_egov_save();
     	});
	    
		/* 요구사항정의서 목록으로 이동 */
	 	function insert(){
	 			document.location = "/req/reqList";   		
		}
	
		/* 요구사항정의서 등록 function */
	    function fn_egov_save() {
			 $.ajax({
					url : "${registerFlag == 'create' ? '/req/reqInsert' : '/req/reqUpdate' }",
					method : "post",
					data : $('#saveForm').serialize(),
					success : function(data){
						if(${registerFlag eq 'create'}){
							projectInsert(data.reqVo);
						}
						else{
							if($('.uploadifive-queue-item').length>0){
								fileUpload(data.reqVo);
							}else{
								delfiles();
							}
						}
					}
			 });
	    }
		
	  	/* 프로젝트 생성 */
	  	function projectInsert(reqVo){
	  		$.ajax({
				url : "/project/insertProject",
				data : {reqId : reqVo.reqId},
				method : "POST",
				success : function(res){
					if ("success" == res){
						if($('.uploadifive-queue-item').length > 0){
							fileUpload(reqVo);
							// 파일업로드가 끝나면, alert를 띄우고 요구사항정의서 리스트로 돌아간다.
							alert("요구사항 정의서를 작성하였습니다.");
							// 요구사항 정의서 목록으로 돌아가기 ..
							$(location).attr("href" , "/req/reqList");
							
			     		}else{
			     			insert();
			     		}
					}
				}
			});
	  	} //projectInsert
	 
	  	/* 파일 업로드 */
	 	function fileUpload(reqVo){
	 		var reqId = reqVo.reqId;
	 		var someId = reqVo.reqId;
	 		
	 		$('#file_upload').data('uploadifive').settings.formData = { 'reqId' : reqId , 'someId' : someId , 'categoryId' : '7' };
	 		$('#file_upload').uploadifive('upload');
	 	}
	  	
	 	/* 파일 삭제버튼 클릭 */
		$(document).on("click", "#btnMinus", function(){
				var id = $(this).prev().attr('name')
				$('#delfile').append(id + ",");
				
				var a = $('#delfile').text();
				$('#delfile').val(a);
				
				$(this).prev().prev().remove();
	     	    $(this).prev().remove();
	     	    $(this).remove();
	       	    
	     });

		/* 파일삭제 */ 
		function delfiles(){
			console.log($('#delfile').val());
		 	$.ajax({url :"${pageContext.request.contextPath}/file/delfiles",
		 			 data : {delfile : $('#delfile').val() },
					 method : "post",
					 success :function(data){
						 insert();
					 }
			 });
		}
	
}); //document.ready
	
	
	
	 
	
	function initData(){
		$('#reqTitle').val("텀블러 자동세척기 개발");
		$('#memId').val("pm1");
		$('#summernote').val("위잉위잉 자동세척해주는 기계개발사업입니다.");
		$('#reqPeriod').val("30");
	}
	
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
	                  	</div>
		            </div>
		            <!-- /.card-header -->
		            <div class="card-body">
		              <div class="form-group row col-md-2">
		                  <label>기간 (days):</label>
		
		                  <div class="input-group">
		                    <div class="input-group-prepend">
		                      <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
		                    </div>
		                    <form:input path="reqPeriod"  class="form-control" id="reqPeriod" placeholder="60일이면 60만 적으세요."/>
		                  </div>
		                  <!-- /.input group -->
		               </div>
		              <div class="row col-md-2">
		                  <label>내용 :</label>
		              </div>
		              <form:textarea path="reqCont" id="summernote" style="display: none;"/>
		              <!-- 파일첨부 -->
					</div>
				</form:form>
				<c:if test="${registerFlag == 'modify' }">
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
				</c:if>
				
				
				
				<form>
					<div style="padding-left: 20px;">
						<label  for="file" class="col-sm-2 control-label">첨부파일</label>
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
					       <a href="#" class="btn btn-secondary" id="back">취소</a>
					       <c:choose>
						       	<c:when test="${registerFlag == 'modify' }">
						       		<button class="btn btn-success float-right insertbtn">수정</button>
						       	</c:when>
						       	<c:when test="${registerFlag == 'create' }">
						       		<button class="btn btn-success float-right insertbtn">저장</button>
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
