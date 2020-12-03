<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<ul>
	<!-- 요구사항정의서 번호가 null이 아닌 경우에만 채팅방 목록을 출력한다. -->
	<c:if test="${projectId ne null }">
		<c:forEach items="${chatList }" var="chat">
			<input type="text" value="${chat.cgroupId }" hidden="hidden">

			<a href="#" class="link">
				<li class="jg cgroupName" cgroupId="${chat.cgroupId }">
					${chat.cgroupName }&nbsp;&nbsp;&nbsp;(${chatList.size() })</li>
			</a>
		</c:forEach>

		<!-- 요구사항 정의서가 null은 아니지만, 열린 채팅방이 없는 경우 .. -->
		<c:if test="${chatList.size() < 1 }">
			<span class="jg">현재 참여중인<br> 채팅이 없습니다.
			</span>
			<br>
			<br>
			<br>
		</c:if>
		<div id="mkNewChat">
			<a href="#" style="color: #2E9AFE;">새로운 채팅방 만들기</a>
		</div>
	</c:if>
</ul>
$$$$$$$
