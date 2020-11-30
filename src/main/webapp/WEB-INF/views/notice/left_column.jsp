<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul class="sidebar-menu" data-widget="tree">
		<li class="header">메뉴</li>
		<li class="active"><a href="${pageContext.request.contextPath}/notice/noticeWrite"><i class="fa fa-edit"></i><span>게시글 작성</span></a></li>
		<li><a href="${pageContext.request.contextPath }/notice/noticeList"><i class="fa fa-list"></i><span>게시글 목록</span></a></li>
	</ul>
</body>
</html>