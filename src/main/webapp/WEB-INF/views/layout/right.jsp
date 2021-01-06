<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<style>
.chatTitle{
	color : black;
	padding-top : 15px;
	padding-left : 5px;
	font-size : 1.2em; 
	background-color : white;
	border-bottom : 1px solid #d2d6de;
	box-shadow : 5px 5px lightgrey;
	margin-bottom : 10px;
	margin-top : 30px;
	height : 50px;
	text-align : center;
	border-radius: 0.35rem;
}
.chatList{
	padding-top : 10px;
	padding-left : 5px;
	background-color : white;
	height : 75%;
	box-shadow : 5px 5px lightgrey;
	border-radius: 0.35rem;
	/* x위치 y위치 블러정도 그림자크기 색 */
}
.mkNewChat{
	margin-top : 20px;
	height : 40px;
	border-radius : .25rem;
	text-align : center;
	background-color : skyblue;
	color : black;
	font-size : 1.2em;
	padding-top : 7px;
	
	/* 마우스 모양을 변경해준다. */ 
	cursor: pointer;
}
</style>
<script>
	// 해당 프로젝트에 존재하는 모든 채팅방 목록 불러오기.
	// 채팅방 리스트를 보고 있을 때만, 해당 리스트가 갱신되어야 한다.
	function readChatList(){
		var memId = '${SMEMBER.memId}';	
		var reqId = '${projectId}';
		$.ajax({
			url : "/chat/readChatList?memId="+memId+"&reqId="+reqId,
			method : "GET",
			success : function(res){
				var html = res.split("$$$$$$$");
				$('.chatList').html(html);
			}
		})
	}
	
	// listNow의 값이 yes인 경우, setTimeout 통해 채팅 목록을 지속적으로 갱신한다.
	function listNow(){
		if ($('#listNow').val() == 'yes'){
			listTimer = setTimeout('readChatList()', 1000);
		}
		// listNow의 값이 yes가 아닌 경우, 반복 함수 종료
		else{
			window.clearTimeout(listTimer);	
		}
		setTimeout('listNow()', 5000);
	}
	
$(function(){
	reqId = "${projectId}";
	if (typeof reqId == ""){
	// 만약 reqId가 존재하지 않는경우에는 실행해선 안된다.
		$('.chatList').html("아직 프로젝트를 선택하지 않았습니다.");	
	}else{
		// PM이 아닌 경우에만, 채팅방 리스트를 불러온다.
		if ('${SMEMBER.memType}' != 'PM'){
			listNow();	
		}else{
			$('.chatList').html("안녕하세요, PM님! :)");
		}
	}
	
	// 프로젝트에 참여하고 있는 회원 목록 불러오기
	$('.mkNewChat').on('click',function(){
		$('#listNow').val("no");
		
		$(".chatList").empty();
		$('.chatTitle').css('display', 'none');
		$('.mkNewChat').css('display', 'none');
		
		var projectId = '${projectId}';
		$.ajax({
			url : "/chat/readChatMembers",
			data : {projectId : projectId}, 
			method : "POST",
			success : function(res){
				var html = res.split("$$$$$$$");
				$('.chatList').html(html);
			}
		})
	})
	
	// 채팅방 이름 클릭 시 해당 채팅방으로 이동.
	$(".chatList").on('click', '.cgroupName', function(){
		// 채팅방 개설 버튼과 타이틀 div를 보이지 않게 설정한다. 
		$('.chatTitle').css('display', 'none');
		$('.mkNewChat').css('display', 'none');
		
		var cgroupId = $(this).attr("cgroupId");
		
		// 채팅방 PK를 session에 저장해야 한다. 
		$.ajax({
			url : "/chat/changeCgroupSession",
			data : {cgroupId : cgroupId},
			method : "POST",
			success : function(res){
				console.log("현재 채팅방 번호 : "+cgroupId);
			}
		})		
		
		$(".chatList").empty();
		$.ajax({
			url : "/chat/readMessages",
			data : {cgroupId : cgroupId, memId : '${SMEMBER.memId}'},
			method : "POST", 
			success : function(res){
				$('#listNow').val("no");
				
				var html = res.split("$$$$$$$");
				$('.chatList').html(html);
			}
		})
	})
	
	
	// 채팅방 생성 버튼을 눌렀을 때
	$(".chatList").on('click','.NewBtn', function(){
		var chk = 0;
				
		$('.warning').text("");
		if (MemListArr.length == 0){
			$('.warning').text("최소 초대 인원은 1명입니다.");
			chk++;
			return;
		}
		if ($('#cgroupName').val() == ""){
			$('.warning').text("그룹 채팅방 이름을 설정해 주세요.");
			chk++;
		}
		
		if (chk == 0){
			// 먼저, 해당 projectId와 이름을 갖는, chatGroup을 하나 입력한다.
			var projectId = '${projectId}';
			var cgroupName = $('#cgroupName').val();
			// 데이터를 넣기 전에, 채팅방 만드는 사람(나)를 추가한다.
			MemListArr.push( "${SMEMBER.memName}" +":[" + "${SMEMBER.memId}" + "]");
			
			$.ajax({
				url : "/chat/insertChatGroup",
				data : {reqId : projectId, cgroupName : cgroupName},
				method : "POST",
				success : function(res){
					var ajaxArr = {"memList" : MemListArr, "cgroupId" : res, "regDt" : $('#clock').val()}; 
					// 이후 해당 채팅방을 사용할 유저를 CHATMEMBER 테이블에 등록한다. 
					$.ajax({
						url : "/chat/insertChatMembers",
						data 			: ajaxArr,
						method 			: "POST",
						success 		: function(res){
							arr = res.split("$$");
							var cgroupId = arr[0];
							var cnt = arr[1];
							alert("채팅방 개설 완료 ! " + cnt +"명을 초대하는 데 성공했습니다..");
							// 채팅방과, 채팅방 멤버를 DB저장 완료하였다..
							// WebSocket 설정 위해, 새롭게 만든 채팅방 번호를 세선에 저장한다.
							$.ajax({
								url : "/chat/changeCgroupSession",
								data : {cgroupId : cgroupId},
								method : "POST",
								success : function(res){
									console.log("현재 채팅방 번호 : "+cgroupId);
									
									$('.chatList').empty();
									memName = '${SMEMBER.memName}';
									memId = '${SMEMBER.memId}';
									
									inviteMsg = "";
									for (i = 0; i < MemListArr.length; i++) {
										inviteMsg += MemListArr[i].replace(":", "");
										// 마지막 회원의 경우 콤마를 붙여선 안된다.
										if (i == MemListArr.length - 1) {/* 아무것도 하지 않는다...*/} 
										else {
											inviteMsg += ", ";
										}
									}
									
									chatCont = "공지:" + memName + "[" + memId + "]" + "님이 "
										+ inviteMsg + "님을 초대하였습니다.";
									// 채팅방 생성, 인원 초대까지 끝났으면 채팅방을 개설하였다는 메시지를 DB에 저장한다.
									$.ajax({
										url : "/chat/sendMessage",
										data : {memId : "*ANNOUNCE*",
											    memName : "*ANNOUNCE*",
											    cgroupId : cgroupId,
											    regDt : $('#clock').val(),
											    chatCont : chatCont
											    },
										method : "POST",
										success : function(res) {
											$('.chatList').empty();
											$.ajax({
												url : "/chat/readMessages",
												data : {cgroupId : cgroupId, memId : '${SMEMBER.memId}'},
												method : "POST", 
												success : function(res){
													var html = res.split("$$$$$$$");
													$('.chatList').html(html);
												}
											})
										}
									})
								}
							})
						}
					})
				}
			})
		}
	})
	
	// 사용자가 뒤로 가기 버튼을 누르면, 숨겨뒀던 헤더 div와 채팅 생성버튼을 다시 보이게 하고, 다시 채팅 목록을 불러온다.
	$('.chatList').on('click', '.returnBtn', function(){
		$('.chatTitle').css('display', 'block');
		$('.mkNewChat').css('display', 'block');
		
		$('.chatList').empty();
		
		$('#listNow').val("yes");
		// 필요한가??
		readChatList();
	})
	
	// 팝업창 관련 스크립트 - 회원 목록 확인 팝업창
	$('.chatList').on('click', '.usersBtn',function(){
		if ($('.pop').css('display') == 'none'){
			$('.pop').css('display', 'block');	
		}else{
			$('.pop').css('display', 'none');
		}
	})
	
	// 사용자가 채팅방 나가기 버튼을 클릭할 때 ..
	$('.chatList').on('click', '.exitBtn', function(){
		var factor = confirm("채팅방을 나가시겠습니까?");
		if(factor){
			// 채팅방에서 해당 회원을 나가게 한다.
			var memId = '${SMEMBER.memId}';
			var memName = '${SMEMBER.memName}';
			var cgroupId = $('#cgroupId').val();
			
			chatCont = "공지:" + memName + "[" + memId+ "]" +"님이 대화방을 나갔습니다.";
			$.ajax({
				url : "/chat/exitChat",
				data : {memId : memId, cgroupId : cgroupId},
				success : function(res){
					if (res > 0){
						// 나간 채팅방에 퇴장하였다는 메시지를 DB에 저장한다.
						$.ajax({
							url : "/chat/sendMessage",
							data : {memId : "*ANNOUNCE*",
								    memName : "*ANNOUNCE*",
								    cgroupId : cgroupId,
								    regDt : $('#clock').val(),
									chatCont : chatCont},
							method : "POST",
							success : function(res) {
								sendAnnounceMessage(chatCont);					
							}
						})
						$('.chatTitle').css('display', 'block');
						$('.mkNewChat').css('display', 'block');
						
						$('.chatList').empty();
						
						$('#listNow').val("yes");
						readChatList();
					}
				}
			})
		}
	})

});
</script>
<aside class="control-sidebar control-sidebar-white" 
		style="margin-top : 18px;
		width : 450px;
		margin-right : 18px;">
	<!-- Control sidebar content goes here -->
	<div class="p-3" 
		style="background-color : white;
		height : 700px;
		border : 5px solid skyblue;
	    border-radius : 0.8rem;
	   	border-bottom-left-radius : 0.8rem;
		">
		<h5 class="jg" style="background-color : ">
			<i class="far fa-comments">&nbsp;</i>채팅
			<input id="listNow" type="text" hidden="hidden" readonly="readonly" value="yes">
		</h5>
		<!--  Header -->
		<div class="chatTitle jg">프로젝트 채팅 목록</div>
		
		<!-- 채팅목록이 출력된다. -->
		<div class="chatList jg">
			<c:if test="${projectId eq null && SMEMBER.memType ne 'PM'}">
				<span class="jg">프로젝트를 먼저 선택해 주세요..</span>
			</c:if>
			<c:if test="${projectId eq null && SMEMBER.memType eq 'PM'}">
				<span class="jg">안녕하세요, PM님! :)</span>
			</c:if>
		</div>
		
		<!-- 선택한 프로젝트가 존재하는 경우에만 채팅방 개설하기 버튼을 표시한다. -->
		<c:if test="${projectId ne null && SMEMBER.memType ne 'PM'}">
			<div class="mkNewChat jg">새로운 채팅방 만들기</div>
		</c:if>
	</div>
</aside>