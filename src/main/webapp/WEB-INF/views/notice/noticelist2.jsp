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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
#pagenum a {
	display: inline-block;
	text-align: center;
	width: 30px;
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

.noticeMain {
	margin: 9px 9px 9px 9px;
	padding: 9px 9px 9px 9px;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#insertnotice")
				.on(
						'click',
						function() {

							$(location)
									.attr('href',
											'${pageContext.request.contextPath}/admin/insertnoticeView');
						})

		$("#pagenum a").addClass("page-link");

	})

	/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo) {
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/admin/noticelist'/>";
		document.listForm.submit();
	}

	function noticeInsert() {
		document.listForm.action = "<c:url value='${pageContext.request.contextPath}/admin/insertnoticeView'/>";
		document.listForm.submit();
	}

	function search() {
		document.listForm.action = "<c:url value='/admin/noticelist'/>";
		document.listForm.submit();
	}
</script>
</head>


<body>
	<form:form commandName="noticeVo" id="listForm" name="listForm"
		method="post">

		<!-- Content Header (Page header) -->

		<section class="content">
		<div class="card noticeMain">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="jg">공지사항</h1>
					</div>
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right"
							style="background-color: white">
							<li class="breadcrumb-item san"><a href="#">Home</a></li>
							<li class="breadcrumb-item active">공지사항</li>
						</ol>
					</div>
				</div>
			</div>

			<!-- 검색창라인 -->
			<div class="card-header  ">
				<div id="keyword" class="card-tools float-right"
					style="width: 450px;">
					<div class="input-group row">
						<label for="searchCondition" style="visibility: hidden;"></label>


						<form:select path="searchCondition" cssClass="use"
							class="form-control col-md-3" style="width: 100px;">
							<form:option value="1" label="제목" />
						</form:select>


						<label for="searchKeyword"
							style="visibility: hidden; display: none;"></label>
						<form:input style="width: 300px;" path="searchKeyword"
							cssClass="txt" placeholder="검색어를 입력하세요." class="form-control" />
						<!--  						    <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="">  -->
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
		</div>
		</section>




		<!-- 		 	<h3>협업이슈 리스트</h3> -->
		<!-- 				<input type= "button" value="작성하기" id="insertissue"> -->

		<section class="content">
		<div class="col-12 col-sm-12">
			<div class="card" style="border-radius: inherit; padding: 2px;">


				<div class="card-body p-0">
					<table class="table">
						<thead>
							<tr>
								<th style="width: 150px; padding-left: 50px;">No.</th>
								<th style="padding-left: 30px;">제목</th>
								<th>작성자</th>
								<th>날짜</th>
								<th></th>
							</tr>
						</thead>
						<tbody>

							<c:forEach items="${noticelist }" var="notice" varStatus="status">
								<tr>

									<td style="width: 150px; padding-left: 50px;"><c:out
											value="${  ((noticeVo.pageIndex-1) * noticeVo.pageUnit + (status.index+1))}" />.</td>

									<td style="padding-left: 30px;"><a
										href="${pageContext.request.contextPath}/admin/eachnoticeDetail?noticeId=${notice.noticeId}">
											${notice.noticeTitle }</a></td>
									<td>${notice.adminId }</td>
									<td>${notice.regDt }</td>
									<td style="text-align: center;">
								</tr>
							</c:forEach>
							<c:if test="${noticelist.size() == 0}">
								<td colspan="7" style="text-align: center;"><br> <strong>
										[ 결과가 없습니다. ] </strong></td>
							</c:if>



						</tbody>
					</table>
				</div>


				<br>
				<div id="paging" class="card-tools">
					<ul class="pagination pagination-sm" id="pagingui">

						<li class="page-item" id="pagenum">
							<%-- 		        		<input type="button" value="#{paginationInfo}" > --%>
							<!-- 						<li class="page-item"><a class="page-link" href="#">«</a></li> -->
							<ui:pagination paginationInfo="${paginationInfo}" type="image"
								jsFunction="fn_egov_link_page" />
						</li>
						<form:hidden path="pageIndex" />
						<!-- 		        		<li class="page-item"><a class="page-link" href="#"> »</a></li> -->

					</ul>
				</div>
				<br>
				<div class="card-footer clearfix">
					<button id="insertnotice" type="button"
						class="btn btn-default float-right" onclick="noticeInsert()">
						<i class="fas fa-plus"></i>등 록
					</button>
				</div>



				<!-- /.card-body -->
			</div>
		</div>
		</section>



	</form:form>
	<!-- </div> -->
</body>
</html>