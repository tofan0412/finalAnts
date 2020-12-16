<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/gantt/codebase/dhtmlxgantt.js"></script>
<link href="/gantt/codebase/dhtmlxgantt.css" rel="stylesheet">
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
</style>
</head>
<body>
	<div id="gantt_here" style='width: 100%; height: 800px;'></div>



	<script type="text/javascript">
		/* gantt 설정  */
		//열 맞춤
		gantt.config.autofit = true;
		gantt.config.grid_width = 500;
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

		gantt.templates.task_class = function (st, end, item) {
			return item.$level == 0 ? "gantt_project" : ""
		};
		//클릭하면 설명보이기
		gantt.plugins({
			quick_info: true
		});
		
		//그리드 조정가능
			gantt.config.columns = [
		{name: "text", tree: true, width: "*", min_width: 120, resize: true},
		{name: "start_date", align: "center", resize: true},
		{name: "duration", align: "center", width: 70, resize: true},
		{name: "add", width: 44}
	];

	// keeps or not the width of the grid area when column is resized
	gantt.config.keep_grid_width = false;
	gantt.config.grid_resize = true;

	// return false to discard the resize
	gantt.attachEvent("onColumnResizeStart", function (index, column) {
		gantt.message("Start resizing <b>" + gantt.locale.labels["column_" + column.name] + "</b>");
		return true;
	});

	var message = null;
	gantt.attachEvent("onColumnResize", function (index, column, new_width) {
		if (!message) {
			message = gantt.message({
				expire: -1,
				text: "<b>" + gantt.locale.labels["column_" + column.name] + "</b> is now <b id='width_placeholder'></b><b>px</b> width"
			});
		}
		document.getElementById("width_placeholder").innerText = new_width
	});

	// return false to discard the resize
	gantt.attachEvent("onColumnResizeEnd", function (index, column, new_width) {
		gantt.message.hide(message);
		message = null;
		gantt.message("Column <b>" + gantt.locale.labels["column_" + column.name] + "</b> is now " + new_width + "px width");
		return true;
	});

	// GRID resize events

	// return false to discard the resize
	gantt.attachEvent("onGridResizeStart", function (old_width) {
		gantt.message("Start grid resizing");
		return true;
	});

	gantt.attachEvent("onGridResize", function (old_width, new_width) {
		if (!message) {
			message = gantt.message({
				expire: -1,
				text: "Grid is now <b id='width_placeholder'></b><b>px</b> width"
			});
		}
		document.getElementById("width_placeholder").innerText = new_width;
	});

	// return false to discard the resize
	gantt.attachEvent("onGridResizeEnd", function (old_width, new_width) {
		gantt.message.hide(message);
		message = null;
		gantt.message("Grid is now <b>" + new_width + "</b>px width");
		return true;
	});


		/* 실행 */
		gantt.init("gantt_here");
		$.getJSON("/todo/getAllTodo", function(data) {
			var gdata = [];
			$.each(data.todoList, function(inx, obj) {
				var gdatum = {};

				if (obj.todoParentid == null) {
					gdatum = {
						id : parseInt(obj.todoId),
						text : obj.todoTitle,
						start_date : obj.todoStart,
						duration : parseInt(obj.todoEnd),
						progress : obj.todoPercent,
						open : true
					};
				} else {
					gdatum = {
						id : obj.todoId,
						text : obj.todoTitle,
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
		gantt.showLightbox(1);
	</script>

</body>
</html>