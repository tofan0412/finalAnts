<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>UploadiFive Test</title>
<script src="/resources/upload/jquery.min.js" type="text/javascript"></script>
<script src="/resources/upload/jquery.uploadifive.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/resources/upload/uploadifive.css">
<style type="text/css">
body {
	font: 13px Arial, Helvetica, Sans-serif;
}
.uploadifive-button {
	float: left;
	margin-right: 10px;
}
#queue {
	border: 1px solid #E5E5E5;
	height: 177px;
	overflow: auto;
	margin-bottom: 10px;
	padding: 0 3px 3px;
	width: 300px;
}
</style>
</head>

<body>
	<h1>UploadiFive Demo</h1>
	<form>

		<div id="queue"></div>
		<input id="file_upload" name="file" type="file" multiple="true"/>
		<input id="submit" type="button" onClick="javascript:$('#file_upload').uploadifive('upload')" value="제출"/>
	</form>

	<script type="text/javascript">
		var timestamp = new Date();
		$(function() {
			$('#file_upload').uploadifive({
				'uploadScript'     : '/file/insertfile',
				'fileObjName'     : 'file',    
				'formData'         : {
									   'categoryId' : "3",
									   'someId'     : '10'
				                     },
				'auto'             : false,
				'queueID'          : 'queue',
				'onUploadComplete' : function(file, data) { 
					
					console.log(data); 
				}
			});
		});
		
	</script>
</body>
</html>