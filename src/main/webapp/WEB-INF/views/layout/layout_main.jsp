<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js">
</script>

<!-- jQuery, style -->
<%@include file="commonLib_main.jsp"%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>

<style type="text/css">
.hold-transition sidebar-mini{
	min-height: 1800px;
	min-width: 1600px; 
}
body{
 overflow-x: hidden;
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

	
</body>
</html>

