<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@include file="fonts.jsp"%>

</head>
<title>협업관리프로젝트</title>
<body class="hold-transition sidebar-mini accent-teal">

		    <section class="content-header" style="
											border-bottom: 1px solid #dee2e6;
											background: linear-gradient(-10deg, #007bff, lightgoldenrodyellow) fixed;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		         <c:if test="${plpmList ne null}">
					<c:forEach items="${plpmList}" var="project">
						<c:if test="${projectId eq project.reqId}"><h1 class="jg">${project.proName}</h1><c:set var="projectNAME" value="${project.proName}"></c:set></c:if>
					</c:forEach>
		         </c:if>
		         <c:if test="${projectList ne null}">
					<c:forEach items="${projectList}" var="project">
						<c:if test="${projectId eq project.reqId}"><h1 class="jg">${project.proName}</h1><c:set var="projectNAME" value="${project.proName}"></c:set></c:if>
					</c:forEach>
		         </c:if>
		            
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">${projectNAME}</li>
		            </ol>
		          </div>
		        </div>
		        <div class="row mb-2">
		        	<p style = "color : lightslategray;">프로젝트 설명을 입력하세요.컬럼 만들어야 하나.. 회의하자!</p>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		
		    <!-- Main content -->
		    <section class="content" style="margin-top: 13px;">
		      <div class="col-12 col-sm-9">
	            <div class="card card-teal card-outline card-tabs">
	              <div class="card-header p-0 pt-1 border-bottom-0">
	                <ul class="nav nav-tabs" id="custom-tabs-three-tab" >
	                  <li class="nav-item">
	                    <a class="nav-link active" id="custom-tabs-three-home-tab" href="${pageContext.request.contextPath}/todo/todoList" >일감</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-gantt-tab"  href="#custom-tabs-three-gantt" >간트</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-messages-issue" href="#custom-tabs-three-issue" >이슈</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-settings-suggest"  href="#custom-tabs-three-suggest" >건의사항</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-calendar-tab"  href="#custom-tabs-three-calendar" >캘린더</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-mywork-tab"  href="${pageContext.request.contextPath}/todo/MytodoList" >내 일감</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-files-tab"  href="#custom-tabs-three-files">파일함</a>
	                  </li>
	                </ul>
	              </div>
	             
	            </div>
          	</div>
		      
		      
		      
		    </section>
		    <!-- /.content -->
	
	
	
</body>
</html>
