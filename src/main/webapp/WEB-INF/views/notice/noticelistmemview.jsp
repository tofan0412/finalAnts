<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
	body{
		min-width:1000px;	
		z-index:1;
	}	
				
	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 padding : 6px; 	 
		 border: none; 
	}
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
	
	#searchBtn{
		height: 38px;
	}

</style>

<script type="text/javascript">
	/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo) {
		document.listForm.pageIndex.value = pageNo;
		if('${SMEMBER}'!= null && '${SMEMBER}'!= ''){			
			document.listForm.main.value = "N";
		}else{
			document.listForm.main.value = "Y";
		}
		document.listForm.action = "<c:url value='/member/noticelistmemview'/>";
		document.listForm.submit();
	}
	
	 function search(){
		document.listForm.pageIndex.value = 1;
		if('${SMEMBER}'!= null && '${SMEMBER}'!= ''){			
			document.listForm.main.value = "N";
		}else{
			document.listForm.main.value = "Y";
		}
		document.listForm.action = "<c:url value='/member/noticelistmemview'/>";
		document.listForm.submit();
	}	
	$(function(){
		$("body").keyup(function(e){
			if(e.keyCode == 13){
				$('#searchBtn').trigger("click");
			}
		})
	})
</script>	
</head>


<body>
<form:form commandName="noticeVo" id="listForm" name="listForm" method="post">
	<form:hidden path="main"/>
		
	<section class="content" >
		<div class="col-12 col-sm-12" style="padding-top: 3%">
			<div class="card" style="border-radius: inherit; padding : 2px; margin-top: 10px">
				<!-- 헤더 부분 -->
				<div class="container-fluid">
					<div class="row mb-2">
						<br>
						<div class="col-sm-6">
							<h1 class="jg" style="padding-left: 10px; padding-top: 10px">공지사항</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right" style="background: white">
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
									<form:option value="2" label="날짜"/>
								</form:select> 
									
								<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
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
		                        <th class="jg" style="text-align: ; width: 10%; padding-left: 7%">NO.</th>
								<th class="jg" style="padding-left: 30px; width: 20%">제목</th>
								<th class="jg" style="text-align: center; width: 10%">작성자</th>
								<th class="jg" style="text-align: center; width: 15%">날짜</th>
		                    </tr>
	                 	</thead>
						
						<!-- 리스트부분 -->
						<tbody >
							<c:forEach items="${noticelist }" var="notice" varStatus="status">

								<tr>
									<td class="jg" style="width: 10%; padding-left: 7%; text-align: ; ">
										<c:out value="${  ((noticeVo.pageIndex-1) * noticeVo.pageUnit + (status.index+1))}" />
									</td>
										
									<td class="jg"  style="padding-left: 30px; width: 20%">
										<c:if test="${notice.importance eq 'gen'}"><span class="badge badge-success ns">일반</span></c:if>
										<c:if test="${notice.importance eq 'emg'}"><span class="badge badge-danger ns">필독</span></c:if>
										&nbsp;
										<c:choose>
										 	<c:when test="${not empty main}">
										 	     <a href="${pageContext.request.contextPath}/member/noticedetailmemview?noticeId=${notice.noticeId}&main=Y">
													<c:if test="${fn:length(notice.noticeTitle) > 30}">									
														${fn:substring(notice.noticeTitle,0 ,30) }...
													</c:if>
													<c:if test="${fn:length(notice.noticeTitle) <= 30}">									
														${notice.noticeTitle}
													</c:if>
												 </a>
	                                        </c:when>  
	                                        <c:otherwise>
	                                            <a href="${pageContext.request.contextPath}/member/noticedetailmemview?noticeId=${notice.noticeId}">
		                                            <c:if test="${fn:length(notice.noticeTitle) > 30}">									
														${fn:substring(notice.noticeTitle,0 ,30) }...
													</c:if>
													<c:if test="${fn:length(notice.noticeTitle) <= 30}">									
														${notice.noticeTitle}
													</c:if>
												</a>
	                                        </c:otherwise>      
                                        </c:choose>
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
			

			</div><!-- /.card-body -->
		</div>
	</section>	
</form:form>
</body>
