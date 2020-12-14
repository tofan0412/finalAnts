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
		<input id="file_upload" name="file_upload" type="file" multiple="true"/>
		<input id="submit" type="button" onClick="javascript:$('#file_upload').uploadifive('upload')" value="제출"/>
	</form>

	<script type="text/javascript">
		var timestamp = new Date();
		$(function() {
			$('#file_upload').uploadifive({
				'auto'             : true,
                'uploadScript'     : '/file/insertfile',
				'formData'         : {
									   'categoryId' : "3",
									   'someId'     : '10'
				                     },
				'fileObjName'     : 'file',   
				'queueID'          : 'queue',
                "fileType": '.gif, .jpg, .png, .jpeg, .bmp, .doc, .ppt, .xls, .xlsx, .docx, .pptx, .zip, .rar, .pdf',
              
                "multi": true,
                "height": 20,
                "width": 100,
                "fileSizeLimit": "20MB",
                "uploadLimit": 10,
                "buttonText": "파일찾기",
                'removeCompleted' : true,
				'onUploadComplete' : function(file, data) {
					var obj = JSON.parse(data);
					console.log(data);
				},
				onCancel : function(file) {
					alert(file.name + " 취소되었습니다.");
				},
				onFallback : function() {
					alert("该浏览器无法使用!");
				},
				onUpload : function(file) {
					//document.getElementById("submit").disabled = true;//当开始上传文件，要防止上传未完成而表单被提交
				},
			});
			
			$('#file_upload').uploadifive({
				'uploadScript'     : '/file/insertfile',
				'formData'         : {
									   'categoryId' : "3",
									   'someId'     : '10'
				                     },
				'auto'             : false,
				'queueID'          : 'queue',
				'uploadScript'     : 'uploadifive.php',
				'onUploadComplete' : function(file, data) { console.log(data); }
			});
		});
	</script>
</body>
</html>