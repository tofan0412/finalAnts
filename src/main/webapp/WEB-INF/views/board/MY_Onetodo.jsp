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
					$("#todoImportance").html('긴급');
				}
				if(data.todoVo.todoImportance =='gen'){
					$("#todoImportance").html('일반');
				}
				$("#todoStart").html(data.todoVo.todoStart);
				$("#todoEnd").html(data.todoVo.todoEnd);
				$("#todoPercent").html(data.todoVo.todoPercent+"%");
				$("#todoId").val(data.todoVo.todoId);
				$("#todoId_in").val(data.todoVo.todoId);
				$("#reqId").val(data.todoVo.reqId);
				
				
				if(data.filelist.length == 0){
					res += '<label class="control-label" >[ 첨부파일이 없습니다. ]</label>';
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
		<div class="card card-primary" id="cardTodo">
            <div class="card-header">
              <h3 class="card-title">일감 상세보기</h3>
            </div>
            <div class="card-body">
                   	<input type="hidden" id="todoId">
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