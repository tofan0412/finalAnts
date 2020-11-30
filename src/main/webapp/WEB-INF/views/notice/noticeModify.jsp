<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>noticeModify.jsp</title>
<script type="text/javascript">
// 	$(document).ready(function() {
// 		var formObj = $("form[role='form']");
// 		console.log(formObj);
		
// 		$(".modBtn").on("click", function() {
// 			formObj.submit();
// 		});
		
// 		$(".cancelBtn").on("click", function() {
// 			history.go(-1);
// 		)};
		
// 		$(".listBtn").on("click", function() {
// 			self.location = "/notice/noticeList";
// 		)};
// 	})
</script>


</head>
<body>
	수정
	<div class="col-lg-12">
	<form role="form" id="writeForm" method="post" action="${pageContext.request.contextPath }notice/noticeModify">
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3>게시글 수정</h3>
			</div>
			<div class="box-body">
				<input type="hidden" name="noticeId" value="${notice.noticeId }">
				<div class="form-group">
					<label for="title">제목</label>
					<input class="form-control" id="title" name="title" placeholder="제목을 입력하세요" value="${notice.noticeTitle }">
				</div>
				<div class="form-group">
					<label for="content">내용</label>
					<textarea class="form-control" id="content" name="content" rows="30"
							placeholder="내용을 입력하세요" style="resize: none;">${notice.noticeCont }</textarea>
				</div>
				<div class="form-group">
					<label for="writer">작성자</label>
					<input class="form-control" id="writer" name="writer" value="${notice.adminId }" readonly>
				</div>
			</div>
			<div class="box-footer">
				<button type="button" class="btn btn-primary"><i class="fa fa-list"></i>목록</button>
				<div class="pull-right">
					<button type="button" class="btn btn-warning cancelBtn"><i class="fa fa-trash"></i>취소</button>
					<button type="submit" class="btn btn-success modBtn"><i class="fa fa-save"></i>수정 저장</button>
				</div>
			</div>
		</div>
	</form>
</div>
</body>
</html>