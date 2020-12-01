<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.sort{
	
		width : 120px;
		height : 30px;
	}
</style>

</head>

<%@include file="../layout/contentmenu.jsp"%>
<body>


<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
		<div class="tab-pane fade" id="custom-tabs-three-g<div id="if_list_div" style="position: relative; padding: 0; overflow: hidden; height: 750px;">
			<div class="content-wrapper" style="min-height: 584px;">
				<!-- Content Header (Page header) -->
				<section class="content-header">
					<div class="container-fluid">
						<div class="row md-2">
							<div class="col-sm-6">
								<h1>회원리스트</h1>
							</div>
							<div class="col-sm-6">
								<ol class="breadcrumb float-sm-right">
									<li class="breadcrumb-item">회원리스트</li>
									<li class="breadcrumb-item">목록</li>
								</ol>
							</div>
						</div>
					</div>
				</section>
				<!-- Main content -->
				<section class="content">
					<div class="card">
						<div class="card-header with-border">
							<button type="button" class="btn btn-primary" id ="addmember">회원등록</button>
							<div id="keyword" class="card-tools" style="width: 550px;">
								<div class="input-group row">
									<!-- sort num -->
									<select class="form-control col-md-3" name="pageSize" id="pageSize" >
										<option value="0">정렬개수</option>
										<option value="3">3개씩</option>
										<option value="5">5개씩</option>
										<option value="7">7개씩</option>
									</select>
									<!-- search bar -->
									<select class="form-control col-md-3" name="searchType" id="searchType" required>
										<option value="">검색구분</option>
										<option value="userid">아이디</option>
										<option value="usernm">이름</option>
										<option value="alias">별명</option>
									</select> <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value=""> <span class="input-group-append">
										<button class="btn btn-primary" type="button" id="searchBtn" data-card-widget="search" >
											<i class="fa fa-fw fa-search"></i>
										</button>
									</span>
									<!-- end : search bar -->
								</div>
							</div>
						</div>
						<div class="card-body" style="text-align: center;">
							<div class="row">
								<div class="col-sm-12">
									<table class="table table-bordered">
									
											<tr>
												<th>아이디</th>
												<th>패스워드</th>
												<th>별명</th>
												<th>도로주소</th>
												<th>등록날짜</th>
												<!-- yyyy-MM-dd  -->
											</tr>
											<tbody id = "memberlist">
												<c:forEach items="${memberList }" var="member">
													<tr data-userid="${member.userid }">	<!-- data는 userId의 값을 잠깐 저장을 해둘수 있다. -->											
														<td>${member.userid }</td> 
														<td>${member.pass }</td> 
														<td>${member.alias }</td>
														<td>${member.addr1 } &nbsp; ${member.addr2 } </td> 	
														<td><fmt:formatDate value="${member.reg_dt }" pattern="yyyy-MM-dd"/></td>
													</tr>
												</c:forEach>											
											</tbody>
									</table>
								</div>
								<!-- col-sm-12 -->
							</div>
							<!-- row -->
						</div>
						<!-- card-body -->
						<div class="card-footer">
							<nav aria-label="member list Navigation">
								<ul class="pagination justify-content-center m-0">
									<c:if test="${page > 1 && page <= pages}">
										<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/member/search?page=1&pageSize=${pageSize}&content=${content}&searchType=${searchType}"><i class="fas fa-angle-double-left"></i></a></li>
										<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/member/search?page=${page-1}&pageSize=${pageSize}&content=${content}&searchType=${searchType}"><i class="fas fa-angle-left"></i></a></li>
									</c:if>
								
									
									<c:forEach var="i" begin="1" end ="${pages }">
										<c:choose>
											<c:when test="${i == page}">
<%-- 												<li class="active"><span>${i }</span></li> --%>
													<li class="page-item active"><span class="page-link">${i }</span></li>
											</c:when>
											<c:otherwise>                                                                                                                                                                                                                                                                                                                                   
												<li class="page-item "><a class="page-link" href="${pageContext.request.contextPath }/member/search?page=${i}&pageSize=${pageSize}&content=${content}&searchType=${searchType}">${i}</a></li>										
											</c:otherwise>
										</c:choose>
									</c:forEach>
									
								<c:if test="${page >= 1 && page < pages}">
									
<%-- 										<li><span><a href="${pageContext.request.contextPath }/BoardlListServlet?page=${page+1}&lbo_id=${lboard.lbo_id}"> > </a></span></li>									 --%>
<%-- 										<li><span><a href="${pageContext.request.contextPath }/BoardlListServlet?page=${pages}&lbo_id=${lboard.lbo_id}"> >> </a></span></li>									 --%>
										<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/member/search?page=${page+1}&pageSize=${pageSize}&content=${content}&searchType=${searchType}"><i class="fas fa-angle-right"></i></a></li>
										<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/member/search?page=${pages}&pageSize=${pageSize}&content=${content}&searchType=${searchType}"><i class="fas fa-angle-double-right"></i></a></li>	
									</c:if>	
									
								</ul>
							</nav>

						</div>
						<!-- card-footer -->
					</div>
					<!-- card  -->
				</section>
			</div>
		</div>antt" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab">
			<h3>협업이슈 작성하기</h3>
			<form id="frm"  class="form-horizontal" method="post" 
										    action="${pageContext.request.contextPath}/projectMember/insertissue" >
				<table>
					<tr>
						<td class="sort" >이슈제목 </td> 			
						<td><input type="text" value="" name="issueTitle"></td> 						
					</tr>
					
					<tr>
						<td class="sort">이슈 내용  </td> 			
						<td><input type="text" value="" name="issueCont"></td> 						
					</tr>
					<tr>
						<td class="sort">이슈 종류</td> 			
						<td><input type="text" value="issue" name="issueKind"></td> 						
					</tr>
					<tr>
						<td class="sort">카테고리</td> 			
						<td><input type="text" value="3" name="categoryId"></td> 						
					</tr>
					
					<tr>
						<td class="sort"></td> 			
						<td><input type="submit" name="작성하기"></td> 						
					</tr>
					
				</table>
			</form>
				<p>파일 : (파일 존재시 다운로드)  </p>
				<p><input type="button" value="다운로드" id="filedown"></p>
				
	    </div>      
	   </div>
	 </div>      
</div>
	
</body>
</html>