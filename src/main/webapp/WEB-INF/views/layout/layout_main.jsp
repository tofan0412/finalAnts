<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

