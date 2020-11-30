<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>noticeList.jsp</title>
</head>
<body>
	<div class="col-lg-12" >
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3 class="box-title">게시글 목록</h3>
			</div>
			<div class="box-body">
				<table class="table table-bordered" border="1">
					<tbody >
						<tr>
							<th style="width: 30px">#</th>
							<th>제목</th>
							<th style="width: 100px">작성자</th>
							<th style="width: 150px">작성시간</th>
							<th style="width: 60px">조회</th>
						</tr>
<%-- 						<c:forEach items="notices" var="notice"> --%>
<!-- 							<tr> -->
<%-- 								<td>${notice.noticeId }</td> --%>
								
<!-- 							</tr> -->
<%-- 						</c:forEach> --%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>

