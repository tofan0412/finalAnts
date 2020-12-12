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
		todoDetail("${param.todoId}");

		
		//진행도 수정
		$(document).on('click','#modalBtn', function(){
			document.proForm.action = "<c:url value='/todo/progressChange'/>";
			document.proForm.submit();
		})
		
		// 뒤로가기
		$(document).on('click','#back', function(){
			window.history.back();
		})
		
	})
	function todoDetail(todoId) {
		$.ajax({
			url : "/todo/myonetodo",
			method : "get",
			data : {
				todoId : todoId
			},
			success : function(data) {
				var res ="";
				$("#todoTitle").html(data.todoVo.todoTitle);
				$("#todoCont").html(data.todoVo.todoCont);
				$("#memId").html(data.todoVo.memId);
				if(data.todoVo.todoImportance =='emg'){
					document.getElementById("cardTodo").className = "card card-danger";
					$("#todoImportance").html('긴급');
				}
				if(data.todoVo.todoImportance =='gen'){
					document.getElementById("cardTodo").className = "card card-primary";
					$("#todoImportance").html('일반');
				}
				$("#todoStart").html(data.todoVo.todoStart);
				$("#todoEnd").html(data.todoVo.todoEnd);
				$("#todoPercent").html(data.todoVo.todoPercent+"%");
				$("#todoId").val(data.todoVo.todoId);
				$("#todoId_in").val(data.todoVo.todoId);
				$("#reqId").val(data.todoVo.reqId);
				
				
				if(data.filelist.length == 0){
					res += '<p>[ 첨부파일이 없습니다. ]</p>';
					$("#filediv").html(res);
				}
				if(data.filelist.length != 0) {
					for( i = 0 ; i< data.filelist.length; i++){	
 						res += '<a href="${pageContext.request.contextPath}/file/publicfileDown?pubId='+data.filelist[i].pubId+'"><input id ="files"  type="button" class="btn btn-default" name="'+ data.filelist[i].pubId+'" value="'+data.filelist[i].pubFilename+'" ></a>  ';
						
 						$("#filediv").html(res);
					}	
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
		<div class="card card-primary" id="cardTodo">
            <div class="card-header">
              <h3 class="card-title">일감 상세보기</h3>
            </div>
            <div class="card-body">
                   	<input type="hidden" id="todoId">
        
					<label for="todoTitle" class="col-sm-1 control-label">제목:</label>
			        <label class="control-label" id="todoTitle"></label><br><br>
					        
					<label for="memId" class="col-sm-1 control-label">담당자:</label>
					<label class="control-label" id="memId"></label>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					        
					<label for="todoPercent" class="col-sm-1 control-label">진행도:</label>
					<label class="control-label" id="todoPercent"></label>
					        
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <label for="todoImportance" class="col-sm-1 control-label">우선순위:</label>
					 <label class="control-label" id="todoImportance"></label><br><br>
					
					 <label for="todoStart" class="col-sm-1 control-label">시작 일:</label>
					 <label class="control-label" id="todoStart"></label>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <label for="todoEnd" class="col-sm-1 control-label">종료 일:</label>
					 <label class="control-label" id="todoEnd"></label><br><br>
					 <label for="todoCont" class="col-sm-1 control-label">할일:</label>
					<label class="control-label" id="todoCont"></label><br>
	              	<div class="form-group">
					<label id="filelabel" for="File" class="col-sm-2 control-label">첨부파일 다운로드</label>
					<div id = "filediv">
						
					</div>
					</div>
	              	
	              	
	              	<div id="btnMenu">
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
       	<input type="hidden" name="reqId" id="reqId">
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