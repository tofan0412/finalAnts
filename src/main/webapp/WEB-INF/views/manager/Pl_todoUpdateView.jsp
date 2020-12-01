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
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
		todoDetail("${param.todoId}");		
		$('#summernote').summernote();
		$("#regBtn").on("click", function() {
			$("#todoform").submit();
		});
 	});
	function todoDetail(todoId) {
		$.ajax({
			url : "/todo/onetodo",
			method : "get",
			data : {
				todoId : todoId
			},
			success : function(data) {
				$("#todoTitle").val(data.todoVo.todoTitle);
				$("#todoCont").val(data.todoVo.todoCont);
				$("#mem-select").val(data.todoVo.memId);
				$("#status-select").val(data.todoVo.todoImportance);
				$("#currentDate").val(data.todoVo.todoStart);
				$("#todo_end").val(data.todoVo.todoEnd);
			}
	
		});
	}
</script>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px;">
	<h3>일감 수정</h3>
	<br>
	<form method="post" action="${pageContext.request.contextPath }/todo/updatetodo" id="todoform"  >	
		<label for="todoTitle" class="col-sm-1 control-label">제목</label>
		<input type="text" name="todoTitle" style="width: 580px;" id="todoTitle"><br><br>
		
		<div style="width: 80%;">
		<label for="todoCont" class="col-sm-1 control-label">할일</label>
		<textarea id="summernote" name="todoCont" id="todoCont"></textarea>
		</div>
		<br><br>
		<label for="mem-select" class="col-sm-1 control-label">담당자</label>
		<select name="memId" id="mem-select">
		    <option value="">담당자를 선택해 주세요</option>
			<c:forEach items="${promemList}" var="mem">
				<option value="${mem.memId}">${mem.memName}</option>
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
		
		<c:if test="${todoVo.todoParentid ne null}">
		<input type="hidden" name="todoParentid" value="${todoVo.todoParentid}"></c:if>
		
		<button type="button" class="btn btn-default" id="regBtn">수정</button>
	</form>
</div>
</html>