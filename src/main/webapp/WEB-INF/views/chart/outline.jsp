<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../layout/fullcalendarLib.jsp"%>
<style>


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
	<h4>프로젝트 이름</h4>
	<div class="card-body">
                <div class="row" style="width: 65%;">
                  <div class="col-6 col-md-3 text-center">
                    <div style="display:inline; width:100px;height:100px;"><canvas width="100" height="100"></canvas><input type="text" class="knob" value="100" data-width="150" data-height="150" data-fgcolor="#3c8dbc" data-thickness="1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: rgb(60, 141, 188) font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly"></div>

                    <div class="knob-label">status</div>
                  </div>
                  <div class="col-6 col-md-3 text-center">
                    <div style="display:inline;width:100px;height:100px;"><canvas width="100" height="100"></canvas><input type="text" class="knob" value="90" data-width="150" data-height="150" data-fgcolor="#3c8dbc" data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly"></div>

                    <div class="knob-label">progress</div>
                  </div>
                  <div class="col-6 col-md-3 text-center">
                    <div style="display:inline;width:100px;height:100px;"><canvas width="100" height="100"></canvas><input type="text" class="knob" value="90" data-width="150" data-height="150" data-fgcolor="#3c8dbc" data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly"></div>

                    <div class="knob-label">suggest</div>
                  </div>
                  <div class="col-6 col-md-3 text-center">
                    <div style="display:inline;width:100px;height:100px;"><canvas width="100" height="100"></canvas><input type="text" class="knob" value="90" data-width="150" data-height="150" data-fgcolor="#3c8dbc" data-thickness="0.1" style="width: 49px; height: 30px; position: absolute; vertical-align: middle; margin-top: 30px; margin-left: -69px; border: 0px; background: none; font: bold 18px Arial; text-align: center; color: rgb(60, 141, 188); padding: 0px; appearance: none;" readonly="readonly"></div>

                    <div class="knob-label">Time elapsed</div>
                  </div>
              </div>
	</div>
</body>
</html>