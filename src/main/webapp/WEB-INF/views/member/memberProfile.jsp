<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<style>
body{
	min-width: 1100px;
	min-height: 500px;
}	
.memvar{
	margin-left : 150px;
}	

								/* 알람 토글(on/off) 스타일 */
.switch {
	position: relative;
	display: inline-block;
	width: 60px;
	height: 34px;
	vertical-align:middle;
}

/* Hide default HTML checkbox */
.switch input {
	display:none;
}
/* The slider */
.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	-webkit-transition: .4s;
	transition: .4s;
}	
.slider:before {
	position: absolute;
	content: "";
	height: 26px;
	width: 26px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	-webkit-transition: .4s;
	transition: .4s;
}
input:checked + .slider {
	background-color: #2196F3;
}
input:focus + .slider {
	box-shadow: 0 0 1px #2196F3;
}
input:checked + .slider:before {
	-webkit-transform: translateX(26px);
	-ms-transform: translateX(26px);
	transform: translateX(26px);
}
/* Rounded sliders */
.slider.round {
	border-radius: 34px;
}
.slider.round:before {
	border-radius: 50%;
}							/* 알람 토글(on/off) 스타일 */
</style>

<script>					/*  알람 토글(on/off) 기능     */
function toggle(element){
	
	// 알람 on
	if(element.checked == true){
		document.getElementById('alias').value = 'Y';
		alert('알람ON'); 
	// 알람 off
	}else if(element.checked == false){ 
		document.getElementById('alias').value = 'N';
		alert('알람OFF'); 
	}
	
	// 알람 데이터 전송
	$.ajax({
		type : "GET",
        url : "/member/updateAlarm",
	        data: {  "memId" : $('#memId').val(),
	        		 "memAlert" : $('#alias').val() }, 
        dataType : "text", 
        success : function(data) {
        },    
        error : function(error) {
        }
	}) 
} 	
</script>

<body class="hold-transition sidebar-mini">	
	<div class="wrapperdd" style="margin-left:25%; margin-right:25%;">
		<div class="register-card-body">
			
			<div class="login-logo">
				<b>Profile</b>
			</div>	
					
			<div class="card card-primary card-outline">	
				<div class="card-body box-profile">					
					<div class="text-center">	 	
						<div class="mailbox-attachment-icon has-img" id="pictureView" style="display:inline-block; border: 1px solid white; height:200px; width:140px; margin: 0 auto;">
							<c:if test="${fn:substring(memberVo.memFilepath,0 ,1) eq '/' }">									
								<img id="imge" class="profile-user-img img-fluid img-circle" style="width: 100%; height: 100%;  border-radius: 70%;" src="${memberVo.memFilepath}" /><br>
							</c:if>
							<c:if test="${fn:substring(memberVo.memFilepath,0 ,2) eq 'D:' }">		
								<img id="pict" style="width: 100%; height: 100%;  border-radius: 70%;" src="/profileImgView?memId=${memberVo.memId}" />
							</c:if>
						</div>
					</div>		
											
					<h3 class="profile-username text-center">
						<input class="profile-username text-center" name="memName" type="text" class="form-control" id="memName" placeholder="(이름)" value="${memberVo.memName}" style="border: none" readonly />
					</h3>
						
					<p class="text-muted text-center">
						<input class="text-muted text-center" name="memId" type="text" class="form-control" id="memId" placeholder="(아이디)" value="${memberVo.memId}" style="border: none" readonly>
					</p>
						
					<ul class="list-group list-group-unbordered mb-3"> 
						<li class="list-group-item"><b>전화번호</b>  	
							<a class="float-right">
								<input name="memTel" type="text" id="usernm" placeholder="(전화번호)" value="${memberVo.memTel}" style="border:none; width:105px;" readonly />
							</a>	
						</li>
						<li class="list-group-item"><b>알람</b> 
							<a class="float-right">
								<input name="memAlert" type="text" id="alias" placeholder="(알람)" value="${memberVo.memAlert}" style="border:none; width:40px;" readonly>
								<c:if test="${memberVo.memId == SMEMBER.memId }">
									<!-- 알람 토글 버튼 -->	
									<label class="switch">											<!-- 알람 토글 기본 y : y아닐땐 off -->
										<input id="tog" type="checkbox" onclick="toggle(this)" value="Y" ${memberVo.memAlert == "Y" ? "CHECKED" : ""}/>	
										<span class="slider round"></span>	
									</label>
								</c:if>
							</a>
						</li>			
						<li class="list-group-item"><b>타입</b>
							<a class="float-right">
								<input name="memType" type="text" id="addr1" placeholder="(타입)" value="${memberVo.memType}" style="text-align:right; padding-right:20px; border:none; width:105px;" readonly>
							</a>
						</li>
					</ul>
					
				</div>
			</div>
			
		<c:if test="${memberVo.memId == SMEMBER.memId }">
			<div class="card-footer">
				<div class="row">
					<div class="col-sm-6">
						<a href="/member/profileupdateview?memId=${memberVo.memId}">
							<button type="button" id="registBtn" class="btn btn-info">수정</button>
						</a>
					</div>
				</div>
			</div>
		</c:if>
				
			<!-- style="display: none" -->
			<div class="content" style="display: none">
				<br>비밀번호 : <input name="memPass" type="text" id="memPass" placeholder="비밀번호" value="${memberVo.memPass}" style="border: none" readonly><br> 
				삭제여부: <input name="del" type="text" id="del" placeholder="삭제여부" value="${memberVo.del}" style="border: none" readonly><br>
				${memberVo.memFilepath} <br>
				${memberVo.memFilename}
				<c:if test="${fn:substring(memberVo.memFilepath,0 ,1) eq '/' }">									
					<img id="imge" style="width: 30px; height: 30px;  border-radius: 70%;" src="${memberVo.memFilepath}" /><br>
				</c:if>
				<c:if test="${fn:substring(memberVo.memFilepath,0 ,2) eq 'D:' }">		
					<img id="pict" style="width: 30px; height: 30px;  border-radius: 70%;" src="/profileImgView?memId=${memberVo.memId}" />
				</c:if>
				<span id="sp">sp : </span>
			</div>
				
		</div>
	</div>
</body>
