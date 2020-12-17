<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">

<script type="text/javascript">
	$(document).ready(function(){
		// 상세일감 보러가기
		$("#todoList tr").on("click",function(){
			var todoId = $(this).data("todoid");
	 		$(location).attr('href', '${pageContext.request.contextPath}/todo/onetodoView?todoId='+todoId);
			});
		
		$("#pagenum a").addClass("page-link");  
		});
	
		$("#todoinsert").on('click', function(){
			$(location).attr('href', '${pageContext.request.contextPath}/todo/todoInsertView');
		})
	
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/todo/todoList'/>";
	   	document.listForm.submit();
	}
	 function search(){
		document.listForm.action = "<c:url value='/todo/todoList'/>";
		document.listForm.submit();
	}
		

</script>
<style type="text/css"> 
#todoTable{
	width : 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    text-align: center;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }


	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 width : auto;	 
		 border: none; 
	
	}
	
	li strong{
		display: inline-block;
		text-align: center;
		width: 30px;
	}
	
	.pagingui{
		 display: inline-block;
		 text-align: center;
		 width: 30px;
		 
	}
	#paging{
		 display: inline-block;
		 width:auto; float:left; margin:0 auto; text-align:center;
		 
	}
	
	
  

</style>
</head>
<body>
	<%@include file="../layout/contentmenu.jsp"%>
	
	<form:form commandName="todoVo" id="listForm" name="listForm" method="post">
	
	<div class="col-12 col-sm-12">
	<div class="card" style="border-radius: inherit; padding : 2px;">
		 <c:if test="${SMEMBER.memId eq projectVo.memId }">
	           <div >
	                <button id="todoinsert" type="button" class="btn btn-default jg"><i class="fas fa-edit"></i>일감 등록</button>
	              </div>
	              
<%-- 				차트	<a class="btn btn-default " href="${pageContext.request.contextPath }/todo/chartView"><i class="fas fa-edit"></i>차트</a> --%>
			   </c:if>
		<br>
		    <div class="card-header ">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">						
        				<select name="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">
							<option value="1" label="담당자"/>
							<option value="2" label="내용"/>
							<option value="3" label="제목"/>
							<option value="4" label="진행도"/>
						</select> 
							 <label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                         <input type="text" class="form-control jg" name="searchKeyword" value="${todoVo.searchKeyword }">
		                  <a href="javascript:search();">
		                  	<button type="button" class="btn-default " style="height: 100%;">
                               <i class="fa fa-search"></i>
                          	</button>
                          </a>
					</div>
		        </div>
		      </div>
		<div class="card-body p-0">
		<table id="todoTable" class="jg">
			<tr>
				<th style="padding-left: 10px;">No.</th>
				<th>상태</th>
				<th >제목</th>
				<th>담당자</th>
				<th>Progress</th>
				<th>진행도</th>
				<th>진행일</th>
				<th>마감일</th>
			</tr>
			<tbody id="todoList" >
				<c:forEach items="${todoList }" var="todo" varStatus="sts" >
					<c:if test="${ todo.todoLevel eq '1' }">
				    <tr data-todoid="${todo.todoId}">
					<td><c:out value="${paginationInfo.totalRecordCount - ((todoVo.pageIndex-1) * todoVo.pageUnit + sts.index)}"/>. 
					<input type="hidden" id="${todo.reqId }" name="${todo.reqId }">
					</td>			
					<td>
					<c:if test="${todo.todoImportance eq 'gen'}"><span class="badge badge-success ns">일반</span></c:if>
					<c:if test="${todo.todoImportance eq 'emg'}"><span class="badge badge-danger ns">긴급</span></c:if>
					</td>
					<td >${todo.todoTitle}</td>
					<td>${todo.memId}</td>
					<c:if test= "${todo.todoPercent eq '0'}">
						<td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-danger" style="width:<c:out value="${NUM+1}"/>%"></div>
	                        </div>
	                    </td>
	                    <td>${todo.todoPercent} %</td>   
                    </c:if>   
					<c:if test= "${todo.todoPercent+0 >=30+0 and todo.todoPercent+0 <=59+0}">
                        <td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-primary" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                    </td>    
	                    <td>${todo.todoPercent} %</td>
                     </c:if>   
					<c:if test= "${todo.todoPercent+0 >=60+0 and todo.todoPercent+0 <=99+0}">
                        <td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-warning" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                     </td>   
	                     <td>${todo.todoPercent} %</td>
                    </c:if>   
					<c:if test= "${todo.todoPercent eq '100'}">
                    	<td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-success" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                     </td>
	                     <td>${todo.todoPercent} %</td>   
                     </c:if>   
					<td>${todo.todoStart}일</td>
					<td>${todo.todoEnd}</td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		</div>
		   <br>
	              <div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm jg" id ="pagingui">
		        		<li  class="page-item jg" id ="pagenum" >	
		        		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
		        		<form:hidden path="pageIndex" />		        		
                    
	                 </ul>
        		  </div>
        		  <br>
	          
           </div>
       </div>
</form:form>		
</body>
</html>