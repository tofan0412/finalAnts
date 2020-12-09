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
 	document.listForm.action = "<c:url value='/bookmark/getallbookmark'/>";
    document.listForm.submit();
 }
 
 
 function search(){
	 	document.listForm.action = "<c:url value='/bookmark/getallbookmark'/>";
	    document.listForm.submit();
}
 
 $(function(){
	 
	//북마크 클릭시
	$(".area-desc").click(function() { 
		var arrowImage = $(this).children("span").children("img"); 
		
		arrowImage.attr("src", function(index, attr){ 
			issueid = arrowImage.attr('name')
			if(attr.match('black')){ 
						
// 				$(location).attr('href', '${pageContext.request.contextPath}/bookmark/removebookmark');
				
				$.ajax({url :"${pageContext.request.contextPath}/bookmark/removebookmark",
					 method : "get",
					 data : {issueId : issueid},
					 success :function(data){	
						alert('삭제성공') 	
						$(location).attr('href', '${pageContext.request.contextPath}/bookmark/getallbookmark');
					 }
				})	
				return attr.replace("black", "white"); 
				
			} 
		}); 
	});
 })
	
 
 </script>

<style type="text/css">


	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 width : auto;	 
		 border: none; 
		background: transparent;
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

</head>
<body>
<form:form commandName="AllBookMarkVo" id="listForm" name="listForm" method="post">

		    <!-- Content Header (Page header) -->
			<section class="content" >
		      <div class="col-12 col-sm-12">
			      <div class="card" style="border-radius: inherit; padding : 2px;">
			      
			    <div class="container-fluid">
		        <div class="row mb-2">
		         <br>
		          <div class="col-sm-6">
		          <br>
		            <h1 class="jg" style=" padding-left : 10px;"><img src="/resources/dist/img/bookmark-black.png" width="30" height="30" name ="${bookmark.issueId}"/>&nbsp;북마크</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right"  style="background : white">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">북마크</li>
		            </ol>
		          </div>
		        </div>
		        </div>
   				
		        
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
							<form:option value="1" label="제목"/>
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
	                        <th style="width: 150px; padding-left: 50px; text-align: center;">No.</th>
	                     	<th  style="padding-left: 30px; text-align: center;">  이슈 제목</th> 
							<th style="text-align: center;">   날짜   </th>
							<th style="text-align: center;">   종류   </th>
							<th style="text-align: center;"> 즐겨찾기 </th>
	                      <th></th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                      
	                       <c:forEach items = "${bookmarklist }" var ="bookmark" varStatus="status">
								<tr>			                 
				                    <td  style="width: 150px; padding-left: 50px; text-align: center;"><c:out value="${  ((AllBookMarkVo.pageIndex-1) * AllBookMarkVo.pageUnit + (status.index+1))}"/>.</td>
								
									<td  style="padding-left: 30px; text-align: center;"><a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${bookmark.issueId}"> ${bookmark.issueTitle }</a> </td>
									<td style="text-align: center;"> ${bookmark.regDt }</td>
									<c:if test="${bookmark.issueKind == 'issue'}">
										<td style="text-align: center;"> 이슈</td>										
									</c:if>
									<c:if test="${bookmark.issueKind == 'notice'}">
										<td style="text-align: center;"> 공지사항</td>										
									</c:if>
									<td style="text-align: center;" class = "area-desc"><span><img src="/resources/dist/img/bookmark-black.png" width="20" height="20" name ="${bookmark.issueId}"/></span></td>											
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
<!-- 	                <button id="insertissue" type="button" class="btn btn-default float-right" onclick="issueInsert()"><i class="fas fa-plus"></i>등 록</button> -->
	              </div>
        		 
        		  
        		  
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>
			<br>
		

</form:form>	    
</body>
</html>