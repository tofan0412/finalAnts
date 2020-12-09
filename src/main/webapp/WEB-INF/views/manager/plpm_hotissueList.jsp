<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	
	// 페이징처리
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/hotIssue/hissueList'/>";
	   	document.listForm.submit();
	}
	
	// 상세 보기
	function hotissueDetail(hissueId){
	   	document.location = "/hotIssue/hissueDetailView?hissueId="+hissueId;
	}
	
	// 답글 작성
	function hotissueInsertChild(hissueId){
		document.listForm.hissueParentid.value = hissueId;
	   	document.listForm.action = "/hotIssue/hissueInsertView";
	   	document.listForm.submit();
	}
	
	// 검색
	function search(){
		document.listForm.action = "<c:url value='/hotIssue/hissueList'/>";
		document.listForm.submit();
	}

</script>
<style type="text/css"> 
#HotIssueVoTable{
	width : 1300px;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }


</style>
</head>
	<%@include file="../layout/contentmenu.jsp"%>
	<div style="background-color: white;">
	<a class="btn btn-default " href="${pageContext.request.contextPath }/hotIssue/hissueInsertView"><i class="fas fa-edit"></i>이슈 작성</a>
	<form:form commandName="hotIssueVo" id="listForm" name="listForm" method="post">
	<form:hidden path="hissueParentid" ></form:hidden>
	<div style="padding-left: 30px; background-color: white;">
		<br>
		    <div class="card-header with-border">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">						
        				<form:select path="searchCondition" cssClass="use" class="form-control col-md-3" style="width: 100px;">
							<form:option value="1" label="작성자"/>
							<form:option value="2" label="제목"/>
							<form:option value="3" label="내용"/>
						</form:select> 
							<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                         <input type="text" class="form-control" name="searchKeyword" value="${hotIssueVo.searchKeyword }">
		                  <a href="javascript:search();">
		                  	<button type="button" class="btn-default" style="height: 100%;">
                               <i class="fa fa-search"></i>
                          	</button>
                          </a>
					</div>
		        </div>
		      </div>
		
		<table id="HotIssueVoTable">
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>작성일</th>
				<th>작성자</th>
				<th></th>
			</tr>
			<tbody id="hotIssueList">
				<c:forEach items="${hotIssueList }" var="hotissue" varStatus="sts" >
				    <tr>
					<td><c:out value="${paginationInfo.totalRecordCount - ((hotIssueVo.pageIndex-1) * hotIssueVo.pageUnit + sts.index)}"/>. 
					<input type="hidden" id="${hotissue.hissueId }" name="${hotissue.hissueId }">
					</td>			
					<c:if test="${hotissue.hissueParentid ne null}">
					<td style="padding-left: 20px;">➜${hotissue.hissueTitle}</td>
					</c:if>
					<c:if test="${hotissue.hissueParentid eq null}">
					<td>${hotissue.hissueTitle}</td>
					</c:if>
					<td>${hotissue.regDt}</td>
					<td>${hotissue.writer}</td>
					<td class="project-actions text-right" style="opacity: .9;">
				        <a class="btn btn-primary btn-sm" href="javascript:hotissueDetail(${hotissue.hissueId });">
				        	<i class="fas fa-folder"></i>상세보기</a>
						<a class="btn btn-info btn-sm" href="javascript:hotissueInsertChild(${hotissue.hissueId });">
				        	<i class="fas fa-pencil-alt"></i>답글 작성</a>
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
</div>
</html>