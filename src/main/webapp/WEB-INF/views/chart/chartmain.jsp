<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html >

<head>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<style type="text/css">
.banicl{
	float:left; 
}

</style>
</head>
<script type="text/javascript">

$(document).ready(function() {
	stackedbarchart();
	donutChart();
// 	donutSuggetstReject();
// 	donutSuggestAccept();
  });
  
function stackedbarchart() {
	$.ajax({
		url : "/project/stackedbarchart",
		method : "get",
		success : function(data) {
		var num = [];
		var percent=[];
		var percent2=[];
		for(i=0; i<data.size; i++){
		num.push(data.todoVoList[i].memName);	
		percent.push(data.todoVoList[i].todoPercent);
		if(data.todoVoList[i].todoPercent == '0'){
		percent2.push(100);	
			
		}
		if(data.todoVoList[i].todoPercent != '0'){
		percent2.push(100 - data.todoVoList[i].todoPercent);				
		}
		}
		var barChartData = {
				labels : num,
				 datasets: [
				        {
				          label               : '할일 진행도',
				          backgroundColor     : 'rgba(60,141,188,0.9)',
				          borderColor         : 'rgba(60,141,188,0.8)',
				          pointRadius          : false,
				          pointColor          : '#3b8bba',
				          pointStrokeColor    : 'rgba(60,141,188,1)',
				          pointHighlightFill  : '#fff',
				          pointHighlightStroke: 'rgba(60,141,188,1)',
				          data                : percent 
				        },
				        {
				          label               : '남은 진행도',
				          backgroundColor     : 'rgba(210, 214, 222, 1)',
				          borderColor         : 'rgba(210, 214, 222, 1)',
				          pointRadius         : false,
				          pointColor          : 'rgba(210, 214, 222, 1)',
				          pointStrokeColor    : '#c1c7d1',
				          pointHighlightFill  : '#fff',
				          pointHighlightStroke: 'rgba(220,220,220,1)',
				          data                : percent2
				        }]
		};
		var stackedBarChartOptions = {
			      responsive              : true,
			      maintainAspectRatio     : false,
			      scales: {
			        xAxes: [{
			          stacked: true,
			        }],
			        yAxes: [{
			          stacked: true
			        }]
			      }
			    };
		var ctx = document.getElementById('stackedBarChartTodo').getContext('2d');
		var stackedBarChartData = $.extend(true, {}, barChartData);
		var stackedBarChart = new Chart(ctx, {
		      type: 'bar',
		      data: stackedBarChartData,
		      options: stackedBarChartOptions
		    });
		}
	});
}



function donutChart() {
	$.ajax({
		url : "/project/donutChart",
		method : "get",
		success : function(data) {
		var dnum = [];
		var dpercent=[];
		for(i=0; i<data.dsize; i++){
		dnum.push(data.donutChartList[i].memName);	
		dpercent.push(data.donutChartList[i].todoPercent);
		
		}
		var donutChartData = {
				labels : dnum,
				 datasets: [
				        {
				          data: dpercent,
				          backgroundColor : ['#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de'],
				        }
				      ]
		};
		 var donutOptions     = {
			      maintainAspectRatio : false,
			      responsive : true,
			    }
		var dctx = document.getElementById('donutChartTodo').getContext('2d');
		var donutChart = new Chart(dctx, {
		      type: 'doughnut',
		      data: donutChartData,
		      options: donutOptions
		    });
		}
	});
}

function donutSuggestAccept() {
	$.ajax({
		url : "/project/donutSuggestAccept",
		method : "get",
		success : function(data) {
		var dpercent=[];
		dpercent.push(data.acceptpercent);
		var donutChartData = {
				labels : ['ACCEPT'],
				 datasets: [
				        {
				          data: dpercent,
				          backgroundColor : ['#f56954'],
				        }
				      ]
		};
		 var donutOptions     = {
			      maintainAspectRatio : false,
			      responsive : true,
			    }
		var dctx = document.getElementById('donutSuggetstAccept').getContext('2d');
		var donutChart = new Chart(dctx, {
		      type: 'doughnut',
		      data: donutChartData,
		      options: donutOptions
		    });
		}
	});
}
function donutSuggetstReject() {
	$.ajax({
		url : "/project/donutSuggetstReject",
		method : "get",
		success : function(data) {
		var dpercent=[];
		dpercent.push(data.acceptpercent);
		var donutChartData = {
				labels : ['REJECT'],
				 datasets: [
				        {
				          data: dpercent,
				          backgroundColor : ['#f56954'],
				        }
				      ]
		};
		 var donutOptions     = {
			      maintainAspectRatio : false,
			      responsive : true,
			    }
		var dctx = document.getElementById('donutSuggetstReject').getContext('2d');
		var donutChart = new Chart(dctx, {
		      type: 'doughnut',
		      data: donutChartData,
		      options: donutOptions
		    });
		}
	});
}
	
</script>

<body>
              <div class="col-12 col-sm-12">
                     <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                      <li class="nav-item">
                        <a class="nav-link active" id="custom-tabs-three-home-tab" data-toggle="pill" href="#custom-tabs-three-work" role="tab" aria-controls="custom-tabs-three-home" aria-selected="true">main</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="custom-tabs-three-gantt-tab" data-toggle="pill" href="#custom-tabs-three-gantt" role="tab" aria-controls="custom-tabs-three-gantt" aria-selected="false">일감관련</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="custom-tabs-three-messages-issue" data-toggle="pill" href="#custom-tabs-three-issue" role="tab" aria-controls="custom-tabs-three-issue" aria-selected="false">건의사항관련</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="custom-tabs-three-settings-suggest" data-toggle="pill" href="#custom-tabs-three-suggest" role="tab" aria-controls="custom-tabs-three-suggest" aria-selected="false">몰라</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="custom-tabs-three-calendar-tab" data-toggle="pill" href="#custom-tabs-three-calendar" role="tab" aria-controls="custom-tabs-three-calendar" aria-selected="false">차트</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="custom-tabs-three-mywork-tab" data-toggle="pill" href="#custom-tabs-three-mywork" role="tab" aria-controls="custom-tabs-three-mywork" aria-selected="false">test</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="custom-tabs-three-files-tab" data-toggle="pill" href="#custom-tabs-three-files" role="tab" aria-controls="custom-tabs-three-files" aria-selected="false">test</a>
                      </li>
                    </ul>
                  </div>
                  <!-- 내용 -->
                  <div class="card-body">
                    <div class="tab-content" id="custom-tabs-three-tabContent">
                      <div class="tab-pane fade active show" id="custom-tabs-three-work" role="tabpanel" aria-labelledby="custom-tabs-three-work-tab">
                          메인차트
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-gantt" role="tabpanel" aria-labelledby="custom-tabs-three-gantt-tab">
                      	<div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                  			<canvas id="stackedBarChartTodo" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
                		</div>
                		<div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
              		 		<canvas id="donutChartTodo" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
              		 	</div>
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab">
                      	<div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
              		 		<canvas id="donutSuggetstAccept" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
                      		<canvas id="donutSuggetstReject" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
                      	</div>
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-suggest" role="tabpanel" aria-labelledby="custom-tabs-three-suggest-tab">
                      	ㅋ
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-calendar" role="tabpanel" aria-labelledby="custom-tabs-three-calendar-tab">
                          캘린더입니다
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-mywork" role="tabpanel" aria-labelledby="custom-tabs-three-mywork-tab">
                          내일감 입니다.
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-files" role="tabpanel" aria-labelledby="custom-tabs-three-files-tab">
                          파일함 입니다.
                      </div>
                    </div>
                  </div>
                  <!-- /.card -->
              
               
</body>
</html>