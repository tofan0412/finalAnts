<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style type="text/css">
	table {
		border : 1 solid black;
	}
</style>

<script type="text/javascript">
$(function(){
	$("#insertissue").on('click', function(){
		
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/insertissueView');
	})
})
</script>

<%@include file="./issuecontentmenu.jsp"%>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
		<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab">
		 	<h3>협업이슈 리스트</h3>
				<input type= "button" value="작성하기" id="insertissue">
				<table border="1">
					<tr>
						<td>  이슈 제목</td> 
						<td>   작성자 </td>
						<td>   날짜   </td>
					</tr>
				 <c:forEach items = "${issuelist }" var ="issue">
					<tr>
					
						<td><a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issue.issueId}"> ${issue.issueTitle }</a> </td>
						<td> ${issue.memId }</td>
						<td> ${issue.regDt }</td>
						 
					</tr>
				 </c:forEach> 
				
				</table>
	    </div>      
	  </div>
	 </div>      
</div>
