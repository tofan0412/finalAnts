<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<script type="text/javascript">
$(function(){
	$("#insertissue").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/insertissueView');
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

<%@include file="../layout/contentmenu.jsp"%>

<body>


<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
		<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab">
		
			<h3>협업이슈 수정하기</h3>
			<form id="frm"  class="form-horizontal" method="post" 
										    action="${pageContext.request.contextPath}/projectMember/updateissue" >
				<table>
					<tr>
						<td class="sort" >이슈제목 </td> 			
						<td><input type="text" value="${issueVo.issueTitle }" name="issueTitle"></td> 						
					</tr>
					
					<tr>
						<td class="sort">이슈 내용  </td> 			
						<td><input type="text" value="${issueVo.issueCont }" name="issueCont"></td> 						
					</tr>
					<tr>
						<td class="sort">이슈 종류</td> 			
						<td><input type="text" value="${issueVo.issueKind }" name="issueKind"></td> 						
					</tr>
					<tr>
						<td class="sort">카테고리</td> 			
						<td><input type="text" value="${issueVo.categoryId }" name="categoryId"></td> 						
					</tr>
					
					<tr>
						<td class="sort"></td> 			
						<td><input type="submit" name="작성하기"></td> 						
					</tr>
					
				</table>
			</form>
				<p>파일 : (파일 존재시 다운로드)  </p>
				<p><input type="button" value="다운로드" id="filedown"></p>
	    </div>      
	   </div>
	 </div>      
</div>
	
</body>
</html>