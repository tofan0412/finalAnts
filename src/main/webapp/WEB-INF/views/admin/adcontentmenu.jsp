<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">
	// $('#1').attr('aria-selected', true);
	// $('#1').addClass("active");
	// $("#noticebtn").on('click', function(){
	// 	$(location).attr('href', '${pageContext.request.contextPath}/admin/noticelist');
	// })
</script>

</head>
<title>adcontentmenu.jsp</title>
<body class="hold-transition sidebar-mini accent-teal">

	<!-- Main content -->
	<section class="content" style="margin-top: 13px; display:none;">
	<div class="col-12 col-sm-9">
		<div class="card card-teal card-outline card-tabs">
			<div class="card-header p-0 pt-1 border-bottom-0">
				<ul class="nav nav-tabs" id="custom-tabs-three-tab">

					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-notice"
						href="${pageContext.request.contextPath}/admin/noticelist">공지사항1</a>
					</li>

					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-memberlist"
						href="${pageContext.request.contextPath}/admin/memberlist">회원 리스트</a></li>
						
					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-iplist" href="#custom-tabs-three-iplist1">IP리스트</a></li>


				</ul>
			</div>

		</div>
	</div>

	</section>

	<!-- /.content -->



</body>
</html>
