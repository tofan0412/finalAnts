<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.adminMsgList{
	margin : 10px 10px 10px 10px;
	padding : 10px 10px 10px 10px;	
}
#msgTable{
	line-height : 25px; 
}
#msgTable th{
	border-bottom: 2px solid lightgrey;  
}
</style>
<script>
$(function(){
	$('.pmAcceptBtn').click(function(){
		confirm("해당 회원의 권한을 PM으로 변경하시겠습니까?");
		if(confirm){
			
		}
	})
})
</script>

<div class="jg card adminMsgList" style="height : 500px;">
	<h1 class="nav-icon fas fa-envelope" style="margin-left : 10px; margin-top : 10px;">&nbsp;쪽지 관리</h1> <br> <br>
	<table id="msgTable" class="table" style="text-align: center;">
		<tr>
			<th>No.</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>상태</th>
			<th>유형</th>
			<th>&nbsp;&nbsp;</th>
		</tr>
		<c:forEach items="${msgList }" var="msg">
			<tr>	
				<td>1</td>
				<td>${msg.msgTitle }</td>
				<td>${msg.msgWriter }</td>
				<td>${msg.regDt }</td>
				<td>
					<c:if test="${msg.msgStatus eq 'WAIT' }">
						대기
					</c:if>
					<c:if test="${msg.msgStatus eq 'ACCEPT' }">
						처리완료
					</c:if>
				</td>
				<td>
					<c:if test="${msg.msgType eq 'PM'}">
						권한 요청
					</c:if>
					<c:if test="${msg.msgType eq 'ISSUE' }">
						일반 문의
					</c:if>
				</td>
				<td>
					<c:if test="${msg.msgStatus eq 'WAIT' && msg.msgType eq 'PM' }">
						<button type="button" class="btn btn-primary pmAcceptBtn">처리</button>
					</c:if>
					<c:if test="${msg.msgStatus eq 'WAIT' && msg.msgType eq 'ISSUE' }">
						<button type="button" class="btn btn-primary">답변</button>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
<span class="jg" style="float : right; margin-right : 10px;">*권한 요청을 처리하는 경우, 해당 회원의 권한이 즉시 PM으로 변경됩니다.</span>