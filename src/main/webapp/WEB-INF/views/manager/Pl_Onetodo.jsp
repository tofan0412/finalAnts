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
				var todaylog = '<div class="jg" style="font-size: 18px;" >오늘 변경 내역</div><br>';
				var daylog = '<div class="jg" style="font-size: 18px;" >과거 변경 내역</div><br>';
				for (var i = 0; i < data.todoVo.length; i++) {
					var todo = data.todoVo[i];
					if("${param.todoId}"==todo.todoId){
						$("#todoTitle").html(todo.todoTitle);
						$("#todoCont").html(todo.todoCont);
						$("#memId").html(todo.memId);
						if(todo.todoImportance =='emg'){
							$("#todoImportance").html('긴급');
						}
						if(todo.todoImportance =='gen'){
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
							html += " <p id='intodoId' class='jg' style='padding-left: 2%;'><i class='far fa-file-alt'></i> <a class='jg linka' href=${pageContext.request.contextPath}/todo/onetodoView?todoId="+todo.todoId+">"+ todo.todoTitle+"</a></p>";
						$("#childtodo").html(html);
						}
						
					}
				for(var i=0; i<data.dbtodolog.length; i++){
					var todolog = data.dbtodolog[i];
					if(todolog.elapsedDay =='0' && todolog.elapsedTime =='0'){
						todaylog += ' <p class="jg" style="padding-left: 2%; color: #6c757d;">'+todolog.elapsedMin+'분&nbsp;&nbsp;전 &nbsp;&nbsp;<span class="bef">'+todolog.beforeId+'</span>에서&nbsp;&nbsp;<span class="aft">'+todolog.afterId+'</span>로&nbsp;&nbsp;담당자&nbsp;&nbsp;변경</p>';
					}
					else if(todolog.elapsedDay =='0' && todolog.elapsedTime !='0'){
						todaylog += ' <p class="jg" style="padding-left: 2%; color: #6c757d;">'+todolog.elapsedTime+'시간&nbsp;&nbsp;'+todolog.elapsedMin+'분&nbsp;&nbsp;전&nbsp;&nbsp;<span class="bef">'+todolog.beforeId+'</span>에서&nbsp;&nbsp;<span class="aft">'+todolog.afterId+'</span>로&nbsp;&nbsp;담당자&nbsp;&nbsp;변경</p>';
						}
					
					else if(todolog.elapsedDay !='0'){
						daylog += '<p class="jg" style="padding-left: 2%; color: #6c757d;">'+todolog.elapsedDay+'일&nbsp;&nbsp;전&nbsp;&nbsp;<span class="bef">'+todolog.beforeId+'</span>에서&nbsp;&nbsp;<span class="aft">'+todolog.afterId+'</span>로&nbsp;&nbsp;담당자&nbsp;&nbsp;변경</p>';
					}
				}
				if(data.dbtodolog.length ==0){
					todaylog += ' <p class="jg" style="padding-left: 2%; color: #6c757d;">변경&nbsp;&nbsp;내역&nbsp;&nbsp;없음</p>';
					daylog += ' <p class="jg" style="padding-left: 2%; color: #6c757d;">변경&nbsp;&nbsp;내역&nbsp;&nbsp;없음</p>';
				}
				
				todaylog +='<br>';
				daylog +='<br>';
				$("#todolog").html(todaylog);
				$("#daylog").html(daylog);
				if(data.filelist.length == 0){
					res += '<div class="jg" >[ 첨부파일이 없습니다. ]</div>';
					$("#filediv").html(res);
				}
				if(data.filelist.length != 0) {
					for( i = 0 ; i< data.filelist.length; i++){	
 						res += '<a href="${pageContext.request.contextPath}/file/publicfileDown?pubId='+data.filelist[i].pubId+'"><input id ="files"  type="button" class="btn btn-default jg" name="'+ data.filelist[i].pubId+'" value="'+data.filelist[i].pubFilename+'" ></a>  ';
						
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
.aft{
 	color: #17a2b8; 
	font-weight: bold;
	}
.bef{
	color: black;
	font-weight: bold;
	}
.card-bani{
	background-color: #f6f6f6;
	}
#todoStart{
	display: inline-block;
	margin-right: 10px;
	}
#todoEnd{
	display: inline-block;
	margin-left: 10px;
	}
.linka{
	color: black;
	}


</style>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
		<div class="col-md-12 ns">
          <div class="card card-primary card-outline" id ="cardTodo">
            <div class="card-header">
              <h3 class="card-title jg">일감 상세보기</h3>
            </div>
            <div class="card-body">
             	<input type="hidden" id="todoId">
             	<input type="hidden" id="reqId">
        <table class="table" >
        <tr class="stylediff">
            <th class="success ">제목</th>
         	<td colspan="3" style="padding-left: 20px;"><div class="jg" id="todoTitle"></div></td>
        </tr>
        <tr class="stylediff">
            <th class="success ">담당자</th>
            <td style="padding-left: 20px; width: 700px; "><div class="jg" id="memId"></div></td>
            <th class="success ">진행도</th>
            <td style="padding-left: 20px;"><div class="jg" id="todoPercent"></div></td>
        </tr>
         
        <tr class="stylediff">
            <th class="success">기간</th>
            <td style="padding-left: 20px; width: 700px;"><div class="jg" id="todoStart"></div>~<div class="jg" id="todoEnd"></div></td>
            <th class="success">우선순위</th>
            <td style="padding-left: 20px;"><div class="jg" id="todoImportance"></div></td>
        </tr>
         
        <tr>
            <th class="success">내용</th>
            <td colspan="3" style="padding-left: 20px;"><div class="jg" id="todoCont"></div></td>
        </tr>
        <tr>
            <th class="success">첨부파일</th>
            <td colspan="3" style="padding-left: 20px;"><div id = "filediv"></div>
			</td>
        </tr>
        </table>
        <br>
				 <c:if test="${SMEMBER.memId eq projectVo.memId }">
		         <div id="btnMenu">
					 <button type="button" class="btn btn-default jg" id="updateBtn">수정</button>
					 <button type="button" class="btn btn-default jg" id="deleteBtn">삭제</button>
					 <div class="float-right">
					 <button type="button" class="btn btn-default jg " id="creatChildBtn">하위일감 생성</button>
					 <button type="button" class="btn btn-default jg " id="back">뒤로가기</button>    
				 	 </div>
				 </div>
				 </c:if>
				 <c:if test="${SMEMBER.memId ne projectVo.memId }">
		         <div id="btnMenu">
					 <button type="button" class="btn btn-default jg float-right" id="back">뒤로가기</button>    
				 </div>
				 </c:if>
            </div>
          </div>
          
          <div class="card" id ="childtot">
            <div class="card-header card-bani jg">
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
          <div class="card" id ="todologl">
            <div class="card-header card-bani jg">
              <h3 class="card-title">변경이력</h3>
              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                  <i class="fas fa-plus"></i>
                </button>
              </div>
            </div>
            <div class="card-body" style="display: none;">
              <div class="form-group" id ="todolog">
              </div>
              <div class="form-group" id ="daylog">
              </div>
            </div>
          </div>
</div>
</html>