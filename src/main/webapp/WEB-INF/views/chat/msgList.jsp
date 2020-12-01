<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	let sock = new SockJS("/echo");
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	$('#sendMsg').on('click',function(){
		sendMessage();
		$('#msg').val('');
	})	
	
	
	// 메시지 전송
	function sendMessage() {
		sock.send($("#msg").val());
	}
	// 서버로부터 메시지를 받았을 때
	function onMessage(msg) {
		var data = msg.data;
		$("#msgArea").append(data + "<br/>");
	}
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#msgArea").append("연결 끊김");
	}

	
</script>
<style>
#msgArea{
	overflow-y : scroll;
	padding : 5px;
	max-height : 500px;
}
.Msg{
	color : black;
	background-color : yellow;
	border-radius: 0.3rem !important;
	padding : 5px;
	margin-top : 5px;
}
.myMsg{
	float : right;
	margin-left : 60px;
	font-size : 1em;
}
.yourMsg{
	float : left;
	margin-right : 60px;
	font-size : 1em;
	
}

</style>
<div>${cgroup.cgroupName }</div>
<!-- 채팅 메시지 목록 부분  -->
<div id="msgArea">	
	<c:forEach items="${msgList }" var="msg">
		
		<c:if test="${msg.memId eq SMEMBER.memId }">
			<div class="myMsg Msg">${msg.chatCont }</div>
		</c:if>
		<c:if test="${msg.memId ne SMEMBER.memId }">
			<div class="yourMsg Msg">${msg.chatCont }</div>
		</c:if>
	</c:forEach>
</div>	
<!-- 텍스트 전송 부분 .. -->
<div style="float : left;">
	<textarea id='msg' cols='17' rows='3' style='resize : none;'/>
	<button id="sendMsg" type='button' style="height : 60px;">전송</button>
</div>
	
$$$$$$$
