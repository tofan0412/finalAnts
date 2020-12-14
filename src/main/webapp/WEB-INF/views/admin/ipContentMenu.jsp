<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<h1 class="jg">IP 설정</h1>
<div class="col-12 col-sm-12">
	<div class="card card-teal card-outline card-tabs">
		<div class="card-header p-0 pt-1 border-bottom-0">
			<ul class="nav nav-tabs" id="custom-tabs-three-tab">

				<li class="nav-item"><a class="nav-link"
					id="custom-tabs-three-notice"
					href="${pageContext.request.contextPath}/admin/noticelist">허용
						IP 리스트</a></li>

				<li class="nav-item"><a class="nav-link"
					id="custom-tabs-three-memberlist"
					href="${pageContext.request.contextPath}/admin/memberlist">차단
						IP 리스트</a></li>

				<li class="nav-item"><a class="nav-link"
					id="custom-tabs-three-iplist" href="#custom-tabs-three-iplist1">IP
						등록</a></li>

				<li class="nav-item"><a class="nav-link"
					id="custom-tabs-three-iplist" href="#custom-tabs-three-iplist1">IP
						변경</a></li>
			</ul>
		</div>
	</div>
</div>