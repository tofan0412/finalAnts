<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="/gantt/codebase/dhtmlxgantt.js"></script>
	<link href="/gantt/codebase/dhtmlxgantt.css" rel="stylesheet">
</head>
<body>
	<div id="gantt_here" style='width:1400px; height:1000px;'></div>
    	
    	
    	
  <script type="text/javascript">
      gantt.init("gantt_here");
      
      $.getJSON("/todo/getAllTodo", function(data){
    	  	var gdata = [];
    		$.each(data.todoList, function(inx, obj){
    			var gdatum = {};
    				
    			if(obj.todoParentid == null){
	    			gdatum = {id:parseInt(obj.todoId), text:obj.todoTitle , start_date:obj.todoStart , duration:parseInt(obj.todoEnd),
	    					  progress:obj.todoPercent, open:true};
    			}else{
	    			gdatum = {id:obj.todoId, text:obj.todoTitle , start_date:obj.todoStart , duration:obj.todoEnd,
	    					  progress:obj.todoPercent, parent:obj.todoParentid};
    			}
    			gdata.push(gdatum);
    		});
    		gantt.parse({
    			data : gdata
    		});
    		
    		

    
    		
    	});
      
 
  </script>

</body>
</html>