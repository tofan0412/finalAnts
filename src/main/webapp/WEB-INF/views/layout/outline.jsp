<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../layout/fullcalendarLib.jsp"%>
<style>

.knob-label{
padding-left: 100px;
}
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

   
  })

</script>
</head>
<body>
<%@include file="../layout/contentmenu.jsp"%>
					<h4 style="margin-left: 50px;">${projectVo.proName}</h4>
					 <br><br>
                	<div class="row" style="width: 65%;  float:left;">
                  <div class="col-6 col-md-3 text-center">
                    <div style="display:inline; width:100px;height:100px;">
                    <canvas width="100" height="100"></canvas>
                    <input type="text" class="knob" value="100" data-width="150" data-height="150" data-fgcolor="#6495ED" data-thickness="1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: #6495ED; font: bold 18px Arial; text-align: center; color: #6495ED; padding: 0px; appearance: none;" readonly="readonly"></div>

                    <div class="knob-label">status</div>
                  </div>
                  <div class="col-6 col-md-3 text-center">
                    <div style="display:inline;width:100px;height:100px;">
                    <canvas width="100" height="100"></canvas>
                    <input type="text" class="knob" value="${pro.percent}" data-width="150" data-height="150" data-fgcolor="#6495ED " data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly"></div>

                    <div class="knob-label">progress</div>
                  </div>
                  <div class="col-6 col-md-3 text-center">
                    <div style="display:inline;width:100px;height:100px;">
                    <canvas width="100" height="100"></canvas>
                    <input type="text" class="knob" value="${pro.elepsedTime }" data-width="150" data-height="150" data-fgcolor="#6495ED" data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly"></div>

                    <div class="knob-label">Time elapsed</div>
                  </div>
                  <div class="col-6 col-md-3 text-center">
                    <div style="display:inline;width:100px;height:100px;">
                    <canvas width="100" height="100"></canvas>
                    <input type="text" class="knob" value="20" data-width="150" data-height="150" data-fgcolor="#6495ED" data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly"></div>

                    <div class="knob-label">suggest</div>
                  </div>
                  <div class="row" style="width: 100%; margin-left: 10%; margin-top: 8%;" >
                    <div class="col-12 col-sm-6 col-md-3" style="width: 35%; margin-right: 10%;" >
                     Progress/Time
                      <div class="progress progress-md">
                        <div class="progress-bar bg-warning" style="width: 80%"></div>
                      </div>
                    </div>
               		 <div class="col-12 col-sm-6 col-md-3" style="width: 35%; margin-right: 10%; ">
                      ProjectFiles
                      <div class="progress progress-md">
                        <div class="progress-bar bg-warning" style="width: 80%"></div>
                      </div>
                    </div>
                    <div class="col-12 col-sm-6 col-md-3" style="width: 35%;" >
                      Issues Reply
                      <div class="progress progress-md" >
                        <div class="progress-bar bg-warning" style="width: 80%;"></div>
                      </div>
                    </div>
                    <div class="col-12 col-sm-6 col-md-3" style="width: 35%; margin-right: 10%; margin-top: 5%;" >
                      Turnout
                      <div class="progress progress-md">
                        <div class="progress-bar bg-warning" style="width: 80%"></div>
                      </div>
                    </div>
               		 <div class="col-12 col-sm-6 col-md-3" style="width: 35%; margin-right: 10%; margin-top: 5%;">
                      Todo
                      <div class="progress progress-md">
                        <div class="progress-bar bg-warning" style="width: 80%; "></div>
                      </div>
                    </div>
                    
                    
					</div>
					</div>
                

                    
              <div class="row" style="width: 30%; float:left; margin-left:5%;  border-bottom: 1px solid black;" > 
              	   <h2>Project Day</h2>
                    <table class="table table-sm" >
                  <tbody>
                    <tr>
                      <td></td>
                      <td>시작일</td>
                      <td></td>
                      <td class="dayt">
                        ${pro.regDt }
                      </td>
                      <td></td>
                    </tr>
                    <tr>
						<td></td>
                      <td>종료일</td>
                      <td></td>
                        <td class="dayt">
                        ${pro.endDt }
                      </td>
                      <td></td>
                    </tr>
                    <tr>
                    <td></td>
                      <td>Day</td>
                      <td></td>
                        <td class="dayt">
                        ${pro.elepsedTime }
                      </td>
                      <td></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="row" style="width: 30%; float:right; margin-right:1%;  margin-top:2%; border-bottom: 1px solid black;" > 
              
              	   <h2>WorkGroup</h2>
                    <ul class="users-list clearfix">
                      <li>
                        <img src="../userprofile/user-0.png" alt="User Image">
                        <span class="users-list-date">PL : ${req.plId }</span>
                      </li>
                      <c:forEach items="${promem }" var="pro" varStatus="sts">
                      <li>
                         <img src="../userprofile/user-4.png" alt="User Image">
                        <span class="users-list-date">${pro.memId }</span>
                      </li>
                      </c:forEach>
                    </ul>
                    <!-- /.users-list -->
              		
              </div>
</body>
</html>