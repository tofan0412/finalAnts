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
$(function(){
	//수정
	$("#updateBtn").on('click', function(){
		var todoId="${todoVo.todoId}"; 
// 		$(location).attr('href', '${pageContext.request.contextPath}/todo/insertissueView');
	})
	
	// 일감 생성
	$("#creattodoBtn").on('click', function(){
 		$(location).attr('href', '${pageContext.request.contextPath}/todo/todoInsertView');
	})
	
	// 하위 일감 생성
	$("#creatChildBtn").on('click', function(){
		var todoParentid="${todoVo.todoId}"; 
		alert(todoParentid);
 		$(location).attr('href', '${pageContext.request.contextPath}/todo/todoInsertView?todoParentid='+todoParentid);
       
	})
	
	// 일감 삭제
	$("#deleteBtn").on('click', function(){
		var todoId="${todoVo.todoId}"; 
		var reqId="${todoVo.reqId}"; 
		 if(confirm("정말 삭제하시겠습니까 ?") == true){
			$(location).attr('href', '${pageContext.request.contextPath}/todo/deletetodo?todoId='+todoId+'&reqId='+reqId);
		    }
		    else{
		        return ;
		    }
	})
})
	
</script>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px;"><h3>일감 상세보기</h3><br>

		
		
		<label for="todoTitle" class="col-sm-1 control-label">제목</label>
		<label class="control-label" id="todoTitle">${todoVo.todoTitle }</label><br><br>
		
		<label for="todoCont" class="col-sm-1 control-label">할일</label>
		<label class="control-label" id="todoCont">${todoVo.todoCont }</label><br><br>
		
		<label for="memId" class="col-sm-1 control-label">담당자</label>
		<label class="control-label" id="memId">${todoVo.memId }</label><br><br>
		
		<label for="todoImportance" class="col-sm-1 control-label">우선순위</label>
		<label class="control-label" id="todoImportance">${todoVo.todoImportance }</label><br><br>

		<label for="todoStart" class="col-sm-1 control-label">시작 일</label>
		<label class="control-label" id="todoStart">${todoVo.todoStart }</label><br><br>
		
		<label for="todoEnd" class="col-sm-1 control-label">종료 일</label>
		<label class="control-label" id="todoEnd">${todoVo.todoEnd }</label><br><br>


		<button type="button" class="btn btn-default" id="updateBtn" >수정</button>
		<button type="button" class="btn btn-default" id="deleteBtn" onclick="removeCheck()">삭제</button>
		<button type="button" class="btn btn-default" id="creatChildBtn">하위일감 생성</button>
		<button type="button" class="btn btn-default" id="creattodoBtn">일감 생성</button>
	
</div>
</html>