<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.projectList{
	margin : 10px 10px 10px 10px;
	padding : 10px 10px 10px 10px;
}
.acceptedProjectList{
	text-align : center;
	width : 100%;
	margin : 0 auto;
}
.acceptedProjectList td{
	padding-left : 15px;
	line-height: 50px;
}
.acceptedProjectList th{
	background-color : lightgrey;
}
</style>

<script>
$(function(){
	$('.projectDelBtn').click(function(){
		alert("프로젝트가 삭제되었습니다.");
		
		var ipId = $(this).attr("ipId");
		$(location).attr("href", "/admin/delproject?reqId="+reqId);
	})
})
</script>

<div class="card projectList" style="margin-top : 50px;">
	<h1 class="jg">프로젝트 리스트</h1>
	
	<div style="float : left; width : 100%;">
		<table class="acceptedProjectList">
			<tr style="height : 30px;">
				<th>프로젝트 이름</th>
				<th>담당자</th>
				<th>-</th>
			</tr>
			<c:forEach items="${projectList }" var="project">
				<tr>
					<td hidden="hidden">${project.reqId }</td>
					<td>${project.proName }</td>
					<td>${project.memId }</td>
					<td><button class="btn btn-danger projectDelBtn" reqId=${project.reqId }>삭제</button></td>
				</tr>
			</c:forEach>
			<c:if test="${projectList.size() == 0 }">
				<tr>
					<td style="width : 57.5%; text-align : right;">프로젝트가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</table>
	</div>
	
	
</div>