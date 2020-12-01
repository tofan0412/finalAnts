<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
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
 			
 			$('#memAlert').val("y");
 			$('#del').val("n");
 			$('#memType').val("mem");
		})
		
				
		
		$(document).ready(function(){
			$("#registBtn").on('click', function(){
				var userid = document.getElementById('memId');
				var usernm = document.getElementById('memName');
				var pass = document.getElementById('memPass');

				
					if(userid.value == "" || usernm.value == "" || pass.value == ""){
						alert("필수입력 사항을 입력해주세요")
					}else{
						$('#fmin').submit();
					}	
			})
		}) 
	</script>

<style>

	#butt{
	}
	.ghgh{
		width:100%;
	}
	.card{
		padding-top: 15%;
		padding-bottom: 15%;
	}
	#content{
		margin-left:41%;
	}
	.input{
		width: 330px;
		height : 50px;
		border-radius: 80px
	}
	
</style>
		
</head>


<title>회원 등록</title>

<body>

	<!-- form start -->
	<div class="card">
		<div>
			<form id="fmin" role="form" class="form-horizontal"
				action="/member/memberRegist" method="POST"
				enctype="multipart/form-data">

				<div>
					<div id="pictureView" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;">
						<img id="pictureViewImg" style="width: 100%; height: 100%;" />
					</div>
				</div>


			<div id="content">
					<div id="butt1">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input id="picture" type="file" name="realFilename" accept=".gif, .jpg, .png" style="height: 37px;" />
					</div>
				<div>
					<label for="id" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>아이디
					</label>
					<div>
						<input class="input" name="memId" type="text" id="memId" placeholder="    회원 id" value="">
					</div>
				</div>

				<div>
					<label for="name" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>이 름
					</label>
					<div>
						<input class="input" name="memName" type="text" id="memName" placeholder="    이름" />
					</div>

				</div>

				<div>
					<label for="pwd" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>패스워드
					</label>
					<div>
						<input class="input" name="memPass" type="password" id="memPass" placeholder="       비밀번호" />
					</div>
				</div>

				<div>
					&nbsp;&nbsp;&nbsp;&nbsp;<label for="alias" style="font-size: 0.9em;">전화번호</label>
					<div>
						<input class="input" name="memTel" type="text" id="memTel" placeholder="       전화번호">
					</div>
				</div>

				<div style="display: none">
					<br>알람 : <input  name="memAlert" type="text" id="memAlert" placeholder="알람"><br> 
					삭제여부: <input class="form-control" name="del" type="text" id="del" placeholder="삭제여부"><br> 
					멤버구분 : <input class="form-control" name="memType" type="text" id="memType" placeholder="멤버구분"><br>
				</div>
				<div id="row1">

					<br><br><br>
					
					<div id="butt">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="registBtn" class="btn btn-info">등록</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="cancelBtn"
							onclick="window.history.back()">&nbsp;&nbsp;&nbsp;취
							&nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
					</div>

				</div>
			</div>
				
				
			</form>
		</div>
		<!-- register-card-body -->
	</div>


</body>
	<script>
		$(document).ready(function() {

			// picture input의 파일 변경시 이벤트 
			$("#picture").change(function() {
				readURL(this);
			});
		});

		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
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

		$(document).ready(
				function() {
					$("#registBtn")
							.on(
									'click',
									function() {
										var userid = document
												.getElementById('memId');
										var usernm = document
												.getElementById('memName');
										var pass = document
												.getElementById('memPass');

										if (userid.value == ""
												|| usernm.value == ""
												|| pass.value == "") {
											alert("필수입력 사항을 입력해주세요")
										} else {
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

		$(document).ready(function() {
			$('#zipcodeBtn').on('click', function() {
				new daum.Postcode({
					oncomplete : function(data) {
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
</html>







