<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
$(function(){
	readChatList();
	
	$(".chatList").on('click', 'li', function(){
		var cgroupId = $(this).attr("cgroupId");
		$(".chatList").empty();
		$.ajax({
			url : "/chat/readMessages",
			data : {cgroupId : cgroupId},
			method : "POST", 
			success : function(res){
				
				
			}
			
			
		})
		
	})
	
	
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
});
</script>
<aside class="control-sidebar control-sidebar-dark">
	<!-- Control sidebar content goes here -->
	<div class="p-3" style="margin-top: 10%;">
		<h5 class="jg">
			<i class="far fa-comments">&nbsp;</i>채팅
		</h5>
		<div class="chatList">
		
		</div>
	</div>
</aside>