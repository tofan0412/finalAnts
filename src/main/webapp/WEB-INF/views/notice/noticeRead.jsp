<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>noticeRead.jsp</title>
<script type="text/javascript">
// 	$(document).ready(function() {
// 		var formObj = $("form[role='form']");
// 		console.log(formObj);
		
// 		$(".modBtn").on("click", function() {
// 			formObj.attr("action", "/notice/noticeModify");
// 			formObj.attr("method", "get");
// 			formObj.submit();
// 		});
		
// 		$(".delBtn").on("click", function() {
// 			formObj.attr("action", "/notice/noticeRemove");
// 			formObj.submit();
// 		)};
		
// 		$(".listBtn").on("click", function() {
// 			self.location = "/notice/noticeList";
// 		)};
		
// 	});
</script>
</head>
<body>
	조회
	<div class="col-lg-12" >
		<div class="box box-primary">
			<div class="box-header with-border" >
				<h3 class="box-title">글제목 : ${notice.noticeTitle }</h3>
			</div>
			<div class="box-body" style="height: 700px" >
				${notice.noticeCont }
			</div>
			<div class="box-footer">
				<div class="user-block">
					<span class="username">
						<a href="#">${notice.adminId }</a>
					</span>
<%-- 					<span class="description"><fmt:formatDate value="notice.regDt" pattern="yyyy-MM-dd"/></span> --%>
				</div>
			</div>
			
			<div class="box-footer">
				<form role="form" method="post">
					<input type="hidden" name="noticeId" value="${notice.noticeId }">
				</form>
				<button type="submit" class="btn btn-primary listBtn"><i class="fa fa-list"></i>목록</button>
				<div class="pull-right">
					<button type="submit" class="btn btn-warning modBtn"><i class="fa fa-edit"></i>수정</button>
					<button type="submit" class="btn btn-danger delBtn"><i class="fa fa-trash"></i>삭제</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>