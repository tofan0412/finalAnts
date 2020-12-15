<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		// 메뉴를 선택하면 배경색이 변한다. 
		$('.selectable').click(function(){
// 			alert($(this).text());
			$('.selectable').parent().removeClass("active");
			$(this).parent().addClass("active");
		})
		
		
		
	})
</script>
<style>
.top{
	border: 1px solid lightgray; 
	font-size: 0.8em; 
	background-color:white; 
	min-height:500px;
	height:550px; 
	width:48%;
	float:left;  
	overflow: auto;
	 
	padding-top:2%;
	padding-bottom:2%;
	padding-left:4%;
	padding-right:4%;
}
th{
	width:300px; 
} 
.bottom{
	border: 1px solid lightgray; 
	width:48%; 
	height:550px; 
	float:left; 
	background-color:white;
	
	padding-top:2%;
	padding-bottom:2%;
	padding-left:4%;
	padding-right:4%;
} 
.noticeTable {
	width: 98%;
	border-collapse: collapse;
}
</style>
</head> 

<body>

<div>
	<div class="top" style="margin-left:1.5%;"><h4>프로젝트 현황</h4>
	(이름 클릭하면 해당 프로젝트 정보 가져오게 할것임..예정.. <br>
	 프로젝트는 들어가기 버튼으로..)
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
				<!-- memType이 MEM일때  -->
				 <c:if test="${empty noticelist}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active" style="background-color:#6495ED;">
				        	<i class="nav-icon fas fa-poll-h"></i> 
							<p>작성된 공지사항<i class="fas fa-angle-left right"></i></p>
						</a>
					    <ul class="nav nav-treeview" style="display: none;">
							<table class="table" style="margin-left:3%">
								<tr "data-privid="${notice.adminId}">
									<th >No.</th>
									<th >프로젝트명</th>
									<th>상태(일단 프로젝트번호)</th>
									<th>생성일</th>
								</tr> 
								<tbody > 
									<c:forEach items="${noticelist}" var="notice" varStatus="status" >
									    <tr>
									    <td style="width: 150px; padding-left: 50px;"><c:out
											value="${  ((noticeVo.pageIndex-1) * noticeVo.pageUnit + (status.index+1))}" />.</td>
											<td ><a
												href="${pageContext.request.contextPath}/admin/eachnoticeDetail?noticeId=${notice.noticeId}">
													${notice.noticeTitle }</a></td>
											<td>${notice.adminId}</td>
											<td>${notice.regDt}</td>
											<td style="text-align: center;">
										</tr>
									</c:forEach> 
								</tbody>
							</table>
						</ul>
					</li>
				 </c:if>
				 
				 
				 
			</ul>
		</nav>
	</div>
	
	
	
	
	
	<!-- 위 오른쪽 공지사항 -->
	<div class="top" style="margin-left:1%;"><h4>공지사항1</h4><br>
	</div>
</div>

</body>
</html>