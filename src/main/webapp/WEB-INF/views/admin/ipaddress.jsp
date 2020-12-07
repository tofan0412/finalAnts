<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
	
<%!String getClientIP(HttpServletRequest request) {

		String ip = request.getHeader("X-FORWARDED-FOR");

		if (ip == null || ip.length() == 0) {

			ip = request.getHeader("Proxy-Client-IP");

		}

		if (ip == null || ip.length() == 0) {

			ip = request.getHeader("WL-Proxy-Client-IP");

		}

		if (ip == null || ip.length() == 0) {

			ip = request.getRemoteAddr();

		}

		return ip;

	}%>



<html>

<head>

<title>Your IP Address</title>

</head>

<body>

	<hr>

	<p>
		Your IP Adress is <b><%=getClientIP(request)%></b>
	</p>

	<hr>

</body>
</html>