<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<style>
.conB {
	padding-top: 100px;
	padding-bottom: 150px;
/* 	background-color: rgba(242, 242, 242, 1); */
}

.conB_title {
	font-size: 50px;
	text-align: center;
	margin-bottom: 70px;
}

.conB_container {
 	display: flex; 
	justify-content: center;
}

.conB_small_container {
	margin-left: 70px;
	margin-right: 70px;
	transition: 0.1s linear;
}

.conB_small_container:hover {
	transform: scale(1.2);
}

.conB_small_container .conB_icon {
	text-align: center;
	margin-bottom: 30px;
}

.conB_small_container .conB_content {
	text-align: center;
}

.conB_small_container .icon {
	display: inline-block;
	font-size: 40px;
	width: 100px;
	line-height: 100px;
	border-radius: 50%;
	background-color: rgba(77, 165, 124, 1);
	color: rgba(255, 255, 255, 1);
}

.conB_small_container h3 {
	font-size: 25px;
	margin-bottom: 10px;
}

.conB_small_container p {
	font-size: 15px;
}
</style>
<div class="main_container jg">
	<div class="conB" style="float : bottom; ">
		<div class="conB_title">
			<h1>관리자 주요기능</h1>
		</div>
		<div class="conB_container">
			<a href="${pageContext.request.contextPath}/admin/noticelist" class="nav-link" style="text-decoration: none;color:#000000;">
				<div class="conB_small_container">
					
					<div class="conB_icon">
						<i class="fas fa-clipboard-list icon"></i>
					</div>
					<div class="conB_content">
						<h3>공지사항</h3>
						<p>사용자에게 필요한 정보를 <br>작성 할 수 있습니다.</p>
					</div>
					
				</div>
			</a>
			
			<a href="${pageContext.request.contextPath}/admin/memberlist" class="nav-link" style="text-decoration: none;color:#000000;">
				<div class="conB_small_container">
					<div class="conB_icon">
						<i class="fas fa-address-book icon"></i>
					</div>
					<div class="conB_content">
						<h3>회원 리스트</h3>
						<p>멤버별 권한설정, 강퇴등 팀관리에 꼭 필요한 기능을 통해<br>효율적인 협업 환경을 구축할 수 있습니다.</p>
					</div>
				</div>
			</a>
			
			<a href="${pageContext.request.contextPath}/admin/ipMain" class="nav-link" style="text-decoration: none;color:#000000;">
				<div class="conB_small_container">
					<div class="conB_icon">
						<i class="fas fa-unlock-alt icon"></i>
					</div>
					<div class="conB_content">
						<h3>보안기능</h3>
						<p>자료보안?<br> Ants 가 책임집니다.</p>
					</div>
				</div>
			</a>
			
			<a href="${pageContext.request.contextPath}/admin/projectlist" class="nav-link"  style="text-decoration: none;color:#000000;">
				<div class="conB_small_container">
					<div class="conB_icon">
						<i class="fas fa-tasks icon"></i>
					</div>
					<div class="conB_content">
						<h3>프로젝트 관리</h3>
						<p>불필요한 프로젝트를 <br> 삭제해 드립니다.</p>
					</div>
				</div>
			</a>
			
		</div>
	</div>
</div>

