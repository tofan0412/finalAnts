<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#progress").hide();
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
		
		//진행도 수정
		$(document).on('click','#modalBtn', function(){
			document.proForm.action = "<c:url value='/todo/progressChange'/>";
			document.proForm.submit();
		})
		
		// 뒤로가기
		$(document).on('click','#back', function(){
			window.history.back();
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
			
				$("#todoTitle").val(data.todoVo.todoTitle);
				$("#todoCont").html(data.todoVo.todoCont);
				$("#memId").val(data.todoVo.memId);
				$("#todoImportance").val(data.todoVo.todoImportance);
				$("#todoStart").val(data.todoVo.todoStart);
				$("#todoEnd").val(data.todoVo.todoEnd);
				$("#todoPercent").val(data.todoVo.todoPercent+"%");
				$("#todoId").val(data.todoVo.todoId);
				$("#todoId_in").val(data.todoVo.todoId);
				
				if(data.todoVo.todoLevel == '2'){
					$("#creatChildBtn").hide();
				}	
				if(data.todoVo.memId == '${SMEMBER.memName}'){
					$("#progress").show();
				}	
			}
	
		});
	
	}

	
</script>

<style type="text/css">
.form-control:disabled, .form-control[readonly] {
   background-color: white;
   }
</style>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px; padding-right: 410px;">
		<div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">일감 상세보기</h3>
            </div>
            <div class="card-body">
              <div class="form-group">
                <label for="todoTitle">제목</label>
                <input type="hidden" id="todoId">
                <input type="text" id="todoTitle" class="form-control" readonly="readonly">
                
              </div>
              <div class="form-group">
                <label for="todoCont">할일</label>
                <div id="todoCont" class="form-control" style="margin-top: 0px; margin-bottom: 0px;"></div>
              </div>
              <div class="form-group">
                <label for="memId">담당자</label>
                <input type="text" id="memId" class="form-control" readonly="readonly">
              </div>
              <div class="form-group">
                <label for="todoImportance">상태</label>
                <input type="text" id="todoImportance" class="form-control" readonly="readonly">
              </div>
              <div class="form-group">
                <label for="todoPercent">진행도</label>
                <input type="text" id="todoPercent" class="form-control" readonly="readonly">
              </div>
              <div class="form-group">
                <label for="todoStart">시작 일</label>
                <input type="text" id="todoStart" class="form-control" readonly="readonly">
              </div>
              <div class="form-group">
                <label for="todoEnd">종료 일</label>
                <input type="text" id="todoEnd" class="form-control" readonly="readonly">
              </div>
              	<div id="btnMenu">
					<c:if test="${SMEMBER.memId eq projectVo.memId }">
					<button type="button" class="btn btn-default" id="updateBtn" >수정</button>
					<button type="button" class="btn btn-default" id="deleteBtn">삭제</button>
					<button type="button" class="btn btn-default" id="creatChildBtn">하위일감 생성</button>
					<button type="button" class="btn btn-default" id="creattodoBtn">일감 생성</button>
					</c:if>
					<button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">진행도</button>	
					<button type="button" class="btn btn-default" id="back">뒤로가기</button>	
				</div>
              
            </div>
          </div>
		
	
</div>

 
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">진행도 수정</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
       	진행도를 입력해주세요!
       	<form id="proForm" name="proForm" method="post">
       	<input type="hidden" name="todoId" id="todoId_in">
       	<input type="text" name="todoPercent">
       	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="modalBtn">등록</button>
      </div>
    </div>
  </div>
</div>


		
</html>