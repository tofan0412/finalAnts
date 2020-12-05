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
		  
		// 모달창 열기
		$("#myBtn").click(function(){
		    $("#myModal").modal();
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
	    	   var html = '<br><input multiple="multiple" type="file" name="privFilepath" id="fileBtn">'
	    	   				+'<button type="button" id="btnMinus" class="btn btn-light filebtn" style="margin-left: 5px; outline: 0; border: 0;">'
								+'<i class="fas fa-fw fa-minus" style=" font-size:10px;"></i>'
							+'</button>';
	    	   $(this).next().next().append(html);  
	    	   
	    	   if(fileSlotCnt >= maxFileSlot){
	    		   $(this).hide();
 	    		   alert("한번에 등록 가능한 파일은 "+maxFileSlot+"개 까지만 등록가능합니다.");
	    	   }
    	   
     	 })
     	 
     	 
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
		document.listForm.action = "<c:url value='/privatefile/privatefileList'/>";
	   	document.listForm.submit();
	}
	 function search(){
		document.listForm.action = "<c:url value='/privatefile/privatefileList'/>";
		document.listForm.submit();
	}
	 		
			
	 
</script>

</head>
<body>
	개인 파일함
<%@include file="../layout/contentmenu.jsp"%>

	
	 
	<form:form commandName="privatefileVo" id="listForm" name="listForm" method="post">
	<div style="padding-left: 30px; background-color: white;">
		<c:if test="${SMEMBER.memId ne null}">
		<%-- href="${pageContext.request.contextPath }/privatefile/privateInsert" --%>
		<!-- <a class="btn btn-default" id="myBtn" ><i class="fas fa-edit"></i>파일 등록</a> --></c:if>
	
		<form>
		<div id="queue">파일을 등록하려면 파일을 끌어다 놓으세요</div>
		<div class="content" style="display: none">
		<input id="file_upload" name="file" type="file" multiple="true"/>
		</div>
		<!-- <input id="submit" type="button" onClick="javascript:$('#file_upload').uploadifive('upload')" value="제출"/> -->
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
		
		
		
		
														<!-- 파일등록 -->
	<div class="container">

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-lg">

					<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<h5>파일등록</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
			<form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/privatefile/privateInsert" id="todoform">
						<div class="panel-group" id="accordion">
						 
							<div class="form-group">
								<label for="file" class="col-sm-2 control-label">파일추가</label>
								<button type="button" id="addbtn" class="btn btn-light filebtn" style="outline: 0; border: 0;">
									<i class="fas fa-fw fa-plus" style=" font-size:10px;"></i>
								</button> <br>
								
								<div id ="filediv" class="col-sm-10">
									<input  type="file" name="privFilepath" id="fileBtn"/>	
								</div>
							</div>
								<hr>
								
					<input type="submit" id="subBtn" class="btn btn-light filebtn" style="outline: 0; border: 0; float:right;" value="등록">

						</div>
			</form>
					</div>
				</div>

			</div>
		</div>
	</div>		
		
<%-- 							파일 버튼 추가 제거 버전
		
	<div class="container">

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-lg">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<h5>파일등록</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
			<form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/privatefile/privateInsert" id="todoform">
						<div class="panel-group" id="accordion">
						 
							<div class="form-group">
								<label for="file" class="col-sm-2 control-label">파일추가</label>
								<button type="button" id="addbtn" class="btn btn-light filebtn" style="outline: 0; border: 0;">
									<i class="fas fa-fw fa-plus" style=" font-size:10px;"></i>
								</button> <br>
								
								<div id ="filediv" class="col-sm-10">
									<input  type="file" name="privFilepath" id="fileBtn"/>	
								</div>
							</div>
								<hr>
								
					<input type="submit" id="subBtn" class="btn btn-light filebtn" style="outline: 0; border: 0; float:right;" value="등록">

						</div>
			</form>
					</div>
				</div>

			</div>
		</div>
	</div>	
		
		 --%>
		
</body>
</html>