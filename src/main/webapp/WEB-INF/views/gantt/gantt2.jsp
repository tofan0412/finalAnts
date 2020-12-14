<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="/gantt/codebase/dhtmlxgantt.js"></script>
	<link href="/gantt/codebase/dhtmlxgantt.css" rel="stylesheet">
</head>
<body>
	<div id="gantt_here" style='width:1000px; height:400px;'></div>
    	
    	
    	
  <script type="text/javascript">
      gantt.init("gantt_here");
      
      $.getJSON("/todo/getAllTodo", function(data){
    	  	gdata = [];
    		$.each(data, function(inx, obj){
    			gdata.push{id : obj.todoId, text:obj.todoTitle};
    		});

    
    		
    	});
      
 
  </script>

</body>
</html>