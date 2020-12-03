<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>

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
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script type="text/javascript">
	 	$(document).ready(function(){
	 		document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
	 		
	 		$('#summernote').summernote();
	 		
	 		// 등록
			$("#regBtn").on("click", function() {
				$("#todoform").submit();
			});
	 		
			// 뒤로가기
			$("#back").on("click", function() {
				window.history.back();
			});
	 	});
</script>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px;"><h3>일감등록</h3><br>

	<form:form  commandName="todoVo" method="post" action="${pageContext.request.contextPath }/todo/todoInsert" id="todoform" >	
		<form:label for="todoTitle" class="col-sm-1 control-label" path="todoTitle">제목</form:label>
		<form:input path="todoTitle" cssStyle="width: 580px;"/><br><br>
		
		<div style="width: 80%;">
		<form:label for="todoCont" class="col-sm-1 control-label" path="todoCont">할일</form:label>
		<form:textarea id="summernote" path="todoCont"></form:textarea>
		</div>
		<br><br>
		<form:label for="mem-select" class="col-sm-1 control-label" path="memId">담당자</form:label>
			<form:select path="memId" id="mem-select" items="${promemList}">
			    <form:option value="">담당자를 선택해 주세요</form:option>
					<form:option value="${promemList.memId}">${promemList.memName}</form:option>
			</form:select><br><br>
		
		<form:label path="todoImportance" for="status-select" class="col-sm-1 control-label">우선순위</form:label>
		<form:select path="todoImportance" id="status-select">
		    <form:option value="gen">보통</form:option>
		    <form:option value="emg">긴급</form:option>
		</form:select><br><br>
		
		<form:label path="currentDate" for="currentDate" class="col-sm-1 control-label">시작 일</form:label>
		<form:input type='date' id='currentDate' path="todoStart"/><br><br>
		
		<form:label path="todoEnd" for="todoEnd" class="col-sm-1 control-label">종료 일</form:label>
		<form:input type='date' id='todo_end' path="todoEnd"/><br><br>
		
		
		<c:if test="${todoVo.todoParentid ne null}">
		<form:input type="hidden" path="todoParentid" value="${todoVo.todoParentid}"/>
		<form:input type="hidden" path="todoLevel" value="2"/>		
		</c:if>
		<c:if test="${todoVo.todoParentid eq null}">
		<form:input type="hidden" path="todoLevel" value="1"/>		
		</c:if>
		
		
		<form:button class="btn btn-default" id="regBtn">등록</form:button>
		<form:button class="btn btn-default" id="back">등록</form:button>
	</form:form>
	
</div>
</html>