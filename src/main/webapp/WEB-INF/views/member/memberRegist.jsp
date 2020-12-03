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
	#basicimg{
		height : 30px;
		width : 150px;	
	}
	.imgc{
		width: 80px; 
		height: 56px; 
		cursor: pointer;
	}

</style>	

</head>


<title>회원 등록</title>
<body>
	<div class="card">
			
			<form id="fmin" role="form" class="form-horizontal" action="/member/memberRegist" method="POST" enctype="multipart/form-data">
			<!-- action="/member/memberRegist" method="POST" enctype="multipart/form-data -->
				<div id="pictureView" style="border: 1px solid green; height: 200px; width: 200px; margin: 0 auto;">
					<img id="pictureViewImg" style="width: 100%; height: 100%;" />
				</div>
				
				<div class="content">
					<button id="basicimg" type="button">기본이미지</button>
					<input id="picture" type="file" name="realFilename" accept=".gif, .jpg, .png" style="height: 37px;"/>
					<input type="text" id="real_filename" name="real_filename" style="display: none">
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
	
	
	
<div class="container">

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">기본 이미지</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
	          <img src="/profile/user-0.png" id="img0" name="img0" class="imgc">
	          <img src="/profile/user-1.png" id="img1" name="img1" class="imgc" onClick="check_img(this.src)">
	          <img src="/profile/user-2.png" id="img2" name="img2" class="imgc"/>
	          <img src="/profile/user-3.png" id="img3" name="img3" class="imgc"/>
	          <img src="/profile/user-4.png" id="img4" name="img4" class="imgc"/>
	          <img src="/profile/user-5.png" id="img5" name="img5" class="imgc"/>
	          <img src="/profile/user-6.png" id="img6" name="img6" class="imgc"/>
	          <img src="/profile/user-7.png" id="img7" name="img7" class="imgc"/>
	          <img src="/profile/user-8.png" id="img8" name="img8" class="imgc"/>
	          <img src="/profile/user-9.png" id="img9" name="img9" class="imgc"/>
	          <img src="/profile/user-10.png" id="img10" name="img10" class="imgc"/>
	          <img src="/profile/user-11.png" id="img11" name="img11" class="imgc"/>
	          <img src="/profile/user-12.png" id="img12" name="img12" class="imgc"/>
	          <img src="/profile/user-13.png" id="img13" name="img13" class="imgc"/>
	          <img src="/profile/user-14.png" id="img14" name="img14" class="imgc"/>
	          <img src="/profile/user-15.png" id="img15" name="img15" class="imgc"/>
	          <img src="/profile/user-16.png" id="img16" name="img16" class="imgc"/>
	          <img src="/profile/user-17.png" id="img17" name="img17" class="imgc"/>
	          <img src="/profile/user-18.png" id="img18" name="img18" class="imgc"/>
	          <img src="/profile/user-19.png" id="img19" name="img19" class="imgc"/>
	          <img src="/profile/user-20.png" id="img20" name="img20" class="imgc"/>
	          <img src="/profile/user-21.png" id="img21" name="img21" class="imgc"/>
	          <img src="/profile/user-22.png" id="img22" name="img22" class="imgc"/>
	          <img src="/profile/user-23.png" id="img23" name="img23" class="imgc"/>
	          <img src="/profile/user-24.png" id="img24" name="img24" class="imgc"/>
	          <img src="/profile/user-25.png" id="img25" name="img25" class="imgc"/>
	          <img src="/profile/user-26.png" id="img26" name="img26" class="imgc"/>
	          <img src="/profile/user-27.png" id="img27" name="img27" class="imgc"/>
	          <img src="/profile/user-28.png" id="img28" name="img28" class="imgc"/>
	          <img src="/profile/user-29.png" id="img29" name="img29" class="imgc"/>
	          <img src="/profile/user-30.png" id="img30" name="img30" class="imgc"/>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
</div>
</body>

<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/bootstrap/dist/js/adminlte.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">


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
		
		
		$(document).ready(function(){
			/* 
				$('#mem_id').val("hsj2@thousandOfAnts.com");
				$('#mem_name').val("한상진");
				$('#mem_pass').val("123");
				$('#mem_tel').val("010-1111-2222");
			*/
				$('#memAlert').val("Y");
				$('#del').val("N");
				$('#memType').val("MEM");
			})
			
		
		// 등록버튼시 미입력 된것 있으면 경고창
		$(document).ready(function() {
			$("#registBtn").on('click', function() {
				var memId = document.getElementById('memId');
				var memName = document.getElementById('memName');
				var memPass = document.getElementById('memPass');
				
				
				if (memId.value == "" || memName.value == "" || memPass.value == "") {
					alert("필수입력 사항을 입력해주세요")
				} else {
					// 누락없이 입력시 전송
					$('#fmin').submit();
				}
		         
			})
		})
		
		
		// 중복검사
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
				return false;	/* 페이지 새로고침 막기 */
			}); //end on 
		}); 
		
		
		
		
		// 기본이미지 보여주기 
		$(document).ready(function(){
			$("#basicimg").click(function(){
				$("#myModal").modal('Show');
			});
		});
		
		
		var imaMap = new Map();
		
		// 기본이미지 선택
	/* 	$(document).ready(function(){
			for(i=0; i<31; i++){
				b = '#img' + i;
				
				$(b).on('click', function(){
					var c = $(b).attr("src");
					
					$('#clickmsg').append(b); 
					$('#clickmsg').append(c); 
					
					imaMap.set(b,c);
					
				 	btn = document.getElementById('pictureViewImg');
				 	bt = document.getElementById('picture');
				 	rf = document.getElementById('real_filename');
					
				 	
				 	btn.src = c;
				 	
				 	bt.src = "/" + c.split('/')[1] + "/" + c.split('/')[2]
				 	rf.value = "/" + c.split('/')[1] + "/" + c.split('/')[2]
				 	
				/*	$('#clickmsg').append(btn.src); 
					
					$('#clickmsg').append(btn.src); 
					
					$("#myModal").modal(imaMap.get('#img30')); */
					
					$("#myModal").modal('hide');
				})
			} */
					
			
			function click_img(b){
				alret(b.value);
				alret($('img0').attr('src'));
			}
		})
</script>
	



</html>