<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
/* bootstrap모달창에서 autocomplete 안먹을 때 설정 */
.ui-autocomplete {
	z-index: 2147483647;
}

.dropbtn {
	border: none;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	min-width: 200px;
	z-index: 1;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: #ddd;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown:hover .dropbtn {
	background-color: #3e8e41;
}
</style>

</head>
</head>
<title>Insert title here</title>
<%-- <c:if test="${SADMIN.adminId == 'admin' }"> --%>
<form:form commandName="memberVo" id="listForm" name="listForm"
	method="post">
	<form:hidden path="memId" />
	<input type="hidden" name="selectedId" />

	<!-- Content Header (Page header) -->
	<section class="content-header"
		style="border-bottom: 1px solid #dee2e6; background: white;">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="jg">회원 리스트</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item san"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">회원 리스트</li>
				</ol>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->
	</section>
	
	
	<!-- Main content -->
	<section class="content">
	<div class="col-md-12">
		<div class="card" style="border-radius: inherit;">
			<div class="card-header">
			<%--
				<h3 class="card-title">
					<div class="input-group mb-3 ">
						<select class="form-control col-md-4" name="searchCondition"
							id="searchCondition" style="font-size: 0.7em;">
							<option value="0">이메일</option>
							<option value="1">이름</option>
							<option value="2">전화번호</option>
							<option value="3">타입</option>
						</select>
						<!-- /btn-group -->
						<form:input path="searchKeyword" class="form-control" />
						<a href="javascript:fn_egov_reqList();">
							<button type="button" class="btn-default" style="height: 100%;">
								<i class="fa fa-search"></i>
							</button>
						</a>
					</div>

				</h3>

				<div class="card-tools">
					<ul class="pagination pagination-sm float-right">
						<li class="page-item"><a class="page-link" href="#">«</a></li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">»</a></li>
					</ul>
				</div>
			</div>
			--%>
			<!-- /.card-header -->
			<div class="card-body p-0">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 100px;">이메일</th>
							<th>이름</th>
							<th>전화번호</th>
						<!--
							<th style="text-align: center;">담당자</th>
							<th style="text-align: center;">응답 상태</th>
						 -->
							<th>타입</th>
							<th>메뉴</th>
						</tr>
					</thead>
					
					<tbody>
<%-- 						<c:forEach items="${reqList }" var="req" varStatus="sts"> --%>
						<c:forEach items="${memberList }" var="member" varStatus="sts">
							<tr>
								<td>${member.memId }</td>
								<td>${member.memName }</td>
								<td>${member.memTel }</td>
								
								<td style="text-align: center;"><c:choose>
										<c:when test="${member.memType eq 'PM' }">
											<span class="badge badge-warning">PM</span>
										</c:when>
										<c:when test="${member.memType eq 'PL' }">
											<span class="badge badge-danger">PL</span>
										</c:when>
										<c:when test="${member.memType eq 'MM' }">
											<span class="badge badge-success">팀원</span>
										</c:when>
									</c:choose></td>
									
								<td class="project-actions text-right" style="opacity: .9;">
									<a class="btn btn-primary btn-sm"
									href="javascript:memlistDetail('<c:out value="${member.memId }"/>');">
										<i class="fas fa-folder"></i> 보기
								</a> <a class="btn btn-info btn-sm"
									href="javascript:memlistUpdate(${member.memId });"> <i
										class="fas fa-pencil-alt"></i> 수정
								</a> <a class="btn btn-danger btn-sm"
									href="javascript:memlistDelete(${member.memId });"> <i
										class="fas fa-trash"></i> 삭제
								</a>
								</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>
			<!-- paging -->
			<div id="paging" class="card-tools">
				<ul class="pagination pagination-sm float-right">
					<ui:pagination paginationInfo="${paginationInfo}" type="image"
						jsFunction="fn_egov_link_page" />
					<form:hidden path="pageIndex" />
				</ul>
			</div>

			<div class="card-footer clearfix">
				<button type="button" class="btn btn-default" id="back">뒤로가기</button>
				<a class="btn btn-app float-right"
					href="javascript:fn_egov_reqInsert();"> <i class="fas fa-edit"></i>
					작성하기
				</a>
			</div>

			<!-- /.card-body -->
		</div>
	</div>
	</section>
</form:form>

<script type="text/javascript">
var searchCondition = "${memberVo.searchCondition}";
if (searchCondition != "") {
	$('#searchCondition').val("" + searchCondition + "").attr("selected",
			"selected");
}

//뒤로가기
$("#back").on("click", function() {
	window.history.back();
});

/* 요구사항정의서 삭제하기 */
function reqDelete(id) {
	if (confirm("삭제한 정보는 복구할 수 없습니다. 정말 삭제하시겠습니까?")) {
		document.listForm.selectedId.value = id;
		document.listForm.action = "<c:url value = '/req/reqDelete'/>";
		document.listForm.submit();
	} else {

	}
}

/* 수정페이지보기 */
function memlistUpdate(id) {
	document.listForm.selectedId.value = id;
	document.listForm.action = "<c:url value = '/admin/memlistUpdateView'/>";
	document.listForm.submit();
}

/*  상세보기 */
function memlistDetail(id) {
	document.listForm.selectedId.value = id;
	document.listForm.action = "<c:url value ='/admin/memlistDetail'/>";
	document.listForm.submit();
}

/* 글 등록 화면 function */
function fn_egov_memlistInsert() {
	document.listForm.action = "<c:url value='/admin/memlistInsertView'/>";
	document.listForm.submit();
}

/* 글 목록 화면 function */
function fn_egov_memberList() {
	document.listForm.action = "<c:url value='/admin/memberList'/>";
	document.listForm.submit();
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo) {
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/admin/memberList'/>";
	document.listForm.submit();
}
</script>






</body>
</html>