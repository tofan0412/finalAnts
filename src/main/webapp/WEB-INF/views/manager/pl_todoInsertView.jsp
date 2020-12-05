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
	 		
	 		// 하위 일감 등록
			$("#creatChildBtn").on("click", function() {

				$("#todoform").attr("action", "${pageContext.request.contextPath }/todo/todoChildInsert");
				
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
<div style="padding-left: 30px; padding-right: 30px;"><h3>일감등록</h3><br>

    <form method="post" action="${pageContext.request.contextPath }/todo/todoInsert" id="todoform"  >
    	<div class="card card-primary card-outline"> 
    		<div class="card-header">
               <h3 class="card-title"><c:out value="${projectVo.proName}"/></h3>
            </div>
        <div class="card-body">
                <div class="form-group">
                  <input class="form-control" placeholder="Subject:" name="todoTitle">
                </div>
                <div class="form-group">
                <textarea id="summernote" name="todoCont" placeholder="할일:"></textarea>
                </div>
                <div class="form-group">
                <label for="mem-select" class="col-sm-1 control-label">담당자</label>
        			<select name="memId" id="mem-select">
            			<option value="">담당자를 선택해 주세요</option>
            			<c:forEach items="${promemList}" var="mem">
                		<option value="${mem.memId}">${mem.memName}</option>
            			</c:forEach>
       				 </select>
                </div>
                <div class="form-group">
                <label for="status-select" class="col-sm-1 control-label">우선순위</label>
        			<select name="todoImportance" id="status-select">
           			 <option value="gen">보통</option>
           			 <option value="emg">긴급</option>
        			</select>
                </div>
                <div class="form-group">
                <label for="currentDate" class="col-sm-1 control-label">시작 일</label>
        			<input type='date' id='currentDate' name="todoStart"/><br><br>
        			<label for="todoEnd" class="col-sm-1 control-label">종료 일</label>
        			<input type='date' id='todo_end' name="todoEnd"/>
                </div>
                <div class="form-group" hidden="hidden">
                	<c:if test="${not empty todoVo.todoParentid}">
			        <input type="hidden" name="todoParentid" value="${todoVo.todoParentid}">
			        <input type="hidden" name="todoLevel" value="2">  
			        </c:if>      
			        <c:if test="${empty todoVo.todoParentid}">
			        <input type="hidden" name="todoLevel" value="1">        
			        </c:if>
                </div>
        </div>   
        <div class="card-footer">
        	<div class="float-center">
		        <button type="button" class="btn btn-default" id="regBtn">등록</button>
		        <c:if test="${ empty todoVo.todoParentid}">
		        <button type="button" class="btn btn-default" id="creatChildBtn">등록하고 하위일감 생성하러 가기</button>
		        </c:if>
		        <button type="button" class="btn btn-default" id="back">뒤로가기</button>
        	</div>
        </div>
    </form>
	
</div>
</html>