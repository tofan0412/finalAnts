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

<script type="text/javascript">

</script>
<style type="text/css">
#todoTable{
	width : 1000px;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    text-align: center;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }

}
#content{
  min-height: calc(100vh - calc(3.5rem + 1px) - calc(3.5rem + 1px));
}
</style>
</head>
<body>
	<%@include file="../layout/contentmenu.jsp"%>
	<div style="padding-left: 30px;">
		<a class="btn btn-default pull-right" href="${pageContext.request.contextPath }/todo/todoInsertView">일감 등록</a>
		<br>
		<table id="todoTable">
			<tr>
				<th>상태</th>
				<th>제목</th>
				<th>담당자</th>
				<th>진행도</th>
				<th>종료일</th>
			</tr>
			<tbody id="todoList">
				<c:forEach items="${todoList}" var="todo">
					<tr data-userid="${todo.todoId}">
						<td>
						<c:if test="${todo.todoImportance eq 'gen'}">일반</c:if>
						<c:if test="${todo.todoImportance eq 'emg'}">긴급</c:if>
						</td>
						<td>${todo.todoTitle}</td>
						<td>${todo.memId}</td>
						<td>
						<c:if test= "${todo.todoPercent eq null}">0%</c:if>
						<c:if test= "${todo.todoPercent ne null}">${todo.todoPsercent}%</c:if>
						</td>
						<td>${todo.todoEnd}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
			</div>			
</body>
</html>