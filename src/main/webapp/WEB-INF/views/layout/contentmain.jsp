<%@page import="java.util.ArrayList"%>
<%@page import="ants.com.board.memBoard.model.ScheduleVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html >
<head>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<script>
$(document).ready(function() {
	chartmain();
});
function chartmain() {
	$.ajax({
		url : "/member/chartmain",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.projectList_main[i].proName);	
			percent.push(data.projectList_main[i].percent);
			}
			var lineChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '진행도',
					          backgroundColor     : '#87C488',
					          borderColor         : '#87C488',
					          pointRadius          : false,
					          pointColor          : '#87C488',
					          pointStrokeColor    : '#87C488',
					          pointHighlightFill  : '#fff',
					          pointHighlightStroke: '#87C488',
					          data                : percent,
					          barThickness: 50
					        }]
			};
			 var lineChartOptions     = {
					 responsive              : true,
				      maintainAspectRatio     : false,
				      datasetFill  			  : false,
				      scales: {
					        xAxes: [{
					          display : false
					        }],
					        yAxes: [{
					        	ticks: {
					                  stepSize: 10,
					                  suggestedMax: 100, 
					                  beginAtZero: true
					          }
					        }]
					      }
				    };
			var dctx = document.getElementById('chartmain').getContext('2d');
			var lineChart = new Chart(dctx, {
				  type: 'bar',
				  data: lineChartData,
				  options: lineChartOptions
			    });
			}
		});
	}
</script>
<style>
#maintop{
	width: 100%;
	height: 40%;
}
#mainleft{
	width: 65%;	
	min-height: 20%;
	float:left;
	
}
#mainright{
	width: 30%;
	min-height: 20%;
	float:left;
}
#project_table{
	width : 50%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    text-align: center;
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
</head>				
<body>
 <div class="col-12 col-sm-12">
 
<div id="maintop" style="OVERFLOW-Y:auto; padding-left:3%; margin-top: 1%;">
 <div class="card" style="height: 100%;">
<div class="card-header">
<h4 class="jg" >Project List</h4></div>
<div class="card-body pt-0" style=" margin-left: 2%; margin-right: 2%; margin-top: 1%; margin-bottom: 0.5%;" >
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
					<td style="text-align: left; width: 350px; font-size: 1em; padding-left: 5%">${project.proName }</td>
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
</div>
</div>

<div id="mainleft" style="padding-left: 3%;">
<div class="card" style="height: 360px;">
<div class="card-header">
<h4 class="jg" >Progress Chart </h4></div>
<div class="card-body pt-0">
	<div class="chart">
		<div class="chartjs-size-monitor">
			<div class="chartjs-size-monitor-expand">
				<div class=""></div>
			</div>
			<div class="chartjs-size-monitor-shrink">
				<div class=""></div>
			</div>
		</div>
		<canvas id="chartmain" style="min-height: 200px; height: 290px; max-height: 290px; max-width: 100%; display: block; width: 100px;" width="100" height="290" class="chartjs-render-monitor"></canvas>
	</div>
	</div>
</div>
</div>
<div id="mainright" style="padding-left: 3%;">
<div class="card" style="height: 350px;">
              <div class="card-header">
                <h4 class="jg" style="text-align: center;"> Calendar</h4>
              </div>
             
              <div class="card-body pt-0">
                <!--The calendar -->
                <div id="calendar" style="width: 100%; height: 100%;" >
                <div class="bootstrap-datetimepicker-widget usetwentyfour">
                <ul class="list-unstyled">
                <li class="show">
                <div class="datepicker">
                <div class="datepicker-days" style="">
                <table class="table table-sm">
                <thead>
                <tr>
                <th class="picker-switch" data-action="pickerSwitch" colspan="5" title="Select Month">December 2020</th>
                </tr>
                <tr><th class="dow">Su</th><th class="dow">Mo</th><th class="dow">Tu</th><th class="dow">We</th><th class="dow">Th</th><th class="dow">Fr</th><th class="dow">Sa</th></tr></thead><tbody><tr><td data-action="selectDay" data-day="11/29/2020" class="day old weekend">29</td><td data-action="selectDay" data-day="11/30/2020" class="day old">30</td><td data-action="selectDay" data-day="12/01/2020" class="day">1</td><td data-action="selectDay" data-day="12/02/2020" class="day">2</td><td data-action="selectDay" data-day="12/03/2020" class="day">3</td><td data-action="selectDay" data-day="12/04/2020" class="day">4</td><td data-action="selectDay" data-day="12/05/2020" class="day weekend">5</td></tr><tr><td data-action="selectDay" data-day="12/06/2020" class="day weekend">6</td><td data-action="selectDay" data-day="12/07/2020" class="day">7</td><td data-action="selectDay" data-day="12/08/2020" class="day">8</td><td data-action="selectDay" data-day="12/09/2020" class="day">9</td><td data-action="selectDay" data-day="12/10/2020" class="day">10</td><td data-action="selectDay" data-day="12/11/2020" class="day">11</td><td data-action="selectDay" data-day="12/12/2020" class="day weekend">12</td></tr><tr><td data-action="selectDay" data-day="12/13/2020" class="day weekend">13</td><td data-action="selectDay" data-day="12/14/2020" class="day">14</td><td data-action="selectDay" data-day="12/15/2020" class="day">15</td><td data-action="selectDay" data-day="12/16/2020" class="day">16</td><td data-action="selectDay" data-day="12/17/2020" class="day">17</td><td data-action="selectDay" data-day="12/18/2020" class="day">18</td><td data-action="selectDay" data-day="12/19/2020" class="day weekend">19</td></tr><tr><td data-action="selectDay" data-day="12/20/2020" class="day weekend">20</td><td data-action="selectDay" data-day="12/21/2020" class="day">21</td><td data-action="selectDay" data-day="12/22/2020" class="day active today">22</td><td data-action="selectDay" data-day="12/23/2020" class="day">23</td><td data-action="selectDay" data-day="12/24/2020" class="day">24</td><td data-action="selectDay" data-day="12/25/2020" class="day">25</td><td data-action="selectDay" data-day="12/26/2020" class="day weekend">26</td></tr><tr><td data-action="selectDay" data-day="12/27/2020" class="day weekend">27</td><td data-action="selectDay" data-day="12/28/2020" class="day">28</td><td data-action="selectDay" data-day="12/29/2020" class="day">29</td><td data-action="selectDay" data-day="12/30/2020" class="day">30</td><td data-action="selectDay" data-day="12/31/2020" class="day">31</td><td data-action="selectDay" data-day="01/01/2021" class="day new">1</td><td data-action="selectDay" data-day="01/02/2021" class="day new weekend">2</td></tr><tr><td data-action="selectDay" data-day="01/03/2021" class="day new weekend">3</td><td data-action="selectDay" data-day="01/04/2021" class="day new">4</td><td data-action="selectDay" data-day="01/05/2021" class="day new">5</td><td data-action="selectDay" data-day="01/06/2021" class="day new">6</td><td data-action="selectDay" data-day="01/07/2021" class="day new">7</td><td data-action="selectDay" data-day="01/08/2021" class="day new">8</td><td data-action="selectDay" data-day="01/09/2021" class="day new weekend">9</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev" data-action="previous"><span class="fa fa-chevron-left" title="Previous Year"></span></th><th class="picker-switch" data-action="pickerSwitch" colspan="5" title="Select Year">2020</th><th class="next" data-action="next"><span class="fa fa-chevron-right" title="Next Year"></span></th></tr></thead><tbody><tr><td colspan="7"><span data-action="selectMonth" class="month">Jan</span><span data-action="selectMonth" class="month">Feb</span><span data-action="selectMonth" class="month">Mar</span><span data-action="selectMonth" class="month">Apr</span><span data-action="selectMonth" class="month">May</span><span data-action="selectMonth" class="month">Jun</span><span data-action="selectMonth" class="month">Jul</span><span data-action="selectMonth" class="month">Aug</span><span data-action="selectMonth" class="month">Sep</span><span data-action="selectMonth" class="month">Oct</span><span data-action="selectMonth" class="month">Nov</span><span data-action="selectMonth" class="month active">Dec</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev" data-action="previous"><span class="fa fa-chevron-left" title="Previous Decade"></span></th><th class="picker-switch" data-action="pickerSwitch" colspan="5" title="Select Decade">2020-2029</th><th class="next" data-action="next"><span class="fa fa-chevron-right" title="Next Decade"></span></th></tr></thead><tbody><tr><td colspan="7"><span data-action="selectYear" class="year old">2019</span><span data-action="selectYear" class="year active">2020</span><span data-action="selectYear" class="year">2021</span><span data-action="selectYear" class="year">2022</span><span data-action="selectYear" class="year">2023</span><span data-action="selectYear" class="year">2024</span><span data-action="selectYear" class="year">2025</span><span data-action="selectYear" class="year">2026</span><span data-action="selectYear" class="year">2027</span><span data-action="selectYear" class="year">2028</span><span data-action="selectYear" class="year">2029</span><span data-action="selectYear" class="year old">2030</span></td></tr></tbody></table></div><div class="datepicker-decades" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev" data-action="previous"><span class="fa fa-chevron-left" title="Previous Century"></span></th><th class="picker-switch" data-action="pickerSwitch" colspan="5">2000-2090</th><th class="next" data-action="next"><span class="fa fa-chevron-right" title="Next Century"></span></th></tr></thead><tbody><tr><td colspan="7"><span data-action="selectDecade" class="decade old" data-selection="2006">1990</span><span data-action="selectDecade" class="decade" data-selection="2006">2000</span><span data-action="selectDecade" class="decade active" data-selection="2016">2010</span><span data-action="selectDecade" class="decade" data-selection="2026">2020</span><span data-action="selectDecade" class="decade" data-selection="2036">2030</span><span data-action="selectDecade" class="decade" data-selection="2046">2040</span><span data-action="selectDecade" class="decade" data-selection="2056">2050</span><span data-action="selectDecade" class="decade" data-selection="2066">2060</span><span data-action="selectDecade" class="decade" data-selection="2076">2070</span><span data-action="selectDecade" class="decade" data-selection="2086">2080</span><span data-action="selectDecade" class="decade" data-selection="2096">2090</span><span data-action="selectDecade" class="decade old" data-selection="2106">2100</span></td></tr></tbody></table></div></div></li><li class="picker-switch accordion-toggle"></li></ul></div></div>
              </div>
              <!-- /.card-body -->
            </div>
</div>
</div>
</html>
</body>