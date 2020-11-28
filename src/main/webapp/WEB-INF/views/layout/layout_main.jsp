<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
.hold-transition sidebar-mini{
	min-height: 1800px;
	min-width: 1600px; 
}

</style>

</head>

<title>Ants - 협업관리 프로젝트 툴</title>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!-- main_header -->
		<tiles:insertAttribute name="header" />
		
		<!-- Main content -->
		<tiles:insertAttribute name="content" />
		
		<!-- Main Footer -->
		<tiles:insertAttribute name="footer" />
	</div>

	<!-- jQuery, style -->
	<%@include file="commonLib_main.jsp"%>
</body>
</html>

