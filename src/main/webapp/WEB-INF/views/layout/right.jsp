<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
$(function(){
	
	readChatList();
	
	// 프로젝트에 참여하고 있는 회원 목록 불러오기
	$(".chatList").on('click', '#mkNewChat',function(){
		$(".chatList").empty();
		var reqId = '${reqId}';
		$.ajax({
			url : "/chat/readChatMembers",
			data : {reqId : reqId}, 
			method : "POST",
			success : function(res){
				var html = res.split("$$$$$$$");
				$('.chatList').html(html);
			}
		})
	})
	
	// 해당 프로젝트에 존재하는 모든 채팅방 목록 불러오기.
	function readChatList(){
		var reqId = '${reqId}';	
		$.ajax({
			url : "/chat/readChatList?reqId="+reqId,
			method : "GET",
			success : function(res){
				var html = res.split("$$$$$$$");
				$('.chatList').html(html);
			}
		});
	};
	
	// 채팅방 이름 클릭 시 해당 채팅방으로 이동.c
	$(".chatList").on('click', 'li', function(){
		$(".chatList").css('color', '#A9E2F3');
		var cgroupId = $(this).attr("cgroupId");
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
	
	
});
</script>
<aside class="control-sidebar control-sidebar-dark">
	<!-- Control sidebar content goes here -->
	<div class="p-3" style="margin-top: 10%;">
		<h5 class="jg">
			<i class="far fa-comments">&nbsp;</i>채팅
		</h5>
		<div class="chatList jg">
		
		</div>
	</div>
</aside>