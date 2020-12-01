<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<script type="text/javascript">
$(function(){
	$("#modissue").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/updateissueView?issueId=${issuevo.issueId}');
	})
	$("#delissue").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/delissue?issueId=${issuevo.issueId}');
	})
})
</script>

<style type="text/css">
	.sort{
	
		width : 120px;
		height : 30px;
	}
</style>

</head>

<%@include file="./issuecontentmenu.jsp"%>
<%-- <%@include file="./eachproject.jsp"%> --%>


<body>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
<!-- 		<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
			<h3>협업이슈 상세내역</h3>
			
			<table>
				<tr>
					<td class="sort">작성자  </td> 			
					<td>${issuevo.memId }</td> 						
				</tr>
				<tr>
					<td class="sort" >이슈제목 </td> 			
					<td>${issuevo.issueTitle}</td> 						
				</tr>
				<tr>
					<td class="sort">작성일  </td> 			
					<td>${issuevo.regDt }</td> 						
				</tr>
				<tr>
					<td class="sort">이슈 내용  </td> 			
					<td>${issuevo.issueCont }</td> 						
				</tr>
				
			</table>
			
				<p>파일 : (파일 존재시 다운로드)  </p>
				<p><input type="button" value="다운로드" id="filedown"></p>
				
				<c:if test="${issuevo.memId == memId}">
					<input type= "button" value="수정하기" id ="modissue">
					<input type= "button" value="삭제하기" id="delissue" >			
				</c:if>
				


	    </div>      
	   </div>
<!-- 	 </div>       -->
</div>

</body>
</html>