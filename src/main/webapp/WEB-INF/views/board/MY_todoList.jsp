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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	
	// 페이징처리
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/todo/MytodoList'/>";
	   	document.listForm.submit();
	}
	
	// 상세 보기
	function todoDetail(todoId){
	   	document.location = "/todo/onetodoView?todoId="+todoId;
	}
	
	// 이슈 작성
	function todoInsert(todoId){
	}
	
	// 건의사항 작성
	function suggestInsert(todoId){
	}
	
	 function search(){
		document.listForm.action = "<c:url value='/todo/MytodoList'/>";
		document.listForm.submit();
	}

</script>
<style type="text/css"> 
#todoTable{
	width : 1300px;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  

</style>
</head>
<body>
	<%@include file="../layout/contentmenu.jsp"%>
	
	<form:form commandName="todoVo" id="listForm" name="listForm" method="post">
	<div style="padding-left: 30px; background-color: white;">
		<br>
		    <div class="card-header with-border">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">						
        				<form:select path="searchCondition" cssClass="use" class="form-control col-md-3" style="width: 100px;">
							<form:option value="1" label="담당자"/>
							<form:option value="2" label="내용"/>
							<form:option value="3" label="제목"/>
						</form:select> 
							<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                         <input type="text" class="form-control" name="searchKeyword" value="${todoVo.searchKeyword }">
		                  <a href="javascript:search();">
		                  	<button type="button" class="btn-default" style="height: 100%;">
                               <i class="fa fa-search"></i>
                          	</button>
                          </a>
					</div>
		        </div>
		      </div>
		
		<table id="todoTable">
			<tr>
				<th>No.</th>
				<th>상태</th>
				<th>제목</th>
				<th>담당자</th>
				<th>Progress</th>
				<th>진행도</th>
				<th>진행일</th>
				<th>마감일</th>
				<th></th>
			</tr>
			<tbody id="todoList">
				<c:forEach items="${todoList }" var="todo" varStatus="sts" >
				    <tr>
					<td><c:out value="${paginationInfo.totalRecordCount - ((todoVo.pageIndex-1) * todoVo.pageUnit + sts.index)}"/>. 
					<input type="hidden" id="${todo.reqId }" name="${todo.reqId }">
					</td>			
					<td>
					<c:if test="${todo.todoImportance eq 'gen'}"><span class="badge badge-success">일반</span></c:if>
					<c:if test="${todo.todoImportance eq 'emg'}"><span class="badge badge-danger">긴급</span></c:if>
					</td>
					<c:if test="${todo.todoLevel ne '1'}">
					<td style="padding-left: 20px;">➜${todo.todoTitle}</td>
					</c:if>
					<c:if test="${todo.todoLevel eq '1'}">
					<td>${todo.todoTitle}</td>
					</c:if>
					<td>${todo.memId}</td>
					<c:if test= "${todo.todoPercent eq '0'}">
						<td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-danger" style="width: <c:out value="${NUM+1}" />%"></div>
	                        </div>
	                    </td>
	                    <td><span class="badge bg-danger">${todo.todoPercent}%</span></td>   
                    </c:if>   
					<c:if test= "${todo.todoPercent+0 >=30+0 and todo.todoPercent+0 <=59+0}">
                        <td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-primary" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                    </td>    
	                    <td><span class="badge bg-primary">${todo.todoPercent}%</span></td>
                     </c:if>   
					<c:if test= "${todo.todoPercent+0 >=60+0 and todo.todoPercent+0 <=99+0}">
                        <td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-warning" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                     </td>   
	                     <td><span class="badge bg-warning">${todo.todoPercent}%</span></td>
                    </c:if>   
					<c:if test= "${todo.todoPercent eq '100'}">
                    	<td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-success" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                     </td>
	                     <td><span class="badge bg-success">${todo.todoPercent}%</span></td>   
                     </c:if>   
					<td>${todo.todoStart}일</td>
					<td>${todo.todoEnd}</td>
					<td class="project-actions text-right" style="opacity: .9;">
				        <a class="btn btn-primary btn-sm" href="javascript:todoDetail(${todo.todoId });">
				        	<i class="fas fa-folder"></i>상세보기</a>
						<a class="btn btn-info btn-sm" href="javascript:todoInsert(${todo.todoId });">
				        	<i class="fas fa-pencil-alt"></i>이슈 작성</a>
						<a class="btn btn-danger btn-sm" href="javascript:suggestInsert(${todo.todoId });">
				        	<i class="fas fa-pencil-alt"></i>건의사항 작성</a>
			        </td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div id="paging" class="card-tools">
		    <ul class="pagination pagination-sm float-right">
		   		<li class="page-item"><a class="page-link" href="#">«</a></li>
				<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page"  />
				<form:hidden path="pageIndex" />
			    <li class="page-item"><a class="page-link" href="#">»</a></li>
		    </ul>
        </div>
	</div>
		</form:form>		
</body>
</html>