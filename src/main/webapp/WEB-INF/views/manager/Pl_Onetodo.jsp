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
	$(document).ready(function() {
		todoAjax("${param.todoId}");
	
				$("#updateBtn").on("click", function(){
					var todoId1 = "${param.todoId}"
					location.href="todo/updatetodoView?todoId="+todoId1;
					});
				$("#deleteBtn").on("click",function(){
					var todoId2 = "${param.todoId}"
					location.href="todo/deletetodo?todoId="+todoId2;
				});
	
	
	});
	function todoAjax(userid) {
		$.ajax({
			url : "/todo/onetodo",
			method : "get",
			data : {
				todoId : todoId
			},
			success : function(data) {
				console.log(data);
				
				$("#todoTitle").html(data.todoVo.todoTitle);
				$("#todoCont").html(data.todoVo.todoCont);
				$("#memId").html(data.todoVo.memId);
				$("#todoImportance").html(data.todoVo.todoImportance);
				$("#todoStart").html(data.todoVo.todoStart);
				$("#todoEnd").html(data.todoVo.todoEnd);	
			}
	
		});
	
	}
</script>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px;"><h3>일감 상세보기</h3><br>

		<label for="todoTitle" class="col-sm-1 control-label">제목</label>
		<label class="control-label" id="todoTitle"></label>
		<label for="todoCont" class="col-sm-1 control-label">할일</label>
		<label class="control-label" id="todoCont"></label>
		<label for="memId" class="col-sm-1 control-label">담당자</label>
		<label class="control-label" id="memId"></label>
		<label for="todoImportance" class="col-sm-1 control-label">우선순위</label>
		<label class="control-label" id="todoImportance"></label>
		<label for="todoStart" class="col-sm-1 control-label">시작 일</label>
		<label class="control-label" id="todoStart"></label>
		<label for="todoEnd" class="col-sm-1 control-label">종료 일</label>
		<label class="control-label" id="todoEnd"></label>

		<button type="button" class="btn btn-default" id="updateBtn">수정</button>
		<button type="button" class="btn btn-default" id="deleteBtn">삭제</button>
	
</div>
</html>