<%@page import="java.util.ArrayList"%>
<%@page import="ants.com.board.memBoard.model.ScheduleVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/WEB-INF/views/layout/fonts.jsp"%>

<script>
// $(document).ready(function() {
// 	chartMain();
// });
// function chartMain() {
	
// 			var num = [];
// 			var percent=[];
// 			for(i=0; i<data.dbsize; i++){
// 			num.push(data.publicFileList[i].regDt);	
// 			percent.push(data.publicFileList[i].pubSize);
			
// 			var lineChartData = {
// 					labels : num,
// 					 datasets: [
// 					        {
// 					          label               : '월별',
// 					          backgroundColor     : '#87C488',
// 					          borderColor         : '#87C488',
// 					          pointRadius          : false,
// 					          pointColor          : '#87C488',
// 					          pointStrokeColor    : '#87C488',
// 					          pointHighlightFill  : '#fff',
// 					          pointHighlightStroke: '#87C488',
// 					          data                : percent,
// 					          barThickness: 50
// 					        }]
// 			};
// 			 var lineChartOptions     = {
// 					 responsive              : true,
// 				      maintainAspectRatio     : false,
// 				      datasetFill  			  : false,
// 				      scales: {
// 					        xAxes: [{
// 					          display : true
// 					        }],
// 					        yAxes: [{
// 					        	ticks: {
// 					                  stepSize: 10,
// 					                  suggestedMax: 80, 
// 					                  beginAtZero: true
// 					          }
// 					        }]
// 					      }
// 				    };
// 			var dctx = document.getElementById('chartfilesmonth').getContext('2d');
// 			var lineChart = new Chart(dctx, {
// 				  type: 'bar',
// 				  data: lineChartData,
// 				  options: lineChartOptions
// 			    });
// 			}

// 	}
</script>
<style>
#top{
	width: 100%;
	height: 420px;
}
#left{
	width: 50%;
	height: 400px;
	float:left;
	
}
#right{
	width: 50%;
	float:left;
	height: 400px;
}
#project_table{
	width : 50%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    text-align: center;
	margin-left: 5%;
	font-size: 0.8em;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 6px;
  }
 tr{
 height: 30px;
 }
 
</style>
	 				
<body>
<div id="top" style="OVERFLOW-Y:auto;">
<br>
<h4 class="jg" style="padding-left: 5%;">Project List</h4>
	<table id="project_table" class="ns">
		<tr style="background-color: #f6f6f6">
			<th>프로젝트 이름</th>
			<th>진행도</th>
			<th>기간</th>
			<th>PL</th>
		</tr>
		<tbody >
				<c:forEach items="${projectList_main }" var="project" varStatus="sts" >
				    <tr>
					<td style="text-align: left; width: 350px; font-size: 1em; padding-left: 8%">${project.proName }</td>
					<c:if test="${empty project.percent }">
					<td style="width: 100px;">0%</td>
					</c:if>					
					<c:if test="${not empty project.percent }">
					<td>${project.percent }%</td>
					</c:if>					
					<td style="width: 200px;">${project.regDt }&nbsp;&nbsp;~&nbsp;&nbsp; ${project.endDt }</td>			
					<td style="width: 100px;">${project.memId }</td>			
					</tr>
				</c:forEach>
		</tbody>
	</table>
</div>
<br><br>
<div id="left">111</div>
<div id="right">222</div>
</body>