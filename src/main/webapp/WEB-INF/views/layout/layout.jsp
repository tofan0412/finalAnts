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

		<!-- Main content -->
		<div class="wrapper">
			<div class="content-wrapper">
				<tiles:insertAttribute name="content" />
			</div>
		</div>
		<!-- Control Sidebar -->
		<tiles:insertAttribute name="right" />

		<!-- Main Footer -->
		<tiles:insertAttribute name="footer" />

	</div>

	<!-- jQuery, style -->
	<%@include file="commonLib.jsp"%>
</body>
</html>

