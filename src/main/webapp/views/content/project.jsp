<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
    <style>
      ng {
        font-family: "Nanum Gothic", sans-serif;
        font-size: 23px;
      }
      ng.a {
        font-weight: 400;
      }
      ng.b {
        font-weight: 700;
      }
      ng.c {
        font-weight: 800;
      }
      ng.d {
        font-weight: bold;
      }
    </style>

</head>
<title>협업관리프로젝트</title>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<!-- main_header -->
		<%@include file="../layout/main_header.jsp"%>
		

		<!-- left Sidebar Container -->
		<%@include file="../layout/left_column.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		  <div class="content-wrapper">
		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											border-bottom: 1px solid #dee2e6;
											background: linear-gradient(-10deg, #007bff, lightgoldenrodyellow) fixed;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1>협업관리툴 개발</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">협업관리툴 개발</li>
		            </ol>
		          </div>
		        </div>
		        <div class="row mb-2 ng">
		        	<p style = "color : lightslategray;">프로젝트 설명을 입력하세요.</p>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		
		    <!-- Main content -->
		    <section class="content">
		      <div class="error-page">
		        <h2 class="headline text-warning"> 404</h2>
		
		        <div class="error-content">
		          <h3><i class="fas fa-exclamation-triangle text-warning"></i> Oops! Page not found.</h3>
		
		          <p>
		            We could not find the page you were looking for.
		            Meanwhile, you may <a href="../../index.html">return to dashboard</a> or try using the search form.
		          </p>
		
		          <form class="search-form">
		            <div class="input-group">
		              <input type="text" name="search" class="form-control" placeholder="Search">
		
		              <div class="input-group-append">
		                <button type="submit" name="submit" class="btn btn-warning"><i class="fas fa-search"></i>
		                </button>
		              </div>
		            </div>
		            <!-- /.input-group -->
		          </form>
		        </div>
		        <!-- /.error-content -->
		      </div>
		      <!-- /.error-page -->
		    </section>
		    <!-- /.content -->
		  </div>
  <!-- /.content-wrapper -->

		<!-- Content Wrapper. Contains page content -->
		<%-- 		<%@include file="content.jsp"%> --%>


		<!-- Control Sidebar -->
		<%@include file="../layout/rigth_column.jsp"%>


		<!-- Main Footer -->
		<%@include file="../layout/main_footer.jsp"%>
	</div>

	<!-- jQuery, style -->
	<%@include file="../layout/commonLib.jsp"%>
	
</body>
</html>
