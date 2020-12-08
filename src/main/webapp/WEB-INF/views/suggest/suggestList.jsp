<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style type="text/css">
#pagenum a {
	display: inline-block;
	text-align: center;
	width: auto;
	border: none;
	background: transparent;
}

li strong {
	display: inline-block;
	text-align: center;
	width: 30px;
}

.pagingui {
	display: inline-block;
	text-align: center;
	width: 30px;
}

#paging {
	display: inline-block;
	/* 		 text-align: center; */
	width: auto;
	float: left;
	margin: 0 auto;
	text-align: center;
	"
}

#searchBtn {
	color: #fff;
	background-color: #007bffab;
	border-color: #007bff;
	box-shadow: none;
}
th,td{
	text-align : center;
}
</style>

<script type="text/javascript">
$(function(){
	$("#insertissue").on('click', function(){
		
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/insertissueView');
	})
	
	$("#pagenum a").addClass("page-link");  
	
	// 북마크 클릭시
	$(".area-desc").click(function() { 
		var arrowImage = $(this).children("span").children("img"); 
		
		arrowImage.attr("src", function(index, attr){ 
			issueid = arrowImage.attr('name')
			if (attr.match('white')) { 			
						
				$.ajax({url :"${pageContext.request.contextPath}/bookmark/addbookmark",
					 method : "get",
					 data : {issueId : issueid},
					 success :function(data){	
						
						alert('등록성공') 	
					 }
				})				
				return attr.replace("white", "black"); 
			} else if(attr.match('black')){ 
				$.ajax({url :"${pageContext.request.contextPath}/bookmark/removebookmark",
					 method : "get",
					 data : {issueId : issueid},
					 success :function(data){	
						alert('삭제성공'); 	
					 }
				})	
				return attr.replace("black", "white"); 
			} 
		}); 
	});

})

/* pagination 페이지 링크 function */
 function fn_egov_link_page(pageNo){
 	document.listForm.pageIndex.value = pageNo;
 	document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
    document.listForm.submit();
 }
 
 function issueInsert(){
 	document.listForm.action = "<c:url value='${pageContext.request.contextPath}/projectMember/insertissueView'/>";
    document.listForm.submit();
 }
 
 function search(){
 	document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
    document.listForm.submit();
}
	 
</script>
<%@include file="/WEB-INF/views/layout/contentmenu.jsp"%>

<form:form commandName="suggestVo" id="listForm" name="listForm" method="post">
	<section class="content">
		<div class="col-12 col-sm-12">
			<div class="card" style="border-radius: inherit; padding: 2px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<br>
						<div class="col-sm-6">
							<br>
							<h1 class="jg" style="padding-left: 10px;">건의 사항 리스트</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right" style="background: white">
								<li class="breadcrumb-item san"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">건의 사항 리스트</li>
							</ol>
						</div>
					</div>
				</div>

				<div class="card-header">
					<div id="keyword" class="card-tools float-right"
						style="width: 550px;">
						<div class="input-group row">
							<label for="searchCondition" style="visibility: hidden;"></label>

							<form:select path="searchCondition" cssClass="use"
								class="form-control col-md-3" style="width: 100px;">
								<form:option value="1" label="작성자" />
								<form:option value="2" label="제목" />
								<form:option value="3" label="내용" />
							</form:select>

							<label for="searchKeyword"
								style="visibility: hidden; display: none;"></label>
							<form:input style="width: 300px;" path="searchKeyword"
								cssClass="txt" placeholder="검색어를 입력하세요." class="form-control" />
							<span class="input-group-append">
								<button class="btn btn-primary" type="button" id="searchBtn"
									onclick="search()">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>

							<!-- end : search bar -->
						</div>
						<br>
					</div>
				</div>
				<!-- /.container-fluid -->

				<!-- /.card-header -->
				<div class="card-body p-0">
					<table class="table">
						<thead>
							<tr>
								<th style="width: 150px; padding-left: 50px;">No.</th>
								<th style="padding-left: 30px;">건의사항 제목</th>
								<th>작성자</th>
								<th>날짜</th>
								<th>해당일감</th>
								<th>처리현황</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${suggestList }" var="suggest" varStatus="status">
								<tr>

									<td style="width: 150px; padding-left: 50px;"><c:out
											value="${  ((suggest.pageIndex-1) * suggest.pageUnit + (status.index+1))}" />.</td>

									<td style="padding-left: 30px;">
										<a href="#">${suggest.sgtTitle }</a>
									</td>
											
									<td>${suggest.memId }</td>
									<td>${suggest.regDt }</td>
									<td>${suggest.todoId }</td>
									<!-- 건의사항 상태 : 대기, 승인, 반려에 따른 출력 -->
									<c:if test="${'WAIT' == suggest.sgtStatus }">
										<td>대기</td>
									</c:if>
									<c:if test="${'Y' == suggest.sgtStatus }">
										<td>승인</td>
									</c:if>
									<c:if test="${'N' == suggest.sgtStatus }">
										<td>반려</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<br>
				<div id="paging" class="card-tools">
					<ul class="pagination pagination-sm" id="pagingui">

						<li class="page-item" id="pagenum"><ui:pagination
								paginationInfo="${paginationInfo}" type="image"
								jsFunction="fn_egov_link_page" /></li>
						<form:hidden path="pageIndex" />

					</ul>
				</div>
				<br>
				<div class="card-footer clearfix">
					<button id="insertissue" type="button"
						class="btn btn-default float-right" onclick="issueInsert()">
						<i class="fas fa-plus"></i>등 록
					</button>
				</div>



				<!-- /.card-body -->
			</div>
		</div>
	</section>
	<br>
</form:form>