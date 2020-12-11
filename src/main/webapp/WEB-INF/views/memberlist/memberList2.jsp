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
	
	$("#insertmemlist").on('click', function(){
		
		$(location).attr('href', '${pageContext.request.contextPath}/admin/insertmemlistView');
	})
	
	$("#pagenum a").addClass("page-link");  
	
	/*
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
	
	*/
	



})



/* pagination 페이지 링크 function */
 function fn_egov_link_page(pageNo){
 	document.listForm.pageIndex.value = pageNo;
 	document.listForm.action = "<c:url value='/admin/memberlist'/>";
    document.listForm.submit();
 }
 
 function memlistInsert(){
 	document.listForm.action = "<c:url value='${pageContext.request.contextPath}/admin/insertmemlistView'/>";
    document.listForm.submit();
 }
 
 function search(){
// 	    var issuekind =  $("#issueKind option").val();
// 	    alert(issuekind);
// 	    document.listForm.issueKind = issuekind;
	 	document.listForm.action = "<c:url value='/admin/memberlist'/>";
	    document.listForm.submit();
}
 
 
 
	 
</script>
</head>

<%-- <%@include file="./issuecontentmenu.jsp"%> --%>
<%@include file="../layout/admin/adcontentmenu.jsp"%>

<body>
<!-- 	<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
<form:form commandName="memberVo" id="listForm" name="listForm" method="post">

		    <!-- Content Header (Page header) -->
		    
		    
		  
		    
		    
<!-- 		 	<h3>협업이슈 리스트</h3> -->
<!-- 				<input type= "button" value="작성하기" id="insertissue"> -->
	
			<section class="content" >
		      <div class="col-12 col-sm-12">
			      <div class="card" style="border-radius: inherit; padding : 2px;">
			      
			    <div class="container-fluid">
		        <div class="row mb-2">
		         <br>
		          <div class="col-sm-6">
		          <br>
		            <h1 class="jg" style=" padding-left : 10px;">멤버 리스트</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right"  style="background : white">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">멤버 리스트</li>
		            </ol>
		          </div>
		        </div>
		        </div>
		        
		        <%--  
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
 			--%>
	              <!-- /.card-header -->
	              <div class="card-body p-0">
	                <table class="table">
	                  <thead>
	                    <tr>
	                        <th style="width: 150px; padding-left: 50px; text-align: center;">No.</th>
	                     	<th  style="padding-left: 30px; text-align: center;">  이메일</th> 
							<th style="text-align: center;">   이름 </th>
<!-- 							<th style="text-align: center;">   비번   </th> -->
							<th style="text-align: center;">   전화번호   </th>
							<th style="text-align: center;"> 타입 </th>
							<th style="text-align: center;"> 알람 </th>
<!-- 	                      <th style="text-align: center;">응답 상태</th> -->
	                      <th></th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                      
                       <c:forEach items = "${memberlist }" var ="member" varStatus="status">
							<tr>
			                 
			                    <td  style="width: 150px; padding-left: 50px; text-align: center;"><c:out value="${  ((memberVo.pageIndex-1) * memberVo.pageUnit + (status.index+1))}"/>.</td>
							
								<td  style="padding-left: 30px; text-align: center;"><a href="${pageContext.request.contextPath}/admin/memlistprofile?memId=${member.memId}"> ${member.memId }</a> </td>
								<td style="text-align: center;"> ${member.memName }</td>
<%-- 								<td style="text-align: center;"> ${member.memPass }</td> --%>
								<td style="text-align: center;"> ${member.memTel }</td>
								<td style="text-align: center;"> ${member.memType }</td>
								<td style="text-align: center;"> ${member.memAlert }</td>
								
							</tr>
						 </c:forEach> 
						 <c:if test="${memberlist.size() == 0}">
							<td colspan="7" style="text-align: center;"><br><strong> [ 결과가 없습니다. ] </strong></td>
						 </c:if>

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
        		  <%-- 
        		  <div class="card-footer clearfix">
	                <button id="insertmemlist" type="button" class="btn btn-default float-right" onclick="memlistInsert()"><i class="fas fa-plus"></i>등 록</button>
	              </div>
        		 --%>
        		  
        		  
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>
			<br>
		

</form:form>	
<!-- </div> -->
</body>
</html>