<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<style>
.chatTitle{
	color : black;
	padding-top : 10px;
	padding-left : 5px;
	font-size : 1.2em; 
	background-color : white;
	border-bottom : 1px solid #d2d6de;
	box-shadow : 5px 5px #20C997;
	height : 50px;
	text-align : center;
}
.chatList{
	background-color : white;
	height : 300px;
	box-shadow : 5px 5px #20C997;
	/* x위치 y위치 블러정도 그림자크기 색 */
}
.mkNewChat{
	margin-top : 20px;
	height : 40px;
	border-radius : .25rem;
	text-align : center;
	background-color : #20C997;
	color : black;
	font-size : 1.2em;
	padding-top : 7px;
	
	/* 마우스 모양을 변경해준다. */ 
	cursor: pointer;
}
</style>
<script>
$(function(){
	readChatList();
	
	// 프로젝트에 참여하고 있는 회원 목록 불러오기
	$('.mkNewChat').on('click',function(){
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
	
	// 해당 프로젝트에 존재하는 모든 채팅방 목록 불러오기.
	function readChatList(){
		var memId = '${SMEMBER.memId}';	
		$.ajax({
			url : "/chat/readChatList?memId="+memId,
			method : "GET",
			success : function(res){
				var html = res.split("$$$$$$$");
				$('.chatList').html(html);
			}
		});
	};
	
	// 채팅방 이름 클릭 시 해당 채팅방으로 이동.
	$(".chatList").on('click', '.cgroupName', function(){
		// 채팅방 개설 버튼과 타이틀 div를 보이지 않게 설정한다. 
		$('.chatTitle').css('display', 'none');
		$('.mkNewChat').css('display', 'none');
		
		$(".chatList").css('color', '#A9E2F3');
		var cgroupId = $(this).attr("cgroupId");

// 		alert(cgroupId);

		$(".chatList").empty();
		$(".chatList").css('font-color', 'black');
		$.ajax({
			url : "/chat/readMessages",
			data : {cgroupId : cgroupId},
			method : "POST", 
			success : function(res){
				var html = res.split("$$$$$$$");
				$('.chatList').html(html);
			}
		})
	})
	
	// 사용자가 뒤로 가기 버튼을 누르면, 숨겨뒀던 헤더 div와 채팅 생성버튼을 다시 보이게 하고, 다시 채팅 목록을 불러온다.
	$('.chatList').on('click', '.returnBtn', function(){
		$('.chatTitle').css('display', 'block');
		$('.mkNewChat').css('display', 'block');
		
		$('.chatList').empty();
		readChatList();
	})
	
	
	// 팝업창 관련 스크립트
	$('.chatList').on('click', '.usersBtn',function(){
		$('.pop').css('display', 'block');
	})
	// 팝업창 스크립트
	$('.chatList').on('click', '.popCloseBtn',function(){
		$('.pop').css('display', 'none');
	});	
	
	
});
</script>
<aside class="control-sidebar control-sidebar-dark">
	<!-- Control sidebar content goes here -->
	<div class="p-3" style="margin-top: 10%;">
		<h5 class="jg">
			<i class="far fa-comments">&nbsp;</i>채팅
		</h5>
		
		<!--  Header -->
		<div class="chatTitle jg">프로젝트 채팅 목록</div>
		
		<!-- 채팅목록이 출력된다. -->
		<div class="chatList jg"></div>
		
		<!-- 선택한 프로젝트가 존재하는 경우에만 채팅방 개설하기 버튼을 표시한다. -->
		<c:if test="${projectId ne null }">
			<div class="mkNewChat jg">새로운 채팅방 만들기</div>
		</c:if>
		
	</div>
</aside>