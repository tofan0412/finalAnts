<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>noticeDetail.jsp</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<script type="text/javascript">
$(function(){
	$("#modnotice").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/admin/updatenoticeView?noticeId=${noticevo.noticeId}');
	})
	$("#delnotice").on('click', function(){
        if(confirm("정말 삭제하시겠습니까 ?") == true){
			$(location).attr('href', '${pageContext.request.contextPath}/admin/delnotice?noticeId=${noticevo.noticeId}');
        }else{
        	return;
        }
	})
	$("#back").on('click',function(){
		window.history.back();
	})
})
</script>

<style type="text/css">
	label{
		width : 76%;
/* 		height : 30px; */
		font-size: 1.2em;
	}
	/*
 	.col-sm-2{ 
 		font-size: 1.3em; 
 		font-weight: bold; 
 	} 
 	*/
 	noticeCont{
 		
 	}
</style>

</head>

<%@include file="./noticecontentmenu.jsp"%>
<%-- <%@include file="./eachproject.jsp"%> --%>


<body>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
<!-- 		<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
			<h3>공지사항  상세내역</h3>
			<br>
			
			<label for="noticeTitle" class="col-sm-2 control-label">제목</label>
			<label id ="noticeTitle" class="control-label">${noticevo.noticeTitle}</label>
			
			
			<br>
			<label for="noticeCont" class="col-sm-2 control-label">내용</label>
			<div>
			<label id ="noticeCont" class="control-label">${noticevo.noticeCont }</label>
			</div>
			<br><br>
			<div>
			<label for="adminId" class="col-sm-2 control-label">작성자</label>
			<label id ="adminId" class="control-label">${noticevo.adminId }</label>
			</div>
			<br>
			<label for="regDt" class="col-sm-2 control-label">작성일</label>
			<label id ="regDt" class="control-label">${noticevo.regDt }</label>
			<br>
			
			
			<br>
			<c:if test="${noticevo.adminId == adminId}">
				<input type= "button" value="수정하기" id ="modnotice" class="btn btn-default">
				<input type= "button" value="삭제하기" id="delnotice"  class="btn btn-default">			
				<input type= "button" value="뒤로가기" id="back"  class="btn btn-default">			
			</c:if>
				


	    </div>      
	   </div>
<!-- 	 </div>       -->
</div>

</body>
</html>