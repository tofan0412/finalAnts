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
	$("#todoList tr").on("click",function(){
		var todoId = $(this).data("todoid");
 		$(location).attr('href', '${pageContext.request.contextPath}/todo/onetodoView?todoId='+todoId);
		});
	});
</script>
<style type="text/css">
#todoTable{
	width : 1000px;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  

</style>
</head>
<body>
	<%@include file="../layout/contentmenu.jsp"%>
	<div style="padding-left: 30px;">
		<a class="btn btn-default pull-right" href="${pageContext.request.contextPath }/todo/todoInsertView?reqId=2">일감 등록</a>
		<br>
		<c:if test="${todoList eq null}">
				"등록된 일감이없습니다."
		</c:if>
		<c:if test="${todoList ne null}">
		
		<table id="todoTable">
		
			<tr>
				<th>상태</th>
				<th>제목</th>
				<th>담당자</th>
				<th>진행도</th>
				<th>진행일</th>
				<th>마감일</th>
			</tr>
			<tbody id="todoList">
			<c:if test="${todoList ne null}">
				<c:forEach items="${todoList}" var="todo">
					<tr data-todoid="${todo.todoId}">
						<td>
						<c:if test="${todo.todoImportance eq 'gen'}">일반</c:if>
						<c:if test="${todo.todoImportance eq 'emg'}">긴급</c:if>
						</td>
						<c:if test="${todo.todoLevel ne '1'}">
						<td style="padding-left: 20px;">➜${todo.todoTitle}</td>
						</c:if>
						<c:if test="${todo.todoLevel eq '1'}">
						<td>${todo.todoTitle}</td>
						</c:if>
						<td>${todo.memId}</td>
						<td>
						<c:if test= "${todo.todoPercent eq null}">0%</c:if>
						<c:if test= "${todo.todoPercent ne null}">${todo.todoPercent}%</c:if>
						</td>
						<td>
						<c:if test="${todo.todoStart eq '0'}">오늘 등록한 일감입니다 :)</c:if>
						<c:if test="${todo.todoStart ne '0'}">${todo.todoStart }</c:if>
						</td>
						<td>${todo.todoEnd}</td>
					</tr>
				</c:forEach>
				</c:if>
			</tbody>
		</table>
		</c:if>
			</div>			
</body>
</html>