<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<style>

/* .knob-label{ */
/* padding-left: 100px; */
/* } */
.dayt{
text-align: right;
}


</style>
<script>
  $(function () {
    /* jQueryKnob */

    $('.knob').knob({
      /*change : function (value) {
       //console.log("change : " + value);
       },
       release : function (value) {
       console.log("release : " + value);
       },
       cancel : function () {
       console.log("cancel : " + this.value);
       },*/
      draw: function () {

        // "tron" case
        if (this.$.data('skin') == 'tron') {

          var a   = this.angle(this.cv)  // Angle
            ,
              sa  = this.startAngle          // Previous start angle
            ,
              sat = this.startAngle         // Start angle
            ,
              ea                            // Previous end angle
            ,
              eat = sat + a                 // End angle
            ,
              r   = true

          this.g.lineWidth = this.lineWidth

          this.o.cursor
          && (sat = eat - 0.3)
          && (eat = eat + 0.3)

          if (this.o.displayPrevious) {
            ea = this.startAngle + this.angle(this.value)
            this.o.cursor
            && (sa = ea - 0.3)
            && (ea = ea + 0.3)
            this.g.beginPath()
            this.g.strokeStyle = this.previousColor
            this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sa, ea, false)
            this.g.stroke()
          }

          this.g.beginPath()
          this.g.strokeStyle = r ? this.o.fgColor : this.fgColor
          this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sat, eat, false)
          this.g.stroke()

          this.g.lineWidth = 2
          this.g.beginPath()
          this.g.strokeStyle = this.o.fgColor
          this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false)
          this.g.stroke()

          return false
        }
      }
    })
    /* END JQUERY KNOB */

  
	// 상세일감 보러가기
	$("#todoList tr").on("click",function(){
		var todoId = $(this).data("todoid");
		$(location).attr('href', '${pageContext.request.contextPath}/todo/onetodoView?todoId='+todoId);
		});
  })

</script>
<%@include file="/WEB-INF/views/layout/fonts.jsp"%>
</head>
<body class="jg">
<%@include file="../layout/contentmenu.jsp"%>
					<br><br>
                	<div class="row jg" style="width: 65%;  float:left; margin-top: 3%;">
                  		<div class="col-6 col-md-3 text-center taskStats clearfix">
                  			<div class="circle" id="STATUS">
                				<div id="statusBall" style="border-radius: 100%; margin: 0px auto; position: relative; display: table; background-color: rgb(100, 149, 237); color: rgb(255, 255, 255); width: 156px; height: 156px;">
                					<div style="display: table-cell; vertical-align: middle; text-align: center;">
                						<span class="_stsLabel" style="font-size: x-large;">Active</span>
                						<span class="additionalLabelText" style="color: rgb(255, 255, 255);"><br>${pro.regDt }</span>
                					</div>
                				</div><h5>status</h5>
                			</div>
                  		</div>
                  		<div class="col-6 col-md-3 text-center taskStats clearfix">
                  			<div class="circle" id="circle_TASK_PROGRESS">
                  				<div class="circles-wrp" style="position: relative; display: inline-block;">
                  					<canvas width="1" height="100"></canvas>
			                    	<c:if test="${empty pro.percent}">
			                    		<input type="text" class="knob" value="0" data-width="150" data-height="150" data-fgcolor="#6495ED " data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly">
			                    	</c:if>
			                    	<c:if test="${not empty pro.percent}">
			                    		<input type="text" class="knob" value="${pro.percent}" data-width="150" data-height="150" data-fgcolor="#6495ED " data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly">
			                    	</c:if>	
                  				</div>
                  			</div><h5>진행도 : %</h5>
                  		</div>
                  		<div class="col-6 col-md-3 text-center taskStats clearfix">
                  			<div class="circle" id="circle_TASK_PROGRESS">
                  				<div class="circles-wrp" style="position: relative; display: inline-block;">
                  					<canvas width="1" height="100"></canvas>
			                    	<input type="text" class="knob" value="${pro.elepsedTime }" data-width="150" data-height="150" data-fgcolor="#6495ED" data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly">
                  				</div>
                  			</div><h5>경과 시간 : 일</h5>
                  		</div>
                  		<div class="col-6 col-md-3 text-center taskStats clearfix">
                  			<div class="circle" id="circle_TASK_PROGRESS">
                  				<div class="circles-wrp" style="position: relative; display: inline-block;">
                  					<canvas width="1" height="100"></canvas>
                  					<input type="text" class="knob" value="${dbsuggestvo.acceptpercent}" data-width="150" data-height="150" data-fgcolor="#6495ED" data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly">
                  				</div>
                  			</div><h5>건의사항 수용률 : %</h5>
                  		</div>
                  		
                  		
                  		<div class="row jg" style="width: 100%; margin-left: 10%; margin-top: 8%;" >
	                    	<div class="col-12 col-sm-6 col-md-3" style="width: 35%; margin-right: 10%;" >
	                     		경과시간 대비 진행율
	                      		<div class="progress progress-md">
	                      			<c:if test="${pro.elepsedTime ne 0 }">
	                      				<fmt:parseNumber value="${pro.percent/pro.elepsedTime }" var="timecalc"/>
	                        				<div class="progress-bar bg-warning" style="width:<c:out value="${timecalc}" />%"></div>
	                        		</c:if>
	                        		<c:if test="${pro.elepsedTime eq 0 }">
	                        			<div class="progress-bar bg-warning" style="width:<c:out value="${pro.percent}" />%"></div>
	                        		</c:if>
	                      		</div>
	                    	</div>
	               		 	<div class="col-12 col-sm-6 col-md-3" style="width: 35%; margin-right: 10%; ">
	                      		프로젝트 파일함 사용량
	                      		<div class="progress progress-md">
	                      			<fmt:parseNumber value="${dbfilevo.pubSize/1024}" var="pnum"/>
	                        		<c:if test="${pnum>=1024}">
	                        			<div class="progress-bar bg-warning" style="width: <c:out value="${pnum/1024}" />%"></div>
	                        		</c:if>
	                        		<c:if test="${pnum<1024}">
	                        			<div class="progress-bar bg-warning" style="width: <c:out value="${pnum}" />%"></div>
	                        		</c:if>
	                      		</div>
	                    	</div>
	                    	<div class="col-12 col-sm-6 col-md-3" style="width: 35%;" >
	                      	소통량
	                      		<fmt:parseNumber value="${dbreplyvo.replypercent}" var="reply"/>
	                      		<div class="progress progress-md" >
	                        		<div class="progress-bar bg-warning" style="width:<c:out value="${reply}" />%"></div>
	                      		</div>
	                    	</div>
	                    	<div class="col-12 col-sm-6 col-md-3" style="width: 35%; margin-right: 10%; margin-top: 5%;" >
	                  		투표율
		                      	<fmt:parseNumber value="${dbvotevo.votepercent}" var="NUM"/>
		                      	<div class="progress progress-md">
		                        	<div class="progress-bar bg-warning" style="width: <c:out value="${NUM}" />%"></div>
		                      	</div>
	                    	</div>
	               		
	               		 	<div class="col-12 col-sm-6 col-md-3" style="width: 35%; margin-top: 7%; margin-right: 10%;">
								<a href="${pageContext.request.contextPath }/todo/chartView">차트 보러가기</a>
	                    	</div>
                    
						</div>
					</div>
                

                    
              <div class="row jg" style="width: 25%; float:left; margin-left:5%;  border-bottom: 1px solid gray;" > 
              	   <h3>Project Day</h3>
                    <table class="table table-sm" >
                  <tbody>
                    <tr>
                      <td></td>
                      <td>시작 일</td>
                      <td></td>
                      <td class="dayt">
                        ${pro.regDt }
                      </td>
                      <td></td>
                    </tr>
                    <tr>
						<td></td>
                      <td>종료 일</td>
                      <td></td>
                        <td class="dayt">
                        ${pro.endDt }
                      </td>
                      <td></td>
                    </tr>
                    <tr>
                    <td></td>
                      <td>경과 일</td>
                      <td></td>
                        <td class="dayt">
                        ${pro.elepsedTime }
                      </td>
                      <td></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="row jg" style="width: 25%; float:left; margin-left:5%;  border-bottom: 1px solid gray; margin-top: 40px;" > 
              	   <h3>WorkGroup</h3>
              	   <table class="table table-sm">
              	   <tbody>
              	   	<tr>
              	   		<th style="border: none">PL : ${req.plId }</th>
              	   	</tr>
<!--                         <img src="../userprofile/user-0.png" alt="User Image"> -->
                    <c:forEach items="${promem }" var="pro" varStatus="sts">
                    	<c:if test="${sts.index%3 eq 0 and sts.index != 0}">
	                    	<tr>
	                    		<td>${pro.memId }</td>
	                    	</tr>
                    	</c:if>
<!--                          <img src="../userprofile/user-4.png" alt="User Image"> -->
                        	
                        <c:if test="${sts.index%3 != 0 or sts.index eq 0}">
	                    	<td>${pro.memId }</td>
                    	</c:if>
                    </c:forEach>
                   </tbody>
              	  </table>
                    <!-- /.users-list -->
              		
              </div>
              <div class="row jg" style="width: 25%; float:left; margin-left:5%;  border-bottom: 1px solid gray; margin-top: 40px;" > 
              	   <h3>deadline</h3>
              	   <table class="table table-sm">
              	   <tbody id="todoList" >
              	   	<c:forEach items="${dbtodovo }" var="todo" varStatus="sts">
              	   	<tr data-todoid="${todo.todoId}">
              	   		<c:choose>
						<c:when test="${fn:length(todo.todoTitle) > 9 }"><td> ${fn:substring(todo.todoTitle,0,8)}...</td></c:when>
						<c:otherwise><td> ${todo.todoTitle} </td></c:otherwise>
						</c:choose>
              	   		<td> ${todo.memId} </td>
              	   		<td> ${todo.todoEnd} </td>
              	   	
              	   	</tr>
              	   	</c:forEach>

                   </tbody>
              	  </table>
                    <!-- /.users-list -->
              		
              </div>
</body>
</html>