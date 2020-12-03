<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세 보기</title>

<!-- Font Awesome Icons -->
<!-- Theme style -->
<style>
	body{
	    min-width: 1000px;
	    min-height: 1000px;
	}
	span{
		margin-left : 150px;
	}
	
</style>
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapperdd">
		<div class="login-logo">
			<b>상세 보기</b>
		</div>
		<!-- form start -->
		<div class="card">
			<div class="register-card-body">

				<br><br><br><br><br>
				<form role="form" class="form-horizontal" action="/memberUpdate/process" method="POST" enctype="multipart/form-data">
					<div class="input-group mb-3">
						<div class="mailbox-attachments clearfix"
							style="text-align: center; width: 100%;">
							<div class="mailbox-attachment-icon has-img" id="pictureView"
								style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;">
								<img style="width: 100%; height: 100%;" src="${memberVo.memFilepath}" />
							</div>
						</div>
						<br>
					</div>
	
	
					<div class="form-group row">
						<label for="id" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;">*</span>아이디
						</label>
						<div class="col-sm-9 input-group-sm">
							<input class="form-control" name="memId" type="text" class="form-control" id="memId" placeholder="(아이디)" value="${memberVo.memId}" style="border: none" readonly>
						</div>
					</div>

					<div class="form-group row">
						<label for="pwd" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;">*</span>이름
						</label>
						<div class="col-sm-9 input-group-sm">
							<input class="form-control" name="memName" type="text" class="form-control" id="memName" placeholder="(이름)" value="${memberVo.memName}" style="border: none" readonly />
						</div>
					</div>

					<div class="form-group row">
						<label for="name" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;">*</span>전화번호
						</label>
						<div class="col-sm-9 input-group-sm">
							<input class="form-control" name="usernm" type="text" id="usernm" placeholder="(전화번호)" value="${memberVo.memTel}" style="border: none" readonly />
						</div>
					</div>

					<div class="form-group row">
						<label for="alias" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;"></span>알람
						</label>
						<div class="col-sm-9 input-group-sm">
							<input class="form-control" name="alias" type="text" id="alias" placeholder="(알람)" value="${memberVo.memAlert}" style="border: none" readonly>
						</div>
					</div>

					<div class="form-group row">
						<label for="alias" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;"></span>타입
						</label>
						<div class="col-sm-3 input-group-sm">
							<input name="addr1" type="text" class="form-control" id="addr1" placeholder="(타입)" value="${memberVo.memType}" style="border: none" readonly>
						</div>
					</div>
					
					<!-- style="display: none" -->
					<div class="content">
						<br>비밀번호 : <input name="memPass" type="text" id="memPass" placeholder="알람" value="${memberVo.memPass}" style="border: none" readonly><br> 
						삭제여부: <input name="del" type="text" id="del" placeholder="삭제여부" value="${memberVo.del}" style="border: none" readonly><br>
						${memberVo.memFilepath} <br>
						${memberVo.memFilename}
					</div>

					<div class="card-footer">
						<div class="row">
							<div class="col-sm-6">
								<a href="/memberUpdate/view?userid=${memberVo.memId}"><button
										type="button" id="registBtn" class="btn btn-info">수정</button></a>
							</div>

							<div class="col-sm-6">
								<button type="button" id="cancelBtn"
									onclick="window.history.back()"
									class="btn btn-default float-right">&nbsp;뒤&nbsp;&nbsp;로&nbsp;&nbsp;가&nbsp;&nbsp;기&nbsp;</button>
							</div>
							<br><br><br><br><br>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>