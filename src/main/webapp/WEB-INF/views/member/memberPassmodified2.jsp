<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>



<script type="text/javascript" src="https://sens.apigw.ntruss.com/sms/v2/services/{serviceId}/messages"></script>
 
<meta http-equiv="Content-Type" content="application/json; charset=UTF-8">
<meta http-equiv="x-ncp-apigw-timestamp" content="{Timestamp}">
<meta http-equiv="x-ncp-iam-access-key" content="{Sub Account Access Key}">
<meta http-equiv="x-ncp-apigw-signature-v2" content="{API Gateway Signature}">



<title>Insert title here</title>
</head>
<style>
.ke{
	width : 300px;
}
</style>
발신성공
<body>

	<form method="post" id="smsForm" action="/member/sendSms">
	    <ul>
	      <li>보낼사람 : <input type="text" name="from"/></li>
	      <li>내용 : <textarea name="text"></textarea></li>
	      <li><input type="button" onclick="sendSMS('sendSms')" value="전송하기" /></li>
	    </ul>
	    <input type="submit">
  	</form>

 	
</body>

 <script>
    function sendSMS(pageName){
    	console.log("문자를 전송합니다.");
    	$("#smsForm").submit();
    }
  </script>

</html>