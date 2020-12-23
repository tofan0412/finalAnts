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
    	
    	// session에 있는 projectId 삭제하기
    	$('#toNotice').click(function(){
    		$.ajax({
    			url : "/common/delProjectIdSession",
    			method : "POST",
    			success : function(res){
    				
    			}
    		})
    	})
    	
    	// 프로필 버튼 누를 때 projectId session값 삭제
    	$('.toProfile').click(function(){
    		$.ajax({
				url : "/common/delProjectIdSession",
				method : "POST",
				success : function(res){
				}
			})
    	})
    	
    	// 알람 관련 버튼 누를 때 projectId session값 삭제
    	$(".toAlarm").click(function(){
			$.ajax({
				url : "/common/delProjectIdSession",
				method : "POST",
				success : function(res){}
			})
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
		// pl요청
		}else if(data[0] == 'req-pl' || data[0] == 'req-pro'){
			$(document).Toasts('create', {
			     body: data[3],
			     title: data[2],
			     subtitle: data[1],
			     icon: 'fas fa-envelope fa-lg',
			});
		// 댓글
		}else if(data[0] == 'reply'){
			$(document).Toasts('create', {
			     body: data[2]+ "<span id='why' style='font-size:0.9em; color:gray;'>"+data[3]+"</span>",
			     title: data[1],
			     subtitle: "댓글",
			     icon: 'fas fa-envelope fa-lg',
			});
		// pl응답
		}else if(data[0] == 'res-pl' || data[0] == 'res-pro'){
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
		alert("소켓 연결 끊김....")
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
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a id="toNotice" href="/member/noticelistmemview" class="nav-link">공지사항</a>
      </li>
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
      <!-- Messages Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="fas fa-users-cog"></i>
<!--           <span class="badge badge-danger navbar-badge">3</span> -->
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <a href="#" class="dropdown-item">
            <!-- Message Start -->
            <div class="media">
              <img src="/dist/img/user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  Brad Diesel
                  <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
                </h3>
                <p class="text-sm">Call me whenever you can...</p>
                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
              </div>
            </div>
            <!-- Message End -->
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
        </div>
      </li>
      <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge" id="alarmCount"></span>
          
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
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
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <div class="dropdown-divider"></div>
          <a href="${pageContext.request.contextPath}/member/profile" class="dropdown-item toProfile">
            <i class="fas fa-user-edit mr-2"></i>프로필
          </a>
          
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-bell mr-2"></i>알림설정
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