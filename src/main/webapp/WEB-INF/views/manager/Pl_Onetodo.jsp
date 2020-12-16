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
		
		
		// 뒤로가기
		$(document).on('click','#back', function(){
			window.history.back();
		})
		
		// 일감 삭제
		$(document).on('click','#deleteBtn', function(){
			var todoId = $("#todoId").val();
			var reqId = $("#reqId").val();
			 if(confirm("정말 삭제하시겠습니까 ?") == true){
				$(location).attr('href', '${pageContext.request.contextPath}/todo/deletetodo?todoId='+todoId+'&reqId='+reqId);
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
				console.log(data);
				var i = 0;
				var html = "";
				var res ="";
				for (var i = 0; i < data.todoVo.length; i++) {
					var todo = data.todoVo[i];
					if("${param.todoId}"==todo.todoId){
						$("#todoTitle").html(todo.todoTitle);
						$("#todoCont").html(todo.todoCont);
						$("#memId").html(todo.memId);
						if(todo.todoImportance =='emg'){
							document.getElementById("cardTodo").className = "card card-danger";
							$("#todoImportance").html('긴급');
						}
						if(todo.todoImportance =='gen'){
							document.getElementById("cardTodo").className = "card card-primary";
							$("#todoImportance").html('일반');
						}
						$("#todoStart").html(todo.todoStart);
						$("#todoEnd").html(todo.todoEnd);
						$("#todoPercent").html(todo.todoPercent+"%");
						$("#todoId").val(todo.todoId);
						$("#reqId").val(todo.reqId);
						$("#todoId_in").val(todo.todoId);
					}
					
					if("${param.todoId}" != todo.todoId && todo.todoParentid != null){
						
							html += "<tr>";
							html += " <td id='intodoId'>" + todo.todoTitle+ "</td>";
							html += " <td>" + '<a class="btn btn-primary btn-sm" href=${pageContext.request.contextPath}/todo/onetodoView?todoId='+todo.todoId+'>보러가기</a>' + "</td>"							
							html += "</tr> ";
						$("#childtodo").html(html);
						}
						
					}
				
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
#intodoId{
	width: 1000px;
}
  .success{
  background-color: #f6f6f6;
  width: 10%;
  text-align: center;
  }

</style>

</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>

<div style="padding-left: 30px; padding-right: 410px;">
		<div class="card card-primary" id ="cardTodo">
            <div class="card-header">
              <h3 class="card-title">일감 상세보기</h3>
            </div>
            <div class="card-body">
             	<input type="hidden" id="todoId">
             	<input type="hidden" id="reqId">
        <table class="table" >
        <tr class="stylediff">
            <th class="success ">제목</th>
         	<td colspan="3"><label class="control-label" id="todoTitle"></label></td>
        </tr>
           
         
        <tr class="stylediff">
            <th class="success ">담당자</th>
            <td><label class="control-label" id="memId"></label></td>
            <th class="success ">진행도</th>
            <td><label class="control-label" id="todoPercent"></label></td>
        </tr>
         
        <tr class="stylediff">
            <th class="success">변경이력</th>
            <td><label class="control-label" >추후처리예정</label></td>
            <th class="success">우선순위</th>
            <td><label class="control-label" id="todoImportance"></label></td>
        </tr>
         
        <tr class="stylediff">
            <th class="success">기간</th>
            <td colspan="3"><label class="control-label" id="todoStart"></label> <label class="control-label">~</label> <label class="control-label" id="todoEnd"></label></td>
        </tr>
         
        <tr>
            <th class="success">내용</th>
            <td colspan="3"><label class="control-label" id="todoCont"></label></td>
        </tr>
        <tr>
            <th class="success">첨부파일</th>
            <td colspan="3"><div id = "filediv">	
					</div></td>
        </tr>
        </table>
				
		         <div id="btnMenu">
				 <c:if test="${SMEMBER.memId eq projectVo.memId }">
					 <button type="button" class="btn btn-default" id="updateBtn" >수정</button>
					 <button type="button" class="btn btn-default" id="deleteBtn">삭제</button>
					 <button type="button" class="btn btn-default" id="creatChildBtn">하위일감 생성</button>
				 </c:if>
					 <button type="button" class="btn btn-default" id="back">뒤로가기</button>    
				 </div>
            </div>
          </div>
          
          <div class="card card-primary" id ="childtot">
            <div class="card-header">
              <h3 class="card-title">하위일감보기</h3>
              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body" style="display: block;">
              <div class="form-group" id ="childtodo">
               
              </div>
            </div>
            <!-- /.card-body -->
          </div>
</div>
</html>