<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
/* pagination 페이지 링크 function */
 function fn_egov_link_page(pageNo){
 	document.listForm.pageIndex.value = pageNo;
 	document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
    document.listForm.submit();
 }
 </script>


</head>
<body>
<form:form commandName="issueVo" id="listForm" name="listForm" method="post">

		    <!-- Content Header (Page header) -->
			<section class="content" >
		      <div class="col-12 col-sm-9">
			    <div class="card" style="border-radius: inherit; padding : 2px;">
   				<h3>북마크 내역</h3>
		        
		        <div class="card-header  ">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">
						<label for="searchCondition" style="visibility:hidden;"></label>
					
						<form:select path="IssueKind" id="issuekindselect" cssClass="use" class="form-control col-md-3" style="width: 100px;">
							<form:option value="" label="전체글"/>
							<form:option value="issue" label="이슈"/>
							<form:option value="notice" label="공지사항"/>
						</form:select>
						
						
        				<form:select path="searchCondition" cssClass="use" class="form-control col-md-3" style="width: 100px;">
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
					<br>
		        </div>
		        
		      </div><!-- /.container-fluid -->

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
							<th> 즐겨찾기 </th>
	                      <th></th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                      
	                       <c:forEach items = "${bookmarklist }" var ="bookmark" varStatus="status">
								<tr>
				                 
				                    <td  style="width: 150px; padding-left: 50px;"><c:out value="${  ((issueVo.pageIndex-1) * issueVo.pageUnit + (status.index+1))}"/>.</td>
								
									<td  style="padding-left: 30px;"><a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issue.issueId}"> ${issue.issueTitle }</a> </td>
									<td> ${bookmark.memId }</td>
									<td> ${bookmark.regDt }</td>
									<c:if test="${bookmark.issueKind == 'issue'}">
										<td> 이슈</td>										
									</c:if>
									<c:if test="${bookmark.issueKind == 'notice'}">
										<td> 공지사항</td>										
									</c:if>
										<c:choose>
											<c:when test="${bookmark.issueDel == '' || bookmark.issueDel == null }">
												<td class = "area-desc"><span><img src="/resources/dist/img/bookmark-white.png" width="20" height="20" name ="${issue.issueId}"/></span></td>
											</c:when>
											<c:otherwise>
												<td class = "area-desc"><span><img src="/resources/dist/img/bookmark-black.png" width="20" height="20" name ="${issue.issueId}"/></span></td>											
											</c:otherwise>
										</c:choose>
										
								
<%-- 									</c:forEach>  --%>
			                      <td style="text-align: center;">
									 
								</tr>
							 </c:forEach> 

	                  </tbody>
	                </table>
	              </div>
 
	              
	              <br>
	              <div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm" id ="pagingui">
	              	
		        		<li  class="page-item" id ="pagenum" >	
		        		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
		        		<form:hidden path="pageIndex" />		        		
                    
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
			<br>
		

</form:form>	    
</body>
</html>