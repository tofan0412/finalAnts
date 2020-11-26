<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<!-- main_header -->
		<%@include file="main_header.jsp"%>

		<!-- left Sidebar Container -->
		<%@include file="left_column.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<!-- Main content -->
			<div class="content">
				<div class="container-fluid">
					<div class="row"></div>
				</div>
			</div>
		</div>

		<!-- Control Sidebar -->
		<%@include file="rigth_column.jsp"%>

		<!-- Main Footer -->
		<%@include file="main_footer.jsp"%>
	</div>

	<!-- jQuery, style -->
	<%@include file="commonLib.jsp"%>
</body>
</html>

