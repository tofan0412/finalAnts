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
	donutSuggetstReject();
	donutSuggestAccept();
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

<body >
<%@include file="../layout/contentmenu.jsp"%>
<div class="wrapper">
<br>
    <!-- Main content -->
      <div class="container-fluid">
           <div class="col-md-6 banicl">
           
            <!-- AREA CHART -->
            <div class="card card-info card-outline collapsed-card">
              <div class="card-header jg">
                <h3 class="card-title">Area Chart</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  
                </div>
              </div>
              <div class="card-body ns" style="display: none;">
                <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                  <canvas id="areaChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
			<!-- PIE CHART -->
            <div class="card card-info card-outline collapsed-card">
              <div class="card-header jg">
                <h3 class="card-title">건의사항 수용 & 거절</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                 
            
                </div>
              </div>
              <div class="card-body ns" style="display: none;">
              <div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                <canvas id="donutSuggetstAccept" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
                <canvas id="donutSuggetstReject" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->


            <!-- DONUT CHART -->
             <div class="card card-info card-outline collapsed-card">
      			 <div class="card-header jg">
                <h3 class="card-title">할일 비중 차트</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                 
                </div>
              </div>
              <div class="card-body ns" style="display: none;">
              <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                <canvas id="donutChartTodo" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
              </div>
            </div>
            <!-- /.card -->

          </div>
          <div class="col-md-6 banicl">
            <!-- LINE CHART -->
            <div class="card card-info card-outline collapsed-card">
              <div class="card-header jg">
                <h3 class="card-title">Line Chart</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                 
                </div>
              </div>
              <div class="card-body ns" style="display: none;">
                <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                  <canvas id="lineChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            <!-- BAR CHART -->
            <div class="card card-info card-outline collapsed-card">
              <div class="card-header jg">
                <h3 class="card-title">멤버별 건의사항 </h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                 
                </div>
              </div>
             <div class="card-body ns" style="display: none;">
                <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                  <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 347px;" width="347" height="250" class="chartjs-render-monitor"></canvas>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            <!-- STACKED BAR CHART -->
            
            <!-- STACKED BAR CHART -->
          <div class="card card-info card-outline collapsed-card">
              <div class="card-header jg">
                <h3 class="card-title">할일 진행도 차트</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  
                </div>
              </div>
              <div class="card-body ns" style="display: none;">
                <div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                  <canvas id="stackedBarChartTodo" style="min-height: 350px; height: 350px; max-height: 350px; max-width: 100%; display: block; width: 100px;" width="100" height="350" class="chartjs-render-monitor"></canvas>
                </div>
              </div>
            </div>
          </div>
          </div>
        </div>
  

</body>
</html>