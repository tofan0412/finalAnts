<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html >

<head>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
<style type="text/css">
.bani_a{text-decoration: none; color: black;}
.bani_a:hover {	text-decoration: none; color: black;}
.baniChart{text-align: center;}
.bani_div{width: 50%; float:left; }
.bani_div2{width: 50%; float:left; }
.bani_div3{width: 50%; float:left;}
</style>
</head>
<script type="text/javascript">

$(document).ready(function() {
	$('#bani_div2').hide();
	$('#bani_div2_1').hide();
	$('#bani_bb').click(function() {		
		$('#bani_div2').show();
		$('#bani_div3').hide();
	})
	$('#bani_aa').click(function() {		
		$('#bani_div3').show();
		$('#bani_div2').hide();
	})
	$('#bani_cc').click(function() {		
		$('#bani_div2_2').show();
		$('#bani_div2_1').hide();
	})
	$('#bani_dd').click(function() {		
		$('#bani_div2_1').show();
		$('#bani_div2_2').hide();
	})
	stackedbarchart();
	donutChart();
	donutSuggestAccept();
	barchartSuggestCnt();
	barchartvoteindi();
	donutchartvotetotal();
	chartfilesmonth();
	chartfilesday();
	chartfilesextension();
	chartIssuesmonth();
	chartIssuesday();
	chartIssuesCnt();
	chartproday();
	donutChartproper();
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
				          backgroundColor     : '#1D6A96',
				          borderColor         : '#1D6A96',
				          pointRadius          : false,
				          pointColor          : '#1D6A96',
				          pointStrokeColor    : '#1D6A96',
				          pointHighlightFill  : '#fff',
				          pointHighlightStroke: '#1D6A96',
				          barThickness: 50,
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
				          barThickness: 50,
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
				          backgroundColor : ['#87C488', '#fb7552', '#f29f8f', '#fed770', '#84c0e9', '#bcc74f'],
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
			dpercent.push(data.dbsuggestvo.acceptpercent);
			dpercent.push(data.dbsuggestvo.rejectpercent);
			var a=data.dbsuggestvo.acceptpercent*1;
			var b=data.dbsuggestvo.rejectpercent*1;
			var c = 100-(a+b)+0;
			var d = c+"";
			dpercent.push(d);
			var donutChartData = {
					labels : ['수용','거절','대기'],
					 datasets: [
					        {
					          data: dpercent,
					          backgroundColor : ['#87C488', '#E3A6A1', '#869DAB'],
					        }
					      ]
			};
			 var donutOptions     = {
				      maintainAspectRatio : false,
				      responsive : true,
				    }
			var dctx = document.getElementById('donutChartsuggest').getContext('2d');
			var donutChart = new Chart(dctx, {
			      type: 'doughnut',
			      data: donutChartData,
			      options: donutOptions
			    });
			}
		});
	}
	
function barchartSuggestCnt() {
	$.ajax({
		url : "/project/barchartSuggestCnt",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.suggestlist[i].memName);	
			percent.push(data.suggestlist[i].chartcnt);
			}
			var barChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '개수',
					          backgroundColor     : '#1D6A96',
					          borderColor         : '#1D6A96',
					          pointRadius          : false,
					          pointColor          : '#1D6A96',
					          pointStrokeColor    : '#1D6A96',
					          pointHighlightFill  : '#fff',
					          pointHighlightStroke: '#1D6A96',
					          data                : percent ,					 
					          barThickness: 50
					         
					        }]
			};
			var barChartOptions = {
				      responsive              : true,
				      maintainAspectRatio     : false,
				      datasetFill  			  : false,
				      scales: {
					        xAxes: [{
					          display : true
					        }],
					        yAxes: [{
					        	ticks: {
					                  stepSize: 10,
					                  suggestedMax: 50, 
					                  beginAtZero: true
					          }
					        }]
					      }
				    };
			var ctx = document.getElementById('chartsuggestCnt').getContext('2d');
			var stackedBarChartData = $.extend(true, {}, barChartData);
			var stackedBarChart = new Chart(ctx, {
			      type: 'bar',
			      data: barChartData,
			      options: barChartOptions
			    });
			}
		});
	}

function donutchartvotetotal() {
	$.ajax({
		url : "/project/donutchartvotetotal",
		method : "get",
		success : function(data) {
			var dpercent=[];
			dpercent.push(data.voteVo.votepercent);
			var a=data.voteVo.votepercent*1;
			var c = 100-a+0;
			var d = c+"";
			dpercent.push(d);
			var donutChartData = {
					labels : ['참여','불참'],
					 datasets: [
					        {
					          data: dpercent,
					          backgroundColor : ['#87C488', '#869DAB']
					         
					        }
					      ]
			};
			 var donutOptions     = {
				      maintainAspectRatio : false,
				      responsive : true,
				    }
			var dctx = document.getElementById('chartvotetotal').getContext('2d');
			var donutChart = new Chart(dctx, {
			      type: 'doughnut',
			      data: donutChartData,
			      options: donutOptions
			    });
			}
		});
	}
	
function barchartvoteindi() {
	$.ajax({
		url : "/project/barchartvoteindi",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.VoteList[i].memName);	
			percent.push(data.VoteList[i].votepercent);
			}
			var barChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '투표 참여율',
					          backgroundColor     : '#1D6A96',
					          borderColor         : '#1D6A96',
					          pointRadius          : false,
					          pointColor          : '#1D6A96',
					          pointStrokeColor    : '#1D6A96',
					          pointHighlightFill  : '#fff',
					          pointHighlightStroke: '#1D6A96',
					          data                : percent,
					          barThickness: 50
					         
					        }]
			};
			var barChartOptions = {
				      responsive              : true,
				      maintainAspectRatio     : false,
				      datasetFill  			  : false,
				      scales: {
					        xAxes: [{
					          display : true
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
			var ctx = document.getElementById('chartvoteindi').getContext('2d');
			var stackedBarChartData = $.extend(true, {}, barChartData);
			var stackedBarChart = new Chart(ctx, {
			      type: 'bar',
			      data: barChartData,
			      options: barChartOptions
			    });
			}
		});
	}
	
function chartfilesday() {
	$.ajax({
		url : "/project/chartfilesday",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.publicFileList[i].regDt);	
			percent.push(data.publicFileList[i].pubSize);
			}
			var lineChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '일별',
					          backgroundColor     : '#1D6A96',
					          borderColor         : '#1D6A96',
					          pointRadius          : false,
					          pointColor          : '#1D6A96',
					          pointStrokeColor    : '#1D6A96',
					          pointHighlightFill  : '#fff',
					          pointHighlightStroke: '#1D6A96',
					          data                : percent 				 
					        }]
			};
			 var lineChartOptions     = {
					  responsive              : true,
				      maintainAspectRatio     : false,
				      datasetFill  			  : false,
				      scales: {
					        xAxes: [{
					          display : true
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
			var dctx = document.getElementById('chartfilesday').getContext('2d');
			var lineChart = new Chart(dctx, {
				  type: 'line',
				  data: lineChartData,
				  options: lineChartOptions
			    });
			}
		});
	}
	
function chartfilesmonth() {
	$.ajax({
		url : "/project/chartfilesmonth",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.publicFileList[i].regDt);	
			percent.push(data.publicFileList[i].pubSize);
			}
			var lineChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '월별',
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
					          display : true
					        }],
					        yAxes: [{
					        	ticks: {
					                  stepSize: 10,
					                  suggestedMax: 80, 
					                  beginAtZero: true
					          }
					        }]
					      }
				    };
			var dctx = document.getElementById('chartfilesmonth').getContext('2d');
			var lineChart = new Chart(dctx, {
				  type: 'bar',
				  data: lineChartData,
				  options: lineChartOptions
			    });
			}
		});
	}
function chartfilesextension() {
	$.ajax({
		url : "/project/chartextension",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.publicFileList[i].pubExtension);	
			percent.push(data.publicFileList[i].pubId);
			}
			var barChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '개수',
					          backgroundColor     : '#6a92cc',
					          borderColor         : '#6a92cc',
					          pointRadius          : false,
					          pointColor          : '#6a92cc',
					          pointStrokeColor    : '#6a92cc',
					          pointHighlightFill  : '#fff',
					          pointHighlightStroke: '#6a92cc',
					          data                : percent,
					          barThickness: 30
					        }]
			};
			 var barChartOptions     = {
					 responsive              : true,
				      maintainAspectRatio     : false,
				      datasetFill  			  : false,
				      scales: {
					        xAxes: [{
					          display : true
					        }],
					        yAxes: [{
					        	ticks: {
					                  stepSize: 10,
					                  beginAtZero: true
					          }
					        }]
					      }
				    };
			var dctx = document.getElementById('chartfilesextension').getContext('2d');
			var barChart = new Chart(dctx, {
				  type: 'bar',
				  data: barChartData,
				  options: barChartOptions
			    });
			}
		});
	}
	
function chartIssuesday() {
	$.ajax({
		url : "/project/chartIssuesday",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.issueList[i].regDt);	
			percent.push(data.issueList[i].issueId);
			}
			var lineChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '일별',
					          backgroundColor     : '#1D6A96',
					          borderColor         : '#1D6A96',
					          pointRadius          : false,
					          pointColor          : '#1D6A96',
					          pointStrokeColor    : '#1D6A96',
					          pointHighlightFill  : '#fff',
					          pointHighlightStroke: '#1D6A96',
					          data                : percent 				 
					        }]
			};
			 var lineChartOptions     = {
					  responsive              : true,
				      maintainAspectRatio     : false,
				      datasetFill  			  : false,
				      scales: {
					        xAxes: [{
					          display : true
					        }],
					        yAxes: [{
					        	ticks: {
					                  stepSize: 10,
					                  suggestedMax: 50, 
					                  beginAtZero: true
					          }
					        }]
					      }
				    };
			var dctx = document.getElementById('chartIssuesday').getContext('2d');
			var lineChart = new Chart(dctx, {
				  type: 'line',
				  data: lineChartData,
				  options: lineChartOptions
			    });
			}
		});
	}
	
function chartIssuesmonth() {
	$.ajax({
		url : "/project/chartIssuesmonth",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.issueList[i].regDt);	
			percent.push(data.issueList[i].issueId);
			}
			var lineChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '월별',
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
					          display : true
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
			var dctx = document.getElementById('chartIssuesmonth').getContext('2d');
			var lineChart = new Chart(dctx, {
				  type: 'bar',
				  data: lineChartData,
				  options: lineChartOptions
			    });
			}
		});
	}
	
function chartIssuesCnt() {
	$.ajax({
		url : "/project/chartIssuesCnt",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.issueList[i].memName);	
			percent.push(data.issueList[i].issueId);
			}
			var barChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '개수',
					          backgroundColor     : '#6a92cc',
					          borderColor         : '#6a92cc',
					          pointRadius          : false,
					          pointColor          : '#3b8bba',
					          pointStrokeColor    : '#6a92cc',
					          pointHighlightFill  : '#fff',
					          pointHighlightStroke: '#6a92cc',
					          data                : percent,
					          barThickness: 50
					        }]
			};
			 var barChartOptions     = {
					 responsive              : true,
				      maintainAspectRatio     : false,
				      datasetFill  			  : false,
				      scales: {
					        xAxes: [{
					          display : true
					        }],
					        yAxes: [{
					        	ticks: {
					                  stepSize: 10,
					                  suggestedMax: 50,
					                  beginAtZero: true
					          }
					        }]
					      }
				    };
			var dctx = document.getElementById('chartIssuesCnt').getContext('2d');
			var barChart = new Chart(dctx, {
				  type: 'bar',
				  data: barChartData,
				  options: barChartOptions
			    });
			}
		});
	}
	
function chartproday() {
	$.ajax({
		url : "/project/chartproday",
		method : "get",
		success : function(data) {
			var num = [];
			var percent=[];
			for(i=0; i<data.dbsize; i++){
			num.push(data.projectList[i].regDt);	
			percent.push(data.projectList[i].percent);
			}
			var lineChartData = {
					labels : num,
					 datasets: [
					        {
					          label               : '일별 진행도',
					          backgroundColor     : '#1D6A96',
					          borderColor         : '#1D6A96',
					          pointRadius          : false,
					          pointColor          : '#1D6A96',
					          pointStrokeColor    : '#1D6A96',
					          pointHighlightFill  : '#fff',
					          pointHighlightStroke: '#1D6A96',
					          data                : percent
					        }]
			};
			 var lineChartOptions     = {
					 responsive              : true,
				      maintainAspectRatio     : false,
				      datasetFill  			  : false,
				      scales: {
					        xAxes: [{
					          display : true
					        }],
					        yAxes: [{
					        	ticks: {
					                  stepSize: 10,
					                  suggestedMax: 50, 
					                  beginAtZero: true
					          }
					        }]
					      }
				    };
			var dctx = document.getElementById('chartproday').getContext('2d');
			var lineChart = new Chart(dctx, {
				  type: 'line',
				  data: lineChartData,
				  options: lineChartOptions
			    });
			}
		});
	}

function donutChartproper() {
	$.ajax({
		url : "/project/donutChartproper",
		method : "get",
		success : function(data) {
			var dpercent=[];
			dpercent.push(data.projectVo.percent);
			var a=data.projectVo.percent*1;
			var c = 100-a+0;
			var d = c+"";
			dpercent.push(d);
			var donutChartData = {
					labels : ['완료','진행'],
					 datasets: [
					        {
					          data: dpercent,
					          backgroundColor : ['#87C488', '#869DAB'],
					        }
					      ]
			};
			 var donutOptions     = {
				      maintainAspectRatio : false,
				      responsive : true,
				    }
			var dctx = document.getElementById('donutChartproper').getContext('2d');
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
	<%@include file="../layout/contentmenu.jsp"%>
		<!-- /.container-fluid -->
              <div class="col-12 col-sm-12 jg">
                     <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                      <li class="nav-item">
                        <a class="nav-link active bani_a" id="custom-tabs-three-home-tab" data-toggle="pill" href="#custom-tabs-three-work" role="tab" aria-controls="custom-tabs-three-home" aria-selected="true">프로젝트 차트</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link bani_a" id="custom-tabs-three-gantt-tab" data-toggle="pill" href="#custom-tabs-three-gantt" role="tab" aria-controls="custom-tabs-three-gantt" aria-selected="false">일감 차트</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link bani_a" id="custom-tabs-three-calendar-tab" data-toggle="pill" href="#custom-tabs-three-calendar" role="tab" aria-controls="custom-tabs-three-calendar" aria-selected="false">이슈 차트</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link bani_a" id="custom-tabs-three-mywork-tab" data-toggle="pill" href="#custom-tabs-three-mywork" role="tab" aria-controls="custom-tabs-three-mywork" aria-selected="false">파일함 차트</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link bani_a" id="custom-tabs-three-settings-suggest" data-toggle="pill" href="#custom-tabs-three-suggest" role="tab" aria-controls="custom-tabs-three-suggest" aria-selected="false">투표 차트</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link bani_a" id="custom-tabs-three-messages-issue" data-toggle="pill" href="#custom-tabs-three-issue" role="tab" aria-controls="custom-tabs-three-issue" aria-selected="false">건의사항 차트</a>
                      </li>
                    </ul>
                  </div>
                  <!-- 내용 -->
                  <div class="card-body jg">
                    <div class="tab-content" id="custom-tabs-three-tabContent">
                      <div class="tab-pane fade active show" id="custom-tabs-three-work" role="tabpanel" aria-labelledby="custom-tabs-three-work-tab">
                      	<br><br>
                      	<div class="bani_div">
                          <h5 class="baniChart">프로젝트 진행도 </h5><br>
                          <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="donutChartproper" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
	              		 </div>
	              		 </div>
	              		 <div class="bani_div">
	              		 <h5 class="baniChart">일별 프로젝트 진행율 </h5><br>
                         <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="chartproday" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
                         </div>
                         </div>
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-gantt" role="tabpanel" aria-labelledby="custom-tabs-three-gantt-tab">
                      <br><br>
                      <div class="bani_div">
                      	<h5 class="baniChart">팀원별 할일 비중도</h5><br>
                		<div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
              		 		<canvas id="donutChartTodo" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
              		 	</div>
              		 	</div>
                      <div class="bani_div">
                      	<h5 class="baniChart">팀원별 할일 진행율</h5><br>
                      	<div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                  			<canvas id="stackedBarChartTodo" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
                		</div>
                		</div>
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab">
                      <br><br>
                      <div class="bani_div">
                      	<h5 class="baniChart">건의사항 현황</h5><br>
                     	 <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="donutChartsuggest" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
	              		 </div>
	              		 </div>
	              		 <div class="bani_div">
                      	<h5 class="baniChart">팀원별 건의사항 작성 수</h5><br>
	              		 <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="chartsuggestCnt" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
	              		 </div>
	              		 </div>
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-suggest" role="tabpanel" aria-labelledby="custom-tabs-three-suggest-tab">
                      <br><br>
                      <div class="bani_div">
                      	<h5 class="baniChart">전체 투표 참여율</h5><br>
                      	 <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="chartvotetotal" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
	              		 </div>
	              		 </div>
	              		 <div class="bani_div">
	              		 <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                      	<h5 class="baniChart">팀원별 투표 참여율</h5><br>
	              		 	<canvas id="chartvoteindi" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
	              		 </div> 
	              		 </div>
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-calendar" role="tabpanel" aria-labelledby="custom-tabs-three-calendar-tab">
                      <input type="button" id="bani_aa" value="일별"/>
                      <input type="button" id="bani_bb" value="월별"/>
                      <br><br>
                      <div class="bani_div3" id="bani_div2" style="margin-top: 3.3%;">
                      	<h5 class="baniChart">월별 이슈 작성 수</h5><br>
                         <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="chartIssuesmonth" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
	              		 </div> 
	              		 </div>
	              		 <div class="bani_div3" id="bani_div3" style="margin-top: 3.3%;">
                      	<h5 class="baniChart">일별 이슈 작성 수</h5><br>
                         <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="chartIssuesday" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
                         </div>
                         </div>
                         <br><br>
                         <div class="bani_div2">
                      	<h5 class="baniChart">팀원별 이슈 작성 수</h5><br>
                         <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="chartIssuesCnt" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
	              		 </div> 
	              		 </div>
                      </div>
                      <div class="tab-pane fade" id="custom-tabs-three-mywork" role="tabpanel" aria-labelledby="custom-tabs-three-mywork-tab">
                      <input type="button" id="bani_cc" value="일별"/>
                      <input type="button" id="bani_dd" value="월별"/>
                      <br><br>
                      <div class="bani_div3" id="bani_div2_1">
                      	<h5 class="baniChart">월별 파일 업로드 용량 (MB)</h5><br>
                         <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="chartfilesmonth" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
	              		 </div> 
	              		 </div>
	              		 <div class="bani_div3" id ="bani_div2_2">
                      	<h5 class="baniChart">일별 파일 업로드 용량 (MB)</h5><br>
                         <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="chartfilesday" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
                         </div>
                         </div>
                         <div class="bani_div2">
                      	<h5 class="baniChart">확장자별 업로드 수</h5><br>
                         <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
	              		 	<canvas id="chartfilesextension" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
	              		 </div> 
	              		 </div>
                      </div>
                    </div>
                  </div>
               
</body>
</html>