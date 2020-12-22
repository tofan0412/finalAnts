<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="commonLib.jsp"%>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>

<script>

</script>
<style>
#top{
	width: 100%;
	height: 600px;
}
#left{
	width: 50%;
	height: 400px;
	float:left;
	
}
#right{
	width: 50%;
	float:left;
	height: 400px;
}
#project_table{
	width : 90%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    text-align: center;
	margin-left: 5%;
	
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
 
</style>
	 				
<body>
<div id="top" style="OVERFLOW-Y:auto;">
<br>
<h4 class="jg" style="padding-left: 5%;">Project List</h4>
	<table id="project_table" class="jg">
		<tr style="background-color: #f6f6f6">
			<th>프로젝트 이름</th>
			<th>Progress</th>
			<th>진행도</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>PL</th>
		</tr>
		<tbody>
				<c:forEach items="${projectList_main }" var="project" varStatus="sts" >
				    <tr>
					<td>${project.proName }</td>
					<c:if test= "${empty project.percent}">
						<td>
	                        <div class="progress progress-xs progress-striped active">
	                          <div class="progress-bar bg-danger" style="width: 1%;"></div>
	                        </div>
	                    </td>
	                    <td>0%</td>   
                    </c:if>   
					<c:if test= "${project.percent+0 != 0 and project.percent+0 <=59+0}">
                        <td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${project.percent}" var="NUM"/>
	                          <div class="progress-bar bg-warning" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                    </td>    
	                    <td>${project.percent}%</td>
                     </c:if>   
					<c:if test= "${project.percent+0 >=60+0 and project.percent+0 <=99+0}">
                        <td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${project.percent}" var="NUM"/>
	                          <div class="progress-bar bg-primary" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                     </td>   
	                     <td>${project.percent}%</td>
                    </c:if>   
					<c:if test= "${project.percent eq '100'}">
                    	<td>
	                        <div class="progress progress-xs progress-striped active">
	                           <fmt:parseNumber value="${project.percent}" var="NUM"/>
	                          <div class="progress-bar bg-success" style="width: <c:out value="${NUM}" />%"></div>
	                        </div>
	                     </td>
						<td>${project.percent }%</td>					
                     </c:if>   
					<td>${project.regDt }</td>			
					<td>${project.endDt }</td>
					<td>${project.memId }</td>			
					</tr>
				</c:forEach>
		</tbody>
	</table>
</div>
<div id="left">111</div>
<div id="right">222</div>
</body>