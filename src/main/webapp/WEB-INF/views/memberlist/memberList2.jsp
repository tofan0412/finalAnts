<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
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

<script type="text/javascript">
$(function(){
	
	$("#insertmemlist").on('click', function(){
		
		$(location).attr('href', '${pageContext.request.contextPath}/admin/insertmemlistView');
	})
	
	$("#pagenum a").addClass("page-link");  

})
$(function(){
	$("body").keyup(function(e){
		if(e.keyCode == 13){
			$('#searchBtn').trigger("click");
		}
	})
})

/* pagination 페이지 링크 function */
 function fn_egov_link_page(pageNo){
 	document.listForm.pageIndex.value = pageNo;
 	document.listForm.action = "<c:url value='/admin/memberlist'/>";
    document.listForm.submit();
 }
 
 function memlistInsert(){
 	document.listForm.action = "<c:url value='${pageContext.request.contextPath}/admin/insertmemlistView'/>";
    document.listForm.submit();
 }
 
 function search(){
	 	document.listForm.pageIndex.value = 1;
	 	document.listForm.action = "<c:url value='/admin/memberlist'/>";
	    document.listForm.submit();
}
	 
</script>
</head>


<body>
<!-- 	<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
<form:form commandName="memberVo" id="listForm" name="listForm" method="post">
	<section class="content" >
		<div class="col-12 col-sm-12">
			<div class="card" style="border-radius: inherit; padding : 2px; margin-top: 10px">
				<!-- 헤더 부분 -->
				<div class="container-fluid">
					<div class="row mb-2">
						<br>
						<div class="col-sm-6">
							<br>
							<h1 class="nav-icon fas fa-address-book" style="padding-left: 10px;">&nbsp;회원리스트</h1>
							
							
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right" style="background: white">
								<li class="breadcrumb-item san jg"><a href="${pageContext.request.contextPath}/admin/adMainView">Home</a></li>
								<li class="breadcrumb-item active jg">회원 리스트</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- 헤더 부분 끝 -->
				
				<!-- 검색창 라인 -->
				<div class="card-header  ">
					<div id="keyword" class="card-tools float-left" style="width: 450px;">
						<button class="btn btn-default">
							<li class="fas fa-download"></li> &nbsp;
							<a style="color : black;"href="/excel/memlistexcelDown"> Excel다운로드</a>
						</button>
					</div>
					<div id="keyword" class="card-tools float-right" style="width: 450px;">
						<div class="input-group row">
							<label for="searchCondition" style="visibility: hidden;"></label>


							<form:select path="searchCondition"
								class="form-control col-md-3 jg" style="width: 100px;">
								<form:option value="1" class="jg" label="아이디" />
								<form:option value="2" class="jg" label="이름" />
								<form:option value="3" class="jg" label="타입" />
							</form:select>


							<label for="searchKeyword"
								style="visibility: hidden; display: none;" class="jg"></label>
							<form:input style="width: 300px;" path="searchKeyword"
								placeholder="검색어를 입력하세요." class="form-control jg" />
							<!--  						    <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="">  -->
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
								<th class="jg" style="width : 10%; padding-left: 20px; text-align: center;">No.</th>
								<th class="jg" style="padding-left: 10%; width: 37%">아이디</th>
								<th class="jg" style="text-align: center; width: 10%">이름</th>
								<th class="jg" style="text-align: center; width: 15%">전화번호</th>
								<th class="jg" style="text-align: center; width: 11%">타입</th>
								<th class="jg" style="text-align: center; width: 13%">알람</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${memberlist }" var="member" varStatus="status">
								<tr>
									<td class="jg" style="width: 10%; padding-left: 20px; text-align: center;">
										<c:out value="${  ((memberVo.pageIndex-1) * memberVo.pageUnit + (status.index+1))}" />.</td>
									<td class="jg" style="padding-left: 10%; width: 37%">
										<a href="${pageContext.request.contextPath}/admin/memlistprofile?memId=${member.memId}">
											${member.memId }</a></td>
									<td class="jg" style="text-align: center;">${member.memName }</td>
									
									<c:choose>
										<c:when test="${member.memTel eq null }">
											<td class="jg" style="text-align: center;">-</td>
										</c:when>
										<c:otherwise>
											<td class="jg" style="text-align: center;">${member.memTel }</td>
										</c:otherwise>
									</c:choose>
										
									<td class="jg" style="text-align: center;">${member.memType }</td>
									<td class="jg" style="text-align: center;">${member.memAlert }</td>
								</tr>
							</c:forEach>
							<c:if test="${memberlist.size() == 0}">
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