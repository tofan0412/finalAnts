<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
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
		 width:auto; float:left; margin:0 auto; text-align:center;"
		 
	}
	
	.option{
		height: 50px;
		width: 150px;
		padding: 5px;
	}
</style>

<script>
$(function(){
	$("#delproject").on('click', function(){
        if(confirm("정말 삭제하시겠습니까 ?") == true){
			$(location).attr('href', '${pageContext.request.contextPath}/admin/delproject?reqId=${projectvo.reqId}');
        }else{
        	return;
        }
	})
})
$(function(){
	
	$("#pagenum a").addClass("page-link");  
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
	 	document.listForm.action = "<c:url value='/admin/projectlist'/>";
	    document.listForm.submit();
}
</script>
</head>
<body>
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
							<h1 class="jg" style="padding-left: 10px;">프로젝트 리스트</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right" style="background: white">
								<li class="breadcrumb-item san jg"><a href="#">Home</a></li>
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
								<form:option value="2" class="jg" label="관계자" />
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
								<th style="width: 150px; padding-left: 50px; text-align: center;">No.</th>
								<th style="text-align: center;">제목</th>
								<th style="text-align: center;">담당자</th>
								<th style="text-align: center;">날짜</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${projectlist }" var="project" varStatus="status">
								<tr>
									<td style="width: 150px; padding-left: 50px; text-align: center;">
										<c:out value="${  ((projectVo.pageIndex-1) * projectVo.pageUnit + (status.index+1))}" />.</td>
									<td style="text-align: center;">${project.proName }</td>
									<td style="text-align: center;">${project.memId }</td>
									<td style="text-align: center;">${project.regDt }</td>
									<td><button id="delproject" class="btn btn-danger projectDelBtn" reqId=${project.reqId }>삭제</button></td>
								</tr>
							</c:forEach>
							<c:if test="${projectlist.size() == 0}">
								<td colspan="7" style="text-align: center;"><br>
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
			</div>
		</div>
	</section>
</form:form>	
</body>
</html>