<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set value="<%=new Date() %>" var="currTime" ></c:set>
<fmt:formatDate value="${currTime }" var="currTime" pattern="yyyy-MM-dd HH:mm:ss" />
<script>
	let sock = new SockJS("/echo");
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	$('#sendMsg').on('click',function(){
		// 공백인 경우 전송하지 않는다.
		if ($('#sendChatCont').val() == ''){
			return;
		}
		else{
			var memId = '${SMEMBER.memId}';
			var regDt = '${currTime}';
			var cgroupId = '${cgroup.cgroupId }';
			var chatCont = $('#sendChatCont').val(); 
			sendMessage();
			$('#sendChatCont').val('');
			
			$.ajax({
				url : "/chat/sendMessage",
				data : {memId : memId, 
					    regDt : regDt, 
					    cgroupId : cgroupId,
					    chatCont : chatCont},
				method : "POST",
				success : function(res){
					
				}
			})	
		}
	})	
	
	// 메시지 전송
	function sendMessage() {
		sock.send($("#sendChatCont").val());
	}
	// 서버로부터 메시지를 받았을 때. 내 아이디인 경우 우측에 배치하고 상대방인 경우 좌측에 배치한다. 
	function onMessage(msg) {
		var data = msg.data;
		var arr = data.split("$$$$");
		var id = arr[0];
		var chatCont = arr[1];
	
		// 내가 전송한 글인 경우 ..
		if (id == '${SMEMBER.memId}'){
			var memId = "<br><div class=\'myMemId memId\'>"+ id + "</div>";
			var timeCode = "<div class='myRegDt'>";
			timeCode += "<c:out value='${currTime}'/></div>";
			
			$('#msgArea').append("<div class=\'oneMsg\'>");
			$('#msgArea').append(memId);
			$("#msgArea").append("<div class=\'myChatCont chatCont\'>"+ chatCont + "</div><br>");
			$("#msgArea").append(timeCode);
			$('#msgArea').append("</div>");
			$('#msgArea').append("<br>");
			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);	
		}
		else{
			var memId = "<br><div class=\'yourMemId memId\'>"+ id + "</div>";
			var timeCode = "<div class='yourRegDt'>";
			timeCode += "<c:out value='${currTime}'/></div>";
			
			$('#msgArea').append("<div class=\'oneMsg\'>");
			$('#msgArea').append(memId);
			$("#msgArea").append("<div class=\'yourChatCont chatCont\'>"+ chatCont + "</div><br>");
			$("#msgArea").append(timeCode);
			$('#msgArea').append("</div>");
			$('#msgArea').append("<br>");
			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
		}	
	}
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#msgArea").append("서버 연결 끊김..");
	}
</script>
<style>
#msgArea{
	overflow-y : scroll;
	padding : 5px;
	height : 300px;
}
.chatCont{
	color : black;
	background-color : yellow;
	border-radius: 0.3rem !important;
	padding : 5px;
}
.myChatCont{
	float : right;
	margin-left : 60px;
	font-size : 1em;
}
.yourChatCont{
	float : left;
	margin-right : 60px;
	font-size : 1em;
}
.myRegDt{
	font-size : 0.9em;
	color : white; 
	float : right;
	text-align : right;
}
.yourRegDt{
	font-size : 0.9em;
	color : white;
	float : left;
	text-align : left; 

}
.memId{
	color : white;
	font-size : 1em;
	padding-top : 10px;
}

.myMemId{
	text-align : right;	
}
.yourMemId{
	text-align : left;
}
.oneMsg{
	margin-top : 30px;
	margin-bottom : 30px;
}


#msgArea::-webkit-scrollbar {width: 16px;}
#msgArea::-webkit-scrollbar-track {background-color:#f1f1f1;}
#msgArea::-webkit-scrollbar-thumb {background-color:#f1ef79;border-radius: 10px;}
#msgArea::-webkit-scrollbar-thumb:hover {background: #555;}
#msgArea::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment {
width:16px;height:16px;background:#f1ef79;} 
</style>
<div>${cgroup.cgroupName }</div>
<!-- 채팅 메시지 목록 부분  -->
<div id="msgArea">	
	<c:forEach items="${msgList }" var="msg">
			
			<input type="text" value='${cgroup.cgroupId }' hidden="hidden">
			<c:if test="${msg.memId eq SMEMBER.memId }">
			<div class="oneMsg">
				<div class="myMemId memId">${msg.memId }</div>
				<div class="myChatCont chatCont">${msg.chatCont }</div><br>
				<div class="myRegDt">${msg.regDt }</div>
				<br>
			</div>
			</c:if>
		
		
		<c:if test="${msg.memId ne SMEMBER.memId }">
			<div class="oneMsg">
				<div class="yourMemId memId">${msg.memId }</div>
				<div class="yourChatCont chatCont">${msg.chatCont }</div><br>
				<div class="yourRegDt">${msg.regDt }</div>
				<br>
			</div>
		</c:if>
	</c:forEach>
</div>
<!-- 텍스트 전송 부분 .. -->
<div style="float : left;">
	<textarea id='sendChatCont' cols='17' rows='3' style='resize : none; margin-top : 5px;'/>
	<input id="sendMsg" type='button' style="height : 40px;" value="전송">
</div>
	
$$$$$$$
