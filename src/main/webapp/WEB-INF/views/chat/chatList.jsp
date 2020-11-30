<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
	<c:forEach items="${chatList }" var="chat">
		<input type="text" value="${chat.cgroupId }" hidden="hidden">
		
		<a href="#" class="link" >
		<li class="jg" cgroupId="${chat.cgroupId }">${chat.cgroupName }&nbsp;
		</a>
		<span style="font-size : 0.8em; color : ">${chatList.size() }</span>
		</li>
	</c:forEach>
	<c:if test="${chatList.size() < 1 }">
		<li class="jg">현재 참여중인 채팅방이 없습니다.</li>
	</c:if>
</ul>
$$$$$$$
