<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#chatMemListHeader{
	color : white;
	font-size : 1.1em;
}
</style>
<script>
$(function(){
	$('.chatMemList').on('click','.singleMem',function(){
		var memId = $(this).attr("memId");
// 		alert(memId);
		
		// 기존에 초대할 회원 목록에 존재하는지 확인해야 한다. 
		
		$('.addMemList').html("<li>"+memId+"</li>");

	})
	
	$(".addMemList").on("click", "li", function(){
				
	})
	
})

</script>

<div class="chatMemList">초대할 회원:<br>
	
	<ul class="addMemList">
		
	</ul>
	
</div>
<br>
<div class="chatMemList">
	<div id="chatMemListHeader">회원목록</div>
	<c:forEach items="${chatMemList }" var="member">
		
		<!-- 자기 자신을 초대할 수는 없으므로 출력 목록에서 제외한다.  -->
		<c:if test="${member.memId eq SMEMBER.memId}">
		</c:if>
				
		<c:if test="${member.memId ne SMEMBER.memId}">
		<div class="singleMem" memId="${member.memId }">${member.memId }</div><br>
		</c:if>
	</c:forEach>
</div>

$$$$$$$