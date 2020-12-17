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
		 width:auto; float:left; margin:0 auto; text-align:center;"
		 
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
						
						alert('삭제성공') 	
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
 	document.listForm.action = "<c:url value='/projectMember/myissuelist'/>";
    document.listForm.submit();
 }
 

 
 function search(){
	 	document.listForm.action = "<c:url value='/projectMember/myissuelist'/>";
	    document.listForm.submit();
}
 
 
 
	 
</script>
</head>

<body>
<!-- 	<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
<form:form commandName="issueVo" id="listForm" name="listForm" method="post">

		    <!-- Content Header (Page header) -->
		    
		    
		  
		    
		    
<!-- 		 	<h3>협업이슈 리스트</h3> -->
<!-- 				<input type= "button" value="작성하기" id="insertissue"> -->
	
			<section class="content" >
		      <div class="col-12 col-sm-12">
			      <div class="card" style="border-radius: inherit; padding : 2px;">
			      
			    <div class="container-fluid">
		        <div class="row mb-1">
		          <div class="col-sm-6">
		         <br>
		            <h3 class="jg" style=" padding-left : 10px;"><li class="nav-icon far fa-lightbulb"></li>&nbsp;내가 작성한 이슈</h3>
		          </div>
		          <div class="col-sm-6">
		         
		            <ol class="breadcrumb float-sm-right"  style="background : white">
		              <li class="breadcrumb-item san jg"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active jg">내가 작성한 이슈</li>
		            </ol>
		          </div>
		        </div>
		        </div>
		        
		        <div class="card-header  ">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">
						<label for="searchCondition" style="visibility:hidden;"></label>
					
						<form:select path="IssueKind" id="issuekindselect" class="form-control col-md-3 jg" style="width: 100px;">
							<form:option value="" label="전체글"/>
							<form:option value="issue" label="이슈"/>
							<form:option value="notice" label="공지사항"/>
						</form:select>
						
						
        				<form:select path="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">
							<form:option value="1" label="제목"/>
							<form:option value="2" label="내용"/>
							<form:option value="3" label="프로젝트명"/>
						</form:select> 
						
						
						<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                    <form:input style="width: 300px;" path="searchKeyword"  placeholder="검색어를 입력하세요." class="form-control jg"/>
<!--  						    <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="">  -->
						<span class="input-group-append">							
							<button class="btn btn-default" type="button" id="searchBtn" onclick="search()" >
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
	                        <th class="jg" style="width: 150px; padding-left: 50px; text-align: center;">No.</th>
	                     	<th class="jg" style="padding-left: 30px; text-align: center;">  이슈 제목</th> 
							<th class="jg" style="text-align: center;"> 프로젝트명 </th>
							<th class="jg" style="text-align: center;">   날짜   </th>
							<th class="jg" style="text-align: center;">   종류   </th>
							<th class="jg" style="text-align: center;"> 즐겨찾기 </th>
<!-- 	                      <th style="text-align: center;">응답 상태</th> -->
	                      <th></th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                       <c:forEach items = "${myissuelist }" var ="issue" varStatus="status">
								<tr>
				                 
				                    <td class="jg" style="width: 150px; padding-left: 50px; text-align: center;"><c:out value="${  ((issueVo.pageIndex-1) * issueVo.pageUnit + (status.index+1))}"/>.</td>
								
									<td class="jg" style="padding-left: 30px; text-align: center;"><a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issue.issueId}&reqId=${issue.reqId}"> ${issue.issueTitle }</a> </td>
									<td class="jg" style="text-align: center;"> ${issue.proName }</td>
									<td class="jg" style="text-align: center;"> ${issue.regDt }</td>
									<c:if test="${issue.issueKind == 'issue'}">
										<td class="jg" style="text-align: center;"> 이슈</td>										
									</c:if>
									<c:if test="${issue.issueKind == 'notice'}">
										<td class="jg" style="text-align: center;"> 공지사항</td>										
									</c:if>
<%-- 									<c:forEach items = "${bookmarklist }" var ="book" > --%>
			
	<!-- 									<td><img src="/resources/dist/img/bookmark-white.png" width="20" height="20" name="bookmark_toggle_01" -->
	<!-- 													OnClick="toggle_img_src( 'bookmark_toggle_01', '/resources/dist/img/bookmark-white.png', '/resources/dist/img/bookmark-black.png');" style="cursor:pointer"></td> -->
										<c:choose>
											<c:when test="${issue.bookmark == '' || issue.bookmark == null }">
												<td style="text-align: center;" class = "area-desc jg"><span><img src="/resources/dist/img/bookmark-white.png" width="20" height="20" name ="${issue.issueId}"/></span></td>
											</c:when>
											<c:otherwise>
												<td style="text-align: center;" class = "area-desc jg"><span><img src="/resources/dist/img/bookmark-black.png" width="20" height="20" name ="${issue.issueId}"/></span></td>											
											</c:otherwise>
										</c:choose>
										
								
<%-- 									</c:forEach>  --%>
			                      <td style="text-align: center;">
									 
								</tr>
							 </c:forEach> 
						<c:if test="${myissuelist.size() == 0}">
							
						 	<tr>
								<td class="jg" colspan="7" style="text-align: center;"><br> [ 결과가 없습니다. ] </td>
							</tr>
						</c:if>
	                  </tbody>
	                </table>
	              </div>
 
	              
	              <br>
	              <div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm jg" id ="pagingui">
	              	
		        		<li  class="page-item jg" id ="pagenum" >	
		        		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
		        		<form:hidden path="pageIndex" />		        		
                    
	                 </ul>
        		  </div>
        		  <br>
           		  <div class="card-footer clearfix">
	              </div>
        		  
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>
			<br>
		

</form:form>	
<!-- </div> -->
</body>
</html>