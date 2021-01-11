<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>




<div class="col-12 col-sm-12" >
<h1 class="nav-icon fas fa-unlock-alt" style="margin-top : 10px; margin-left : 10px;">&nbsp;IP 설정</h1> <br> <br>
	<div class="card" style="border-top:none; border-radius: inherit; padding : 2px; margin-top: 10px;">
		<div class="container-fluid">
			<ul class="nav nav-tabs" id="custom-tabs-three-tab">
			
				<li class="nav-item getIpList">
					<a class="nav-link"
					id="custom-tabs-three-notice"
					href="/admin/ipMain">최근 접속 IP</a>
				</li>
				
				<li class="nav-item getIpList">
					<a class="nav-link"
					id="custom-tabs-three-notice"
					href="/admin/getIpList">IP 관리</a>
				</li>

				<li class="nav-item"><a class="nav-link"
					id="custom-tabs-three-iplist" href="/admin/insertIpView">
					IP 등록</a>
				</li>
			</ul>
		</div>
	</div>
</div>

<!-- <div class="col-12 col-sm-12 jg"> -->
<!-- <div class="card" style="border-radius: inherit; padding : 2px; margin-top: 10px;"> -->
<!-- 	<div class="container-fluid"> -->
<!-- 		<div class="row mb-2"> -->
<!-- 			<div class="col-sm-6"> -->
<!-- 				<br> -->
<!-- 				<h1 class="nav-icon fas fa-unlock-alt">&nbsp;IP 설정</h1> <br> <br> -->
<!-- 			</div> -->
			
<!-- 		</div> -->
<!-- 	</div> -->
<!--     <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist"> -->
<!--      <li class="nav-item"> -->
<!--        <a class="nav-link active bani_a" id="custom-tabs-three-home-tab" data-toggle="pill" href="#custom-tabs-three-loginlog" role="tab" aria-controls="custom-tabs-three-home" aria-selected="true">최근 접속 IP(최근 10개)</a> -->
<!--      </li> -->
<!--      <li class="nav-item"> -->
<!--        <a class="nav-link bani_a" id="custom-tabs-three-gantt-tab" data-toggle="pill" href="#custom-tabs-three-iplist" role="tab" aria-controls="custom-tabs-three-gantt" aria-selected="false">IP 관리</a> -->
<!--      </li> -->
<!--      <li class="nav-item"> -->
<!--        <a class="nav-link bani_a" id="custom-tabs-three-calendar-tab" data-toggle="pill" href="#custom-tabs-three-ipinsert" role="tab" aria-controls="custom-tabs-three-calendar" aria-selected="false">IP 등록</a> -->
<!--      </li> -->
<!--    </ul> -->


<!-- <div class="card-body jg"> -->
<!--       <div class="tab-content" id="custom-tabs-three-tabContent"> -->
<!--         <div class="tab-pane fade active show" id="custom-tabs-three-loginlog" role="tabpanel" aria-labelledby="custom-tabs-three-work-tab"> -->
        	
<!--         	<div class="bani_div"> -->
<%--         		<%@ include file="/WEB-INF/views/admin/ipMain.jsp" %> --%>
<!-- <!--             	<h5 class="baniChart" style="display: inline-block;">최근 접속IP 목록(최근 10개)</h5> --> 
<!--             	<button class="btn btn-default"> -->
<!-- 					<li class="fas fa-download"></li> &nbsp; -->
<!-- 					<a style="color : black;"href="/excel/iplistexcelDown"> Excel다운로드</a> -->
<!-- 				</button> -->
<!-- 				<br> -->
<!-- 				<table class="recentIpList"> -->
<!-- 					<tr style="height : 30px;"> -->
<!-- 						<th>사용자</th> -->
<!-- 						<th>IP</th> -->
<!-- 						<th>접속국가</th> -->
<!-- 						<th>접속 시간</th> -->
<!-- 					</tr> -->
<!-- 				</table> -->
<!--  		 	</div> 		 	 -->
<!--        </div> -->
       
<!--         <div class="tab-pane fade  " id="custom-tabs-three-iplist" role="tabpanel" aria-labelledby="custom-tabs-three-work-tab"> -->
<!--         	<br> -->
<!--         	<div class="bani_div"> -->
<!--             	<h5 class="baniChart">IP 목록 </h5><br> -->
<!--             	<table class="acceptedIpList"> -->
<!-- 					<tr style="height : 30px;"> -->
<!-- 						<th>IP</th> -->
<!-- 						<th>담당자</th> -->
<!-- 						<th>-</th> -->
<!-- 					</tr> -->
<%-- 					<c:forEach items="${ipList }" var="ip"> --%>
<!-- 						<tr> -->
<%-- 							<td hidden="hidden">${ip.ipId }</td> --%>
<%-- 							<td>${ip.ipAddr }</td> --%>
<%-- 							<td>${ip.adminId }</td> --%>
<%-- 							<td><button class="btn btn-danger ipDelBtn" ipId=${ip.ipId }>삭제</button></td> --%>
<!-- 						</tr> -->
<%-- 					</c:forEach> --%>
<%-- 					<c:if test="${ipList.size() == 0 }"> --%>
<!-- 						<tr> -->
<!-- 							<td style="width : 57.5%; text-align : right;">등록한 IP가 존재하지 않습니다.</td> -->
<!-- 						</tr> -->
<%-- 					</c:if> --%>
<!-- 				</table> -->
<!--  		 	</div> 	 -->
<!--  		 	<div id="paging" class="card-tools"> -->
<!-- 				<ul class="pagination pagination-sm jg" id="pagingui"> -->
			
<%-- 					<li class="page-item jg" id="pagenum"><ui:pagination --%>
<%-- 							paginationInfo="${paginationInfo}" type="image" --%>
<%-- 							jsFunction="fn_egov_link_page" /></li> --%>
<%-- 					<form:hidden path="pageIndex" /> --%>
<!-- 				</ul> -->
<!-- 			</div>	 	 -->
<!--        </div> -->
       
       
<!--         <div class="tab-pane fade  " id="custom-tabs-three-ipinsert" role="tabpanel" aria-labelledby="custom-tabs-three-work-tab"> -->
<!--         	<br><br> -->
<!--         	<div class="bani_div"> -->
<!--             	<h5 class="baniChart">신규 IP 등록 </h5><br> -->
<!--             	<div class="inputIpArea" style="float : left; width : 100%;"> -->
<%-- 					<form id="ipForm" action="/admin/insertIp" style="float : left;"> --%>
<!-- 						<span class="jg">허용할 IP를 입력해 주세요.</span> -->
<!-- 						<input class="ip" name="ip1" id="ip1" type="text" maxlength="3"> -->
<!-- 						.&nbsp;<input class="ip" name="ip2" id="ip2" type="text" maxlength="3"> -->
<!-- 						.&nbsp;<input class="ip" name="ip3" id="ip3" type="text" maxlength="2"> -->
<!-- 						.&nbsp;<input class="ip" name="ip4" id="ip4" type="text" maxlength="2"> -->
<%-- 					</form> --%>
<!-- 					<button class="ipRegBtn" style="margin-left : 10px;">등록</button> -->
<!-- 					<div> -->
<!-- 						<span class="errorMsg jg" style="color : red; float : left;"></span> -->
<!-- 					</div>		 -->
<!-- 				</div> -->
<!--  		 	</div> 		 	 -->
<!--        </div> -->
<!-- 	</div> -->
<!-- </div> -->
     
<!-- </div> -->
<!-- </div>  -->
