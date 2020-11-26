<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
</head>
<title>협업관리프로젝트</title>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<!-- main_header -->
		<tiles:insertAttribute name="header" />
		<!-- left Sidebar Container -->
		<tiles:insertAttribute name="left" />

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Main content -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
					<tiles:insertAttribute name="content" />
					</div>
				</div>
			</div>
		</div>

		<!-- Content Wrapper. Contains page content -->

		<%-- 		<%@include file="content.jsp"%> --%>


		<!-- Control Sidebar -->
		<tiles:insertAttribute name="right" />


		<!-- Main Footer -->
		<tiles:insertAttribute name="footer" />
	</div>

	<!-- jQuery, style -->
	<%@include file="commonLib.jsp"%>
</body>
</html>

