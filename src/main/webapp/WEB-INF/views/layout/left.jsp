<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	
<!-- Channel Plugin Scripts -->
<script>
  (function() {
    var w = window;
    if (w.ChannelIO) {
      return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
    }
    var ch = function() {
      ch.c(arguments);
    };
    ch.q = [];
    ch.c = function(args) {
      ch.q.push(args);
    };
    w.ChannelIO = ch;
    function l() {
      if (w.ChannelIOInitialized) {
        return;
      }
      w.ChannelIOInitialized = true;
      var s = document.createElement('script');
      s.type = 'text/javascript';
      s.async = true;
      s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
      s.charset = 'UTF-8';
      var x = document.getElementsByTagName('script')[0];
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === 'complete') {
      l();
    } else if (window.attachEvent) {
      window.attachEvent('onload', l);
    } else {
      window.addEventListener('DOMContentLoaded', l, false);
      window.addEventListener('load', l, false);
    }
  })();
  ChannelIO('boot', {
    "pluginKey": "9fecedd4-d5c5-4ee5-bdcc-ddf8f29b6c2e"
  });
</script>
<!-- End Channel Plugin -->
 
<script>
	$(function(){
		// 메뉴를 선택하면 배경색이 변한다. 
		$('.selectable').click(function(){
// 			alert($(this).text());
			$('.selectable').parent().removeClass("active");
			$(this).parent().addClass("active");
		})
		
		$('.mkPjtBtn').click(function(){
			var plId = '${SMEMBER.memId}';
			$(location).attr('href', '/project/readReqList?plId='+plId);
		})
		
		
	})


</script>


<aside class="main-sidebar sidebar-light-teal elevation-4">
	<!-- Brand Logo -->		
	<a href="/mainpage/mainreconnection?memId=${SMEMBER.memId}" class="brand-link" style="border-bottom: none"> 
	<img src="/dist/img/antslogo.png" class="brand-image" style="float: none;width: 46px;margin: 15px 8px 10px 7px;height: 50px;">
	<img src="/dist/img/ants.png" style="width: 100px;">
	</a>
		
	<!-- Sidebar -->
	<div class="sidebar" style="font-size: 0.8em;">
		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
				<li class="nav-item has-treeview menu-open">
		            <a href="#" class="nav-link active">
		              <i class="nav-icon fas fa-newspaper"></i>
						<p class="jg">전체정보<i class="fas fa-angle-left right"></i></p>
		            </a>
		            <ul class="nav nav-treeview" style="display: block;">
		              <li class="nav-item">
		                <a href="/alarmList" class="nav-link">
		                 <i class="nav-icon fas fa-bullhorn"></i>
							<p class="selectable jg">새로운 소식</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/bookmark/getallbookmark" class="nav-link">
						<i class="nav-icon fas fa-bookmark"></i>
						<p class="selectable jg">내 북마크</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/projectMember/myissuelist" class="nav-link">
						<i class="nav-icon far fa-lightbulb"></i>
						<p class="selectable jg">내가 작성한 이슈</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/schedule/MyclendarView" class="nav-link">
		                <i class="nav-icon far fa-calendar-alt"></i>
						<p class="selectable jg">개인 캘린더</p>
		                </a>
		              </li>
		              <li class="nav-item">
		                <a href="${pageContext.request.contextPath}/privatefile/privatefileView" class="nav-link">
		                <i class="nav-icon fas fa-folder-open"></i>
						<p class="selectable jg">내 파일함</p>
		                </a>
		              </li>
		              
		              
					</ul>
				</li><br>
				<li class="nav-item has-treeview menu-open">
					<c:choose>
						<c:when test="${SMEMBER.memType eq 'PM' }">
							<a href="#"	class="nav-link active"><i class="nav-icon fa fa-check"></i>
								<p class="jg">요구사항공간<i class="fas fa-angle-left right"></i></p>
							</a>
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="/req/reqList" class="nav-link"><i class=" nav-icon fas fa-clipboard-list"></i>
										<p class="jg">요구사항정의서 관리</p>
									</a>
								</li>
								<li class="nav-item">
									<a href="/req/reqInsertView" class="nav-link"><i	class="nav-icon fa fa-plus-square"></i>
										<p class="jg">요구사항정의서  생성하기</p>
									</a>
								</li>
							</ul>	
						</c:when>
						<c:when test="${SMEMBER.memType ne 'PM' }">
							<a href="#"	class="nav-link active"><i class="nav-icon fa fa-check"></i>
								<p class="jg">협업공간<i class="fas fa-angle-left right"></i></p>
							</a>	
							<ul class="nav nav-treeview">
								<li class="nav-item">
									<a href="#" class="nav-link"><i	class="nav-icon fa fa-plus-square"></i>
										<p class="selectable mkPjtBtn jg">프로젝트  생성하기</p>
									</a>
								</li>
							</ul>
						</c:when>
					</c:choose>
				</li>
				<br>
				
				<!-- memType이 MEM일때  -->
				 <c:if test="${not empty memInProjectList}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p class="jg">참여중인 프로젝트<i class="fas fa-angle-left right"></i></p>
						</a>
							
					    <ul class="nav nav-treeview" style="display: block;">
					    	<c:forEach items="${memInProjectList}" var="project">
					    		<c:if test="${project.memId != SMEMBER.memId }">
							    	<li class="nav-item">
										<a class="nav-link jg" href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}">
									 		<i class="nav-icon fas fa-layer-group"></i><p class="selectable">${project.proName}</p>
									 	</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				 </c:if>
				 <!-- memType이 PL일때 -->
				 <c:if test="${not empty plInProjectList}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p class="jg">내가 PL인 프로젝트<i class="fas fa-angle-left right"></i></p>
						</a>
					    <ul class="nav nav-treeview" >
					    	<c:forEach items="${plInProjectList}" var="project">
					    		<c:if test="${project.proName != '' and project.proName != null}">
							    	<li class="nav-item">
										<a class="nav-link jg" href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}">
									 		<i class="nav-icon fas fa-layer-group"></i><p>${project.proName}</p>
									 	</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				 </c:if>
				 <!-- memType이 PM일때 -->
				 <c:if test="${not empty pmInProjectList}">
					<li class="nav-item has-treeview menu-open">
			            <a href="#" class="nav-link active">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p class="jg">프로젝트관리<i class="fas fa-angle-left right"></i></p>
						</a>
					    <ul class="nav nav-treeview" >
					    	<c:forEach items="${pmInProjectList}" var="project">
					    		<c:if test="${project.proName != '' and project.proName != null}">
							    	<li class="nav-item">
										<a class="nav-link jg" href="${pageContext.request.contextPath}/project/projectgetReq?reqId=${project.reqId}" >
									 		<i class="nav-icon fas fa-layer-group"></i><p>${project.proName}</p>
									 	</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				 </c:if>
				 
				 <!-- 프로젝트없는 경우 -->
				 <c:if test="${memInProjectList eq null and plInProjectList eq null and pmInProjectList eq null}">
					<li class="nav-item has-treeview menu-close">
			            <a href="#" class="nav-link">
				        	<i class="nav-icon fas fa-poll-h"></i>
							<p class="jg">참여중인 프로젝트가 없습니다</p>
						</a>
				 </c:if>
			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>