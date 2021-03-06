<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
	
	// 페이징처리
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/todo/MytodoList'/>";
	   	document.listForm.submit();
	}
	
	 function search(){
		 document.listForm.pageIndex.value = 1;
		document.listForm.action = "<c:url value='/todo/MytodoList'/>";
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
		 padding : 6px; 	 
		 border: none; 
	}
	
	li strong{
		display: inline-block;
		text-align: center;
		 padding : 6px; 
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
<%@include file="../layout/contentmenu.jsp"%>
	
<form:form commandName="todoVo" id="listForm" name="listForm" method="post">
<div class="col-12 col-sm-12">
	<div class="card" style="border-radius: inherit; padding : 2px;">
	
		<br>
	    <div class="card-header">
	    	<div id="keyword" class="card-tools float-left"
					style="width: 450px;">
					<h3 class="jg" style="padding-left: 10px;">내 일감</h3>
			</div>
			<div id="keyword" class="card-tools float-right" style="width: 450px;">
				<div class="input-group row">
					<label for="searchCondition" style="visibility:hidden;"></label>
															
       				<form:select path="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">
						<form:option value="1" label="제목"/>
						<form:option value="2" label="내용"/>
						<form:option value="3" label="진행도"/>
					</form:select> 
					
					<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
                    <form:input style="width: 300px;" path="searchKeyword" placeholder="검색어를 입력하세요." class="form-control jg" />
					<span class="input-group-append">							
						<button class="btn btn-default" type="button" id="searchBtn" onclick="search()" >
							<i class="fa fa-fw fa-search"></i>
						</button>
					</span>
					
				</div>
				<br>
	        </div>
	      </div>
		<div class="card-body p-0">
		<table id="todoTable" class="jg">
			<tr>
				<th style="padding-left: 10px;">No.</th>
				<th>상태</th>
				<th>제목</th>
				<th>담당자</th>
				<th>Progress</th>
				<th>진행도</th>
				<th>진행일</th>
				<th>마감일</th>
				
			</tr>
			<tbody id="todoList">
					<c:forEach items="${todoList }" var="todo" varStatus="sts" >
				  	 <tr>
					<td><c:out value="${paginationInfo.totalRecordCount - ((todoVo.pageIndex-1) * todoVo.pageUnit + sts.index)}"/>. 
					<input type="hidden" id="${todo.reqId }" name="${todo.reqId }">
					</td>			
					<td>
					<c:if test="${todo.todoImportance eq 'gen'}"><span class="badge badge-success ns">일반</span></c:if>
					<c:if test="${todo.todoImportance eq 'emg'}"><span class="badge badge-danger ns">긴급</span></c:if>
					</td>
					<td style="text-align: left;">
					<a href="${pageContext.request.contextPath}/todo/myonetodoView?todoId=${todo.todoId}"> 
					<c:if test="${fn:length(todo.todoTitle) > 30}">									
						${fn:substring(todo.todoTitle,0 ,30) }...
					</c:if>
					<c:if test="${fn:length(todo.todoTitle) <= 30}">									
						${todo.todoTitle}
					</c:if>
					</a> 
					</td>
					<td>${todo.memId}</td>
					<c:if test= "${todo.todoPercent eq '0'}">
						<td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-danger" style="width: <c:out value="${NUM+1}" />%"></div>
	                        </div>
	                    </td>
	                    <td>${todo.todoPercent}%</td>   
                    </c:if>   
					<c:if test= "${todo.todoPercent+0 != 0 and todo.todoPercent+0 <=59+0}">
                        <td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-warning" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                    </td>    
	                    <td>${todo.todoPercent}%</td>
                     </c:if>   
					<c:if test= "${todo.todoPercent+0 >=60+0 and todo.todoPercent+0 <=99+0}">
                        <td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-primary" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                     </td>   
	                     <td>${todo.todoPercent}%</td>
                    </c:if>   
					<c:if test= "${todo.todoPercent eq '100'}">
                    	<td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${todo.todoPercent}" var="NUM"/>
	                          <div class="progress-bar bg-success" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                     </td>
	                     <td>${todo.todoPercent}%</td>   
                     </c:if>   
					<td>${todo.todoStart}일</td>
					<td>${todo.todoEnd}</td>
					
					</tr>
				</c:forEach>
				<c:if test="${todoList.size() == 0}">
				<td colspan="8" style="text-align: center;"  class="jg"><br> [ 결과가 없습니다. ] </td>
				</c:if>
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
