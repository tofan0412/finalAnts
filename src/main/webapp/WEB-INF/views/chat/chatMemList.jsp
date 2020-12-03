<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.warning{
	color : red; 
	font-size : 0.7em;
}
.singleMem{
	color : black;
}
.listHeader{
	text-align : center;
	color : black;
	padding-top : 5px;
	border-bottom : 2px solid #d2d6de; 
	height : 30px;
}
</style>
<script>
$(function(){
	MemListArr = [];
	var cgroupId = 0;	// 채팅방을 개설한 후, 해당 채팅방 번호를 갖는 회원 목록을 DB에 저장하기 위해 !
	
	// 나 자신은 채팅방에 반드시 포함되어야 한다.
	MemListArr.push('${SMEMBER.memId}');
	
	// 하단의 목록에서 회원 아이디를 클릭하면 추가된다.
	$(".chatMemList").on('click','.singleMem',function(){
		var memId = $(this).attr('memId');
		
		if (memId == '${SMEMBER.memId}'){
			
		}else{
			addMember(memId);	
		}
		
	})
	// 추가되어 있는 회원 아이디를 클릭하면 제거된다.
	$(".MemList").on('click','.addedMemId',function(){
		var memId = $(this).attr('memId');
		
		if (memId == '${SMEMBER.memId}'){
			$('.warning').text("당사자는 제외할 수 없습니다.");
		}else{
			delMember(memId);	
		}
	})
	
	// 채팅방 개설 버튼을 누르면 채팅방이 개설된다.
	$(".NewBtn").on('click', function(){
		$('.warning').text("");
		if (MemListArr.length == 0 || MemListArr.length == 1){
			$('.warning').text("채팅방 최소 인원은 2명입니다.");	
		}
		
		// 동일한 이름을 갖는 채팅방이 존재하는지 확인해야 한다.
		
		else{
			// 먼저, 해당 projectId와 이름을 갖는, chatGroup을 하나 입력한다.
			var projectId = '${projectId}';
			var cgroupName = $('#cgroupName').val();
			
			$.ajax({
				url : "/chat/insertChatGroup",
				data : {reqId : projectId, cgroupName : cgroupName},
				method : "POST",
				success : function(res){
					var ajaxArr = {"memList" : MemListArr, "cgroupId" : res}; 
					// 이후 해당 채팅방을 사용할 유저를 CHATMEMBER 테이블에 등록한다. 
					$.ajax({
						url : "/chat/insertChatMembers",
						data 			: ajaxArr,
						method 			: "POST",
						success 		: function(res){
							alert("채팅방을 개설하였습니다.");
						}
					})
				}
			})
		}
	})
	
	function addMember(memId){
		// 기존에 추가한 회원과 겹치는지 먼저 확인 ...
		var check = 0;
		for(i = 0 ; i < MemListArr.length ; i++){
			if ( MemListArr[i] == memId ){
				$('.warning').text("이미 추가한 회원입니다.");
				check = 1;
			}
		}
		
		// 검사 결과 이미 추가한 회원이 아닌경우 추가할 수 있다.
		if (check != 1){
			$('.warning').text('');
			MemListArr.push(memId);		
		}
		listMember(MemListArr);
	}
	
	function delMember(memId){
		$('.warning').text('');
		MemListArr.splice(MemListArr.indexOf(memId),1); // 뒤의 개수는 몇개를 제거할 지 이다..
		listMember(MemListArr);
	}
	
	function listMember(MemListArr){
		$('.MemList').empty();
		for (i = 0 ; i < MemListArr.length ; i++){
			$('.MemList').append("<div class=\'singleMem addedMemId\' memId='"+MemListArr[i]+"'>"+MemListArr[i]+"</div>");	
		}	
// 		alert("현재 회원 상태 : "+MemListArr);
	}
	
})

</script>
<!-- 바깥은 chatList라는 DIV가 여전히 감싸고 있다. -->
<div class="listHeader">초대할 회원&nbsp;<br><span class="warning"></span></div>

<div class="chatList">
	<div class="MemList" style="padding-top : 10px; padding-left : 10px; height : 100px; border-bottom : 1px solid #d2d6de;"></div>
	<div class="chatMemList">
		<div class="listHeader">회원 목록</div>
		<c:forEach items="${chatMemList }" var="member">
			<!-- 자기 자신을 초대할 수는 없으므로 출력 목록에서 제외한다.  -->
			<c:if test="${member.memId eq SMEMBER.memId}">
			</c:if>
					
			<c:if test="${member.memId ne SMEMBER.memId}">
			<div class="singleMem" memId="${member.memId }">${member.memId }</div><br>
			</c:if>
		</c:forEach>
		
		<div style="text-align : center;">
			<input type="text" id="cgroupName" class="form-control" style="width : 100%;" placeholder="채팅방 이름을 입력하세요 ..">
			<br>
			<input type="button" class="btn btn-success returnBtn" value="돌아가기" style="float : left;">
			<input type="button" class="btn btn-success NewBtn" value="개설하기">
		</div>
	</div>
</div>

$$$$$$$