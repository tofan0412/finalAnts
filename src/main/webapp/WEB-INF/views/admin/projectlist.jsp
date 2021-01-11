<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 padding : 6px; 	 
		 border: none; 
	
	}
	/*
	#table{
		width : 100%;
	    border-top: 1px solid #444444;
	    border-collapse: collapse;
	    text-align: center;
  	}
   	th, td { 
 	    border-bottom: 1px solid #444444; 
 	    padding: 10px; 
   	} 
   	*/
   	
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
		 width:auto; float:left; margin:0 auto; text-align:center;"
		 
	}
	
	.option{
		height: 50px;
		width: 150px;
		padding: 5px;
	}
	#recent, #old{
		background-color:transparent;  
	 	border:0px transparent solid;
	 	outline: none;
	}
</style>

<script type="text/javascript">
$(function(){
	$('.projectDelBtn').click(function(e){
		e.preventDefault();
		alert("프로젝트가 삭제되었습니다.");
		
		var reqId = $(this).attr("reqId");
		//$(location).attr("href", "/admin/delproject?reqId="+reqId);
		location.href="/admin/delproject?reqId="+reqId;
	})
	/*
	$("#delproject").on('click',function(){
		if(confirm("정말 삭제하시겠습니까 ?") == true){
			$(location).attr('href', '${pageContext.request.contextPath}/admin/delproject?reqId=${project.reqId}');
        }else{
        	return;
        }
	})
	*/
	$("body").keyup(function(e){
		if(e.keyCode == 13){
			$('#searchBtn').trigger("click");
		}
	})
})

/* pagination 페이지 링크 function */
 function fn_egov_link_page(pageNo){
 	document.listForm.pageIndex.value = pageNo;
 	document.listForm.action = "<c:url value='/admin/projectlist'/>";
    document.listForm.submit();
 }
 
 function memlistInsert(){
 	document.listForm.action = "<c:url value='${pageContext.request.contextPath}/admin/insertmemlistView'/>";
    document.listForm.submit();
 }
 
 function search(){
	document.listForm.pageIndex.value = 1;
	document.listForm.action = "<c:url value='/admin/projectlist'/>";
    document.listForm.submit();
}
</script>

<!-- 	<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
<form:form commandName="projectVo" id="listForm" name="listForm" method="post">
	<section class="content" >
		<div class="col-12 col-sm-12">
			<div class="card" style="border-radius: inherit; padding : 2px; margin-top: 10px">
				<!-- 헤더 부분 -->
				<div class="container-fluid">
					<div class="row mb-2">
						<br>
						<div class="col-sm-6">
							<br>
							<h1 class="nav-icon fas fa-tasks" style="padding-left: 10px;">&nbsp;프로젝트 리스트</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right" style="background: white">
								<li class="breadcrumb-item san jg"><a href="${pageContext.request.contextPath}/admin/adMainView">Home</a></li>
								<li class="breadcrumb-item active jg">프로젝트 리스트</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- 헤더 부분 끝 -->
				
				<!-- 검색창 라인 -->
				<div class="card-header  ">
					<div id="keyword" class="card-tools float-right"
						style="width: 450px;">
						<div class="input-group row">
							<label for="searchCondition" style="visibility: hidden;"></label>


							<form:select path="searchCondition"
								class="form-control col-md-3 jg" style="width: 100px;">
								<form:option value="1" class="jg" label="제목" />
								<form:option value="2" class="jg" label="담당자" />
							</form:select>


							<label for="searchKeyword"
								style="visibility: hidden; display: none;" class="jg"></label>
							<form:input style="width: 300px;" path="searchKeyword"
								placeholder="검색어를 입력하세요." class="form-control jg" />
							<span class="input-group-append">
								<button class="btn btn-default" type="button" id="searchBtn"
									onclick="search()">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>

							<!-- end : search bar -->
						</div>
						<br>
					</div>
				</div>
				<!-- 검색창 라인 끝 -->
				
				<!-- 리스트 부분 시작 -->
	            <div class="card-body p-0">
	            	<table class="table">
	            		<!-- 헤더부분  -->
						<thead>
							<tr>
								<th class="jg" style="width: 10%; padding-left: 30px; text-align: center;">No.</th>
								<th class="jg" style="padding-left: 30px; width: 30%">제목</th>
								<th class="jg" style="text-align: center; width: 15%">담당자</th>
								<th class="jg" style="text-align: center; width: 15%">날짜</th>
								<th class="jg" style="text-align: center; width: 13%">진행여부</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${projectlist }" var="project" varStatus="status">
								<tr>
									<td class="jg" style="width: 10%; padding-left: 30px; text-align: center;">
										<c:out value="${  ((projectVo.pageIndex-1) * projectVo.pageUnit + (status.index+1))}" />.</td>
									<td class="jg" style="padding-left: 30px; width: 30%">${project.proName }</td>
									<td class="jg" style="text-align: center; width: 15%">${project.memId }</td>
									<td class="jg" style="text-align: center;" width="15%">${project.regDt }</td>
<%-- 									<td class="jg" style="text-align: center;" width="13%">${project.proStatus }</td> --%>
									<c:choose>
										<c:when test="${project.proStatus eq null }">
											<td class="jg" style="text-align: center; width:13%">대기</td>
										</c:when>
										<c:when test="${project.proStatus eq 'ACTIVE' }">
											<td class="jg" style="text-align: center; width:13%">진행</td>
										</c:when>
										<c:when test="${project.proStatus eq 'STOP' }">
											<td class="jg" style="text-align: center; width:13%">중지</td>
										</c:when>
										<c:when test="${project.proStatus eq 'END' }">
											<td class="jg" style="text-align: center; width:13%">완료</td>
										</c:when>
<%-- 										<c:otherwise> --%>
<%-- 											<td class="jg" style="text-align: center; width:13%;">${project.proStatus }</td> --%>
<%-- 										</c:otherwise> --%>
									</c:choose>
									
									<td><button id="delproject" type="button" class="btn btn-danger projectDelBtn" style="width:45pt;height:24pt;font-size: 15px" reqId=${project.reqId }>삭제</button></td>
										
								</tr>
							</c:forEach>
							<c:if test="${projectlist.size() == 0}">
								<td colspan="7" style="text-align: center;" class="jg"><br>
								<strong> [ 결과가 없습니다. ] </strong></td>
							</c:if>
						</tbody>
					</table>
	            </div>
	            <!-- 리스트 부분 끝 -->
	            <br>
				<!-- 페이징,등록 부분 시작 -->
				<div id="paging" class="card-tools">
					<ul class="pagination pagination-sm jg" id="pagingui">
						<li class="page-item jg" id="pagenum">
							<ui:pagination paginationInfo="${paginationInfo}" type="image"
							jsFunction="fn_egov_link_page" />
						</li>
						<form:hidden path="pageIndex" />
					</ul>
				</div>
				<br>
	<span class="jg" style="float : right; margin-right : 10px;">*삭제를  클릭하는 경우, 해당 프로젝트가 즉시 삭제됩니다.</span>
			</div>
		</div>
	</section>
</form:form>	
