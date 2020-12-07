<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 요구사항정의서 번호가 null이 아닌 경우에만 채팅방 목록을 출력한다. -->
<c:if test="${projectId ne null }">
	<c:forEach items="${chatList }" var="chat">
		<input type="text" value="${chat.cgroupId }" hidden="hidden">
		<div class="jg cgroupName" cgroupId="${chat.cgroupId }"
			style="height: 40px; padding: 10px 10px 10px; color: black;">
			<a href="#" class="link" style="color: black;">
				${chat.cgroupName }&nbsp;&nbsp;&nbsp;(${chatList.size() })
			</a>
		</div>
	</c:forEach>

	<!-- 요구사항 정의서가 null은 아니지만, 열린 채팅방이 없는 경우 .. -->
	<c:if test="${chatList.size() < 1 }">
		<div style="text-align : center; padding-top : 80px;">
			<span class="jg">현재 참여중인<br> 채팅이 없습니다.</span>
		</div>
		<br>
		<br>
		<br>
	</c:if>
</c:if>
$$$$$$$
