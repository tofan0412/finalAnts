<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/req/reqList'/>";
	   	document.listForm.submit();
	}

</script>

</head>
<title>협업관리프로젝트</title>
<form:form commandName="reqVo" id="listForm" name="listForm" method="post">

	<div class="wrapper">

		<!-- Content Wrapper. Contains page content -->
		  <div class="content-wrapper">
		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											border-bottom: 1px solid #dee2e6;
											background: white;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1 class="jg">요구사항 정의서</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">요구사항 정의서</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		

    <!-- Main content -->
		    <section class="content">
		      <div class="col-md-12">
			      <div class="card" style="border-radius: inherit;">
	              <div class="card-header">
	                <h3 class="card-title">요구사항 정의서</h3>
	
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
	              <!-- /.card-header -->
	              <div class="card-body p-0">
	                <table class="table">
	                  <thead>
	                    <tr>
	                      <th>#</th>
	                      <th>요구사항정의서 제목</th>
	                      <th>기간</th>
	                      <th>담당자 지정</th>
	                      <th>응답 상태</th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                      <c:forEach items="${reqList }" var="req" >
	                    	<tr>
		                      <td>${reqList.indexOf(req)+1 } .</td>
		                      <td>${req.reqTitle }</td>
		                      <td>${req.reqPeriod }</td>
	                    	  <td>${req.plId }</td>
		                      <td>${req.status }</td>
		                      
		                    </tr>
	                      </c:forEach>
	                  
	                  </tbody>
	                </table>
	              </div>
	              
	              <div id="paging">
        			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        			<form:hidden path="pageIndex" />
        		</div>
	              <!-- /.card-body -->
	            </div>
            </div>
		    </section>
		    <!-- /.content -->
		  </div>
		      
		    </section>
		    <!-- /.content -->
		  </div>
  <!-- /.content-wrapper -->

		<!-- Content Wrapper. Contains page content -->
		<%-- 		<%@include file="content.jsp"%> --%>



</form:form>
	<!-- jQuery, style -->
	<%@include file="../layout/commonLib.jsp"%>
</body>
</html>
