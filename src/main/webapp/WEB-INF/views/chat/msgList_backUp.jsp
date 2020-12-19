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
			var memId = "<br><div class=\'myMemId memId\'>"+ id + "</div>";
			var timeCode = "<div class='myRegDt'>";
			timeCode += "<c:out value='${currTime}'/></div>";
			
			$('#msgArea').append("<div class=\'oneMsg\'>");
			$('#msgArea').append(memId);
			$("#msgArea").append("<div class=\'myChatCont chatCont\'>"+ chatCont + "</div><br>");
			$("#msgArea").append(timeCode);
			$('#msgArea').append("</div>");
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
			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
		}	
	}
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#msgArea").append("서버 연결 끊김..");
	}
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
	border-bottom : 1px solid #d2d6de;
	box-shadow : 5px 5px #20C997;
}
/* 메시지 출력 부분 */
#msgArea{
	overflow-y : scroll;
	padding : 5px;
	height : 300px;
	background-color : white;
	box-shadow : 5px 5px #20C997;
}
.chatCont{
	color : #444;
	background-color : #d2d6de;
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
	font-size : 0.7em;
	color : lightgrey; 
	float : right;
	text-align : right;
}
.yourRegDt{
	font-size : 0.7em;
	color : lightgrey;
	float : left;
	text-align : left; 
}

.memId{
	color : black;
	font-size : 0.8em;
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
	width : 130px; 
	height : 100px;
	background-color : yellow;
	color : black;
	position : absolute;
	top : 100px;
	left : 50px;
}

/* 메시지 전송바 스타일 */
.form-control {
    display: block;
    float : left;
    width: 180px;
    height: 35px;
    padding: .375rem .75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 2px solid white;
    border-radius: .25rem;
    box-shadow: inset 0 0 0 transparent;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.input-group-append {
    position: relative;
    margin-left: 155px;
    display : flex;
    height : 35px;
}
.btn{
	border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}
</style>
<!-- 채팅방 이름을 표시한다. -->
<div class="chatName">${cgroup.cgroupName }
	<!-- 뒤로 가기 버튼 -->
	<span class="returnBtn fas fa-undo icon" style="float : right; padding-right : 10px;"></span>
	<!-- 회원 목록 확인하기 -->
	<span class="usersBtn fas fa-user icon" style="float : right; padding-right : 10px;"></span>
	<!-- 회원 목록 버튼을 누르면 나올 팝업창 -->
</div>

<!-- 팝업창  -->
<div class="pop" style="display : none; z-index : 1;"> 
	회원 1<br> 회원2<br> 회원3
	<div class="popCloseBtn" style="width : 50px; margin : auto; ">
		닫기버튼 DIV
	</div>
</div>

<!-- 채팅 메시지 목록 부분  -->
<div id="msgArea">	
	<c:forEach items="${msgList }" var="msg">
			
		<!-- 접속한 사용자의 아이디와 일치하는 경우, 우측 배열 -->
		<c:if test="${msg.memId eq SMEMBER.memId }">
		<div class="oneMsg">
			<div class="myMemId memId">${msg.memId }</div>
			<div class="myChatCont chatCont">${msg.chatCont }</div><br>
			<div class="myRegDt">${msg.regDt }</div>
		</div>
		</c:if>
		
		<!-- 접속한 사용자가 보낸 메시지가 아닌 경우, 좌측 배열 -->
		<c:if test="${msg.memId ne SMEMBER.memId }">
			<div class="oneMsg">
				<div class="yourMemId memId">${msg.memId }</div>
				<div class="yourChatCont chatCont">${msg.chatCont }</div><br>
				<div class="yourRegDt">${msg.regDt }</div>
			</div>
		</c:if>
	</c:forEach>
</div>

<!-- 텍스트 전송 부분 .. -->
<div style="float : left; margin-top : 13px;">
	<input type="text" class="form-control" id='sendChatCont' placeholder="Message.."/>
	<span class="input-group-append">
		<button id="sendMsg" class="btn btn-success" type="button">Send</button>
	</span>
</div>
$$$$$$$