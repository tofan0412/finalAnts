<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
	<c:forEach items="${msgList }" var="msg">
		<input type="text" value="${msg.cgroupId }" hidden="hidden">
		
		<a href="#" class="msgBox" >
		<c:if test="${SMEMBER.memId == msg.memId}"></c:if>
		<li class="jg">${chat.cgroupName }&nbsp;
		</a>
		<span style="font-size : 0.8em; color : ">${chatList.size() }</span>
		</li>
	</c:forEach>
	<c:if test="${msgList.size() < 1 }">
		<li class="jg">아직까지 나눈 대화가 없습니다. 새로운 대화를 나눠보세요 !</li>
	</c:if>
</ul>
$$$$$$$
