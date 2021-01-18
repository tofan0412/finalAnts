<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/gantt/codebase/dhtmlxgantt.js"></script>
<link href="/gantt/codebase/dhtmlxgantt.css" rel="stylesheet">
<script src="https://export.dhtmlx.com/gantt/api.js"></script>  
<script src="http://export.dhtmlx.com/gantt/api.js"></script> 
<style type="text/css">
.gantt_task_progress {
	text-align: left;
	padding-left: 10px;
	box-sizing: border-box;
	color: white;
	font-weight: bold;
}

.weekend {
	background: #f4f7f4;
}

.gantt_selected .weekend {
	background: #f7eb91;
}
.scaleBtn{
	width: 100%;
	background: white;
	padding-top: 10px;
	padding-left: 10px;
	padding-bottom: 10px;
}
</style>
</head>
<body>
	<%@include file="../layout/contentmenu.jsp"%>
	<div class="scaleBtn">
		<form class="gantt_control">
			<div class="input-group input-group-sm col-md-1 float-left" style="min-width: max-content">
		      	<select class="form-control" name="searchCondition" id="searchCondition" style="font-size: 0.7em;">
					<option value="0">전체(담당자)</option>
					<c:forEach items="${promemList }" var="p">
						<option value="${p.memId }">${p.memName }</option>
					</c:forEach>
				</select>
		          <div class="input-group-append" id="stoBtn">
		          	<div class="btn btn-default">
		             		<i class="fas fa-search"></i>
		            </div>
		          </div>
		    </div>
		    &nbsp;&nbsp;&nbsp;
			<input type="radio" id="scale1" class="gantt_radio" name="scale" value="day">
				<label for="scale1">일간</label> &nbsp; 
			<input type="radio" id="scale2" class="gantt_radio" name="scale" value="week"> 
				<label for="scale2">주간</label> 
			<input type="radio" id="scale3" class="gantt_radio" name="scale" value="month" checked=""> 
				<label for="scale3">월간</label> &nbsp; 
			<input type="radio" id="scale4" class="gantt_radio" name="scale" value="quarter" > 
				<label for="scale4">분기</label> &nbsp; 
			<input type="radio" id="scale5" class="gantt_radio" name="scale" value="year" > 
				<label for="scale5">년도</label>&nbsp; 
			<input type="button" value="축소" onclick="zoomIn()" class="btn btn-default  btn-sm btn-flat"> 
			<input type="button" value="확대" onclick="zoomOut()" class="btn btn-default btn-sm btn-flat"> &nbsp; &nbsp; 
			<input value="Excel 다운로드" type="button" onclick="gantt.exportToExcel()" style="margin:0 15px; float: right;" class="btn btn-default  btn-sm btn-flat">
			<input value="PDF 다운로드" type="button" onclick='gantt.exportToPDF()' style="float: right;" class="btn btn-default  btn-sm btn-flat">
		</form>
	</div>
	<div id="gantt_here" style='width: 100%; height: 600px; font-size: 0.7em;'></div>
	




	<script type="text/javascript">
		/* gantt 설정  */
		//나라설정
		gantt.i18n.setLocale("kr");
		
		//열높이
		gantt.config.row_height = 30;
		
		//진행률
		gantt.templates.progress_text = function(start, end, task) {
			return "<span style='text-align:left;'>"
					+ Math.round(task.progress * 100) + "% </span>";
		};
		//주말표시
		gantt.templates.scale_cell_class = function(date) {
			if (date.getDay() == 0 || date.getDay() == 6) {
				return "weekend";
			}
		};
		gantt.templates.timeline_cell_class = function(item, date) {
			if (date.getDay() == 0 || date.getDay() == 6) {
				return "weekend"
			}
		};
		//상위레벨 색상 다르게
		gantt.config.wide_form = 1;

		gantt.templates.task_class = function(st, end, item) {
			return item.$level == 0 ? "gantt_project" : ""
		};
		//툴팁
		gantt.plugins({
			tooltip : true
		});
		//툴팁내용
		gantt.templates.tooltip_text = function(start, end, task) {
			return "<b>업무:</b> " + task.text + "<br/><b>시작일:</b> " + task.start_date + "<br/><b>기간:</b> "
					+ task.duration + "<br/><b>담당자:</b>" + task.users;
		};

		//읽기 전용
		gantt.config.readonly = true;
		//년,분기,월,주,일 기간설정
		var zoomConfig = {
			levels : [
					{
						name : "day",
						scale_height : 27,
						min_column_width : 80,
						scales : [ {
							unit : "day",
							step : 1,
							format : "%M %d"
						} ]
					},
					{
						name : "week",
						scale_height : 50,
						min_column_width : 50,
						scales : [
								
								{
									unit : "week",
									format : "Week #%W"
								},
								{
									unit : "day",
									step : 1,
									format : "%j %D"
								} ]
					},
					{
						name : "month",
						scale_height : 50,
						min_column_width : 120,
						scales : [ {
							unit : "month",
							format : "%F, %Y"
						}, {
							unit : "week",
							format : "Week #%W"
						} ]
					},
					{
						name : "quarter",
						height : 50,
						min_column_width : 90, 
						scales : [
								{
									unit : "month",
									step : 1,
									format : "%M"
								},
								{
									unit : "quarter",
									step : 1,
									format : function(date) {
										var dateToStr = gantt.date
												.date_to_str("%M");
										var endDate = gantt.date.add(gantt.date
												.add(date, 3, "month"), -1,
												"day");
										return dateToStr(date) + " - "
												+ dateToStr(endDate);
									}
								} ]
					}, {
						name : "year",
						scale_height : 50,
						min_column_width : 30,
						scales : [ {
							unit : "year",
							step : 1,
							format : "%Y"
						} ]
					} ]
		};
		gantt.ext.zoom.init(zoomConfig);
		gantt.ext.zoom.setLevel("month");
		gantt.ext.zoom.attachEvent("onAfterZoom",
				function(level, config) {
					document.querySelector(".gantt_radio[value='" + config.name
							+ "']").checked = true;
				})
		function zoomIn() {
			gantt.ext.zoom.zoomIn();
		}
		function zoomOut() {
			gantt.ext.zoom.zoomOut()
		}
		var radios = document.getElementsByName("scale");
		for (var i = 0; i < radios.length; i++) {
			radios[i].onclick = function(event) {
				gantt.ext.zoom.setLevel(event.target.value);
			};
		}//zoom
		
		gantt.config.columns = [
		    {name:"text",       label:"작업명", width:"*", 	  resize: true,  tree:true},
		    {name:"start_date", label:"시작일", align:"center", resize: true},
		    {name:"duration",   label:"기간",  align:"center" },
		    {name:"users",      label:"담당자", align:"center", width:60 }
		];

		/* 실행 */
		var gdata = [];
		ganttInit();
		function ganttInit(){
			$.getJSON("/todo/getAllTodo", function(data) {
				gantt.init("gantt_here");
				$.each(data.todoList, function(inx, obj) {
					var gdatum = {};
	
					if (obj.todoParentid == null) {
						gdatum = {
							id : parseInt(obj.todoId),
							text : obj.todoTitle,
							users : obj.memName,
							priority : obj.todoImportance,
							start_date : obj.todoStart,
							duration : parseInt(obj.todoEnd),
							progress : obj.todoPercent,
							open : true
						};
					} else {
						gdatum = {
							id : obj.todoId,
							text : obj.todoTitle,
							users : obj.memName,
							priority : obj.todoImportance,
							start_date : obj.todoStart,
							duration : obj.todoEnd,
							progress : obj.todoPercent,
							parent : obj.todoParentid
						};
					}
					gdata.push(gdatum);
				});
				gantt.parse({
					data : gdata
				});
				
			});//json
		}
		$('#stoBtn').on('click',function(){
			//기존 차트 삭제
			gdata = [];
			gantt.clearAll();
			
			var memId =  $("#searchCondition option:selected").val();
			//전체 선택
			if(memId == '0'){
				ganttInit();
			}
			
			$.getJSON("/todo/getSelectTodo?memId="+memId, function(data2) {
				gantt.init("gantt_here");
				$.each(data2.todoList, function(inx, obj) {
					var gdatum = {};

					if (obj.todoParentid == null) {
						gdatum = {
							id : parseInt(obj.todoId),
							text : obj.todoTitle,
							users : obj.memName,
							priority : obj.todoImportance,
							start_date : obj.todoStart,
							duration : parseInt(obj.todoEnd),
							progress : obj.todoPercent,
							open : true
						};
					} else {
						gdatum = {
							id : obj.todoId,
							text : obj.todoTitle,
							users : obj.memName,
							priority : obj.todoImportance,
							start_date : obj.todoStart,
							duration : obj.todoEnd,
							progress : obj.todoPercent,
							parent : obj.todoParentid
						};
					}
					
					gdata.push(gdatum);
				});
				gantt.parse({
					data : gdata
				});
				
			});//json
			
		})
	</script>

</body>
</html>