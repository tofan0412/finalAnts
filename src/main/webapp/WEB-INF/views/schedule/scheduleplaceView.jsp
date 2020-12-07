<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script  type="text/javascript">
$(document).ready(function(){
	$("#schedulelist tr").on("click",function(){
		var scheId = $(this).data("scheid");
			$(location).attr('href', '${pageContext.request.contextPath}/schedule/scheduleSelect?scheId='+scheId);
	});
})  
</script>
<body>

	일정장소 게시판
	<%@include file="../layout/contentmenu.jsp"%>
	
	<br>
	<a href="/schedule/scheduleInsertview"><input type="button" value="일정등록"></a>
	<form:form commandName="scheduleVo" id="listForm" name="listForm" method="post">
	<div style="padding-left: 30px; background-color: white;">
		<table id="todoTable">
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>내용</th>
				<th>날짜</th>
				<th>X_VAL</th>
				<th>Y_VAL</th>
				<th>CATEGORY_ID</th>
				<th>REQ_ID</th>
				<th>MEM_ID</th>
				<th>DEL</th>
				<th>START_DT</th>
				<th>END_DT</th>
				<th>주소</th>
			</tr>

			<tbody id="schedulelist">
				<c:forEach items="${schedulelist}" var="schedule" varStatus="sts" >
				    <tr data-scheid="${schedule.scheId}">
					<td><c:out value="${paginationInfo.totalRecordCount - ((scheduleVo.pageIndex-1) * scheduleVo.pageUnit + sts.index)}"/>. 
						<input type="hidden" id="${schedule.scheId }" name="${schedule.scheId }">
					</td>	
					<td>
						${schedule.scheTitle}
					</td>
					<td>
						${schedule.scheCont }
					</td>
					<td>
						${schedule.regDt }
					</td>
					<td>
						${schedule.xVal }
					</td>
					<td>
						${schedule.yVal }
					</td>
					<td>
						${schedule.categoryId }
					</td>
					<td>
						${schedule.reqId }
					</td>
					<td>
						${schedule.memId }
					</td>
					<td>
						${schedule.del }
					</td>
					<td>
						${schedule.startDt }
					</td>
					<td>
						${schedule.endDt }
					</td>
					<td>
						${schedule.juso }
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