<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
.ipList{
	margin : 10px 10px 10px 10px;
	padding : 10px 10px 10px 10px;
}
.acceptedIpList{
	text-align : center;
	width : 90%;
	margin : 0 auto;
}
.acceptedIpList td{
	padding-left : 15px;
	line-height: 50px;
}
.acceptedIpList th{
	background-color : lightgrey;
}
.pagingui {
	display: inline-block;
	text-align: center;
	width: 30px;
}
#paging {
	display: inline-block;
	width: auto;
	float: left;
	margin: 0 auto;
	text-align: center;
	"
}
</style>
<script>
$(function(){
	$('.ipDelBtn').click(function(){
		alert("IP가 삭제되었습니다.");
		
		var ipId = $(this).attr("ipId");
		$(location).attr("href", "/admin/delIp?ipId="+ipId);
	})
})
</script>

<div class="card ipList" style="margin-top : 50px;">
	<!-- contentMenuBar -->
	<%@ include file="/WEB-INF/views/admin/ipContentMenu.jsp" %>
	<!-- /contentMenuBar -->
	
	<div style="float : left; width : 100%;">
		<h5 class="jg">허용 IP 리스트</h5>
		<table class="acceptedIpList">
			<tr style="height : 30px;">
				<th>IP</th>
				<th>담당자</th>
				<th>-</th>
			</tr>
			<c:forEach items="${ipList }" var="ip">
				<tr>
					<td hidden="hidden">${ip.ipId }</td>
					<td>${ip.ipAddr }</td>
					<td>${ip.adminId }</td>
					<td><button class="btn btn-danger ipDelBtn" ipId=${ip.ipId }>삭제</button></td>
				</tr>
			</c:forEach>
			<c:if test="${ipList.size() == 0 }">
				<tr>
					<td style="width : 57.5%; text-align : right;">등록한 IP가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</table>
	</div>
	
	<div id="paging" class="card-tools">
		<ul class="pagination pagination-sm jg" id="pagingui">
	
			<li class="page-item jg" id="pagenum"><ui:pagination
					paginationInfo="${paginationInfo}" type="image"
					jsFunction="fn_egov_link_page" /></li>
			<form:hidden path="pageIndex" />
	
		</ul>
	</div>
	
	
</div>

