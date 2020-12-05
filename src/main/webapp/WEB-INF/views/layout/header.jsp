 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	var socket = null;
    $(document).ready(function(){
    	//웹소켓 연결
    	sock = new SockJS('/alarm');
    	socket = sock;
    	
    	sock.onopen = function(){
    		console.log('info: connection opened');
    	};
    	
    	//데이터전달 받았을 때
    	sock.onmessage = onMessage;
    	//소켓연결 끊겼을 때
    	sock.onclose = onClose;
    	
    	alarmCount('${SMEMBER.memId}');
    	
    	
	});
    
	function onMessage(evt){
		var data  = evt.data;
		console.log("ReceivMessage: " + data + "\n");
		var memId = '${SMEMBER.memId}';
		alarmCount(memId);
		
		toastr.info(data);

    	toastr.options = {
    	  "closeButton": false,
    	  "debug": false,
    	  "newestOnTop": false,
    	  "progressBar": false,
    	  "positionClass": "toast-top-right",
    	  "preventDuplicates": false,
    	  "onclick": null,
    	  "showDuration": "500",
    	  "hideDuration": "1000",
    	  "timeOut": "5000",
    	  "extendedTimeOut": "1000",
    	  "showEasing": "swing",
    	  "hideEasing": "linear",
    	  "showMethod": "fadeIn",
    	  "hideMethod": "fadeOut"
    	}
		
	}
	
	
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		alert("소켓 연결 끊김....")
	}
	
	function alarmCount(memId){
		$.ajax({
			url:'/alarmCount',
			data:{memId : memId},
			type:'POST',
			dataType:'json',
			success:function(count){
				console.log(count);
				if(count.cnt == '0'){
					
				}else{
					$('#alarmCount').text(count.cnt);
				}
			},
			error:function(err){
				alert('err');
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
        <a href="#" class="nav-link">Home</a>
      </li>
    </ul>

    <!-- SEARCH FORM -->
    <form class="form-inline ml-3">
      <div class="input-group input-group-sm">
        <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
        <div class="input-group-append">
          <button class="btn btn-navbar" type="submit">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
    </form>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <li class="jg" style="padding-top : 5px;">
      	<c:if test="${SMEMBER.memId ne null }">
    	  환영합니다, ${SMEMBER.memId }님!
   		</c:if>
   		<c:if test="${projectId ne null }">
    	  현재 프로젝트 번호 : ${projectId}
   		</c:if>
   		
      </li>
      <!-- Messages Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-comments"></i>
          <span class="badge badge-danger navbar-badge">3</span>
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
            <!-- Message Start -->
            <div class="media">
              <img src="/dist/img/user8-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  John Pierce
                  <span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>
                </h3>
                <p class="text-sm">I got your message bro</p>
                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
              </div>
            </div>
            <!-- Message End -->
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <!-- Message Start -->
            <div class="media">
              <img src="/dist/img/user3-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  Nora Silvester
                  <span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>
                </h3>
                <p class="text-sm">The subject goes here</p>
                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
              </div>
            </div>
            <!-- Message End -->
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
          <span class="dropdown-item dropdown-header">15 Notifications</span>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-envelope mr-2"></i> 4 new messages
            <span class="float-right text-muted text-sm">3 mins</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-users mr-2"></i> 8 friend requests
            <span class="float-right text-muted text-sm">12 hours</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-file mr-2"></i> 3 new reports
            <span class="float-right text-muted text-sm">2 days</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>
        </div>
      </li>
      
       <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-user-circle"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <div class="dropdown-divider"></div>
          <a href="/member/profile" class="dropdown-item">
            <i class="fas fa-user-edit mr-2"></i>프로필
          </a>
          
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-bell mr-2"></i>알림설정
          </a>
          
          <div class="dropdown-divider"></div>
          <a href="/member/logout" class="dropdown-item">
            <i class="fas fa-toggle-off mr-2"></i>로그아웃
          </a>
        </div>
          
      </li>
      
      <li class="nav-item">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
          <i class="fas fa-th-large"></i>
        </a>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->