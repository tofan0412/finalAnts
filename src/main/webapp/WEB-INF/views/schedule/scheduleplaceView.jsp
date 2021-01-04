<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
body{
	min-width: 1000px;
	
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
		 width:auto; 
		 float:left; 
		 margin:0 auto; 
		 text-align:center;
		 margin-top:20px;	
		 margin-left:45%;		
	}	
</style>

<script  type="text/javascript">
$(document).ready(function(){
	$("#schedulelist tr").on("click",function(){
		var scheId = $(this).data("scheid");
			$(location).attr('href', '${pageContext.request.contextPath}/schedule/scheduleSelect?scheId='+scheId);
	});
})   

function scheInsert(){
 	document.listForm.action = "<c:url value='${pageContext.request.contextPath}/schedule/scheduleInsertview'/>";
 	document.listForm.submit();
 }	
	
/* pagination 페이지 링크 function */
 function fn_egov_link_page(pageNo){
 	document.listForm.pageIndex.value = pageNo;
 	document.listForm.action = "<c:url value='/schedule/scheduleplaceView'/>";
    document.listForm.submit();
 }
</script>
	
<body>	
<%@include file="../layout/contentmenu.jsp"%>
<form:form commandName="scheduleVo" id="listForm" name="listForm" method="post">
	<section class="content" >
	      <div class="col-12 col-sm-12">
		    <div class="card" style="border-radius: inherit; padding : 2px;">
	        <br>
	        <div class="card-header  ">
	        <div id="keyword" class="card-tools float-left" style="width: 450px;">
					<h3 class="jg" style="padding-left: 10px;">일정 리스트 / <a style="color: black;" href="${pageContext.request.contextPath}/schedule/clendarView">Calendar</a></h3>
			</div>
			<div id="keyword" class="card-tools float-right" style="width: 450px;">
				<div class="input-group row">
					<label for="searchCondition" style="visibility:hidden;"></label>
			
       				<form:select path="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">
						<form:option value="1" label="제목"/>
						<form:option value="2" label="내용"/>
						<form:option value="3" label="작성자"/>
					</form:select> 					
					
					<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
                    <form:input style="width: 300px;" path="searchKeyword" placeholder="검색어를 입력하세요." class="form-control jg"/>
<!--  						    <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="">  -->
					<span class="input-group-append">							
						<button class="btn btn-default" type="button" id="searchBtn" onclick="search()" >
							<i class="fa fa-fw fa-search"></i>
						</button>
					</span>
					
					<!-- end : search bar -->
				</div>
				<br>
	        </div>
		        
		  </div><!-- /.container-fluid -->


	 <div class="card-body p-0">
		<table id="todoTable" class="table">
			<tr>				
				<th class="jg" style="text-align: center;" id="1">No.</th>
				<th class="jg" style="padding-left: 50px; width: 35%;" id="2">제목</th>
				<th class="jg" style="text-align: center;" id="3">작성자</th>
				<th class="jg" style="text-align: center;" id="4">등록일</th>
			</tr>
 	
			<tbody id="schedulelist">
				<c:forEach items="${schedulelist}" var="schedule" varStatus="sts" >
				    <tr data-scheid="${schedule.scheId}">
						
						<td class="jg" style="width: 200px; text-align: center;"><c:out value="${  ((scheduleVo.pageIndex-1) * scheduleVo.pageUnit + (sts.index+1))}"/>.</td>
					
						<td style="padding-left: 50px; width: 35%;" class="jg">
							<c:if test="${fn:length(schedule.scheTitle) > 30}">									
								${fn:substring(schedule.scheTitle,0 ,30) }...
							</c:if>
							<c:if test="${fn:length(schedule.scheTitle) <= 30}">									
									${schedule.scheTitle}
							</c:if>
						</td>
						<td style="text-align: center;" class="jg">
							${schedule.memName }
						</td>
						<td style="text-align: center;" class="jg">
							${schedule.regDt }
						</td>
					</tr>
				</c:forEach> 
			</tbody>
		</table>
	  </div>

	
	<div id="paging" class="card-tools">
		<ul class="pagination pagination-sm jg" id="pagingui" style="margin-bottom: 0px;">
			<li class="page-item jg" id="pagenum">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
			</li>
			<form:hidden path="pageIndex" />
		</ul>
	</div>
		
	
	<div class="card-footer clearfix">
		<c:if test="${projectVo.proStatus eq 'ACTIVE'}">
        	<button id="insertissue" type="button" class="btn btn-default float-left jg" onclick="scheInsert()"><i class="fas fa-edit"></i>등 록</button>
		</c:if>	
	</div>
<!-- /.card-body -->
	
       </div>
    </div>
  </section>
  <br>
</form:form>
</body>
