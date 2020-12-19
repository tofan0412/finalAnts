<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set value="<%=new Date() %>" var="currTime" ></c:set>
<fmt:formatDate value="${currTime }" var="currTime" pattern="yyyy-MM-dd HH:mm:ss" />
<script>
	// sockJS 선언하기. 만약 기존에 선언된 경우 선언을 생략한다.
	sockMsg = new SockJS("/echo");
   	sockMsg.onmessage = onMessage;
   	sockMsg.onclose = onClose;
	
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
	
	$('.returnBtn').click(function(){
		sockMsg.close();
	})
	
	// 메시지 전송
	function sendMessage() {
		sockMsg.send($("#sendChatCont").val());
	}
	// 서버로부터 메시지를 받았을 때. 내 아이디인 경우 우측에 배치하고 상대방인 경우 좌측에 배치한다. 
	function onMessage(msg) {
		var data = msg.data;
		var arr = data.split("$$$$");
		
		var cgroupId = arr[0];
		var id = arr[1];
		var chatCont = arr[2];
		
		console.log("채팅방 번호 : "+cgroupId+", 발신인 : "+id+", 내용 : "+chatCont);
		
		// 현재 내가 있는 채팅방이 아닌 경우, 메시지를 메신저에 표시하지 않는다.
		if ("${cgroupId}" != cgroupId){
			return; 
		}
		
		// 내가 전송한 글인 경우 ..
		if (id == '${SMEMBER.memId}'){
			var memId = "<div class=\'memId mine\'>"+ id + "</div>";
			var timeCode = "<div class='regDt mine'>";
			timeCode += "<c:out value='${currTime}'/></div>";
			
			$('#msgArea').append("<div class=\'oneMsg\'>");
			$('#msgArea').append(memId);
			$("#msgArea").append("<div class=\"chatCont mine\"><span class=\'spaan\'>&nbsp;"+ chatCont + "&nbsp;</span></div>");
			$("#msgArea").append(timeCode);
			$('#msgArea').append("</div>");
			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);	
		}
		else{
			var memId = "<div class=\'memId yours\'>"+ id + "</div>";
			var timeCode = "<div class='regDt yours'>";
			timeCode += "<c:out value='${currTime}'/></div>";
			
			$('#msgArea').append("<div class=\'oneMsg\'>");
			$('#msgArea').append(memId);
			$("#msgArea").append("<div class=\"chatCont yours\"><span class=\'spaan\'>&nbsp;"+ chatCont + "&nbsp;</span></div>");
			$("#msgArea").append(timeCode);
			$('#msgArea').append("</div>");
			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
		}	
	}
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#msgArea").append("서버 연결 끊김..");
	}
	$(function(){
		// 문서 로딩이 끝나면 최 하단으로 내린다...
		$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);	
		
		
		
		
		
	})
</script>
<style>
/* 채팅방 제목 부분 */
.chatName{
	background-color : white;
	height : 50px;
	/* 수직 방향으로 가운데 정렬 */
/* 	display: table-cell; */
/*  vertical-align: middle;	 */
	padding-top : 15px;
	color : black;
	padding-left : 10px;
	border-bottom : 2px solid lightgrey;	
}
/* 메시지 출력 부분 */
#msgArea{
	overflow-y : scroll;
	padding : 5px;
	height : 100%;
	background-color : white;
}
.chatCont{
	color : #444;
	border-radius: 0.3rem !important;
	padding : 5px;
}

.regDt{
	font-size : 0.7em;
	color : lightgrey;
}

.memId{
	color : black;
	font-size : 0.8em;
}

.mine{
	text-align : right;	
	align : right;
	margin-left : 30%;
}

.yours{
	text-align : left;
	align : left;
	margin-right : 30%;
}

.oneMsg{
	margin-top : 15px;
	margin-bottom : 15px;
}
.spaan{
	background-color : #d2d6de;
	height : 100%;
	display:inline-block;
	border-radius : 0.4rem;
	text-align : left;
	padding : 2px 2px 4px 4px;
}
.announce{
	text-align : center;
}
/* 스크롤바 스타일 */
#msgArea::-webkit-scrollbar {width: 16px;}
#msgArea::-webkit-scrollbar-track {background-color:#f1f1f1;} 
#msgArea::-webkit-scrollbar-thumb {background-color:#b8babd;}
#msgArea::-webkit-scrollbar-thumb:hover {background: #b8babd;}
#msgArea::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment {
width:16px;height:16px;background:#d2d6de;} 

.fas{
	cursor : pointer;
}
.pop{
	width : 250px; 
	height : 400px;
	overflow-y : auto;
	background-color : white;
	border : 2px solid black;
	border-radius : 0.4rem;
	color : black;
	position : absolute;
	top : 13%;
	left : 48%;
	padding : 10px 10px 10px 10px;
}

/* 메시지 전송바 스타일 */
.sendMsgTextbar {
    width: 100%;
    height: 7%;
    margin-top : 5px;
    font-size: 1rem;
    font-weight: 400;
    border: 2px solid skyblue;
    border-radius: .4rem;
}
</style>
<!-- 채팅방 이름을 표시한다. -->
<div class="chatName">${cgroup.cgroupName }
	<!-- 뒤로 가기 버튼 -->
	<span class="returnBtn fas fa-undo icon" style="float : right; padding-right : 10px;"></span>
	<!-- 회원 목록 확인하기 -->
	<span class="usersBtn fas fa-user icon" style="float : right; padding-right : 10px;"></span>
	<!-- 채팅방 나가기 버튼 -->
	<span class="exitBtn fas fa-door-open icon" style="float : right; padding-right : 10px;"></span>
</div>

<!-- 팝업창  -->
<div class="pop" style="display : none; z-index : 1; overflow-y : auto;"> 
	<label class="jg" style="padding-top : 10px;"><h4>채팅방 회원 목록</h4></label><hr>
	<c:forEach var="i" begin="0" end="${chatMemList.size() }" >
		<div style="height : 10%; folat : left;">${chatMemList[i].memId }	
			<br><span style="color : blue;">${memInfoList[i].memName }</span>
		</div>
		<br>
	</c:forEach>
</div>

<!-- 채팅 메시지 목록 부분  -->
<div id="msgArea">	
	<c:forEach items="${msgList }" var="msg">
			
		<!-- 접속한 사용자의 아이디와 일치하는 경우, 우측 배열 -->
		<c:if test="${msg.memId eq SMEMBER.memId }">
			<div class="oneMsg" chatId="${msg.chatId}" >
				<div class="memId mine">${msg.memId }</div>
				<div class="chatCont mine">
					<span class="spaan">&nbsp;${msg.chatCont }&nbsp;</span>
				</div>
				<div class="regDt mine">${msg.regDt }</div>
			</div>
		</c:if>
		<!-- 접속한 사용자가 보낸 메시지가 아닌 경우, 좌측 배열 -->
		<c:if test="${msg.memId ne SMEMBER.memId }">
			<div class="oneMsg" chatId="${msg.chatId}" >
				<div class="memId yours">${msg.memId }</div>
				<div class="chatCont yours">
					<span class="spaan">&nbsp;${msg.chatCont }&nbsp;</span>
				</div>
				<div class="regDt yours">${msg.regDt }</div>
			</div>
		</c:if>
	</c:forEach>
</div>

<!-- 텍스트 전송 부분 .. -->
<input type="text" class="sendMsgTextbar" id='sendChatCont' placeholder="Message.." autocomplete="off" />
<button id="sendMsg" class="btn btn-success" type="button" style="width : 100%;">Send</button>
$$$$$$$
