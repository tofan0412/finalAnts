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
	body{
	    min-width: 1100px;
	    min-height: 1100px;
	}
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
		padding : 10px;
		padding-left : 20px;
		width: 330px;
		height : 50px;
		border-radius: 80px;
		outline: none;
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
	#checkbtn{
		height : 42px;
	}

</style>	
</head>

<title>정보 수정</title>
<body>
	<div class="card">
			
				<!-- 경로 미리보기용 -->
			<!-- <div id="clickmsg">경로 : </div> 
			<hr> 
			-->
			<form id="fmin" role="form" class="form-horizontal" action="/member/profileupdate" method="POST" enctype="multipart/form-data">
			<!-- action="/member/memberRegist" method="POST" enctype="multipart/form-data -->
				<div id="pictureView" style="border: 1px solid green; height: 200px; width: 200px; margin: 0 auto;">
					<img id="pictureViewImg" style="width: 100%; height: 100%;" />
				</div>
				<div class="content">
					<button id="basicimg" type="button">기본이미지</button>
					<input id="picture" type="file" name="memFilename" accept=".gif, .jpg, .png" style="height: 37px;"/>
				</div>
				
				<br><br>
				<div class="content"> 
					<label for="id" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>아이디
					</label>
					<div id="idcheck">
						<input class="input" name="memId" type="email" id="memId" placeholder="회원 id" value="${memberVo.memId}" readonly/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="check_font" id="checkMsg"></div>
					</div>
				</div>
					
				<div class="content">
					<label for="name" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>이 름
					</label>
					<div>
						<input class="input" name="memName" type="text" id="memName" placeholder="이름" value="${memberVo.memName}"/>
					</div>
				</div>

				<div class="content">
					<label for="pwd" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>패스워드1
					</label>
					<div>
						<input class="input" name="memPass" type="password" id="memPass" placeholder="패스워드1" value="${memberVo.memPass}"/>
					</div>
				</div>
				
				
				<div class="content">
					<label for="pwd" style="font-size: 0.9em;">
						&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;">*</span>패스워드2
					</label>
					<div>
						<input class="input" type="password" id="memPass2" placeholder="패스워드2" value="${memberVo.memPass}"/>
					</div>
				</div>

				<div class="content">
						&nbsp;&nbsp;&nbsp;&nbsp;<label for="alias" style="font-size: 0.9em;">전화번호</label>
					<div>
						<input class="input" name="memTel" type="tel" id="memTel" placeholder="전화번호( '-' 없이 작성해주세요)" value="${memberVo.memTel}"/>
					</div>
				</div>
				
				
				<!-- style="display: none" -->
				<div class="content" style="display: none">
					<br>알람 : <input class="form-control" name="memAlert" type="text" id="memAlert" placeholder="알람" value="${memberVo.memAlert}" readonly><br> 
					삭제여부:   <input class="form-control" name="del" type="text" id="del" placeholder="삭제여부" value="${memberVo.del}" readonly><br> 
					멤버구분 :  <input class="form-control" name="memType" type="text" id="memType" placeholder="멤버구분" value="${memberVo.memType}" readonly><br>
					이미지 경로: <input class="form-control" name="imgname" type="text" id="imgname" placeholder="파일경로" value="${memberVo.memFilepath}" readonly>
					사진 : <img id="pict" style="width: 30px; height: 30px;" src="/profileImgView?memId=${memberVo.memId}" />
					기본이미지 : <img id="imge" style="width: 30px; height: 30px;" src="${memberVo.memFilepath}" /><br>
				</div>
				
				<div id="row1">
					<br><br><br>
					<div class="content" id="butt">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="registBtn" class="btn btn-info">등록</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" id="cancelBtn" class="btn btn-info" onclick="window.history.back()">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp; 소 &nbsp;&nbsp;&nbsp;</button>
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
	          <img src="/profile/user-1.png" id="img1" name="img1" class="imgc">
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
			
							/* 기본이미지/사진 선택 해서 보여주기 */
			
							
			pict = document.getElementById('pict').src	// display none 에 숨어있는 사진의 src속성값 가져옴
														// src="/profileImgView?memId=${memberVo.memId}" 
			imge = document.getElementById('imge').src	// display none 에 숨어있는 기본이미지의 src속성값 가져옴
														// src="${memberVo.memFilepath}"
			
														
			picval = pict.split('/')[0].indexOf('profileImgView') // 아이디 값으로 memFilepath의 속성을 가져오기 때문에 항상
										// 값이 동일하다 -> http://localhost/profileImgView?memId=noylit@naver.com
			imgval= imge.split('/')[0].indexOf('http')	
			// 파일가져올때 -> file:///D:/upload/james.png	// 기본이미지    -> https://localhost/profile/user-16.png
			// memFilepath 의 속성값을 바로 가져오기 때문에 웹에 저장된 기본이미지를 불러오는지
			//								     로컬에 저장된 파일을 가져오는지 경로로 확인이 가능하다. 
			
			
			$('#sp').append(' pict : ' + picval + '//' + pict);	// 경로 확인하려고 (숨김항목)
			$('#sp').append(' imge : ' + imgval + '//' + imge); // 경로 확인하려고 (숨김항목)
			
			
			if(imgval == -1){	// imgval(memFilepath) 의 값이 http(웹사이트)에서 가져온것이 아니면(file) -1
				$('#pictureViewImg').attr('src', pict);
			}else if(imgval == 0){	// imgval(memFilepath) 의 값이 http(웹사이트)에서 가져온 거면 0 -> 웹사이트는 기본이미지
				$('#pictureViewImg').attr('src', imge);
			}
			
		
			
			// 기본이미지 선택하면 파일 값 초기화
			var picture = document.getElementById('picture');
			picture.value = null;
				
			// 파일의 경로값을 꺼냄
			// picture input의 파일 변경시 이벤트 
			$("#picture").change(function(){ 
				readURL(this);
			});
		});
	
		// 이미지 뷰어 src속성에 등록
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
			  
				reader.onload = function (e) {
					$('#pictureViewImg').attr('src', e.target.result);  
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		
		
		// 패스워드 2개 입력한것 값 비교
		var newpass1 = document.getElementById('memPass');	
		var newpass2 = document.getElementById('memPass2');
		
		// 등록버튼시 미입력 된것 있으면 경고창
		$(document).ready(function() {
			$("#registBtn").on('click', function() {
				var memId = document.getElementById('memId');
				var memName = document.getElementById('memName');
				var memPass = document.getElementById('memPass');
				
				// 누락있을때
				if (memId.value == "" || memName.value == "" || memPass.value == "") {
					alert("필수입력 사항을 입력해주세요")
				}
				
				// 누락없을때
				else {
					
					// 비밀번호 일치시 
					if(newpass1.value == newpass2.value){
						$('#fmin').submit();
					}else{
						alert("비밀번호가 일치하지 않습니다.")
					}
					
				}
		         
			})
		})
		
		
		
		
		
		
												/* 기본이미지 선택  */
		
		// 기본이미지 모달창 띄으기
		$(document).ready(function(){
			$('#basicimg').click(function(){
				$("#myModal").modal();
			})
			
			
			
			$('#img0').click(function(){
				// 기본이미지 선택하면 파일 값 날리기
				var picture = document.getElementById('picture');
				picture.value = null;

				// 0번 이미지 경로 가져오기
				imgsrc = document.getElementById('img0').src 
				
				/* $('#clickmsg').append(imgsrc); */		 		// 이미지 경로 미리보기
				$('#pictureViewImg').attr('src', imgsrc); 		// 이미지 뷰어에 보이기
				$('#imgname').attr('value', imgsrc);			// input 태그에 value값으로 경로 추가
				/* 
				var pass = document.getElementById('imgname');	// img name 에 담긴 value값 가져오기
				alert(pass.value);								// img name 의 value 값 확인
				*/
 				// 모달창 닫기
				$("#myModal").modal('hide');
				
			})
			
			
			$('#img1').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img1').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img2').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img2').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img3').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img3').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img4').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img4').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			
			
			
			
			
			$('#img5').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img5').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img6').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img6').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img7').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img7').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img8').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img8').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img9').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img9').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			
			
			
			
			
			$('#img10').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img10').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img11').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img11').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img12').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img12').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img13').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img13').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img14').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img14').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			
			
			
			
			
			$('#img15').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img15').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img16').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img16').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img17').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img17').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img18').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img18').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img19').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img19').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
		
			
			
			
			
			
			
			$('#img20').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img20').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img21').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img21').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img22').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img22').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img23').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img23').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img24').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img24').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			
			
			
			
			
			
			
			$('#img25').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img25').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img26').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img26').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img27').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img27').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img28').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img28').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			$('#img29').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img29').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
			
			
			
			
			
			
			$('#img30').click(function(){
				var picture = document.getElementById('picture');// 파일 value값 지우기
				picture.value = null;
				
				imgsrc = document.getElementById('img30').src	// 경로 가져오기
				$('#pictureViewImg').attr('src', imgsrc); 		// 뷰어에 이미지 보여주기
				$('#imgname').attr('value', imgsrc);			// 경로값 속성으로 추가
				
				$("#myModal").modal('hide');					// 모달창 닫기
			})
		})	
</script>
	



</html>