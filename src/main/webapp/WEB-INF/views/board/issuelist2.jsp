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

	ul {
		display: table; margin: auto; padding:0;

		}
	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 width : 30px;	 
		 
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
/* 		 text-align: center; */
		 width:auto; float:left; margin:0 auto; text-align:center;"
		 
	}
	#searchBtn {
	    color: #fff;
	    background-color: #007bffab;
	    border-color: #007bff;
	    box-shadow: none;
	}	
	
</style>

<script type="text/javascript">
$(function(){
	$("#insertissue").on('click', function(){
		
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/insertissueView');
	})
	
	$("#pagenum a").addClass("page-link");  

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
// 	    var issuekind =  $("#issueKind option").val();
// 	    alert(issuekind);
// 	    document.listForm.issueKind = issuekind;
	 	document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
	    document.listForm.submit();
}
 
 
 
 
	 
</script>
</head>

<%@include file="./issuecontentmenu.jsp"%>
<%-- <%@include file="./eachproject.jsp"%> --%>

<body>
<!-- 	<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
<form:form commandName="issueVo" id="listForm" name="listForm" method="post">

		    <!-- Content Header (Page header) -->
		    <section class="content-header col-md-10" style="
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
		        
		        <div class="card-header with-border">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">
						<!-- sort num -->
<!-- 						<select class="form-control col-md-3" name="pageSize" id="pageSize" > -->
<!-- 							<option value="0">정렬개수</option> -->
<!-- 							<option value="3">3개씩</option> -->
<!-- 							<option value="5">5개씩</option> -->
<!-- 							<option value="7">7개씩</option> -->
<!-- 						</select> -->
						<!-- search bar -->
						<label for="searchCondition" style="visibility:hidden;"></label>
						
<!-- 						<select class="form-control col-md-3" name="issueKind" id="issueKind"  style="width: 100px;">						 -->
<!-- 							<option value="issue">이슈</option> -->
<!-- 							<option value="notice">공지사항</option> -->
<!-- 						</select>  -->
					
						
        				<form:select path="searchCondition" cssClass="use" class="form-control col-md-3" style="width: 100px;">
<!-- 						<select class="form-control col-md-3" name="searchType" id="searchType" required> -->
						
<%-- 							<form:option value="0" label="종류"/> --%>
							<form:option value="1" label="작성자"/>
							<form:option value="2" label="제목"/>
							<form:option value="3" label="내용"/>
						
						</form:select> 
						
						
							<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                        <form:input style="width: 300px;" path="searchKeyword" cssClass="txt" placeholder="검색어를 입력하세요." class="form-control"/>
<!--  						    <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="">  -->
						<span class="input-group-append">							
							<button class="btn btn-primary" type="button" id="searchBtn" onclick="search()" >
								<i class="fa fa-fw fa-search"></i>
							</button>
						</span>
						<!-- end : search bar -->
					</div>
		        </div>
		        
		      </div><!-- /.container-fluid -->
		    </section>
		    
		  
		    
		    
<!-- 		 	<h3>협업이슈 리스트</h3> -->
<!-- 				<input type= "button" value="작성하기" id="insertissue"> -->
	
			<section class="content">
		      <div class="col-md-10">
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
	                        <th style="width: 150px; padding-left: 50px;">No.</th>
	                     	<th  style="padding-left: 30px;">  이슈 제목</th> 
							<th>   작성자 </th>
							<th>   날짜   </th>
							<th>   종류   </th>
<!-- 	                      <th style="text-align: center;">응답 상태</th> -->
	                      <th></th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                      
		                       <c:forEach items = "${issuelist }" var ="issue" varStatus="status">
									<tr>
<%-- 					                    <td>${status.index+1 }</td> --%>
<%-- 					                    <td>${issue.issueId }</td> --%>
					                 
					                    <td  style="width: 150px; padding-left: 50px;"><c:out value="${  ((issueVo.pageIndex-1) * issueVo.pageUnit + (status.index+1))}"/>.</td>
									
										<td  style="padding-left: 30px;"><a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issue.issueId}"> ${issue.issueTitle }</a> </td>
										<td> ${issue.memId }</td>
										<td> ${issue.regDt }</td>
										<c:if test="${issue.issueKind == 'issue'}">
											<td> 이슈</td>										
										</c:if>
										<c:if test="${issue.issueKind == 'notice'}">
											<td> 공지사항</td>										
										</c:if>
				                      <td style="text-align: center;">
										 
									</tr>
								 </c:forEach> 

		                      
	                  
	                  </tbody>
	                </table>
	              </div>
 
	              
	              <br>
	              <div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm" id ="pagingui">
	                    <li class="page-item pagingui"><a class="page-link" href="#">«</a></li>
	                    
		        		<li  class="page-item" id ="pagenum" >	
<%-- 		        		<input type="button" value="#{paginationInfo}" > --%>
		        		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
		        			<form:hidden path="pageIndex" />
		        			
	                    <li class="page-item pagingui"><a class="page-link" href="#">»</a></li>
	                 </ul>
        		  </div>
        		  <br>
        		  <div class="card-footer clearfix">
	                <button id="insertissue" type="button" class="btn btn-default float-right" onclick="issueInsert()"><i class="fas fa-plus"></i>등 록</button>
	              </div>
        		 
        		  
        		  
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>
				
		

</form:form>	
<!-- </div> -->
</body>
</html>