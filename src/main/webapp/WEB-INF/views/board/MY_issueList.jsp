<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
	body{
		min-width: 700px;
	}

	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 width : auto;	 
		 border: none; 
		background: transparent;
		padding: 6px;
	}
	
	li strong{
		display: inline-block;
		text-align: center;
		padding: 6px;
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
	
	#recent, #old{
		background-color:transparent;  
	 	border:0px transparent solid;
	 	outline: none;
	}
		
	
</style>

<script type="text/javascript">
$(function(){
	
	$("#insertissue").on('click', function(){
		
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/insertissueView');
	})
	
	if(${sort} == 2){
		$('#old').css("color","#00a2e4");
	}else if(${sort} == 1 || ${sort} == null){
		$('#recent').css("color","#00a2e4");
	}
	
// 	$("#pagenum a").addClass("page-link");  
	

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
// 						alert('등록성공') 	
					 }
				})				
				return attr.replace("white", "black"); 
			} else if(attr.match('black')){ 
						
				$.ajax({url :"${pageContext.request.contextPath}/bookmark/removebookmark",
					 method : "get",
					 data : {issueId : issueid},
					 success :function(data){	
						
// 						alert('삭제성공') 	
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
 
function oldsort(){
	 	document.listForm.pageIndex.value = 1;
	 	document.listForm.sort.value = 2;
	 	document.listForm.action = "<c:url value='/projectMember/myissuelist'/>";
	    document.listForm.submit();
}

function recentsort(){
	 	document.listForm.pageIndex.value = 1;
	 	document.listForm.sort.value = 1;
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
		            <h3 class="jg" style=" padding-left : 10px; display: inline-block;"><li class="nav-icon far fa-lightbulb"></li>&nbsp;내가 작성한 이슈</h3>
		             &nbsp;
						<form:hidden path="sort" />
						<form:button id="recent" onclick="javascript:recentsort();" >최신순</form:button> &nbsp;
						<form:button id="old" onclick="javascript:oldsort();" >오래된순</form:button> &nbsp;
		          </div>
		          <div class="col-sm-6">
		         
		            <ol class="breadcrumb float-sm-right"  style="background : white">
		              <li class="breadcrumb-item san jg"><a href="${pageContext.request.contextPath}/member/mainpage">Home</a></li>
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
	                        <th class="jg" style="width : 8%; padding-left: 20px; text-align: center; ">No.</th>
	                     	<th class="jg" style="padding-left: 30px; width : 38%;">  이슈 제목</th> 
							<th class="jg" style="text-align: center; width : 18%;"> 프로젝트명 </th>
							<th class="jg" style="text-align: center; width : 14%;">   날짜   </th>
							<th class="jg" style="text-align: center; width : 10%;">   종류   </th>
							<th class="jg" style="text-align: center; width :10%;"> 즐겨찾기 </th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                       <c:forEach items = "${myissuelist }" var ="issue" varStatus="status">
								<tr>
				                 <td class="jg" style="width: 8%; padding-left: 20px; text-align: center;">
			                    	<c:if test="${sort == 1}">
				                    	<c:out value="${paginationInfo.totalRecordCount - ((issueVo.pageIndex-1) * issueVo.pageUnit + status.index)}"/>.
			                    	</c:if>
			                    	<c:if test="${sort == 2}">
				                    	<c:out value="${  ((issueVo.pageIndex-1) * issueVo.pageUnit + (status.index+1))}"/>.
			                    	</c:if>
			                    	
			                    </td>
<%-- 				                    <td class="jg" style="width : 8%; padding-left: 20px; text-align: center;"><c:out value="${  ((issueVo.pageIndex-1) * issueVo.pageUnit + (status.index+1))}"/>.</td> --%>
								
									<td class="jg" style="padding-left: 30px; width : 38%;">
										<a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issue.issueId}&reqId=${issue.reqId}"> 
											<c:if test="${fn:length(issue.issueTitle) > 30}">									
												${fn:substring(issue.issueTitle,0 ,30) }...
											</c:if>
											<c:if test="${fn:length(issue.issueTitle) <= 30}">									
												${issue.issueTitle}
											</c:if>
										</a> 
									</td>
									<td class="jg" style="text-align: center; width : 18%;"> ${issue.proName }</td>
									<td class="jg" style="text-align: center; width : 14%;"> ${issue.regDt }</td>
									<c:if test="${issue.issueKind == 'issue'}">
										<td class="jg" style="text-align: center; width : 10%;"> 이슈</td>										
									</c:if>
									<c:if test="${issue.issueKind == 'notice'}">
										<td class="jg" style="text-align: center; width : 10%;"> 공지사항</td>										
									</c:if>
			
										<c:choose>
											<c:when test="${issue.bookmark == '' || issue.bookmark == null }">
												<td class = "area-desc jg" style="text-align: center; width : 10%;" class = "jg"><span><img src="/resources/dist/img/bookmark-white.png" width="20" height="20" name ="${issue.issueId}"/></span></td>
											</c:when>
											<c:otherwise>
												<td class = "area-desc jg" style="text-align: center; width : 10%;" class = "jg"><span><img src="/resources/dist/img/bookmark-black.png" width="20" height="20" name ="${issue.issueId}"/></span></td>											
											</c:otherwise>
										</c:choose>
										
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