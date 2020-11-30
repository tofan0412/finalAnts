<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@include file="/WEB-INF/views/layout/fonts.jsp"%>

</head>
<title>협업관리프로젝트</title>
<body class="hold-transition sidebar-mini accent-teal ngc">
	<div class="wrapper">

		<!-- main_header -->
		<%@include file="../layout/header.jsp"%>
		

		<!-- left Sidebar Container -->
		<%@include file="../layout/admin_left.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		  <div class="content-wrapper">
		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											border-bottom: 1px solid #dee2e6;
											background: linear-gradient(-10deg, #007bff, lightgoldenrodyellow) fixed;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1 class="jg">협업관리툴 개발</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">협업관리툴 개발</li>
		            </ol>
		          </div>
		        </div>
		        <div class="row mb-2">
		        	<p style = "color : lightslategray;">프로젝트 설명을 입력하세요.</p>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		
		    <!-- Main content -->
		    <section class="content" style="margin-top: 13px;">
		      <div class="col-12 col-sm-9">
	            <div class="card card-teal card-outline card-tabs">
	              <div class="card-header p-0 pt-1 border-bottom-0">
	                <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
	                  <li class="nav-item">
	                    <a class="nav-link active" id="custom-tabs-three-home-tab" data-toggle="pill" href="#custom-tabs-three-work" role="tab" aria-controls="custom-tabs-three-home" aria-selected="true">일감</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-gantt-tab" data-toggle="pill" href="#custom-tabs-three-gantt" role="tab" aria-controls="custom-tabs-three-gantt" aria-selected="false">간트</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-messages-issue" data-toggle="pill" href="#custom-tabs-three-issue" role="tab" aria-controls="custom-tabs-three-issue" aria-selected="false">이슈</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-settings-suggest" data-toggle="pill" href="#custom-tabs-three-suggest" role="tab" aria-controls="custom-tabs-three-suggest" aria-selected="false">건의사항</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-calendar-tab" data-toggle="pill" href="#custom-tabs-three-calendar" role="tab" aria-controls="custom-tabs-three-calendar" aria-selected="false">캘린더</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-mywork-tab" data-toggle="pill" href="#custom-tabs-three-mywork" role="tab" aria-controls="custom-tabs-three-mywork" aria-selected="false">내 일감</a>
	                  </li>
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-files-tab" data-toggle="pill" href="#custom-tabs-three-files" role="tab" aria-controls="custom-tabs-three-files" aria-selected="false">파일함</a>
	                  </li>
	                </ul>
	              </div>
	              <!-- 내용 -->
	              <div class="card-body">
	                <div class="tab-content" id="custom-tabs-three-tabContent">
	                  <div class="tab-pane fade active show" id="custom-tabs-three-work" role="tabpanel" aria-labelledby="custom-tabs-three-work-tab">
	                  	일감내용입니다.
	                  </div>
	                  <div class="tab-pane fade" id="custom-tabs-three-gantt" role="tabpanel" aria-labelledby="custom-tabs-three-gantt-tab">
	                  	간트차트입니다.
	                  </div>
	                  <div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab">
	                  	이슈내용입니다.
	                  </div>
	                  <div class="tab-pane fade" id="custom-tabs-three-suggest" role="tabpanel" aria-labelledby="custom-tabs-three-suggest-tab">
	                  	건의사항입니다.
	                  </div>
	                  <div class="tab-pane fade" id="custom-tabs-three-calendar" role="tabpanel" aria-labelledby="custom-tabs-three-calendar-tab">
	                  	캘린더입니다
	                  </div>
	                  <div class="tab-pane fade" id="custom-tabs-three-mywork" role="tabpanel" aria-labelledby="custom-tabs-three-mywork-tab">
	                  	내일감 입니다.
	                  </div>
	                  <div class="tab-pane fade" id="custom-tabs-three-files" role="tabpanel" aria-labelledby="custom-tabs-three-files-tab">
	                  	파일함 입니다.
	                  </div>
	                </div>
	              </div>
	              <!-- /.card -->
	            </div>
          	</div>
		      
		      
		      
		    </section>
		    <!-- /.content -->
		  </div>
  <!-- /.content-wrapper -->

		<!-- Content Wrapper. Contains page content -->
		<%-- 		<%@include file="content.jsp"%> --%>


		<!-- Control Sidebar -->
<%-- 		<%@include file="../layout/right.jsp"%> --%>


		<!-- Main Footer -->
		<%@include file="../layout/footer.jsp"%>
	</div>

	<!-- jQuery, style -->
	<%@include file="../layout/commonLib.jsp"%>
	
</body>
</html>
