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
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
	table {
		border : 1 solid black;
	}
</style>

<script type="text/javascript">
$(function(){
	$("#insertissue").on('click', function(){
		
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/insertissueView');
	})
	
// 	$("a").addClass("page-link"); 
})


/* pagination 페이지 링크 function */
 function fn_egov_link_page(pageNo){
 	document.listForm.pageIndex.value = pageNo;
 	document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
    document.listForm.submit();
 }
 
	 
</script>
</head>

<%@include file="./issuecontentmenu.jsp"%>

<body>
<form:form commandName="issueVo" id="listForm" name="listForm" method="post">

		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											border-bottom: 1px solid #dee2e6;
											background: white;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1 class="jg">현업이슈 리스트</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">현업이슈 리스트</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		    
<!-- 		 	<h3>협업이슈 리스트</h3> -->
<!-- 				<input type= "button" value="작성하기" id="insertissue"> -->
	
			<section class="content">
		      <div class="col-md-12">
			      <div class="card" style="border-radius: inherit;">
<!-- 	              <div class="card-header"> -->
<!-- 	                <h3 class="card-title">현업이슈 리스트 등록</h3> -->
	
<!-- 	                <div class="card-tools"> -->
<!-- 	                  <ul class="pagination pagination-sm float-right"> -->
<!-- 	                    <li class="page-item"><a class="page-link" href="#">«</a></li> -->
<!-- 	                    <li class="page-item"><a class="page-link" href="#">1</a></li> -->
<!-- 	                    <li class="page-item"><a class="page-link" href="#">2</a></li> -->
<!-- 	                    <li class="page-item"><a class="page-link" href="#">3</a></li> -->
<!-- 	                    <li class="page-item"><a class="page-link" href="#">»</a></li> -->
<!-- 	                  </ul> -->
<!-- 	                </div> -->
<!-- 	              </div> -->
	              <!-- /.card-header -->
	              <div class="card-body p-0">
	                <table class="table">
	                  <thead>
	                    <tr>
	                        <th style="width: 100px;">No.</th>
	                     	<td>  이슈 제목</td> 
							<td>   작성자 </td>
							<td>   날짜   </td>
<!-- 	                      <th style="text-align: center;">응답 상태</th> -->
	                      <th></th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                      
		                       <c:forEach items = "${issuelist }" var ="issue" varStatus="status">
									<tr>
					                    <td>${status.index+1 }</td>
<%-- 					                    <td><c:out value="${paginationInfo.totalRecordCount - ((issueVo.pageIndex-1) * issueVo.pageUnit + sts.index)}"/>.</td> --%>
									
										<td><a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issue.issueId}"> ${issue.issueTitle }</a> </td>
										<td> ${issue.memId }</td>
										<td> ${issue.regDt }</td>
				                      <td style="text-align: center;">
										 
									</tr>
								 </c:forEach> 
<!-- 		                      <td class="project-actions text-right" style="opacity: .9;"> -->
<!-- 		                          <a class="btn btn-primary btn-sm" href="#"> -->
<!-- 		                              <i class="fas fa-folder"> -->
<!-- 		                              </i> -->
<!-- 		                              View -->
<!-- 		                          </a> -->
<!-- 		                          <a class="btn btn-info btn-sm" href="#"> -->
<!-- 		                              <i class="fas fa-pencil-alt"> -->
<!-- 		                              </i> -->
<!-- 		                              Edit -->
<!-- 		                          </a> -->
<!-- 		                          <a class="btn btn-danger btn-sm" href="#"> -->
<!-- 		                              <i class="fas fa-trash"> -->
<!-- 		                              </i> -->
<!-- 		                              Delete -->
<!-- 		                          </a> -->
<!-- 		                      </td> -->
		                      
	                  
	                  </tbody>
	                </table>
	              </div>
	              
	              <div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm ">
	                    <li class="page-item"><a class="page-link" href="#">«</a></li>
		        		<li  class="page-item">	
<%-- 		        		<input type="button" value="#{paginationInfo}" > --%>
		        		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
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
				
				
<!-- 				<div class="card-body" style="text-align: center;"> -->
<!-- 							<div class="row"> -->
<!-- 								<div class="col-sm-12"> -->
<!-- 									<table class="table table-bordered"> -->
									
<!-- 											<tr> -->
<!-- 												<td>  이슈 제목</td>  -->
<!-- 												<td>   작성자 </td> -->
<!-- 												<td>   날짜   </td> -->
<!-- 												yyyy-MM-dd  -->
<!-- 											</tr> -->
<!-- 											<tbody id = "memberlist"> -->
<%-- 												 <c:forEach items = "${issuelist }" var ="issue"> --%>
<!-- 													<tr> -->
													
<%-- 														<td><a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issue.issueId}"> ${issue.issueTitle }</a> </td> --%>
<%-- 														<td> ${issue.memId }</td> --%>
<%-- 														<td> ${issue.regDt }</td> --%>
														 
<!-- 													</tr> -->
<%-- 												 </c:forEach> 										 --%>
<!-- 											</tbody> -->
<!-- 									</table> -->
<!-- 								</div> -->
<!-- 								col-sm-12 -->
<!-- 							</div> -->
<!-- 							row -->
<!-- 						</div> -->
						
				 <!-- card-body -->
<!-- 				  <div id="paging" class="card-tools"> -->
<!-- 	              	<ul class="pagination pagination-sm float-right"> -->
<!-- 	                    <li class="page-item"><a class="page-link" href="#">«</a></li> -->
<%-- 		        			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page"  /> --%>
<%-- 		        			<form:hidden path="pageIndex" /> --%>
<!-- 	                    <li class="page-item"><a class="page-link" href="#">»</a></li> -->
<!-- 	                 </ul> -->
<!--         		  </div> -->
        		  
<!--         		  <div class="card-footer clearfix"> -->
<!-- 	                <button type="button" class="btn btn-default float-right" onclick="fn_egov_reqInsert()"><i class="fas fa-plus"></i>등 록</button> -->
<!-- 	              </div> -->
<!-- 	    </div>       -->
<!-- 	  </div> -->
<!-- 	 </div>       -->
<!-- </div> -->


</form:form>	
</body>
</html>