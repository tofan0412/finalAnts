<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
	<c:forEach items="${chatList }" var="chat">
		<input type="text" value="${chat.cgroupId }" hidden="hidden">
		
		<a href="#" class="link" >
		<li class="jg" cgroupId="${chat.cgroupId }">
		${chat.cgroupName }&nbsp;
		</li>
		</a>
		<span style="font-size : 0.8em; color : ">${chatList.size() }</span>
	</c:forEach>
	<c:if test="${chatList.size() < 1 }">
		<span class="jg">현재 참여중인<br> 채팅이 없습니다.</span><br><br><br>
		
		<!-- 프로젝트를 선택했을 때만, 채팅방을 개설할 수 있다. -->
		<c:if test="${reqId ne null }">
			<div id="mkNewChat"><a href="#" style="color : #2E9AFE; ">새로운 채팅방 만들기</a></div>
		</c:if>
	</c:if>
</ul>
$$$$$$$
