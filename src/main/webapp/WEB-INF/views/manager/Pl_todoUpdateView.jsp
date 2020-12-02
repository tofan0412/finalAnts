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
		$("#memChangecomment").hide();
		$('#summernote').summernote();
		
		// db일자 가져오기
		var todo_start = $('#todo_start').val();
		var todo_end = $('#todo_end').val();
		document.getElementById('todoStart').value = new Date(todo_start).toISOString().substring(0, 10);
 		document.getElementById('todoEnd').value = new Date(todo_end).toISOString().substring(0, 10);
		
 		// 등록
		$("#regBtn").on("click", function() {
			$("#todoform").submit();
		});
		
 		// 뒤로가기
		$("#back").on("click", function() {
			window.history.back();
		});
		
 		// 담당자 변경
		$("#mem-select").on("change", function() {
			$("#changemem").val('${todoVo.memId }');
			$("#memChangecomment").show();
		});
 	});

</script>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px;">
	<h3>일감 수정</h3>
	<br>
	<form method="post" action="${pageContext.request.contextPath }/todo/updatetodo" id="todoform"  >	
		<input type="hidden" name="todoId" value="${todoVo.todoId }">
		<label for="todoTitle" class="col-sm-1 control-label">제목</label>
		<input type="text" name="todoTitle" style="width: 580px;" id="todoTitle" value="${todoVo.todoTitle }"><br><br>
		
		<div style="width: 80%;">
		<label for="todoCont" class="col-sm-1 control-label">할일</label>
		<textarea id="summernote" name="todoCont" id="todoCont">${todoVo.todoCont }</textarea>
		</div>
		<br><br>
		<label for="mem-select" class="col-sm-1 control-label">담당자</label>
		<select name="memId" id="mem-select">
			<c:forEach items="${promemList}" var="mem">
				<option value="${mem.memId}">${mem.memName}</option>
			</c:forEach>
		</select>
		<div id="memChangecomment">
		<label for="memChangeComment" class="col-sm-1 control-label">인수인계 내용</label>
		<input type="text" id="memChangeComment" name ="logComment"/>
		</div>
		
		<br><br>
		<input type="hidden" name="changemem" id="changemem" />
		
		<label for="status-select" class="col-sm-1 control-label">우선순위</label>
		<select name="todoImportance" id="status-select">
		    <c:if test="${todoVo.todoImportance eq 'gen' }">
		    <option value="gen">보통</option>
		    <option value="emg">긴급</option>
		    </c:if>
		    <c:if test="${todoVo.todoImportance eq 'emg' }">
		    <option value="emg">긴급</option>
		    <option value="gen">보통</option>
		    </c:if>
		</select><br><br>
		
		<label for="todoPercent" class="col-sm-1 control-label">진행도</label>
		<input type="text" id="todoPercent" name="todoPercent" value="${todoVo.todoPercent }"/><br><br>
		
		<label for="todoStart" class="col-sm-1 control-label">시작 일</label>
		<input type='date' id='todoStart' name="todoStart"/><br><br>
		<input type="hidden" id='todo_start' value="${todoVo.todoStart}"/><br><br>
		
		<label for="todoEnd" class="col-sm-1 control-label">종료 일</label>
		<input type='date' id='todoEnd' name="todoEnd"/><br><br>
		<input type="hidden" id='todo_end' value="${todoVo.todoEnd}"/><br><br>
		
		<button type="button" class="btn btn-default" id="regBtn">수정</button>
		<button type="button" class="btn btn-default" id="back">뒤로가기</button>
	</form>
</div>
</html>