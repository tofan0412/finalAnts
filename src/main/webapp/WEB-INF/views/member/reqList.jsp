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

	/* 글 등록 화면 function */
	function fn_egov_reqInsert() {
	   	document.listForm.action = "<c:url value='/req/reqInsertView'/>";
	   	document.listForm.submit();
	}
	/* 글 등록 화면 function */
	function fn_egov_addPL() {
	   	document.listForm.action = "<c:url value='/req/addPLView'/>";
	   	document.listForm.submit();
	}


	/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/req/reqList'/>";
	   	document.listForm.submit();
	}
	
	//$("a").addClass("page-link");  

</script>

</head>
<title>협업관리프로젝트</title>
	<form:form commandName="reqVo" id="listForm" name="listForm" method="post">

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
	                <h3 class="card-title">요구사항 정의서 등록</h3>
	
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
	                      <th style="width: 100px;">No.</th>
	                      <th>제목</th>
	                      <th>기간</th>
	                      <th style="text-align: center;">담당자</th>
	                      <th style="text-align: center;">응답 상태</th>
	                      <th></th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                      <c:forEach items="${reqList }" var="req" varStatus="sts" >
	                    	<tr>
		                      <td><c:out value="${paginationInfo.totalRecordCount - ((reqVo.pageIndex-1) * reqVo.pageUnit + sts.index)}"/>.</td>
		                      <td>${req.reqTitle }</td>
		                      <td>${req.reqPeriod }</td>
	                    	  <td style="text-align: center;">
	                    	  	<c:choose>
		                      	  <c:when test="${req.plId==null }">
		                      	  	<a class="btn btn-info btn-sm" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
		                              <i class="fas fa-plus"></i>
		                              PL등록
		                          	</a>
		                      	  </c:when>
		                      	  <c:otherwise>${req.plId }</c:otherwise>
		                      	</c:choose>
	                    	  </td>
		                      <td style="text-align: center;">
		                      	<c:choose>
		                      	  <c:when test="${req.status eq '대기' }"><span class="badge badge-warning">${req.status }</span></c:when>
		                      	  <c:when test="${req.status eq '반려' }"><span class="badge badge-danger">${req.status }</span></c:when>
		                      	  <c:when test="${req.status eq '수락' }"><span class="badge badge-success">${req.status }</span></c:when>
		                      	</c:choose>
		                      <td class="project-actions text-right" style="opacity: .9;">
		                          <a class="btn btn-primary btn-sm" href="#">
		                              <i class="fas fa-folder"></i>
		                              View
		                          </a>
		                          <a class="btn btn-info btn-sm" href="#">
		                              <i class="fas fa-pencil-alt"></i>
		                              Edit
		                          </a>
		                          <a class="btn btn-danger btn-sm" href="#">
		                              <i class="fas fa-trash"></i>
		                              Delete
		                          </a>
		                      </td>
		                    </tr>
	                      </c:forEach>
	                  
	                  </tbody>
	                </table>
	              </div>
	              
	              <div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm float-right">
	                    <li class="page-item"><a class="page-link" href="#">«</a></li>
		        			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page"  />
		        			<form:hidden path="pageIndex" />
	                    <li class="page-item"><a class="page-link" href="#">»</a></li>
	                 </ul>
        		  </div>
        		  
        		  <div class="card-footer clearfix">
	                <button type="button" class="btn btn-default float-right" onclick="fn_egov_reqInsert()"><i class="fas fa-plus"></i>등 록</button>
	              </div>
        		  
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>
	</form:form>
	
	<!-- PL등록 모달창 -->
	<div class="modal fade" id="addPL" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="addPLLable">New message</h4>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="control-label">이메일:</label>
	            <input type="text" class="form-control" id="recipient-name" name="memId">
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label">첨부할 내용:</label>
	            <textarea class="form-control" id="message-text"></textarea>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Send message</button>
	      </div>
	    </div>
	  </div>
	</div>
		
	
	
	
	

</body>
</html>
