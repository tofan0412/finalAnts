<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<%@ include file="../layout/commonLib.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#memberList tr").on("click",function(){
			//data-userid
			var userid = $(this).data("userid");
			console.log("userid : "+userid);		
			location.href = "member?userid="+userid;
			});
		});
		 
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "getpage?pageSize=" + sel;
	}
	
</script>
</head>
<body>
	일감등록
	
</body>
</html>