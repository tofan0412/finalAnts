<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js">
</script>
	<!-- jQuery, style -->
	<%@include file="commonLib.jsp"%>
	<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<script type="text/javascript">
$(function(){
	var memId = '${SMEMBER.memId}';
	if (memId == ''){
		alert("로그인이 필요합니다.");
		$(location).attr('href', '/member/loginView');
	}
})
</script>
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


</body>
</html>

