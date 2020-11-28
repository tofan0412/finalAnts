<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="http://fonts.googleapis.com/earlyaccess/nanumpenscript.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/jejumyeongjo.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/kopubbatang.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumbrushscript.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/hanna.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanummyeongjo.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/jejuhallasan.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
<style>
.np{font-family: 'Nanum Pen Script', cursive;}
.jg{font-family: 'Jeju Gothic', sans-serif;}
.jm{font-family: 'Jeju Myeongjo', serif;}
.kb{font-family: 'KoPub Batang', serif;}
.nb{font-family: 'Nanum Brush Script', cursive;}
.ns{font-family: 'Noto Sans KR', sans-serif;}
.hn{font-family: 'Hanna', sans-serif;}
.ng{font-family: 'Nanum Gothic', sans-serif;}
.nm{font-family: 'Nanum Myeongjo', serif;}
.jh{font-family: 'Jeju Hallasan', cursive;}
.ngc{font-family: 'Nanum Gothic Coding', monospace;}
</style>

</head>
<title>협업관리프로젝트</title>
<body class="hold-transition sidebar-mini accent-teal">
	<div class="wrapper">

		<!-- main_header -->
		<%@include file="../layout/header.jsp"%>
		

		<!-- left Sidebar Container -->
		<%@include file="../layout/left.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		  <div class="content-wrapper">
		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											border-bottom: 1px solid #dee2e6;
											background: white;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1 class="jg">요구사항 정의서</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">요구사항 정의서</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		

    <!-- Main content -->
		    <section class="content">
		      <div class="col-md-12">
			      <div class="card" style="border-radius: inherit;">
	              <div class="card-header">
	                <h3 class="card-title">요구사항 정의서</h3>
	
	                <div class="card-tools">
	                  <ul class="pagination pagination-sm float-right">
	                    <li class="page-item"><a class="page-link" href="#">«</a></li>
	                    <li class="page-item"><a class="page-link" href="#">1</a></li>
	                    <li class="page-item"><a class="page-link" href="#">2</a></li>
	                    <li class="page-item"><a class="page-link" href="#">3</a></li>
	                    <li class="page-item"><a class="page-link" href="#">»</a></li>
	                  </ul>
	                </div>
	              </div>
	              <!-- /.card-header -->
	              <div class="card-body p-0">
	                <table class="table">
	                  <thead>
	                    <tr>
	                      <th style="width: 10px">#</th>
	                      <th>Task</th>
	                      <th>Progress</th>
	                      <th style="width: 40px">Label</th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                    <tr>
	                      <td>1.</td>
	                      <td>Update software</td>
	                      <td>
	                        <div class="progress progress-xs">
	                          <div class="progress-bar progress-bar-danger" style="width: 55%"></div>
	                        </div>
	                      </td>
	                      <td><span class="badge bg-danger">55%</span></td>
	                    </tr>
	                    <tr>
	                      <td>2.</td>
	                      <td>Clean database</td>
	                      <td>
	                        <div class="progress progress-xs">
	                          <div class="progress-bar bg-warning" style="width: 70%"></div>
	                        </div>
	                      </td>
	                      <td><span class="badge bg-warning">70%</span></td>
	                    </tr>
	                    <tr>
	                      <td>3.</td>
	                      <td>Cron job running</td>
	                      <td>
	                        <div class="progress progress-xs progress-striped active">
	                          <div class="progress-bar bg-primary" style="width: 30%"></div>
	                        </div>
	                      </td>
	                      <td><span class="badge bg-primary">30%</span></td>
	                    </tr>
	                    <tr>
	                      <td>4.</td>
	                      <td>Fix and squish bugs</td>
	                      <td>
	                        <div class="progress progress-xs progress-striped active">
	                          <div class="progress-bar bg-success" style="width: 90%"></div>
	                        </div>
	                      </td>
	                      <td><span class="badge bg-success">90%</span></td>
	                    </tr>
	                  </tbody>
	                </table>
	              </div>
	              <!-- /.card-body -->
	            </div>
            </div>
		    </section>
		    <!-- /.content -->
		  </div>
		      
		    </section>
		    <!-- /.content -->
		  </div>
  <!-- /.content-wrapper -->

		<!-- Content Wrapper. Contains page content -->
		<%-- 		<%@include file="content.jsp"%> --%>


		<!-- Control Sidebar -->
		<%@include file="../layout/rigth.jsp"%>


		<!-- Main Footer -->
		<%@include file="../layout/footer.jsp"%>
	</div>

	<!-- jQuery, style -->
	<%@include file="../layout/commonLib.jsp"%>
	
</body>
</html>
