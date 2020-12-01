<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
	#butt{
	}
	.ghgh{
		width:100%;
	}
	.card{
		padding-top: 8%;
		padding-bottom: 6%;
	}
	.content{
		margin-left:43%;
	}
	.input{ 
		width: 330px;
		height : 50px;
		border-radius: 80px
	}
</style>	
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
</script>
</head>


<title>회원 등록</title>
<body>
	<div class="card">
		
			<form id="fmin" role="form" class="form-horizontal" action="/member/memberRegist" method="POST" enctype="multipart/form-data">
			<!-- action="/member/memberRegist" method="POST" enctype="multipart/form-data -->
				<div id="pictureView" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;">
					<img id="pictureViewImg" style="width: 100%; height: 100%;" />
				</div>
				
				<div class="content">
					<input id="picture" type="file" name="realFilename" accept=".gif, .jpg, .png" style="height: 37px;" />
				</div>
				
				<div class="content"> 
					<label for="id" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>아이디
					</label>
					<div id="idcheck">
						<input class="input" name="memId" type="text" id="memId" placeholder="    회원 id"/>
						<button type="submit" id="checkbtn" class="btn btn-default">중복확인</button>
						<div class="check_font" id="checkMsg"></div>
					</div>
				</div>
				
				<div class="content">
					<label for="name" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>이 름
					</label>
					<div>
						<input class="input" name="memName" type="text" id="memName" placeholder="    이름"/>
					</div>
				</div>

				<div class="content">
					<label for="pwd" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>패스워드
					</label>
					<div>
						<input class="input" name="memPass" type="password" id="memPass" placeholder="       비밀번호"/>
					</div>
				</div>

				<div class="content">
						&nbsp;&nbsp;&nbsp;&nbsp;<label for="alias" style="font-size: 0.9em;">전화번호</label>
					<div>
						<input class="input" name="memTel" type="text" id="memTel" placeholder="       전화번호"/>
					</div>
				</div>

				<div class="content" style="display: none">
					<br>알람 : <input  name="memAlert" type="text" id="memAlert" placeholder="알람"><br> 
					삭제여부: <input class="form-control" name="del" type="text" id="del" placeholder="삭제여부"><br> 
					멤버구분 : <input class="form-control" name="memType" type="text" id="memType" placeholder="멤버구분"><br>
				</div>
				
				<div id="row1">
					<br><br><br>
					<div class="content" id="butt">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="registBtn" class="btn btn-info" disabled="disabled">등록</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="cancelBtn" onclick="window.history.back()">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp; 소 &nbsp;&nbsp;&nbsp;</button>
					</div>
				</div>
			</form>
	</div>
</body>

<script type="text/javascript">
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
		
		$(document).ready(function() {
			$("#registBtn").on('click', function() {
				var memId = document.getElementById('memId');
				var memName = document.getElementById('memName');
				var memPass = document.getElementById('memPass');
				
				
				if (memId.value == "" || memName.value == "" || memPass.value == "") {
					alert("필수입력 사항을 입력해주세요")
				} else {
					$('#fmin').submit();
				}
		         
			})
		})
		
		
		$(document).ready(function(){ 
			$('#checkbtn').on('click', function(){ 
				$.ajax({ type: 'POST', 
					url: '/member/checkSignup', 
					dataType : 'json',
					data: { "memId" : $('#memId').val() }, 
					success: function(data){
						if($.trim(data) == 0){ 
							$('#checkMsg').html('<p style="color:blue">사용가능</p>'); 
							btn = document.getElementById('registBtn')
							btn.disabled = false;
						}else{ 
							$('#checkMsg').html('<p style="color:red">사용불가능</p>'); 
						} 
					}
				}); //end ajax 
				return false;
			}); //end on 
		}); 
		
</script>
	



</html>