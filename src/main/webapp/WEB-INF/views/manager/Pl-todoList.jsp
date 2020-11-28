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
// 	 	$(document).ready(function(){
// 	 		document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
// 	 	});
</script>
</head>
	<h3>일감 리스트!</h3>
		<table class="table table-striped">
			<tr>
				<th>상태</th>
				<th>제목</th>
				<th>담당자</th>
				<th>진행도</th>
				<th>종료일</th>
			</tr>
			<tbody id="todoList">
				<c:forEach items="${todoList}" var="todo">
					<tr data-userid="${todo.todo_id}">
						<td>${todo.todo_importance}</td>
						<td>${todo.todo_title}</td>
						<td>${todo.mem_id}</td>
						<td>${todo.todo_percent(}</td>
						<td>${todo.todo_title}</td>
						<td>${todo.todo_end}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<a class="btn btn-default pull-right" href="${pageContext.request.contextPath }/todo/todoInsertView">일감 등록</a>
						

</html>