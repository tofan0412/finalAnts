<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/resources/upload/jquery.min.js" type="text/javascript"></script>
<script src="/resources/upload/jquery.uploadifive.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/resources/upload/uploadifive.css">

<title>Insert title here</title>
<style>
body{
	min-width: 1000px;
	min-height: 1000px;
}
.uploadifive-button {
	float: left;
	margin-right: 10px;
}
#queue {
	border: 1px solid black;
	height: 177px;
	overflow: auto;
	margin-bottom: 10px;
	margin-left: 15px;
	margin-right: 15px;
/* 	padding: 0 3px 3px; */

	width: 98%;
	text-align: center;
	color: lightgray;
	line-height: 170px;
}
#todoTable {
	width: 98%;
	border-top: 1px solid #444444;
	border-collapse: collapse;
	border-bottom: 1px solid #444444;
}
th, td {
	padding: 10px;
	style="border:none;"
}
th{
	border-bottom: 1px solid #444444;
}
.delbtn{
	background-color: white;
	border-radius: 15px;
	padding-left: 10px;
	padding-right: 10px;
	text-align: center;
	border: 1px solid lightblue;
} 
.tooltip-inner {
   min-width: 650px;
    /* If max-width does not work, try using width instead */
   max-width: 650px; 
}

/* .delbtn{
	background-color: red;
	border-radius: 100%;
	text-align: center;
	font-size: 10px;
	font-weight: 900;
	color: white;
	border: 1px solid red;
}  */
</style>


<script type="text/javascript">
	$(document).ready(function(){
		$('#div').hide()
		$(document).tooltip({
			// 툴팁에 title 속성에 html 적용시키기
			content: function() {
		    	return $(this).prop('title');
		    }
		});
     
		// 마우스 올려놨을때
		$("#privatefileList tr").on("mouseenter",function(){
			$(this).css("backgroundColor","#F0F8FF");
			
			  
		/* 	$.ajax({ type: 'GET', 
				url: '/privatefile/privatefileSelect', 
				dataType : 'json',
				data: { "privId" : $(this).data("privid") }, 
				success: function(data){
					alert(data);
					$(this).attr('title', data.privateVo); 
				}
				
			}); //end ajax  */
			 
		});

		// 마우스가 벗어났을때
		$("#privatefileList tr").on("mouseleave",function(){
			$(this).css("backgroundColor","white");
		});  
     	  
		var QueueCnt =0;
     	// 드래그앤 드랍 파일등록 
 		$(function() {
			$('#file_upload').uploadifive({
				'uploadScript'     : '/privatefile/privateInsert',
				'fileObjName'     : 'file',    
				'auto'             : true,
				'queueID'          : 'queue',				
				"fileType": '.gif, .jpg, .png, .jpeg, .bmp, .doc, .ppt, .xls, .xlsx, .docx, .pptx, .zip, .rar, .pdf',
				 "multi": true,
	             "height": 30,
	             "width": 100,
	             "buttonText": "파일찾기",
	             "fileSizeLimit": "20MB",
	             "uploadLimit": 10,
				'onUploadComplete' : function(file, data) { 
					
					console.log(data); 
// 					location.reload();	// 페이지 새로고침
				},
				'onCancel': function (file) {// 파일이 큐에서 취소되거나 제거 될 때 트리거됩니다.					
					QueueCnt--;
					if(QueueCnt == 0){
						$('#dragdiv').show();
					}
				}, 			
				'onAddQueueItem'   : function(file) { // 대기열에 추가되는 각 파일에 대해 트리거됩니다.
					QueueCnt++;
					$('#dragdiv').hide();
				},
				'onClearQueue': function (queue) { // clearQueue 함수 중에 트리거 됨
					
				}
				
			});
		});
		 
	});	
		
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/privatefile/privatefileView'/>";
	   	document.listForm.submit();
	}
	 function search(){
		document.listForm.action = "<c:url value='/privatefile/privatefileView'/>";
		document.listForm.submit();
	}
	 	
	 
</script>

</head>
<body>
<div id="div">
	<%@include file="../layout/contentmenu.jsp"%>
</div>

<form:form commandName="privatefileVo" id="listForm" name="listForm" method="post">
<section class="content" >
  <div class="col-12 col-sm-12">
<!-- 파일등록  -->


    
	      <div class="card" style="border-radius: inherit; padding : 2px;">
	      
	    <div class="container-fluid">
        <div class="row mb-2">
         <br>
          <div class="col-sm-6">
          <br><br>
            <h1 class="jg" style=" padding-left : 10px;">개인 파일함</h1>
          </div>
          <div class="col-sm-6">
          <br>
            <ol class="breadcrumb float-sm-right"  style="background : white">
              <li class="breadcrumb-item san jg"><a href="#">Home</a></li>
              <li class="breadcrumb-item active jg">개인 파일함</li>
            </ol>
          </div>
        </div>
        </div>
        
    <form>
		<div id="queue">
			<div id ="dragdiv" class="jg"><img src="/fileFormat/addfile.png" style="width:30px; height:30px;">마우스로 파일을 끌어오세요</div>
		</div>
		
		<div class="content" style="display: none">
		<input id="file_upload" name="file" type="file" multiple="true"/>
		</div>
	</form>
        
	<div style="padding-left: 30px; background-color: white;">
		<c:if test="${SMEMBER.memId ne null}"></c:if>
	
		<br>
		<div class="float-left">
		    <div class="card-header with-border">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">		
						<form:select path="searchCondition" cssClass="use" class="form-control col-md-3" style="width: 100px;">				
							<form:option value="1" label="날짜"/>
							<form:option value="2" label="파일명"/>
						</form:select> 
							 <label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                         <input type="text" class="form-control" name="searchKeyword" value="${privatefileVo.searchKeyword }">
		                  <a href="javascript:search();">
		                  	<button type="button" class="btn-default" style="height: 100%;">
                               <i class="fa fa-search"></i>
                          	</button>
                          </a>
					</div>
		        </div>
		    </div>
		</div>
		<div class="card-body p-0">
		<table id="todoTable">
			<tr>
				<th width="80px">No.</th> 
				<th style="padding-left:45px;">파일명</th>
				<th></th>  
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th width="200px">수정한 날짜</th>
				<th width="200px">파일사이즈</th>
				<th width="110px" style="padding-left:20px;">삭제</th>
			
			</tr> 
			<tbody id="privatefileList"> 
				<c:forEach items="${privatefileList}" var="privatefile" varStatus="sts" >
						
						<c:set var="orginalName" value="${privatefile.privFilename}"/>
						<c:set var="nameLength" value="${fn:length(orginalName)}"/>
						<c:set var="cutName" value="${fn:substring(orginalName, nameLength-5, nameLength)}"/>
						<c:set var="filename" value="${fn:substringAfter(cutName,'.')}"/>
						
				    <tr "data-privid="${privatefile.privId}" title="시퀸스 : ${privatefile.privId} <br>
																	수정한 날짜: ${privatefile.regDt } <br>
																	파일이름 : ${privatefile.privFilename } <br>
																	파일경로 : ${privatefile.privFilepath} <br>
																	파일사이즈 : ${privatefile.privSize } KB<br>
																	확장자: ${filename} <br>
																	작성자 : ${privatefile.memId} <br>
																	">
					<td><c:out value="${paginationInfo.totalRecordCount - ((privatefileVo.pageIndex-1) * privatefileVo.pageUnit + sts.index)}"/>. 
						<input type="hidden" id="${privatefile.privId }" name="${privatefile.privId }">
					</td>	
					<td>
						
						<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
							<img name="link" src="/fileFormat/${fn:toLowerCase(filename)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
							${privatefile.privFilename }
						</a>
 
					</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					
					<td > 
						${privatefile.regDt }
					</td>
					<td style="padding-left:23px;"> 
						${privatefile.privSize } KB
					</td>
					<%-- <td>
						<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
						<input type="button" value="다운로드"/>
						</a>
					</td> --%>
					<td>
						<a href="/privatefile/privatefileDelete?privId=${privatefile.privId}">
						<input type="button" class="delbtn" value="삭제"/>
						</a>
					</td>
					</tr>
					
				</c:forEach> 
			</tbody>
		</table>
		</div>  
		  
		<div id="paging" class="card-tools" style="padding-right:2%">
		    <ul class="pagination pagination-sm float-right">
		   		<li class="page-item"><a class="page-link" href="#">«</a></li>
				<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page"  />
				<form:hidden path="pageIndex" />
			    <li class="page-item"><a class="page-link" href="#">»</a></li>
		    </ul>
        </div>
	</div>
</div>

</div>

</section>
</form:form>	


</body>
</html>