<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- jQuery, style -->
	<%@include file="../layout/commonLib.jsp"%>
	<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<style>
.content-wrapper{
	margin-top : 15px;
}
</style>
</head>
<title>관리자 협업관리</title>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<!-- main_header -->
		<tiles:insertAttribute name="adheader" />

		<!-- left Sidebar Container -->
		<tiles:insertAttribute name="adleft" />

		<!-- Main content -->
		<div class="wrapper">
			<div class="content-wrapper">
				<tiles:insertAttribute name="adcontent" />
			</div>
		</div>
		<!-- Control Sidebar -->
<%-- 		<tiles:insertAttribute name="right" /> --%>

		<!-- Main Footer -->
		<tiles:insertAttribute name="adfooter" />

	</div>


</body>
</html>

