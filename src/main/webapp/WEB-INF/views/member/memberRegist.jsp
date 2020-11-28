<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap/dist/css/adminlte.min.css"><!-- 로그인 화면 페이지 레이아웃 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


	<script>
		$(document).ready(function(){


 			/* 
 			$('#mem_id').val("hsj2@thousandOfAnts.com");
 			$('#mem_name').val("한상진");
 			$('#mem_pass').val("123");
 			$('#mem_tel').val("010-1111-2222");
 			 */
 			
 			$('#mem_alert').val("y");
 			$('#del').val("n");
 			$('#mem_type').val("mem");
		})
		
				
		
		$(document).ready(function(){
			$("#registBtn").on('click', function(){
				var userid = document.getElementById('mem_id');
				var usernm = document.getElementById('mem_name');
				var pass = document.getElementById('mem_pass');

				
					if(userid.value == "" || usernm.value == "" || pass.value == ""){
						alert("필수입력 사항을 입력해주세요")
					}else{
						$('#fmin').submit();
					}	
			})
		}) 
	</script>

 	<style>
		.col-sm-3{
			width:100px;
		}
		.form-control{
			height: 100px;
		}
	#butt{
		padding-left:80%;
	}
	.ghgh{
		width:100%;
	}
	#butt1{
		padding-left:50%
	}
	
	</style>
		
</head>


<title>회원 등록</title>

<body class="hold-transition sidebar-mini">

						<!-- form start -->
						<div class="card">
							<div class="register-card-body">
							
								
								<form id="fmin" role="form" class="form-horizontal" action="/member/memberRegist" method="POST" enctype="multipart/form-data">
									
									<div>
										<div class="mailbox-attachment-icon has-img" id="pictureView" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;">
											<img id="pictureViewImg" style="width:100%; height:100%;"/>
										</div>
										
										<div id="butt1">
											<input id="picture"  type="file" name="realFilename" accept=".gif, .jpg, .png" style="height:37px;"/>
										</div>
									</div>
									
									
									
									
									
										 
									<div class="form-group row">
										<label for="id" class="col-sm-3" style="font-size: 0.9em;">
											<span style="color: red; font-weight: bold;">*</span>아이디
										</label>
										<div class="col-sm-9 input-group-sm">
											<input name="mem_id" type="text" class="form-control" id="mem_id" placeholder="회원 id" value="">
										</div>
									</div>
									
									<div class="form-group row">
										<label for="name" class="col-sm-3" style="font-size: 0.9em;">
											<span style="color: red; font-weight: bold;">*</span>이 름
										</label>
										<div class="col-sm-9 input-group-sm">
											<input class="form-control" name="mem_name" type="text" id="mem_name" placeholder="이름" />
										</div>

									</div>
									
									<div class="form-group row">
										<label for="pwd" class="col-sm-3" style="font-size: 0.9em;">
											<span style="color: red; font-weight: bold;">*</span>패스워드</label>
										<div class="col-sm-9 input-group-sm">
											<input class="form-control" name="mem_pass" type="password" class="form-control" id="mem_pass" placeholder="비밀번호" />
										</div>
									</div>
									
									<div class="form-group row">
										<label for="alias" class="col-sm-3" style="font-size: 0.9em;">전화번호</label>
										<div class="col-sm-9 input-group-sm">
											<input class="form-control" name="mem_tel" type="text" id="mem_tel" placeholder="전화번호">
										</div>
									</div>
				
				
				
									<div class="form-group row" style="display: none">
										<br>알람 : <input class="form-control" name="mem_alert" type="text" id="mem_alert" placeholder="알람"><br>
											삭제여부 : <input class="form-control" name="del" type="text" id="del" placeholder="삭제여부"><br>
											멤버구분 : <input class="form-control" name="mem_type" type="text" id="mem_type" placeholder="멤버구분"><br>
									</div>
						
						
						
						
										<div id="row1">
										
										
											<div id="butt">
												<button type="button" id="registBtn" class="btn btn-info">등록</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<button type="button" id="cancelBtn" onclick="window.history.back()" >&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
											</div>


										</div> 
								</form>
							</div>
							<!-- register-card-body -->
						</div>


	<script>
		$(document).ready(function(){
			
			// picture input의 파일 변경시 이벤트 
			$("#picture").change(function(){
			   readURL(this);
			});
		});
		
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
			  
				reader.onload = function (e) {
					$('#pictureViewImg').attr('src', e.target.result);  
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		
 	/* 	$(document).ready(function(){
 			$('#userid').val("hsj3");
 			$('#usernm').val("한상진");
 			$('#pass').val("123");
 			$('#alias').val("테스트용");
 			$('#addr1').val("대전시 대덕구 송촌동");
 			$('#addr2').val("483-15번지");
 			$('#zipcode').val("33443");
		})  */
		
		
		$(document).ready(function(){
			$("#registBtn").on('click', function(){
				var userid = document.getElementById('userid');
				var usernm = document.getElementById('usernm');
				var pass = document.getElementById('pass');

				
					if(userid.value == "" || usernm.value == "" || pass.value == ""){
						alert("필수입력 사항을 입력해주세요")
					}else{
						$('#fmin').submit();
					}	
						
			/* if(userid.value != null){ */
					/*  alert(userid.value) */
					/* alert("${sessionScope.memlist.get(0).getUserid()}") }*/
					/* 
				 	  for(var i=0; i<${memlist.size()}; i++){
					 	  	
							if( userid.value == hsj ){
								alert("중복된 아이디가 있습니다", userid.value)
							} 
				 	  } */
				})
			}) 
			
		
		$(document).ready(function(){
			$('#zipcodeBtn').on('click', function(){
			    new daum.Postcode({
			        oncomplete: function(data) {
				        console.log(data)
				        
				        $('#addr1').val(data.roadAddress);
				        $('#zipcode').val(data.zonecode);
			            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
			            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
			        }	
			    }).open();
			})
		
		})
		
	</script>
	
	<!-- 	userid, usernm, pass, alias, addr1, addr2, zipcode, filename, realfilename
	
	 
	-->
</body>
</html>







