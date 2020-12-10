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
	    min-width: 1100px;
	    min-height: 1100px;
	}
	span{
		margin-left : 150px;
	}
	
</style>
<script>
$(document).ready(function(){
	
								/* 기본이미지/사진 선택 해서 보여주기 */
	
	
	pict = document.getElementById('pict').src	// display none 에 숨어있는 사진의 src속성값 가져옴
												// src="/profileImgView?memId=${memberVo.memId}" 
	imge = document.getElementById('imge').src	// display none 에 숨어있는 기본이미지의 src속성값 가져옴
												// src="${memberVo.memFilepath}"
	
												
	picval = pict.split('/')[0].indexOf('profileImgView') // 아이디 값으로 memFilepath의 속성을 가져오기 때문에 항상
								// 값이 동일하다 -> http://localhost/profileImgView?memId=noylit@naver.com
								// 값이 동일하기 때문에 비교대상에 필요 없음 x
	imgval= imge.split('/')[0].indexOf('http')	
	// 파일가져올때 -> file:///D:/upload/james.png	// 기본이미지    -> https://localhost/profile/user-16.png
	// memFilepath 의 속성값을 바로 가져오기 때문에 웹에 저장된 기본이미지를 불러오는지
	//								     로컬에 저장된 파일을 가져오는지 경로로 확인이 가능하다. 
	
	
	$('#sp').append(' pict : ' + picval + '//' + pict);	// 경로 확인하려고 (숨김항목)
	$('#sp').append(' imge : ' + imgval + '//' + imge); // 경로 확인하려고 (숨김항목)
	
	
	if(imgval == -1){		// imgval(memFilepath) 의 값이 http(웹사이트)에서 가져온것이 아니면(file) -1
		$('#pictureViewImg').attr('src', pict);
	}else if(imgval == 0){	// imgval(memFilepath) 의 값이 http(웹사이트)에서 가져온 거면(img) 0 -> 웹사이트는 기본이미지
		$('#pictureViewImg').attr('src', imge);
	}
	
	
})
</script>
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapperdd">
		<div class="login-logo">
			<b>프로필</b>
		</div>	
		<!-- form start -->
		<div class="card">
			<div class="register-card-body">

				<br><br><br><br><br>
					<div class="input-group mb-3">
						<div class="mailbox-attachments clearfix"
							style="text-align: center; width: 100%;">
							<div class="mailbox-attachment-icon has-img" id="pictureView"
								style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;">
								<img id="pictureViewImg" style="width: 100%; height: 100%;"/>
							</div>
						</div>
						<br>
					</div>
	
					
					<div class="form-group row">
						<label for="id" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;">*</span>아이디
						</label>
						<div class="col-sm-6 input-group-sm">
							<input class="form-control" name="memId" type="text" class="form-control" id="memId" placeholder="(아이디)" value="${memberVo.memId}" style="border: none" readonly>
						</div>
					</div>

					<div class="form-group row">
						<label for="pwd" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;">*</span>이름
						</label>
						<div class="col-sm-6 input-group-sm">
							<input class="form-control" name="memName" type="text" class="form-control" id="memName" placeholder="(이름)" value="${memberVo.memName}" style="border: none" readonly />
						</div>
					</div>

					<div class="form-group row">
						<label for="name" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;">*</span>전화번호
						</label>
						<div class="col-sm-6 input-group-sm">
							<input class="form-control" name="usernm" type="text" id="usernm" placeholder="(전화번호)" value="${memberVo.memTel}" style="border: none" readonly />
						</div>
					</div>

					<div class="form-group row">
						<label for="alias" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;"></span>알람
						</label>
						<div class="col-sm-6 input-group-sm">
							<input class="form-control" name="alias" type="text" id="alias" placeholder="(알람)" value="${memberVo.memAlert}" style="border: none" readonly>
						</div>
					</div>

					<div class="form-group row">
						<label for="alias" class="col-sm-3" style="font-size: 0.9em;">
							<span style="color: red; font-weight: bold;"></span>타입
						</label>
						<div class="col-sm-6 input-group-sm">
							<input name="addr1" type="text" class="form-control" id="addr1" placeholder="(타입)" value="${memberVo.memType}" style="border: none" readonly>
						</div>
					</div>
					
					<!-- style="display: none" -->
					<div class="content" <%--style="display: none" --%> >
						<br>비밀번호 : <input name="memPass" type="text" id="memPass" placeholder="알람" value="${memberVo.memPass}" style="border: none" readonly><br> 
						
						삭제여부: <input name="del" type="text" id="del" placeholder="삭제여부" value="${memberVo.del}" style="border: none" readonly><br>
						
						${memberVo.memFilepath} <br>
						${memberVo.memFilename}
						<img id="pict" style="width: 30px; height: 30px;" src="/profileImgView?memId=${memberVo.memId}" />
						<img id="imge" style="width: 30px; height: 30px;" src="${memberVo.memFilepath}" /><br>
						<span id="sp">sp : </span>
					</div>
					
					<br><br><br><br> 
					<div class="card-footer">
						<div class="row">
							<div class="col-sm-6">
								<a href="/member/profileupdateview"><button type="button" id="registBtn" class="btn btn-info">수정</button></a>
							</div>

							<div class="col-sm-6">
								<button type="button" id="cancelBtn"
									onclick="window.history.back()"
									class="btn btn-default float-right">&nbsp;뒤&nbsp;&nbsp;로&nbsp;&nbsp;가&nbsp;&nbsp;기&nbsp;</button>
							</div>
							
						</div>
					</div>
			</div>
		</div>
	</div>

</body>
</html>