<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<label>No.</label> <input id="scheId" name="scheId" value="${privateVo.privId}" style="border:none;" readonly> <br>
	<label>파일경로</label> <input id="scheId" name="scheId" value="${privateVo.privFilepath}" style="border:none;" readonly> <br>
	<label>파일이름</label> <input id="scheId" name="scheId" value="${privateVo.privFilename}" style="border:none;" readonly> <br>
	<label>수정한 날짜</label> <input id="scheId" name="scheId" value="${privateVo.regDt}" style="border:none;" readonly> <br>
	<label>파일사이즈</label> <input id="scheId" name="scheId" value="${privateVo.privSize}" style="border:none;" readonly> <br>
	<label>작성자</label> <input id="scheId" name="scheId" value="${privateVo.memId}" style="border:none;" readonly> <br>
</body>
</html>