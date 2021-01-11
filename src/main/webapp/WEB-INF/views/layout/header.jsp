 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	.toast{
		width:500px;
		font-family: Jeju Gothic;
	}
</style>
<script>
	getNow();

	// 시간 관련 함수 설정
	function getNow() {
		var now = new Date();
	
		var calendar = now.getFullYear() + "-" + (now.getMonth() + 1) + "-"
				+ now.getDate();
	
		var currentHours = addZeros(now.getHours(), 2);
		var currentMinute = addZeros(now.getMinutes(), 2);
		var currentSeconds = addZeros(now.getSeconds(), 2);
	
		$('#clock').val(
				calendar + " " + currentHours + ":" + currentMinute + ":"
						+ currentSeconds);
		setTimeout("getNow()", 1000);
	}
	
	function addZeros(num, digit) { // 자릿수 맞춰주기
		var zero = '';
		num = num.toString();
		if (num.length < digit) {
			for (i = 0; i < digit - num.length; i++) {
				zero += '0';
			}
		}
		return zero + num;
	}
 	
	var socket = null;
    $(document).ready(function(){
    	//알림을 받을때만 웹소켓 연결
    	if("${SMEMBER.memAlert == 'Y'}"){
	    	sock = new SockJS('/alarm');
	    	socket = sock;
	    	
	    	socket.onopen = function(){
	    		console.log('info: connection opened');
	    	};
	    	
	    	//데이터전달 받았을 때
	    	socket.onmessage = onMessage;
	    	//소켓연결 끊겼을 때
	    	socket.onclose = onClose;
    	}
    	
    	alarmCount('${SMEMBER.memId}');
    	
    	$('#why').on('click',function(){
    		document.location = '/alarmList';
    	});
    	
    	// 관리자에게 쪽지 보내는 모달 창 띄우기
    	$('#msgBtn').click(function(){
    		$('#msgCont').val('');
    		$('#msgType').val('선택');
    		
    		$('#msgToAdminModal').modal();
    	})
    	
    	// 내 쪽지함 확인하기
    	$('#msgAnsBtn').click(function(){
    		$('.msgAnsBody').empty();
    		html = "";
    		$.ajax({
    			url : "/msg/myMsgList",
    			data : {msgReceiver : '${SMEMBER.memId}'},
    			method : "POST",
    			success : function(res){
    				html += "<table>";
    				html += "<tr style=\'text-align : center;\'><th>작성자</th><th>내용</th><th>작성일</th></tr>";
    				for(i = 0 ; i < res.length ; i++){
    					html += "<tr>";
	    					html += "<td style=\'text-align : center;\'>" + res[i].msgWriter + "</td>";
	    					html += "<td style=\'text-align : center;\'>" + res[i].msgCont + "</td>";
	    					html += "<td style=\'text-align : center;\'>" + res[i].regDt + "</td>";
    					html += "</tr>";
    				}
    				$('.msgAnsBody').html(html);
    			}
    		})
    		
    		
    		$('#msgAnsModal').modal();
    	})
    	
    	
    	$('#msgCont').keyup(function(){
    		$('.msgWarningCont').empty();
    	})
    	
    	$('#helloBtn').click(function(){
    		msgType = $('#msgType').val();
			
    		count = 0;
    		if (msgType == '선택'){
    			alert("쪽지 유형을 선택해 주세요.");
    			count++;
    		}
    		
    		if (msgType == '권한요청'){
    			type = 'PM';
    		}else if (msgType == '문의'){
    			type = 'ISSUE';
    		}
    		
    		msgCont = $('#msgCont').val();
    		if (msgCont == ''){
    			$('.msgWarningCont').text("내용을 입력해 주세요.");
    			count++;
    		}
    		
    		msgWriter = '${SMEMBER.memId}';
    		regDt = $('#clock').val();
    		msgStatus = 'WAIT';
    		
    		if (count < 1){
    			$.ajax({
    				url : "/msg/insertMsg",
    				data : {msgType : type, msgCont : msgCont,
    						msgWriter : msgWriter, regDt : regDt, 
    						msgStatus : msgStatus, msgReceiver : 'ADMIN'},
    				method : "POST", 
    				success : function(res){
    					alert("쪽지를 보냈습니다.");
    					$('#msgToAdminModal').modal('hide');
    				}
    			})
    		}
    	})
	});
    
	function onMessage(evt){
		var data  = evt.data.split('&&');
		var memId = '${SMEMBER.memId}';
		alarmCount(memId);
		// 답글
		if(data[0] == 'posts'){
			$(document).Toasts('create', {
			     body: data[2]+ "<br><span id='why' style='font-size:0.9em; color:gray;'>"+data[3]+"</span>["+data[4]+"]",
			     title: data[1],
			     subtitle: '답글이 달렸습니다.' ,
			     icon: 'fas fa-envelope fa-lg',
			});
		// 요청,응답
		}else if(data[0] == 'req-pl' || data[0] == 'req-pro' || data[0] == 'res-pl' || data[0] == 'res-pro'){
			$(document).Toasts('create', {
			     body: data[3],
			     title: data[2],
			     subtitle: data[1],
			     icon: 'fas fa-envelope fa-lg',
			});
		// 댓글
		}else if(data[0].indexOf('reply') != -1){
			$(document).Toasts('create', {
			     body: data[2]+ "<br><span id='why' style='font-size:0.9em; color:gray;'>"+data[3]+"["+data[5]+"]"+"</span>",
			     title: "새로운 댓글이 있습니다." ,
			     subtitle: data[1],
			     icon: 'fas fa-envelope fa-lg',
			});
		// 건의사항작성
		}else if(data[0] == 'suggest'){
			$(document).Toasts('create', {
			     body: data[2]+ "<br><span id='why' style='font-size:0.9em; color:gray;'>["+data[6]+"]"+data[4]+"</span>",
			     title: "새로운 건의사항이 있습니다.",
			     subtitle: data[1] ,
			     icon: 'fas fa-envelope fa-lg',
			});
		// 건의사항응답	
		}else if(data[0] == 'res-suggest'){
			$(document).Toasts('create', {
				body: data[3],
			    title: data[2],
			    subtitle: data[1],
			    icon: 'fas fa-envelope fa-lg',
			});
		}
		
	}
	
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		console.log("소켓 연결이 끊겼습니다..");
	}
	
	/* 알림 총 개수*/
	function alarmCount(memId){
		$.ajax({
			url:'/alarmCount',
			data:{memId : memId},
			type:'POST',
			dataType:'json',
			success:function(data){
				console.log(data);
				var alarmVo = data.alarmVo;
				if(alarmVo.totalCnt == '0'){
				}else{
					$('#alarmCount').text(alarmVo.totalCnt);
				}
				$('.alarmCount').prepend(alarmVo.totalCnt);
				$('#resCnt').append(parseInt(alarmVo.reqPl + alarmVo.resPl)+ " 새로운 요청");
				$('#replyCnt').append(alarmVo.reply + " 새로운 댓글");
				$('#postsCnt').append(alarmVo.posts + " 새로운 게시물");
			},
			error:function(err){
				alert(err);
			}
		});
	}		

</script>
   <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item jg">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block jg">
        <a id="home" href="${pageContext.request.contextPath}/member/mainpage" class="nav-link">HOME</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block jg">
        <a id="toNotice" href="/member/noticelistmemview" class="nav-link">공지사항</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block jg">
      	<!-- 현재 시간 표시하는 부분.. -->
		<input class="nav-link" type="text" id="clock" readonly style="border : none; color : blue;"> 
      <li>
    </ul>
		
    
	
    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <li class="jg" style="padding-top : 5px;">
      	<c:if test="${SMEMBER.memId ne null }">
    	  환영합니다, ${SMEMBER.memName }님!
   		</c:if>
   		<c:if test="${projectId ne null }">
<%--     	  현재 프로젝트 번호 : ${projectId} --%>
   		</c:if>
   		
      </li>
 
      <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge" id="alarmCount"></span>
          
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right jg">
          <span class="dropdown-item dropdown-header alarmCount">개의 알림이 있습니다.</span>
          <div class="dropdown-divider"></div>
          <a href="${pageContext.request.contextPath}/alarmList?searchCondition=1" class="dropdown-item toAlarm" id="resCnt" style="font-size: 0.9em">
            <i class="fas fa-envelope mr-2 " ></i>
          </a>
          <div class="dropdown-divider"></div>
          <a href="${pageContext.request.contextPath}/alarmList?searchCondition=2" class="dropdown-item toAlarm" id="replyCnt" style="font-size: 0.9em">
            <i class="fas fa-comment-dots mr-2" ></i> 
          </a>
          <div class="dropdown-divider"></div>
          <a href="${pageContext.request.contextPath}/alarmList?searchCondition=3" class="dropdown-item toAlarm" id="postsCnt" style="font-size: 0.9em">
            <i class="fas fa-reply mr-2" ></i> 
          </a>
          <div class="dropdown-divider"></div>
          <a href="${pageContext.request.contextPath}/alarmList" class="dropdown-item dropdown-footer">모든 알림 보기</a>
        </div>
      </li>
      
       <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-user-circle"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right jg">
          <div class="dropdown-divider"></div>
          <a href="${pageContext.request.contextPath}/member/profile?memId=${SMEMBER.memId}" class="dropdown-item">
            <i class="fas fa-user-edit mr-2"></i>프로필
          </a>
          
          <div class="dropdown-divider"></div>
          <a href="#" id="msgBtn" class="dropdown-item">
            <i class="fas fa-envelope mr-2"></i>관리자에게 쪽지보내기
          </a>
          
          <div class="dropdown-divider"></div>
          <a href="#" id="msgAnsBtn" class="dropdown-item">
            <i class="fas fa-envelope-open mr-2"></i>내 쪽지함
          </a>
          
          <div class="dropdown-divider"></div>
          <a href="${pageContext.request.contextPath}/member/logout" class="dropdown-item">
            <i class="fas fa-toggle-off mr-2"></i>로그아웃
          </a>
        </div>
          
      </li>
      
      <li class="nav-item">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
          <i class="fas fa-comments"></i>
        </a>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->
  
  
  <!-- 관리자에게 쪽지 보내는 MODAL 창 -->
    <div class="modal fade jg" id="msgToAdminModal" tabindex="-1" role="dialog"
		aria-labelledby="msgToAdminModal">
		<div class="modal-dialog modal-lg-center" role="document">
			<div class="modal-content" style="height: 350px; width : 450px;">
				
				<div class="modal-header">
					<h3 class="modal-title" id="addplLable">관리자에게 쪽지 보내기</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<label>유형</label>&nbsp;&nbsp;
					<select id="msgType">
						<option>선택</option>
						<option>권한요청</option>
						<option>문의</option>
					</select><br>
					<label>내용</label>
					<span class="msgWarningCont" style="color : red;"></span>
					<br>
					<textarea id="msgCont" rows="4" placeholder="최대 입력은 20자입니다." maxlength="20" cols="30" style="width : 100%; resize : none;" autocomplete="off"></textarea>
				</div>
				
				<div class="modal-footer">
					<div style="float: right;">
						<button id="helloBtn" class="btn btn-primary" type="button">쪽지 보내기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
  <!-- 내 쪽지함 -->
	<div class="modal fade jg" id="msgAnsModal" tabindex="-1" role="dialog"
		aria-labelledby="msgAnsModal">
		<div class="modal-dialog modal-lg-center" role="document">
				<div class="modal-content" style="height: 500px; width : 450px;">

				<div class="modal-header">
					<h3 class="modal-title" id="addplLable">내 쪽지함</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body msgAnsBody" style="height : 75%; overflow-y : width : 95%; auto; margin : 0 auto;">
					
				</div>
			</div>
		</div>
	</div>	