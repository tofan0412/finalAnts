<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 padding : 6px; 	 
		 border: none; 
	}
	/*
	#table{
		width : 100%;
	    border-top: 1px solid #444444;
	    border-collapse: collapse;
	    text-align: center;
  	}
  	
   	th, td { 
 	    border-bottom: 1px solid #444444; 
 	    padding: 10px; 
   	} 
	*/
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
	$(function() {
		$("#insertnotice").on('click',function() {
			$(location).attr('href','${pageContext.request.contextPath}/admin/insertnoticeView');
		})

// 		$("#pagenum a").addClass("page-link");
		
		$("body").keyup(function(e){
			if(e.keyCode == 13){
				$('#searchBtn').trigger("click");
			}
		})

	})

	/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo) {
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/admin/noticelist'/>";
		document.listForm.submit();
	}

	function noticeInsert() {
		document.listForm.action = "<c:url value='${pageContext.request.contextPath}/admin/insertnoticeView'/>";
		document.listForm.submit();
	}

	function search() {
		document.listForm.pageIndex.value = 1;
		document.listForm.action = "<c:url value='/admin/noticelist'/>";
		document.listForm.submit();
	}
</script>
</head>


<body>
<form:form commandName="noticeVo" id="listForm" name="listForm" method="post">
		
	<section class="content" >
		<div class="col-sm-12 col-sm-12">
			<div class="card" style="border-radius: inherit; padding : 2px; margin-top: 10px">
				<!-- 헤더 부분 -->
				<div class="container-fluid">
					<div class="row mb-2">
						<br>
						<div class="col-sm-6">
							<br>
							<h1><i class=" fas fa-clipboard-list " style="padding-left: 10px">&nbsp;공지사항</i></h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right" style="background: white">
								<li class="breadcrumb-item san jg"><a href="${pageContext.request.contextPath}/admin/adMainView">Home</a></li>
								<li class="breadcrumb-item active jg">공지사항</li>
							</ol>
						</div>
					</div>
				</div>
				
				<!-- 검색창 라인 -->
				<div class="card-header  ">
					<div id="keyword" class="card-tools float-right" style="width: 450px;">
						<div class="input-group row">		
							<form:select path="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">				
								<form:option value="1" label="제목"/>
							</form:select> 
								
							<label for="searchKeyword" style="visibility:hidden; display:none;" class="jg"></label>
							<form:input style="width: 300px;" path="searchKeyword"  placeholder="검색어를 입력하세요." class="form-control jg"/>
			                 
				            <span class="input-group-append">							
								<button class="btn btn-default" type="button" id="searchBtn" onclick="search()" >
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
						</div><br>
					</div>
				</div>
				<!-- 검색창 라인 끝 -->
				
				<!-- 리스트 부분 시작 -->
	            <div class="card-body p-0">
	            	<table class="table">
	            		<!-- 헤더부분  -->
						<thead>
		                    <tr>
		                    	<!-- 
		                        <th style="width: 150px; padding-left: 50px; text-align: center;">No.</th>
		                     	<th style="width:50%; padding-left: 30px; text-align: center;" class="jg"> 제목</th> 
								<th style="text-align: center;" class="jg">   작성자 </th>
								<th style="text-align: center;" class="jg">   날짜   </th>
								 -->
								<th class="jg" style="text-align: ; width: 10%; padding-left: 50px">NO.</th>
								<th class="jg" style="padding-left: 30px; width: 20%">제목</th>
								<th class="jg" style="text-align: center; width: 10%">작성자</th>
								<th class="jg" style="text-align: center; width: 15%">작성일</th>
		                    </tr>
	                 	</thead>
						<!-- 리스트부분 -->
						<tbody >
						<c:set var="count" value="0"/>
							<c:forEach items="${noticelist }" var="noti" varStatus="status">
								<c:if test="${noti.importance eq 'emg'}">
									<c:set var="count" value="${count + 1}"/>
								</c:if>
							
							</c:forEach>
							
							<c:forEach items="${noticelist }" var="notice" varStatus="status">

								<tr>
									<c:choose>
										<c:when test="${notice.importance eq 'emg'}">
											<td class="jg" style="width: 10%; padding-left: 25px; color: red;"><span style="border: 1px solid #F6CECE; padding: 5px; border-radius: 5px; background-color: #F6CECE">공지사항</span></td>
										</c:when>
										<c:when test="${notice.importance eq 'gen'}">
												<td class="jg" style="width: 10%; padding-left: 55px; text-align: ; ">
													<c:out value="${  ((noticeVo.pageIndex-1) * noticeVo.pageUnit + (status.index+1)) - count}" />
												</td>
										</c:when>
									</c:choose>
										
									<td class="jg"  style="padding-left: 30px; width: 20%">
										<c:if test="${notice.importance eq 'gen'}"><span class="badge badge-success ns">일반</span></c:if>
										<c:if test="${notice.importance eq 'emg'}"><span class="badge badge-danger ns">필독</span></c:if>
										&nbsp;
										<a href="${pageContext.request.contextPath}/admin/eachnoticeDetail?noticeId=${notice.noticeId}">
											<c:if test="${fn:length(notice.noticeTitle) > 30}">									
												${fn:substring(notice.noticeTitle,0 ,30) }...
											</c:if>
											<c:if test="${fn:length(notice.noticeTitle) <= 30}">									
												${notice.noticeTitle}
											</c:if>
										</a>
									</td>
									
									<td class="jg" style="text-align: center; width: 10%">${notice.adminId }</td>
									<td class="jg" style="text-align: center; width: 15%">${notice.regDt }</td>
									
								</tr>
								
							</c:forEach>
							<c:if test="${noticelist.size() == 0}">
								<td colspan="7" style="text-align: center;" class="jg"><br> <strong>
										[ 결과가 없습니다. ] </strong></td>
							</c:if>
							
						</tbody>
	            	</table>
	            </div><!-- 리스트 부분 끝 -->
	            
				<br>
				<!-- 페이징,등록 부분 시작 -->
				<div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm jg" id ="pagingui">
	              	
		        		<li  class="page-item jg" id ="pagenum" >	
		        		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
		        		<form:hidden path="pageIndex" />		        		
                    
	                 </ul>
        		  </div>
				<br>
				<div class="card-footer clearfix">
					<button id="insertnotice" type="button"
						class="btn btn-default float-left" onclick="noticeInsert()">
						<i class="fas fa-plus"></i>등 록
					</button>
				</div>
				<!-- 페이징,등록 부분 끝 -->

			</div><!-- /.card-body -->
		</div>
	</section>	
</form:form>
</body>
</html>