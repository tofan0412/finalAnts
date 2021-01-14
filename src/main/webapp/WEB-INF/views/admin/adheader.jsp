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
</script>

   <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="${pageContext.request.contextPath}/admin/adMainView" class="nav-link">Home</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
      	<input class="nav-link jg" type="text" id="clock" readonly style="border : none; color : black;">
      </li>
    </ul>


    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <li class="jg" style="padding-top : 5px;">
      	<c:if test="${SADMIN.adminId ne null }">
    	  환영합니다, 관리자님!
   		</c:if>
      </li>
      
      
		<!-- 관리자 메뉴바 -->
       <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-user-circle"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <div class="dropdown-divider"></div>
          <a href="${pageContext.request.contextPath}/admin/adlogout" class="dropdown-item">
            <i class="fas fa-toggle-off mr-2"></i>로그아웃
          </a>
        </div>
          
      </li>
<!--       right side bar -->
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button"> -->
<!--           <i class="fas fa-comments"></i> -->
<!--         </a> -->
<!--       </li> -->
      
      
    </ul>
  </nav>
  <!-- /.navbar -->