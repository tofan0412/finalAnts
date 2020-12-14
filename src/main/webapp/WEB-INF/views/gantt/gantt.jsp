<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gantt chart</title>
  <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE"/>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

  <link rel=stylesheet href="/gantt/platform.css" type="text/css">
  <link rel=stylesheet href="/gantt/libs/jquery/dateField/jquery.dateField.css" type="text/css">

  <link rel=stylesheet href="/gantt/gantt.css" type="text/css">
  <link rel=stylesheet href="/gantt/ganttPrint.css" type="text/css" media="print">
  <link rel=stylesheet href="/gantt/libs/jquery/valueSlider/mb.slider.css" type="text/css" media="print">
  

  <script src="/gantt/libs/jquery/jquery.livequery.1.1.1.min.js"></script>
  <script src="/gantt/libs/jquery/jquery.timers.js"></script>

  <script src="/gantt/libs/utilities.js"></script>
  <script src="/gantt/libs/forms.js"></script>
  <script src="/gantt/libs/date.js"></script>
  <script src="/gantt/libs/dialogs.js"></script>
  <script src="/gantt/libs/layout.js"></script>
  <script src="/gantt/libs/i18nJs.js"></script>
  <script src="/gantt/libs/jquery/dateField/jquery.dateField.js"></script>
  <script src="/gantt/libs/jquery/JST/jquery.JST.js"></script>
  <script src="/gantt/libs/jquery/valueSlider/jquery.mb.slider.js"></script>

  <script type="text/javascript" src="/gantt/libs/jquery/svg/jquery.svg.min.js"></script>
  <script type="text/javascript" src="/gantt/libs/jquery/svg/jquery.svgdom.1.8.js"></script>

  <script src="/gantt/ganttUtilities.js"></script>
  <script src="/gantt/ganttTask.js"></script>
  <script src="/gantt/ganttDrawerSVG.js"></script>
  <script src="/gantt/ganttZoom.js"></script>
  <script src="/gantt/ganttGridEditor.js"></script>
  <script src="/gantt/ganttMaster.js"></script>  
  
  <script>
  	$(function(){
  		
	  var ge = new GanttMaster();
	  ge.init($("#workSpace"));
  	})

  </script>

</head>

<body>

	<div id="workSpace" style="padding:0px; overflow-y:auto; overflow-x:hidden;border:1px solid #e5e5e5;position:relative;margin:0 5px" class="TWGanttWorkSpace">
		
	</div>


</body>
</html>