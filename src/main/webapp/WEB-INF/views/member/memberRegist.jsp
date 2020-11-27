<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


	<script>
		$(document).ready(function(){


 	
 			$('#mem_id').val("hsj");
 			$('#mem_name').val("한상진");
 			$('#mem_pass').val("123");
 			$('#mem_tel').val("010-1111-2222");
 			$('#mem_alert').val("1");
 			$('#del').val("1");
 			$('#mem_type').val("1");
	
		
		
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
		})
	</script>


<title>회원 등록</title>


</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<div id="if_list_div" style="position: relative; padding: 0; overflow: hidden;">
			<!-- Content Wrapper. Contains page content -->
			<div class="content-wrapper">

				<!-- Main content -->
				<section class="content register-page" style="height:100%;">
					<div class="container-fluid">
						<div class="login-logo">
							<b>회원 등록</b>
						</div>
						<!-- form start -->
						<div class="card">
							<div class="register-card-body">
							
								
								<form id="fmin" role="form" class="form-horizontal" action="/member/memberRegist" method="POST" enctype="multipart/form-data">
									<div class="input-group mb-3">
										<div class="mailbox-attachments clearfix" style="text-align: center; width:100%;">
											<div class="mailbox-attachment-icon has-img" id="pictureView" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;">
												<img id="pictureViewImg" style="width:100%; height:100%;"/>
											</div>
											<div class="mailbox-attachment-info">
												<div class="input-group input-group-sm">
													<input id="picture" class="form-control" type="file" name="realFilename" accept=".gif, .jpg, .png" style="height:37px;"/>
												</div>
											</div>
										</div>
										<br />
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
				
									<div class="form-group row">
										<br>알람 : <input class="form-control" name="mem_alert" type="text" id="mem_alert" placeholder="알람"><br>
											삭제여부 : <input class="form-control" name="del" type="text" id="del" placeholder="삭제여부"><br>
											멤버구분 : <input class="form-control" name="mem_type" type="text" id="mem_type" placeholder="멤버구분"><br>
									</div>
						
									<div class="card-footer">
										<div class="row">
											<div class="col-sm-6">
												<button type="button" id="registBtn" class="btn btn-info">등록</button>
											</div>

											<div class="col-sm-6">
												<button type="button" id="cancelBtn" onclick="window.history.back()" class="btn btn-default float-right">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
											</div>

										</div>
									</div>
								</form>
							</div>
							<!-- register-card-body -->
						</div>
					</div>
				</section>
				<!-- /.content -->
			</div>
			<!-- /.content-wrapper -->
		</div>
	</div>


	
	
	<!-- 	userid, usernm, pass, alias, addr1, addr2, zipcode, filename, realfilename
	
	 
	-->
</body>
</html>







