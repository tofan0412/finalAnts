<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 요구사항정의서 번호가 null이 아닌 경우에만 채팅방 목록을 출력한다. -->
<c:if test="${projectId ne null }">
	<c:if test="${chatList.size() > 0 }">
		<div style="height : 100%; overflow-y : auto;">
			<c:forEach var="i" begin="0" end="${chatList.size()-1 }" >
				<input type="text" value="${chatList[i].cgroupId }" hidden="hidden">
					<div class="jg cgroupName" cgroupId="${chatList[i].cgroupId }"
						style="height: 40px; padding: 10px 10px 10px; color: black;">
						<a href="#" class="link" style="color: black;">
							${chatList[i].cgroupName }&nbsp;&nbsp;&nbsp;
						</a>
						<div class="jg" style="color : grey; font-size : 0.9em; float : right;">
						${eachChatMemList[i].size() }명 참여중
						</div>
					</div>
			</c:forEach>
		</div>
	</c:if>

	<!-- 요구사항 정의서가 null은 아니지만, 열린 채팅방이 없는 경우 .. -->
	<c:if test="${chatList.size() < 1 }">
		<div style="text-align : center; padding-top : 200px;">
			<span class="jg">현재 참여중인<br> 채팅이 없습니다.</span>
		</div>
		<br>
		<br>
		<br>
	</c:if>
</c:if>
<c:if test="${projectId eq null }">
	<div style="text-align : center; padding-top : 200px;">
		<span class="jg">프로젝트를 <br> 선택해 주세요.</span>
	</div>
</c:if>
$$$$$$$
