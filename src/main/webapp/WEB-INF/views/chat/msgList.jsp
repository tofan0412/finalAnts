<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	getNow();
	// 시간 관련 함수 설정
	function getNow() {
		var now = new Date();

		var calendar = now.getFullYear() + "-" + (now.getMonth() + 1) + "-"
				+ now.getDate();

		var currentHours = addZeros(now.getHours(), 2);
		var currentMinute = addZeros(now.getMinutes(), 2);
		var currentSeconds = addZeros(now.getSeconds(), 2);

		$('#clock').val(
				calendar + " " + currentHours + ":" + currentMinute + ":"
						+ currentSeconds);
		setTimeout("getNow()", 1000);
	}

	function addZeros(num, digit) { // 자릿수 맞춰주기
		var zero = '';
		num = num.toString();
		if (num.length < digit) {
			for (i = 0; i < digit - num.length; i++) {
				zero += '0';
			}
		}
		return zero + num;
	}

	// sockJS 선언하기. 만약 기존에 선언된 경우 선언을 생략한다.
	sockMsg = new SockJS("/echo");
	sockMsg.onmessage = onMessage;
	sockMsg.onclose = onClose;

	$('#sendMsg').on('click', function() {
		// 공백인 경우 전송하지 않는다.
		if ($('#sendChatCont').val() == '') {
			return;
		} else {
			var memId = '${SMEMBER.memId}';
			var memName = '${SMEMBER.memName}';
			var regDt = $('#clock').val();
			var cgroupId = '${cgroup.cgroupId }';
			var chatCont = $('#sendChatCont').val();
			sendMessage();
			$('#sendChatCont').val('');

			$.ajax({
				url : "/chat/sendMessage",
				data : {
					memId : memId,
					regDt : regDt,
					memName : memName,
					cgroupId : cgroupId,
					chatCont : chatCont
				},
				method : "POST",
				success : function(res) {

				}
			})
		}
	})

	$('.returnBtn').click(function() {
		sockMsg.close();
	})

	// 메시지 전송
	function sendMessage() {
		sockMsg.send($("#sendChatCont").val());
	}

	// 엔터버튼으로 전송
	$(".sendMsgTextbar").keyup(function(e) {
		if (e.keyCode == 13) {
			$('#sendMsg').trigger("click");
		}
	})

	// 서버로부터 메시지를 받았을 때. 내 아이디인 경우 우측에 배치하고 상대방인 경우 좌측에 배치한다. 
	function onMessage(msg) {
		var data = msg.data;
		var arr = data.split("$$$$");	// 채팅방 번호, memId, memName, 메시지 내용

		var cgroupId = arr[0];
		var id = arr[1];
		var memName = arr[2];
		var chatCont = arr[3];

		// 		console.log("채팅방 번호 : "+cgroupId+", 발신인 : "+id+", 내용 : "+chatCont);

		// 현재 내가 있는 채팅방이 아닌 경우, 메시지를 메신저에 표시하지 않는다.
		if ("${cgroupId}" != cgroupId) {
			return;
		}

		// 내가 전송한 글인 경우 ..
		if (id == '${SMEMBER.memId}') {
			var memId = "<div class=\'memId mine\'>" + memName + "</div>";
			var timeCode = "<div class='regDt mine'>";
			timeCode += $('#clock').val() + "</div>";

			$('#msgArea').append("<div class=\'oneMsg\'>");
			$('#msgArea').append(memId);
			$("#msgArea").append(
					"<div class=\"chatCont mine\"><span class=\'spaan\'>&nbsp;"
							+ chatCont + "&nbsp;</span></div>");
			$("#msgArea").append(timeCode);
			$('#msgArea').append("</div>");
			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
		} else {
			var memId = "<div class=\'memId yours\'>" + memName + "</div>";
			var timeCode = "<div class='regDt yours'>";
			timeCode += $('#clock').val() + "</div>";

			$('#msgArea').append("<div class=\'oneMsg\'>");
			$('#msgArea').append(memId);
			$("#msgArea").append(
					"<div class=\"chatCont yours\"><span class=\'spaan\'>&nbsp;"
							+ chatCont + "&nbsp;</span></div>");
			$("#msgArea").append(timeCode);
			$('#msgArea').append("</div>");
			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
		}
	}
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#msgArea").append("서버 연결 끊김..");
	}
	$(function() {
		popInviteMemListArr = [];
		popInviteMemNameListArr = [];
		
		// 문서 로딩이 끝나면 최 하단으로 내린다...
		$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
		
		// mouseenter, mouseleave 이벤트
		$('.popInvite').on('mouseenter','invitePjtMember',function(){
			$(this).css("background-color", 'lightgrey');
		})
		
		$('.popInvite').on('mouseleave','invitePjtMember',function(){
			$(this).css("background-color", 'white');
		})
		
		// 팝업창 관련 스크립트 - 회원 초대 팝업창
		$('.userInviteBtn').on('click',function(){
			// 초대할 회원 목록 초기화
			popInviteMemListArr = [];
			popInviteMemNameListArr = [];
			// 프로젝트 멤버 회원 리스트 초기화
			$('.popInvite .popInviteMemList').empty();
			$('.popInviteAddedMemList').empty();
			$('.popWarning').empty();
			
			if ($('.popInvite').css('display') == 'none'){
				$('.popInvite').css('display', 'block');
				
				$.ajax({
					url : "/projectMember/proMemList",
					data : {reqId : '${projectId}'},
					method : "POST", 
					success : function(res){
						chatMemListArr = $('.popChatMemList');
						alreadyIn = 0;
						for (i = 0 ; i < res.length ; i++){
							alreadyIn = 0;
							// 이미 채팅방에 참여한 회원인지 검사
							for(j = 0 ; j < chatMemListArr.length ; j++){
								if (res[i].memId == chatMemListArr[j].attributes[1].value){
									alreadyIn++;
									break;
								}
							}							
							
							if (res[i].memFilepath != '' && alreadyIn == 0){
								$('.popInvite .popInviteMemList').append(
									"<div class=\'popInviteMem\' style=\'margin-top : 10px;\'>"
									+"<img class=\'img-circle\' alt=\'이미지\'"
										+ "style=\'width : 25px; height : 25px; padding-right : 5px;\'"
										+ "src=\'" + res[i].memFilepath + "\'/>"
										+ res[i].memName + "[" + res[i].memId + "]"
										+ "<span class=\'popInviteMemBtn\' memId=\'" + res[i].memId + "\' "
											+ "memName=\'" + res[i].memName + "\' "
											+ "style=\'border : 2px solid white; "
									        +"border-radius : 0.45rem; "
											+"background-color : #81BEF7; "
											+"float : right;"
											+"cursor : pointer;"
											+"color : white;\'" + ">&nbsp;초대&nbsp;</span></div>"
								)
							}
							if (res[i].memFilepath == '' && alreadyIn == 0){
								$('.popInvite .popInviteMemList').append(
									"<div class=\'popInviteMem\' style=\'margin-top : 10px;\'>"	
									+"<img class=\'img-circle\' alt=\'이미지\'"
										+ "style=\'width : 25px; height : 25px; padding-right : 5px;\'"
										+ "src=\'${pageContext.request.contextPath }/WEB-INF/views/userprofile/user-1.png\'/>"
										+ res[i].memName + "[" + res[i].memId + "]"
										+ "<span class=\'popInviteMemBtn\' memId=\'" + res[i].memId + "\' "
											+ "memName=\'" + res[i].memName + "\' "
											+ "style=\'border : 2px solid white; "
									        +"border-radius : 0.45rem; "
											+"background-color : #81BEF7; "
											+"float : right;"
											+"cursor : pointer;"
											+"color : white;\'" + ">&nbsp;초대&nbsp;</span></div>"
								)
							}
						}
					}
				})
			}else{
				$('.popInvite').css('display', 'none');
			}
		})
		
		// pop 초대창에서 사용자 초대 버튼을 눌렀을 때...
		$('.popInviteMemList').on('click', '.popInviteMemBtn', function(){
			var memId = $(this).attr("memId");
			var memName = $(this).attr("memName");
			popAddMember(memId, memName);
			popListMember(popInviteMemListArr, popInviteMemNameListArr);
		})
		
		// pop 초대창에서 초대리스트에 추가된 회원 아이디를 누르면, 초대 리스트에서 제거된다.
		$('.popInviteAddedMemList').on("click",".popSelectedMemExceptBtn", function(){
			var memId = $(this).attr('memId');
			var memName = $(this).attr('memName');
			
			popDelMember(memId, memName);
			popListMember(popInviteMemListArr, popInviteMemNameListArr);
		})
		
		// 초대할 회원 목록을 모두 작성하고 초대 버튼을 누르면, 해당 회원이 채팅방에 초대된다. (이 때 알람도 함께 !!)
		$('.popInviteBtn').click(function(){
			if (popInviteMemListArr.length == 0){
				$('.popWarning').text("초대할 회원을 선택해 주세요..");
				return;
			}else{	// 최소 1명의 초대할 회원이 존재하는 경우..
				var cgroupId = '${cgroup.cgroupId }';
				var ajaxArr = {"memList" : popInviteMemListArr, "cgroupId" : cgroupId}; 
				var memName = '${SMEMBER.memName}';
				var memId = '${SMEMBER.memId}';
				
				inviteMsg = "";
				for (i = 0 ; i < popInviteMemListArr.length ; i++){
					inviteMsg += popInviteMemNameListArr[i]; 
					inviteMsg += "[";
					inviteMsg += popInviteMemListArr[i];
					inviteMsg += "]";
					// 마지막 회원의 경우 콤마를 붙여선 안된다.
					if(i == popInviteMemListArr.length - 1){
						
					}else{
						inviteMsg += ", ";	
					}
				}
				$.ajax({
					url : "/chat/insertChatMembers",
					data : ajaxArr,
					method : "POST",
					success : function(res){
						// 초대했다는 메시지를 보내야 한다..
						$.ajax({
							url : "/chat/sendMessage",
							data : {memId : "$ANNOUNCE$",
								    memName : "$ANNOUNCE$",
								    cgroupId : cgroupId,
									chatCont : memName + "[" + memId+ "]" +"님이 " + inviteMsg
										+ "님을 초대하였습니다."
									},
							method : "POST",
							success : function(res) {
																			
							}
						})
					}
				})
			}
		})
		
	})
	// 회원 초대 관련 함수
	// addMember : 초대 리스트에 선택한 회원 저장
	// delMember : 초대 리스트에서 선택한 회원 삭제
	// listMember : 초대 리스트 출력하기
	function popAddMember(memId, memName){
	// 기존에 추가한 회원과 겹치는지 먼저 확인 ...
	var check = 0;
	for(i = 0 ; i < popInviteMemListArr.length ; i++){
		if ( popInviteMemListArr[i] == memId ){
			$('.popWarning').text("이미 추가한 회원입니다.");
			check = 1;
		}
	}
	// 검사 결과 이미 추가한 회원이 아닌경우 추가할 수 있다.
	if (check != 1){
		$('.popWarning').text('');
		popInviteMemListArr.push(memId);	
		popInviteMemNameListArr.push(memName);
	}
	popListMember(popInviteMemListArr, popInviteMemNameListArr);
	}

	function popDelMember(memId, memName){
		$('.popWarning').text('');
		popInviteMemListArr.splice(popInviteMemListArr.indexOf(memId),1); // 뒤의 개수는 몇개를 제거할 지 이다..
		popInviteMemNameListArr.splice(popInviteMemNameListArr.indexOf(memName),1)	// 이름 리스트에서 해당 회원 이름 제거
		popListMember(popInviteMemListArr, popInviteMemNameListArr);
	}

	function popListMember(popInviteMemListArr, popInviteMemNameListArr){
		$('.popInviteAddedMemList').empty();
		for (i = 0 ; i < popInviteMemListArr.length ; i++){
			$('.popInviteAddedMemList')
				.append("<div class=\'popSelectedMem jg\'>"
						+ "&nbsp;" + popInviteMemNameListArr[i] +"["+popInviteMemListArr[i].substring(0,10)+"]"
						+ "<span class=\'popSelectedMemExceptBtn jg\' "
						+ "memId=\'"+ popInviteMemListArr[i] + "\' "
						+ "memName=\'"+ popInviteMemNameListArr[i] + "\' "
						+ "style=\'margin-left : 3px;\'>&nbsp;x&nbsp;</span></div>");	
		}	
	}
	
</script>
<style>
/* 채팅방 제목 부분 */
.chatName {
	background-color: white;
	height: 50px;
	/* 수직 방향으로 가운데 정렬 */
	/* 	display: table-cell; */
	/*  vertical-align: middle;	 */
	padding-top: 15px;
	color: black;
	padding-left: 10px;
	border-bottom: 2px solid lightgrey;
}
/* 메시지 출력 부분 */
#msgArea {
	overflow-y: scroll;
	padding: 5px;
	height: 100%;
	background-color: white;
}

.chatCont {
	color: #444;
	border-radius: 0.3rem !important;
	padding: 5px;
}

.regDt {
	font-size: 0.7em;
	color: lightgrey;
}

.memId {
	color: black;
	font-size: 0.8em;
}

.mine {
	text-align: right;
	align: right;
	margin-left: 30%;
}

.yours {
	text-align: left;
	align: left;
	margin-right: 30%;
}

.oneMsg {
	margin-top: 15px;
	margin-bottom: 15px;
}

.spaan {
	background-color: #d2d6de;
	height: 100%;
	display: inline-block;
	border-radius: 0.4rem;
	text-align: left;
	padding: 2px 2px 4px 4px;
}

.spaanAnnounce {
	background-color: #F78181;
	height: 100%;
	display: inline-block;
	border-radius: 0.4rem;
	text-align: left;
	padding: 2px 2px 4px 4px;
}

.announce {
	text-align: center;
}
/* 스크롤바 스타일 */
#msgArea::-webkit-scrollbar {
	width: 16px;
}

#msgArea::-webkit-scrollbar-track {
	background-color: #f1f1f1;
}

#msgArea::-webkit-scrollbar-thumb {
	background-color: #b8babd;
}

#msgArea::-webkit-scrollbar-thumb:hover {
	background: #b8babd;
}

#msgArea::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment
	{
	width: 16px;
	height: 16px;
	background: #d2d6de;
}

.fas {
	cursor: pointer;
}

.pop {
	width: 250px;
	height: 400px;
	overflow-y: auto;
	background-color: white;
	border: 2px solid black;
	border-radius: 0.4rem;
	color: black;
	position: absolute;
	top: 13%;
	left: 48%;
	padding: 10px 10px 10px 10px;
}

.popInvite {
	width: 400px;
	height: 600px;
	background-color: white;
	border: 2px solid black;
	border-radius: 0.4rem;
	color: black;
	position: absolute;
	top: 13%;
	left: 5%;
	padding: 10px 10px 10px 10px;
}

/* 회원 초대 경고창 관련 css */
.popWarning{
	color : red; 
	font-size : 0.9em;
}
/* 회원 초대  */
.popSelectedMem{
	border-radius : 0.4rem;
	font-size : 1.3em;
	background-color : #0080FF;
	float : left;
	height : 30px;
	margin : 5px 5px 5px 5px;
	color : white;
}
.popSelectedMemExceptBtn{
	cursor: pointer;
}


/* 메시지 전송바 스타일 */
.sendMsgTextbar {
	width: 100%;
	height: 7%;
	margin-top: 5px;
	font-size: 1rem;
	font-weight: 400;
	border: 2px solid skyblue;
	border-radius: .4rem;
}
</style>

<!-- 현재 시간 표시하는 부분.. -->
<input type="text" id="clock" readonly hidden="hidden">

<!-- 채팅방 이름을 표시한다. -->
<input type="text" id="cgroupId" value="${cgroup.cgroupId }"
	hidden="hidden">

<div class="chatName">${cgroup.cgroupName }
	<!-- 뒤로 가기 버튼 -->
	<span class="returnBtn fas fa-undo icon"
		style="float: right; padding-right: 10px;"></span>
	<!-- 회원 목록 확인하기 -->
	<span class="usersBtn fas fa-users icon"
		style="float: right; padding-right: 10px;"></span>
	<!-- 회원 초대하기 버튼 -->
	<span class="userInviteBtn fas fa-user-plus icon"
		style="float: right; padding-right: 10px;"></span>
	<!-- 채팅방 나가기 버튼 -->
	<span class="exitBtn fas fa-door-open icon"
		style="float: right; padding-right: 10px;"></span>
</div>

<!-- 팝업창  -->
<div class="pop" style="display: none; z-index: 1; overflow-y: auto;">
	<label class="jg" style="padding-top: 10px;"><h4>참여중인 멤버</h4></label>
	<hr>
	<c:forEach var="i" begin="0" end="${chatMemList.size()-1 }">
		<div class="popChatMemList" memId="${chatMemList[i].memId }" style="float : left; margin-right : 10px;">
			<!-- 사용자가 지정한 이미지가 null이 아닌 경우.. -->
			<c:if test="${memInfoList[i].memFilepath ne null}">
			<img class="img-circle" alt="이미지" style="width: 25px; height:  25px;"  
				src="${memInfoList[i].memFilepath}" />
			</c:if>
			<!-- 사용자가 지정한 이미지가 null인 경우 -->
			<c:if test="${memInfoList[i].memFilepath eq null}">
			<img class="img-circle" alt="이미지" style="width: 25px; height:  25px;" 
				src="${pageContext.request.contextPath }/WEB-INF/views/userprofile/user-1.png" />
			</c:if>
		</div>
		
		<div style="height: 10%; folat: left;">${chatMemList[i].memId }
			<br>
			<span style="color: blue;">${memInfoList[i].memName }</span>
		</div>
		<br>
	</c:forEach>
</div>

<!-- 회원 초대 팝업창 -->
<div class="popInvite" style="display: none; z-index: 1;">
	<label class="jg" style="padding-top: 10px;"><h4>초대하기</h4></label>
	<hr>
	<div class="popInviteMemList" style="height : 50%; line-height: 30px; overflow-y : auto;"></div>
	<br>
	<div class="popInviteAddedMemList" 
		style="height : 20%; 
		       border : 2px solid grey;
		       overflow-y : auto; 
		       border-radius : 0.45rem;"></div>
	<br>	
	<button class="btn btn-primary popInviteBtn" type="button" 
		style="float : right;">초대하기</button>
	<span class="popWarning" style="float : right"></span>&nbsp;&nbsp;       
</div>


<!-- 채팅 메시지 목록 부분  -->
<div id="msgArea">
	<c:forEach items="${msgList }" var="msg">

		<!-- 접속한 사용자의 아이디와 일치하는 경우, 우측 배열 -->
		<c:if test="${msg.memId eq SMEMBER.memId && msg.memId ne '$ANNOUNCE$'}">
			<div class="oneMsg" chatId="${msg.chatId}">
				<div class="memId mine">${msg.memName }</div>
				<div class="chatCont mine">
					<span class="spaan">&nbsp;${msg.chatCont }&nbsp;</span>
				</div>
				<div class="regDt mine">${msg.regDt }</div>
			</div>
		</c:if>
		<!-- 접속한 사용자가 보낸 메시지가 아닌 경우, 좌측 배열 -->
		<c:if test="${msg.memId ne SMEMBER.memId && msg.memId ne '$ANNOUNCE$' }">
			<div class="oneMsg" chatId="${msg.chatId}">
				<div class="memId yours">${msg.memName }</div>
				<div class="chatCont yours">
					<span class="spaan">&nbsp;${msg.chatCont }&nbsp;</span>
				</div>
				<div class="regDt yours">${msg.regDt }</div>
			</div>
		</c:if>
		
		<!-- 초대 알림, 퇴장 알림, 개설 알림등의 공지사항 메시지인 경우 .. -->
		<c:if test="${msg.memId eq '$ANNOUNCE$' }">
			<div class="oneMsg announce" chatId="${msg.chatId }">
				<div class="spaanAnnounce">&nbsp;${msg.chatCont }&nbsp;</div>
			</div>	
		</c:if>
	</c:forEach>
</div>

<!-- 텍스트 전송 부분 .. -->
<input type="text" class="sendMsgTextbar" id='sendChatCont'
	placeholder="Message.." autocomplete="off" />
<button id="sendMsg" class="btn btn-success" type="button"
	style="width: 100%;">Send</button>
$$$$$$$
