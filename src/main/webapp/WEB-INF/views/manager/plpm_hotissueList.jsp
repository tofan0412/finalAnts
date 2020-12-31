<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">


<script type="text/javascript">
$(document).ready(function(){

	
	$("#pagenum a").addClass("page-link");  
	
	$("#hissueInsert").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/hotIssue/hissueInsertView');
	})
	
	$("#filesview").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/hotissueFile/hotissuefileview');
	})
	
});

	

	// 페이징처리
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/hotIssue/hissueList'/>";
	   	document.listForm.submit();
	}
	
	
	// 검색
	function search(){
		document.listForm.pageIndex.value = 1;
		document.listForm.action = "<c:url value='/hotIssue/hissueList'/>";
		document.listForm.submit();
	}

</script>
<style type="text/css"> 
#HotIssueVoTable{
	width : 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    text-align: center;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }

	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 width : auto;	 
		 border: none; 
	
	}
	
	li strong{
		display: inline-block;
		text-align: center;
		width: 30px;
	}
	
	.pagingui{
		 display: inline-block;
		 text-align: center;
		 width: 30px;
		 
	}
	#paging{
		 display: inline-block;
		 width:auto; float:left; margin:0 auto; text-align:center;
		 
	}
	body{
  		min-width: 630px;
    }
	

</style>
</head>
<body>
	<%@include file="../layout/contentmenu.jsp"%>
	<form:form commandName="hotIssueVo" id="listForm" name="listForm" method="post">
	<div class="col-12 col-sm-12">
	<div class="card" style="border-radius: inherit; padding : 2px;">
	<div>
	
	</div>
	<form:hidden path="hissueParentid" ></form:hidden>
		<br>
		    <div class="card-header">
		    	<div id="keyword" class="card-tools float-left" style="width: 450px;">
						<h3 class="jg" style="padding-left: 10px; display: inline-block;">PM-PL이슈 리스트</h3> &nbsp;&nbsp;&nbsp;
						<button id="hissueInsert" type="button" class="btn btn-default jg"><i class="fas fa-edit"></i>이슈 작성</button>
						<button id="filesview" type="button" class="btn btn-default jg"><i class="nav-icon fas fa-folder-open"></i>파일함</button>
				</div>
		    
				<div id="keyword" class="card-tools float-right jg" style="width: 550px;">
					<div class="input-group row">						
        				<form:select path="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">
        				
							<form:option value="1" label="작성자"/>
							<form:option value="2" label="제목"/>
							<form:option value="3" label="내용"/>
						</form:select> 
							<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                        <input type="text" class="form-control jg" name="searchKeyword" value="${hotIssueVo.searchKeyword }">
	                        <span class="input-group-append">							
								<button class="btn btn-default" type="button" id="searchBtn" onclick="search()" >
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
		                
					</div>
		        </div>
		      </div>
		<div class="card-body p-0">
		<table id="HotIssueVoTable" class="jg">
			<tr>
				<th style="padding-left: 10px;">No.</th>
				<th >제목</th>
				<th>작성일</th>
				<th>작성자</th>
			</tr>
			<tbody id="hotIssueList">
				<c:forEach items="${hotIssueList }" var="hotissue" varStatus="sts" >
				    <tr>
					<td><c:out value="${paginationInfo.totalRecordCount - ((hotIssueVo.pageIndex-1) * hotIssueVo.pageUnit + sts.index)}"/>. 
					</td>			
					<c:if test="${hotissue.hissueParentid ne null}">
					<td style="text-align: left; padding-left: 9%;">
					<a href="${pageContext.request.contextPath}/hotIssue/hissueDetailView?hissueId=${hotissue.hissueId}"> 
					<span style="color: gray;">답글 : </span>&nbsp;
					<c:if test="${fn:length(hotissue.hissueTitle) > 25}">									
						${fn:substring(hotissue.hissueTitle,0 ,25) }...
					</c:if>
					<c:if test="${fn:length(hotissue.hissueTitle) <= 25}">									
						${hotissue.hissueTitle}
					</c:if>
					</a> 
					</td>
					</c:if>
					<c:if test="${hotissue.hissueParentid eq null}">
					<td style="text-align: left; padding-left: 9%;">
					<a href="${pageContext.request.contextPath}/hotIssue/hissueDetailView?hissueId=${hotissue.hissueId}"> 
					<c:if test="${fn:length(hotissue.hissueTitle) > 30}">
						${fn:substring(hotissue.hissueTitle,0 ,30) }...
					</c:if>
					<c:if test="${fn:length(hotissue.hissueTitle) <= 30}">									
						${hotissue.hissueTitle}
					</c:if>
					</a> 
					</td>
					</c:if>
					<td>${hotissue.regDt}</td>
					<td>${hotissue.writer}</td>
					</tr>
				</c:forEach>
				<c:if test="${hotIssueList.size() == 0}">
				<td colspan="4" style="text-align: center;"  class="jg"><br> [ 결과가 없습니다. ] </td>
				</c:if>
			</tbody>
		</table>
		</div>
	  <br>
	              <div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm jg" id ="pagingui">
		        		<li  class="page-item jg" id ="pagenum" >	
		        		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
		        		<form:hidden path="pageIndex" />		        		
                    
	                 </ul>
        		  </div>
        		  <br>
	          
           </div>
       </div>
</form:form>		
</body>
</html>