<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	 	$(document).ready(function(){
	 		document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
	 	});
</script>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px;"><h3>일감 수정</h3><br>

	<form method="post" action="${pageContext.request.contextPath }/todo/updateissueView" id="todoform"  >	
		<label for="todoTitle" class="col-sm-1 control-label">제목</label>
		<input type="text" name="todoTitle" style="width: 580px;"><br><br>
		<label for="todoCont" class="col-sm-1 control-label">할일</label>
		<textarea name="todoCont" cols="80" rows="2" style="resize: none;"></textarea><br><br>
		<label for="mem-select" class="col-sm-1 control-label">담당자</label>
		<select name="memId" id="mem-select">
		    <option value="">담당자를 선택해 주세요</option>
			<c:forEach items="${promemList}" var="mem">
				<option value="${mem.memId}">${mem.memId}</option>
			</c:forEach>
		</select><br><br>
		<label for="status-select" class="col-sm-1 control-label">우선순위</label>
		<select name="todoImportance" id="status-select">
		    <option value="gen">보통</option>
		    <option value="emg">긴급</option>
		</select><br><br>
		<label for="currentDate" class="col-sm-1 control-label">시작 일</label>
		<input type='date' id='currentDate' name="todoStart"/><br><br>
		<label for="todoEnd" class="col-sm-1 control-label">종료 일</label>
		<input type='date' id='todo_end' name="todoEnd"/><br><br>
<!-- 		<label for="realFilename" class="col-sm-1 control-label">파일</label> -->
<!-- 		<input type="file" name="realFilename" id="realFilename"/> -->
<%-- 		<c:if test="${상위일감을클릭해서 들어오면... }"> --%>
<%-- 		<input type="hidden" name="" value="${상위일감.....id}"></c:if> --%>
		<button type="button" class="btn btn-default" id="regBtn">수정</button>
	</form>
</div>
</html>