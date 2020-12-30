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
		<c:if test="${dbsize eq '1'}">
          <div class="card card-primary card-outline" id ="cardTodo">
            <div class="card-header">
              <h3 class="card-title jg">일감 상세보기</h3>
            </div>
            <div class="card-body">
      		<c:forEach items="${todoVo }" var= "todo" varStatus="sts" >
             	<input type="hidden" id="todoId" value="${todo.todoId }">
             	<input type="hidden" id="reqId" value="${todo.reqId }">
        <table class="table" >
        <tr class="stylediff">
            <th class="success ">제목</th>
         	<td colspan="3" style="padding-left: 20px;"><div class="jg" id="todoTitle">${todo.todoTitle }</div></td>
        </tr>
        <tr class="stylediff">
            <th class="success ">담당자</th>
            <td style="padding-left: 20px; width: 700px; "><div class="jg" id="memId">${todo.memName }</div></td>
            <th class="success ">진행도</th>
            <td style="padding-left: 20px;"><div class="jg" id="todoPercent">${todo.todoPercent }%</div></td>
        </tr>
         
        <tr class="stylediff">
            <th class="success">기간</th>
            <td style="padding-left: 20px; width: 700px;"><div class="jg" id="todoStart">${todo.todoStart }</div>~<div class="jg" id="todoEnd">${todo.todoEnd }</div></td>
            <th class="success">우선순위</th>
            <c:if test="${todo.todoImportance eq 'emg' }">
            <td style="padding-left: 20px;"><div class="jg" id="todoImportance">긴급</div>
            </td>
            </c:if>
            <c:if test="${todo.todoImportance eq 'gen' }">
            <td style="padding-left: 20px;"><div class="jg" id="todoImportance">일반</div>
            </td>
            </c:if>
        </tr>
         
        <tr>
            <th class="success">내용</th>
            <td colspan="3" style="padding-left: 20px;"><div class="jg" id="todoCont">${todo.todoCont }</div></td>
        </tr>
        <tr>
            <th class="success">첨부파일</th>
            <td colspan="3" style="padding-left: 20px;">
            <div id = "filediv">
	            <c:if test="${empty filelist}">
	 				<div class="jg" >[ 첨부파일이 없습니다. ]</div>
	            </c:if>
	            <c:if test="${not empty filelist}">
	 				<c:forEach items="${filelist }" var= "ffile" varStatus="sts" >
 						<a href="${pageContext.request.contextPath}/file/publicfileDown?pubId=${ffile.pubId}">
 						<input id ="files"  type="button" class="btn btn-default jg" name="${ffile.pubId}" value="${ffile.pubFilename}" ></a>
	 				</c:forEach>
	            </c:if>
            </div>
			</td>
        </tr>
        </table>
        <br>
				 <c:if test="${SMEMBER.memId eq projectVo.memId }">
		         <div id="btnMenu">
					 <button type="button" class="btn btn-default jg" id="updateBtn">수정</button>
					 <button type="button" class="btn btn-default jg" id="deleteBtn">삭제</button>
					 <div class="float-right">
					 <c:if test="${todo.todoLevel eq '1' }">
					 <button type="button" class="btn btn-default jg " id="creatChildBtn">하위일감 생성</button>
					 </c:if>
					 <button type="button" class="btn btn-default jg " id="back">뒤로가기</button>    
				 	 </div>
				 </div>
				 </c:if>
				 <c:if test="${SMEMBER.memId ne projectVo.memId }">
		         <div id="btnMenu">
					 <button type="button" class="btn btn-default jg float-right" id="back">뒤로가기</button>    
				 </div>
				 </c:if>
				 </c:forEach>
            </div>
          </div>
           <c:if test="${not empty dbtodolog}">
          <div class="card" id ="todologl">
            <div class="card-header card-bani jg">
              <h3 class="card-title">변경이력</h3>
              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                  <i class="fas fa-plus"></i>
                </button>
              </div>
            </div>
            <c:forEach items="${dbtodolog }" var= "todolog" varStatus="sts" >
             <div class="card-body" style="display: none;">
              <div class="form-group" id ="todolog">
              <div class="jg" style="font-size: 18px;" >오늘 변경 내역<br>
              <c:if test="${todolog.elapsedDay eq '0' and todolog.elapsedTime eq '0'}">
              	<p class="ns" style="padding-left: 2%; color: #6c757d; font-size: 0.9em;">${todolog.elapsedMin}&nbsp;&nbsp;분&nbsp;&nbsp;전&nbsp;&nbsp;<span class="bef">${todolog.beforeId}</span>에서&nbsp;&nbsp;<span class="aft">${todolog.afterId}</span>(으)로&nbsp;&nbsp;담당자&nbsp;&nbsp;변경</p>
              </c:if>
              <c:if test="${todolog.elapsedDay eq '0' and todolog.elapsedTime ne '0'}">
              	<p class="ns" style="padding-left: 2%; color: #6c757d; font-size: 0.9em;">${todolog.elapsedTime} 시간&nbsp;&nbsp; ${todolog.elapsedMin} 분&nbsp;&nbsp;전&nbsp;&nbsp;<span class="bef">${todolog.beforeId}</span>에서&nbsp;&nbsp;<span class="aft">${todolog.afterId}</span>(으)로&nbsp;&nbsp;담당자&nbsp;&nbsp;변경</p>
			  </c:if>
            </div><br>
              </div>
              <div class="form-group" id ="daylog">
              <div class="jg" style="font-size: 18px;" >과거 변경 내역<br>
              <c:if test="${todolog.elapsedDay ne '0'}">
			  <p class="ns" style="padding-left: 2%; color: #6c757d; font-size: 0.9em;">${todolog.elapsedDay}일&nbsp;&nbsp;전&nbsp;&nbsp;<span class="bef">${todolog.beforeId}</span>에서&nbsp;&nbsp;<span class="aft">${todolog.afterId}</span>(으)로&nbsp;&nbsp;담당자&nbsp;&nbsp;변경</p>
			  </c:if>
              </div><br>
              </div>
            </div>
           </c:forEach>
          </div>
          </c:if>
          </c:if>
          
          
		<c:if test="${dbsize ne '1'}">
		<c:forEach items="${todoVo }" var= "todo" varStatus="sts" >
			<c:if test="${sts.index eq '0'}">
          <div class="card card-primary card-outline" id ="cardTodo">
            <div class="card-header">
              <h3 class="card-title jg">일감 상세보기</h3>
            </div>
            <div class="card-body">
             	<input type="hidden" id="todoId" value="${todo.todoId }">
             	<input type="hidden" id="reqId" value="${todo.reqId }">
        <table class="table" >
        <tr class="stylediff">
            <th class="success ">제목</th>
         	<td colspan="3" style="padding-left: 20px;"><div class="jg" id="todoTitle">${todo.todoTitle }</div></td>
        </tr>
        <tr class="stylediff">
            <th class="success ">담당자</th>
            <td style="padding-left: 20px; width: 700px; "><div class="jg" id="memId">${todo.memName }</div></td>
            <th class="success ">진행도</th>
            <td style="padding-left: 20px;"><div class="jg" id="todoPercent">${todo.todoPercent }%</div></td>
        </tr>
         
        <tr class="stylediff">
            <th class="success">기간</th>
            <td style="padding-left: 20px; width: 700px;"><div class="jg" id="todoStart">${todo.todoStart }</div>~<div class="jg" id="todoEnd">${todo.todoEnd }</div></td>
            <th class="success">우선순위</th>
            <c:if test="${todo.todoImportance eq 'emg' }">
            <td style="padding-left: 20px;"><div class="jg" id="todoImportance">긴급</div>
            </td>
            </c:if>
            <c:if test="${todo.todoImportance eq 'gen' }">
            <td style="padding-left: 20px;"><div class="jg" id="todoImportance">일반</div>
            </td>
            </c:if>
        </tr>
         
        <tr>
            <th class="success">내용</th>
            <td colspan="3" style="padding-left: 20px;"><div class="jg" id="todoCont">${todo.todoCont }</div></td>
        </tr>
         
        <tr>
            <th class="success">첨부파일</th>
            <td colspan="3" style="padding-left: 20px;">
            <div id = "filediv">
	            <c:if test="${empty filelist}">
	 				<div class="jg" >[ 첨부파일이 없습니다. ]</div>
	            </c:if>
	            <c:if test="${not empty filelist}">
	 				<c:forEach items="${filelist }" var= "ffile" varStatus="sts" >
 						<a href="${pageContext.request.contextPath}/file/publicfileDown?pubId=${ffile.pubId}">
 						<input id ="files"  type="button" class="btn btn-default jg" name="${ffile.pubId}" value="${ffile.pubFilename}" ></a>
	 				</c:forEach>
	            </c:if>
            </div>
			</td>
        </tr>
        </table>
        <br>
				 <c:if test="${SMEMBER.memId eq projectVo.memId }">
		         <div id="btnMenu">
					 <button type="button" class="btn btn-default jg" id="updateBtn">수정</button>
					 <button type="button" class="btn btn-default jg" id="deleteBtn">삭제</button>
					 <div class="float-right">
					 <c:if test="${todo.todoLevel eq '1' }">
					 <button type="button" class="btn btn-default jg " id="creatChildBtn">하위일감 생성</button>
					 </c:if>
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
          </c:if>
          </c:forEach>
          </c:if>
          
          <c:if test="${dbsize ne '1'}">
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
             <c:forEach items="${todoVo }" var= "todo" varStatus="sts" >
             <c:if test="${todo.todoLevel eq '2' and sts.index ne '0'}">
               	<p id='intodoId' class='jg' style='padding-left: 2%;'>
               	<i class='far fa-file-alt'></i> 
               	<a class='jg linka' href="${pageContext.request.contextPath}/todo/onetodoView?todoId=${todo.todoId}">${ todo.todoTitle}</a>
               	</p>
               	</c:if>
               	</c:forEach>
              </div>
            </div>
          </div>
        
		    <c:if test="${not empty dbtodolog }">
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
              <div class="jg" style="font-size: 18px;" >오늘 변경 내역<br>
            <c:forEach items="${dbtodolog }" var= "todolog" varStatus="sts" >
              <c:if test="${todolog.elapsedDay eq '0' and todolog.elapsedTime eq '0'}">
              	<p class="ns" style="padding-left: 2%; color: #6c757d; font-size: 0.9em;">${todolog.elapsedMin}&nbsp;&nbsp;분&nbsp;&nbsp;전&nbsp;&nbsp; <span class="bef">${todolog.beforeId}</span>에서&nbsp;&nbsp;<span class="aft">${todolog.afterId}</span>(으)로&nbsp;&nbsp;담당자&nbsp;&nbsp;변경</p>
              </c:if>
              <c:if test="${todolog.elapsedDay eq '0' and todolog.elapsedTime ne '0'}">
              	<p class="ns" style="padding-left: 2%; color: #6c757d; font-size: 0.9em;">${todolog.elapsedTime} 시간&nbsp;&nbsp; ${todolog.elapsedMin} 분&nbsp;&nbsp;전&nbsp;&nbsp;<span class="bef">${todolog.beforeId}</span>에서&nbsp;&nbsp;<span class="aft">${todolog.afterId}</span>로&nbsp;&nbsp;담당자&nbsp;&nbsp;변경</p>
			  </c:if>
           </c:forEach>
            </div>
            <br>
              </div>
              <div class="form-group" id ="daylog">
              <div class="jg" style="font-size: 18px;" >과거 변경 내역<br>
              <c:forEach items="${dbtodolog }" var= "todolog" varStatus="sts" >
              <c:if test="${todolog.elapsedDay ne '0'}">
			  <p class="ns" style="padding-left: 2%; color: #6c757d; font-size: 0.9em;">${todolog.elapsedDay}일&nbsp;&nbsp;전&nbsp;&nbsp;<span class="bef">${todolog.beforeId}</span>에서&nbsp;&nbsp;<span class="aft">${todolog.afterId}</span>(으)로&nbsp;&nbsp;담당자&nbsp;&nbsp;변경</p>
			  </c:if>
              </c:forEach>
              </div>
              <br>
              </div>
            </div>
          </div>
          </c:if>
		</c:if>
</div>
</html>