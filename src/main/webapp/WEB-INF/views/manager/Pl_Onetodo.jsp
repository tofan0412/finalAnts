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
	$(document).ready(function() {
		todoDetail("${param.todoId}");

		//수정
		$(document).on('click','#updateBtn', function(){
			var todoId = $("#todoId").val();
 	 		$(location).attr('href', '${pageContext.request.contextPath}/todo/updatetodoView?todoId='+todoId);
		})
		
		//생성
		$(document).on('click','#creattodoBtn', function(){
	 		$(location).attr('href', '${pageContext.request.contextPath}/todo/todoInsertView');
		})
		
		//하위
		$(document).on('click','#creatChildBtn', function(){
			var todoId = $("#todoId").val();
	 		$(location).attr('href', '${pageContext.request.contextPath}/todo/todoInsertView?todoParentid='+todoId);
		})
		
		// 일감 삭제
		$(document).on('click','#deleteBtn', function(){
			var todoId = $("#todoId").val();
			 if(confirm("정말 삭제하시겠습니까 ?") == true){
				$(location).attr('href', '${pageContext.request.contextPath}/todo/deletetodo?todoId='+todoId);
			    }
			    else{
			        return ;
			    }
		})
	})
	function todoDetail(todoId) {
		$.ajax({
			url : "/todo/onetodo",
			method : "get",
			data : {
				todoId : todoId
			},
			success : function(data) {
				$("#todoTitle").html(data.todoVo.todoTitle);
				$("#todoCont").html(data.todoVo.todoCont);
				$("#memId").html(data.todoVo.memId);
				$("#todoImportance").html(data.todoVo.todoImportance);
				$("#todoStart").html(data.todoVo.todoStart);
				$("#todoEnd").html(data.todoVo.todoEnd);
				$("#todoId").val(data.todoVo.todoId);
				
				var res = "";
					res += '<button type="button" class="btn btn-default" id="updateBtn" >수정</button>';
					res += '<button type="button" class="btn btn-default" id="deleteBtn">삭제</button>';
					res += '<button type="button" class="btn btn-default" id="creatChildBtn">하위일감 생성</button>';
					res += '<button type="button" class="btn btn-default" id="creattodoBtn">일감 생성</button>';
				
				$("#btnMenu").html(res);
			}
	
		});
	
	}

	
</script>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px;"><h3>일감 상세보기</h3><br>
		
		
		<input type="hidden" id="todoId">
		
		<label for="todoTitle" class="col-sm-1 control-label">제목</label>
		<label class="control-label" id="todoTitle"></label><br><br>
		
		<label for="todoCont" class="col-sm-1 control-label">할일</label>
		<label class="control-label" id="todoCont"></label><br><br>
		
		<label for="memId" class="col-sm-1 control-label">담당자</label>
		<label class="control-label" id="memId"></label><br><br>
		
		<label for="todoImportance" class="col-sm-1 control-label">우선순위</label>
		<label class="control-label" id="todoImportance"></label><br><br>

		<label for="todoStart" class="col-sm-1 control-label">시작 일</label>
		<label class="control-label" id="todoStart"></label><br><br>
		
		<label for="todoEnd" class="col-sm-1 control-label">종료 일</label>
		<label class="control-label" id="todoEnd"></label><br><br>
		<div id="btnMenu"></div>
</div>
</html>