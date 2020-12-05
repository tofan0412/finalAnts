<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
.uploadifive-button {
	float: left;
	margin-right: 10px;
}
#queue {
	border: 1px solid blue;
	height: 177px;
	overflow: auto;
	margin-bottom: 10px;
	padding: 0 3px 3px;
	width: 98%;
	text-align: center;
	color: lightgray;
	line-height: 170px;
}
#todoTable{
	width : 1300px;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  

</style>
<script type="text/javascript">
	$(document).ready(function(){
		
	/* 	
		$("#privatefileList tr").on("click",function(){
			var privId = $(this).data("privid");
	 		$(location).attr('href', '${pageContext.request.contextPath}/privatefile/privateSelect?privId='+privId);
			});
	 	
		  */
     	 
     	// 드래그앤 드랍 파일등록 
 		$(function() {
			$('#file_upload').uploadifive({
				'uploadScript'     : '/privatefile/privateInsert',
				'fileObjName'     : 'file',    
				'auto'             : true,
				'queueID'          : 'queue',
				'onUploadComplete' : function(file, data) { 
					
					console.log(data); 
					location.reload();	// 페이지 새로고침
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
	개인 파일함
<%@include file="../layout/contentmenu.jsp"%>

	<form:form commandName="privatefileVo" id="listForm" name="listForm" method="post">
	<div style="padding-left: 30px; background-color: white;">
		<c:if test="${SMEMBER.memId ne null}"></c:if>
	
		<!-- 파일등록  -->
		<form>
		<div id="queue">파일을 등록하려면 파일을 끌어다 놓으세요</div>
		<div class="content" style="display: none">
		<input id="file_upload" name="file" type="file" multiple="true"/>
		</div>
		</form>
		
		<br>
		    <div class="card-header with-border">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">						
        				<select name="searchCondition" class="form-control col-md-3" style="width: 100px;">
							<option value="1" label="파일명"/>
							<option value="2" label="날짜"/>
						</select> 
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
		<table id="todoTable">
			<tr>
				<th>No.</th>
				<th>파일경로</th>
				<th>파일이름</th>
				<th>수정한 날짜</th>
				<th>파일사이즈</th>
				<th>작성자</th>
				<th>다운로드</th>
				<th>삭제</th>
			</tr>
			<tbody id="privatefileList">
				<c:forEach items="${privatefileList}" var="privatefile" varStatus="sts" >
				    <tr data-privid="${privatefile.privId}">
					<td><c:out value="${paginationInfo.totalRecordCount - ((privatefileVo.pageIndex-1) * privatefileVo.pageUnit + sts.index)}"/>. 
						<input type="hidden" id="${privatefile.privId }" name="${privatefile.privId }">
					</td>	
					<td>
						${privatefile.privFilepath}
					</td>
					<td>
						${privatefile.privFilename }
					</td>
					<td>
						${privatefile.regDt }
					</td>
					<td>
						${privatefile.privSize }
					</td>
					<td>
						${privatefile.memId }
					</td>
					<td>
						<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
						<input type="button" value="다운로드"/>
						</a>
					</td>
					<td>
						<a href="/privatefile/privatefileDelete?privId=${privatefile.privId}">
						<input type="button" value="삭제"/>
						</a>
					</td>
					</tr>
					
				</c:forEach> 
			</tbody>
		</table>
		 
		<div id="paging" class="card-tools">
		    <ul class="pagination pagination-sm float-right">
		   		<li class="page-item"><a class="page-link" href="#">«</a></li>
				<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page"  />
				<form:hidden path="pageIndex" />
			    <li class="page-item"><a class="page-link" href="#">»</a></li>
		    </ul>
        </div>
	</div>
		</form:form>	
</body>
</html>