<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.ipMain{
	margin : 10px 10px 10px 10px;
	padding : 10px 10px 10px 10px;
}
.recentIpList{
	text-align : center;
	width : 95%;
	margin : 0 auto;
}
.recentIpList td{
	padding-left : 15px;
	line-height: 50px;
}
.recentIpList th{
	background-color : lightgrey;
}

</style>
<script>
$(function(){
	readRecentIpList();

	$(".getIpList").click(function(){
		$(location).attr("href", "/admin/getIpList");
	})
})

function readRecentIpList(){
	$.ajax({
		url : "/admin/loginLogList", 
		method : "POST",
		success : function(res){
			for(var i = 0 ; i < 10; i++){
				$('.recentIpList')
				  .append("<tr><td>"+res[i].memId + "</td>" 
						+ "<td>" + res[i].ipAddr + "</td>" 
						+ "<td>" + "대한민국" + "</td>"
						+ "<td>"+res[i].iphistDate+"</td></tr>");
			}
		}
	})
}
</script>
<div class="card ipMain" >
	<!-- contentMenuBar -->
	<%@ include file="/WEB-INF/views/admin/ipContentMenu.jsp" %>
	<!-- /contentMenuBar -->
	
	<div style="float : left; width : 100%;">
		<!-- right : 최근 접속 IP 리스트  -->
		<h5 class="jg" style="display: inline-block;padding: 1%; padding-left: 3%; ">최근 접속 IP 리스트 (최근 10개 항목)</h5>
		 &nbsp; &nbsp;
		<button class="btn btn-default">
			<li class="fas fa-download"></li> &nbsp;
			<a style="color : black;"href="/excel/iplistexcelDown"> Excel다운로드</a>
			
		</button>
		
		<table class="recentIpList">
			<tr style="height : 30px;">
				<th style="width : 10%;">사용자</th>
				<th>IP</th>
				<th style="width : 10%;">접속국가</th>
				<th style="width : 20%;">접속 시간</th>
			</tr>
		</table>
	</div>
</div>
