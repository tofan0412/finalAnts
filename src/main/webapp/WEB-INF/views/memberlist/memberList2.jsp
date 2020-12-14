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
	
	.memlistMain{
		margin: 9px 9px 9px 9px;
		padding: 9px 9px 9px 9px;
	}
</style>

<script type="text/javascript">
$(function(){
	
	$("#insertmemlist").on('click', function(){
		
		$(location).attr('href', '${pageContext.request.contextPath}/admin/insertmemlistView');
	})
	
	$("#pagenum a").addClass("page-link");  
	

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


<body>
<!-- 	<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
<form:form commandName="memberVo" id="listForm" name="listForm" method="post">

		<!-- Content Header (Page header) -->
		<section class="content">
		<div class="card memlistMain">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="jg">회원 리스트</h1>
					</div>
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right"
							style="background-color: white">
							<li class="breadcrumb-item san"><a href="#">Home</a></li>
							<li class="breadcrumb-item active">회원리스트</li>
						</ol>
					</div>
				</div>
			</div>

			<!-- 검색창라인 -->
			<div class="card-header  ">
				<div id="keyword" class="card-tools float-right"
					style="width: 450px;">
					<div class="input-group row">
						<label for="searchCondition" style="visibility: hidden;"></label>


						<form:select path="searchCondition" cssClass="use"
							class="form-control col-md-3" style="width: 100px;">
							<form:option value="1" label="이메일" />
							<form:option value="2" label="이름" />
							<form:option value="3" label="타입" />
						</form:select>


						<label for="searchKeyword"
							style="visibility: hidden; display: none;"></label>
						<form:input style="width: 300px;" path="searchKeyword"
							cssClass="txt" placeholder="검색어를 입력하세요." class="form-control" />
						<!--  						    <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="">  -->
						<span class="input-group-append">
							<button class="btn btn-primary" type="button" id="searchBtn"
								onclick="search()">
								<i class="fa fa-fw fa-search"></i>
							</button>
						</span>

						<!-- end : search bar -->
					</div>
					<br>
				</div>


			</div>
			<!-- /.container-fluid -->
		</div>
		</section>





		<section class="content" >
		      <div class="col-12 col-sm-12">
			      <div class="card" style="border-radius: inherit; padding : 2px;">
			      
		        
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
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>
			<br>
		

</form:form>	
<!-- </div> -->
</body>
</html>