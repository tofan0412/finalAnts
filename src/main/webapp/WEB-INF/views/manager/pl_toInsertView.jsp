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

<%@ include file="../layout/commonLib.jsp"%>
<script type="text/javascript">
	 	$(document).ready(function(){
	 		document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
	 	});
</script>
</head>
<div style="padding-left: 30%;">
<br>
<div style="padding-left: 25%;"><h3>일감등록</h3></div><br>

	<form method="todoinsert" action="${pageContext.request.contextPath }/todo/todoInsert" id="todoform" enctype="multipart/form-data">	
		<label for="todo_title" class="col-sm-1 control-label">제목</label>
		<input type="text" name="todo_title" style="width: 580px;"><br><br>
		<label for="todo_cont" class="col-sm-1 control-label">할일</label>
		<textarea name="todo_cont" cols="80" rows="2" style="resize: none;"></textarea><br><br>
		<label for="mem-select" class="col-sm-1 control-label">담당자</label>
		<select name="mem_id" id="mem-select">
		    <option value="">담당자를 선택해 주세요</option>
<%-- 			<c:forEach items="${해당 팀원id 불러와서 뿌릴 예정}" var="mem"> --%>
<!-- 				<option value=""></option> -->
<%-- 			</c:forEach> --%>
		</select><br><br>
		<label for="status-select" class="col-sm-1 control-label">우선순위</label>
		<select name="todo_importance" id="status-select">
		    <option value="gen">보통</option>
		    <option value="emg">긴급</option>
		</select><br><br>
		<label for="currentDate" class="col-sm-1 control-label">시작 일</label>
		<input type='date' id='currentDate' name="todo_start"/><br><br>
		<label for="todo_end" class="col-sm-1 control-label">종료 일</label>
		<input type='date' id='todo_end' name="todo_end"/><br><br>
		<label for="realFilename" class="col-sm-1 control-label">파일</label>
		<input type="file" name="realFilename" id="realFilename"/>
<%-- 		<c:if test="${상위일감을클릭해서 들어오면... }"> --%>
<%-- 		<input type="hidden" name="" value="${상위일감.....id}"></c:if> --%>
		<button type="submit" class="btn btn-default" id="regBtn">등록</button>
	</form>
</div><br><br><br><br><br><br><br><br><br><br><br><br>
</html>