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

<style type="text/css">


	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 padding : 6px; 
		 border: none; 
	
	}
	
	li strong{
		display: inline-block;
		text-align: center;

		padding : 6px; 
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
	
	.option{
		height: 50px;
		width: 150px;
		padding: 5px;
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
	
// 	$("#pagenum a").addClass("page-link");  
	if(${sort} == 2){
		$('#old').css("color","#00a2e4");
	}else if(${sort} == 1 || ${sort} == null){
		$('#recent').css("color","#00a2e4");
	}
	
	
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
 	if('${sort}' == '2'){
		document.listForm.sort.value = 2;
	}else if('${sort}' == '1' || ${sort} == null){
		document.listForm.sort.value = 1;
	}
 	document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
    document.listForm.submit();
 }
 
 function issueInsert(){
 	document.listForm.action = "<c:url value='${pageContext.request.contextPath}/projectMember/insertissueView'/>";
    document.listForm.submit();
 }
 
 function search(){
	 	document.listForm.pageIndex.value = 1;
	 	document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
	    document.listForm.submit();
}
 
 function oldsort(){
	 	document.listForm.pageIndex.value = 1;
	 	document.listForm.sort.value = 2;
	 	document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
	    document.listForm.submit();
}
 
 function recentsort(){
	 	document.listForm.pageIndex.value = 1;
	 	document.listForm.sort.value = 1;
	 	document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
	    document.listForm.submit();
}
 
 
 
	 
</script>
</head>

<%-- <%@include file="./issuecontentmenu.jsp"%> --%>
<%@include file="../layout/contentmenu.jsp"%>

<body>
<!-- 	<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
<form:form commandName="issueVo" id="listForm" name="listForm" method="post">
	
			<section class="content" >
		      <div class="col-12 col-sm-12">
			      <div class="card" style="border-radius: inherit; padding : 2px;">
		        
		        <br>
		        <div class="card-header  ">
		        <div id="keyword" class="card-tools float-left" style="width: 450px;">
						<h3 class="jg" style="padding-left: 10px; display: inline-block;">현업이슈 리스트</h3>
						&nbsp;
						<form:hidden path="sort" />
						<form:button id="recent" onclick="javascript:recentsort();" >최신순</form:button> &nbsp;
						<form:button id="old" onclick="javascript:oldsort();" >오래된순</form:button> &nbsp;
					
<!-- 						<input type="button" value="excelDown"><a href="/exceldown"></a> -->
<%-- 						<form:select path="RegDt" id="regdtsort" class="form-control col-md-3 jg" style="display: inline-block;" > --%>
<%-- 							<form:option value="recent" class="jg option"  label="최신순"/> --%>
<%-- 							<form:option value="old" class="jg option" label="오래된순"/> --%>
<%-- 						</form:select> --%>
				</div>
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">
						<label for="searchCondition" style="visibility:hidden;"></label>
					
						<form:select path="IssueKind" id="issuekindselect" class="form-control col-md-3 jg" style="width: 100px; ">
							<form:option value="" class="jg option" label="전체글"/>
							<form:option value="issue" class="jg option"  label="이슈"/>
							<form:option value="notice" class="jg option" label="공지사항"/>
						</form:select>
						
						
        				<form:select path="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">
							<form:option value="1"  class="jg" label="작성자"/>
							<form:option value="2"  class="jg" label="제목"/>
							<form:option value="3"  class="jg" label="내용"/>
						</form:select> 
						
						
						<label for="searchKeyword" style="visibility:hidden; display:none;"  class="jg"></label>
	                    <form:input style="width: 300px;" path="searchKeyword" placeholder="검색어를 입력하세요." class="form-control jg"
	                    		/>
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
	                    	 <th class="jg" style="width : 10%; padding-left: 20px; text-align: center; ">No.</th>
	                     	<th class="jg" style="padding-left: 30px; width : 37%;">  이슈 제목</th> 
							<th class="jg" style="text-align: center; width : 10%;"> 작성자 </th>
							<th class="jg" style="text-align: center; width : 15%;">   날짜   </th>
							<th class="jg" style="text-align: center; width : 11%;">   종류   </th>
							<th class="jg" style="text-align: center; width :13%;"> 즐겨찾기 </th>
							
	                    </tr>
	                  </thead>
	                  <tbody>
	                      
                       <c:forEach items = "${issuelist }" var ="issue" varStatus="status">
							<tr>
			                 
			                    <td class="jg" style="width: 10%; padding-left: 20px; text-align: center;">
			                    	<c:if test="${sort == 1}">
				                    	<c:out value="${paginationInfo.totalRecordCount - ((issueVo.pageIndex-1) * issueVo.pageUnit + status.index)}"/>.
			                    	</c:if>
			                    	<c:if test="${sort == 2}">
				                    	<c:out value="${  ((issueVo.pageIndex-1) * issueVo.pageUnit + (status.index+1))}"/>.
			                    	</c:if>
			                    	
			                    </td>
							
								<td class="jg"  style="padding-left: 30px; width: 37%;">
									<a href="${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issue.issueId}"> 
									<c:if test="${fn:length(issue.issueTitle) > 30}">									
										${fn:substring(issue.issueTitle,0 ,30) }...
									</c:if>
									<c:if test="${fn:length(issue.issueTitle) <= 30}">									
										${issue.issueTitle}
									</c:if>
									</a> 
								</td>
								<td class="jg" style="text-align: center; width : 10%;"> ${issue.memName }</td>
								<td class="jg" style="text-align: center; width : 15%;"> ${issue.regDt }</td>
								<c:if test="${issue.issueKind == 'issue'}">
									<td style="text-align: center; width : 11%;" class="jg"> 이슈</td>										
								</c:if>
								<c:if test="${issue.issueKind == 'notice'}">
									<td style="text-align: center; width : 11%;" class="jg"> 공지사항</td>										
								</c:if>
									<c:choose>
										<c:when test="${issue.issueDel == '' || issue.issueDel == null }">
											<td style="text-align: center; width : 13%;" class = "area-desc"><span><img src="/resources/dist/img/bookmark-white.png" width="20" height="20" name ="${issue.issueId}"/></span></td>
										</c:when>
										<c:otherwise>
											<td style="text-align: center; width : 13%;" class = "area-desc"><span><img src="/resources/dist/img/bookmark-black.png" width="20" height="20" name ="${issue.issueId}"/></span></td>											
										</c:otherwise>
									</c:choose>
<!-- 		                      <td style="text-align: center;"> -->
								 
							</tr>
						 </c:forEach> 
						 <c:if test="${issuelist.size() == 0}">
							<td colspan="7" style="text-align: center;"  class="jg"><br> [ 결과가 없습니다. ] </td>
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
<%-- 		        		<form:hidden path="sort" />		        		 --%>
                    
	                 </ul>
        		  </div>
        	
        		  <div class="card-footer clearfix">
	                <c:if test="${projectVo.proStatus == 'ACTIVE' }">
	                	<button id="insertissue" type="button" class="btn btn-default float-left jg" onclick="issueInsert()"><i class="fas fa-edit "></i>등 록</button>
	                </c:if>
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