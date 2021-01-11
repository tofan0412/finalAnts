<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">

var itemName = [];
var itemCnt = []
<c:forEach items="${itemlist }" var="item" varStatus="status">
	itemName[${status.index}] = '${item.voteitemName}';
	itemCnt[${status.index}] = '${item.voteCount}'
</c:forEach>

$(function(){
	
	$('#dchart').hide();
	$('#chart').hide();
	$('#charttd').hide();

	    
	$('.writeCon').each(function () {	
		  this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
	}).on('input', function () {
		  this.style.height = 'auto';
		  this.style.height = (this.scrollHeight) + 'px';
	});
	
	$("#pagenum a").addClass("page-link");  
	
	console.log("뭔뎅")
	
	// 투표하기 버튼
	$(document).on('click', '#votejoinbtn', function(){	
		$('input[type=radio]').prop('checked',false);
		
		
		// 이미 투표를 참여했을 경우
		$(":radio[name='voteItem']").each(function() {
			var $this = $(this);		
			
			if($this.val() == '${voteres.voteitemId}')		{
				$(":radio[name='voteItem']").attr('disabled',true);
				$this.prop('checked', true);
				$('.warningVoted').text("이미 투표에 참여하셨습니다.");
				$('#regBtn').hide();
			}		
		});

		$('#voteDetail').modal();
	})
	
	// 투표완료 버튼
	$('#regBtn').on('click', function(){		
		var vote = $("input[type=radio]:checked").val();
		var voteid =  '${voteVo.voteId}';
		console.log(voteid)
		
		if('${voteres.memId}' == '${SMEMBER.memId}' ){
			alert('이미 투표에 참여하셨습니다.')
		}else{
			$(location).attr('href', '${pageContext.request.contextPath}/vote/voteMember?voteitemId='+vote+'&voteId='+voteid);			
		}
		
	})
	
	// 삭제하기 버튼
	$('#votedelbtn').on('click', function(){	
		if(confirm("정말 삭제하시겠습니까 ?") == true){
			var voteid =  '${voteVo.voteId}';
			$(location).attr('href', '${pageContext.request.contextPath}/vote/delVote?&voteId='+voteid);
        }else{
        	return;
        }
		
	})
	
	// 뒤로가기
	$(document).on('click','#back', function(){		
// 		$("#listform").attr("action", "${pageContext.request.contextPath}/vote/votelist");
		listform.submit();	
	})
	
	// 답글 글자수 계산
	$('#re_con').keyup(function (e){
	    var content = $(this).val();
	  
	    console.log(content)
		
	    $('#counter').html("('+content.length+' / 최대 300자)");    //글자수 실시간 카운팅	  
		$('span').html(content.length);
		
	    if (content.length > 300){
	        alert("최대 300자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 300));
	        $('span').html("(200 / 최대 300자)");
	    }
	});
	
	// 댓글 작성하기 삭제 버튼
	$('#replydiv').on('click','#replydelbtn', function(){
		if(confirm("댓글을 정말 삭제하시겠습니까 ?") == true){   
			var someid = $(this).prev().val();
			var replyid = $(this).prev().prev().val();
			issueid = '${issuevo.issueId }'
			console.log(replyid)
			console.log(someid)
			$.ajax({url :"/reply/delreply",
				   data :{replyId: replyid,
					       someId: someid },
				   method : "get",
				   success :function(data){	
					   console.log(data)
					   $(location).attr('href', '${pageContext.request.contextPath}/vote/voteDetail?voteId='+someid);				
				 }
			})
		}else{
        	return;
        }
	})
	
	// 댓글 작성
	$('#replybtn2').on('click', function(){
		replyinsert();
	})
	
	// 원그래프 버튼
	$('#dchartbtn').on('click', function(){
		doughnutchart(); // 원그래프
		$('#chart').hide();
		$('#pertd').hide();
		$('#charttd').show();
		$('#dchart').show();
	})
	
	// 막대 차트 버튼
	$('#chartbtn').on('click', function(){
		chart(); // 막대그래프
		$('#dchart').hide();
		$('#pertd').hide();
		$('#chart').show();
		$('#charttd').show();
	})
	
	// 내 차트
	$('#mychartbtn').on('click', function(){
		chart(); // 막대그래프
		$('#dchart').hide();
		$('#charttd').hide();
		$('#chart').show();
		$('#pertd').show();
	})
	
})

// 댓글작성시 작동 증가
function resize(obj) {
	  obj.style.height = "1px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
}


//댓글 작성
function replyinsert() {
	console.log($('#re_con').val())
	$.ajax({
	
		url : "${pageContext.request.contextPath}/reply/insertreply",
		method : "post",
		data : {
			someId :  '${voteVo.voteId }',
			categoryId : '10',
			replyCont : $('#re_con').val()
			
		},
		success : function(data) {
				saveMsg();
				
		}

	});

}
//댓글알림 
function saveMsg(){
	var alarmData = {
						"alarmCont" : "${projectVo.reqId}&&${SMEMBER.memName}&&${SMEMBER.memId}&&/vote/voteDetail&&${voteVo.voteId}&&${voteVo.voteTitle}&&"+ $('#re_con').val() + "&&${projectVo.proName}",
						"memId" 	: "${voteVo.memId}",
						"alarmType" : "reply-10"
	}
	console.log(alarmData);
	
	$.ajax({
			url : "/alarmInsert",
			data : JSON.stringify(alarmData),
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			dataType : 'text',
			success : function(data){
				
				let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memId +"&&"+ alarmData.alarmType;
				socket.send(socketMsg);
				$(location).attr('href', '${pageContext.request.contextPath}/vote/voteDetail?voteId=${voteVo.voteId}');
				
			},
			error : function(err){
				console.log(err);
			}
	});
}


function doughnutchart(){
	var dnum = [];
	var dpercent=[];
	for(i=0; i<itemName.length; i++){
		dnum.push(itemName[i]);	
		dpercent.push(Math.round(itemCnt[i]/'${voteVo.votedNo}' *100));
	}
	var donutChartData = {
			 labels : dnum,
			 datasets: [
			        {
			          data: dpercent,
			          backgroundColor : [
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
							'rgba(255, 159, 64, 1)',
							'rgba(153, 102, 255, 1)'
						]
			        }
			      ],
			      
				
	}
	var donutOptions = { 
			cutoutPercentage: 30, //도넛두께 : 값이 클수록 얇아짐 
			legend: {position:'bottom', 
					 padding:5, 
					 labels: {pointStyle:'circle', 
						 		usePointStyle:true}
			} 
	};


	 
	var dctx = document.getElementById('dchart').getContext('2d');
	var donutChart = new Chart(dctx, {
	      type: 'doughnut',
	      data: donutChartData,
	      options: donutOptions
	    });
}

function chart2(){
	var num = [];
	var percent=[];
	for(i=0; i<itemName.length; i++){
		num.push(itemName[i]);	
		percent.push(itemCnt[i]);
	}

	var barChartData = {
			 labels : num,
			 datasets: [
			        {
			          label               : '득표수',
			          borderColor: "rgba(255, 201, 14, 1)",
			          backgroundColor: "rgba(255, 201, 14, 0.5)",
			          pointRadius          : false,
			          pointColor          : '#3b8bba',
			          pointHighlightFill  : '#fff',
			          data                : percent ,					 
			          barThickness: 30
			         
			        }]
	};
	var barChartOptions = {
			
		      responsive              : true,
		      maintainAspectRatio     : false,
		      datasetFill  			  : false,
		      tooltips: {
		            mode: 'index',
		            intersect: false,
		        },
		        hover: {
		            mode: 'nearest',
		            intersect: true
		        },
		      scales: {
		          xAxes: [{
		                display: true,
		                ticks: {
			                  stepSize: 1,
			                  suggestedMax: '${voteVo.voteTotalno}', 
			                  beginAtZero: true
			           }
		          
		        
		            }],
		            yAxes: [{
		                display: true,
		                ticks: {
		                	beginAtZero:true
		                  },
			          
		               
		            }]
			      }
		    };
	var ctx = document.getElementById('chart').getContext('2d');
	var stackedBarChartData = $.extend(true, {}, barChartData);
	var stackedBarChart = new Chart(ctx, {
	      type: 'horizontalBar',
	      data: barChartData,
	      options: barChartOptions
	});
}



function chart() {
	
	var num = [];
	var percent=[];
	for(i=0; i<itemName.length; i++){
		num.push(itemName[i]);	
		percent.push(itemCnt[i]);
	}

	var barChartData = {
			labels : num,
			 datasets: [
			        {
			          label               : '득표수',
			          backgroundColor: [ 
			        	  'rgba(255, 99, 132, 0.5)', 
			        	  'rgba(54, 162, 235, 0.5)', 
			        	  'rgba(255, 206, 86, 0.5)', 
			        	  'rgba(75, 192, 192, 0.5)', 
			        	  'rgba(153, 102, 255, 0.5)', 
			        	  'rgba(255, 159, 64, 0.5)'
			          ], 
			          borderColor: [
			        	  'rgb(255, 99, 132,1.5)', 
			        	  'rgba(54, 162, 235, 1.5)', 
			        	  'rgba(255, 206, 86, 1.5)', 
			        	  'rgba(75, 192, 192, 1.5)', 
			        	  'rgba(153, 102, 255, 1.5)', 
			        	  'rgba(255, 159, 64, 1.5)'
			          ],

			          
			       
			          pointRadius          : false,
			          fill: false,
			          data                : percent ,					 
			          barThickness: 40
			         
			        }]
	};
	var barChartOptions = {
		      responsive              : true,
		      maintainAspectRatio     : false,
		      datasetFill  			  : false,
		      scales: {
			        xAxes: [{
			          display : true
			        }],
			        yAxes: [{
			        	ticks: {
			                  stepSize: 1,
			                  suggestedMax: '${voteVo.voteTotalno}', 
			                  beginAtZero: true
			          }
			        }]
			      }
		    };
	var ctx = document.getElementById('chart').getContext('2d');
	var stackedBarChartData = $.extend(true, {}, barChartData);
	var stackedBarChart = new Chart(ctx, {
	      type: 'bar',
	      data: barChartData,
	      options: barChartOptions
	});
			
	
}






</script>


<style type="text/css">
	label{
		width : 100px auto;
		padding: 2px;
	}
	.labels{
		width : 200px;
		padding: 5px;
	}
	
	 /* For Chrome or Safari */ 
     progress::-webkit-progress-bar { 
         background-color: #eeeeee; 
     } 

     progress::-webkit-progress-value { 
         background-color: #ffc711 !important; 
     } 


     /* For Firefox */ 
     progress { 
         background-color: #eee; 
     } 

     progress::-moz-progress-bar { 
         background-color: #ffc711 !important; 
     } 

     /* For IE10 */ 
     progress { 
         background-color: #eee; 
     } 

     progress { 
         background-color: #ffc711; 
     } 
	
	.div{
		display: inline-block;
		height:auto;
		width: auto;
	}
	#votesort{
		height: 200px auto;
	}
	
	.writeCon{
	   width:100%; overflow:visible; background-color:transparent; border:none;
  		resize :none; 
  		padding-left:40px;
	}
	
	#re_con{
		width: 700px;
		display :inline-block;
      	resize: none;
      	padding: 1.1em; /* prevents text jump on Enter keypress */
      	padding-bottom: 0.2em;
      	line-height: 1.6;
      	overflow-y:hidden;
	}	
 	#re_con.autosize { min-height: 56px; } 
	
	.form-control:disabled, .form-control[readonly] {
   background-color: white;
   }
  .success{
  background-color: #f6f6f6;
  width: 10%;
  text-align: center;
  }
	
 
</style>

<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
	
	    	<form id="listform" action="${pageContext.request.contextPath}/vote/votelist" method="post">
			    <input type="hidden" value="${searchCondition }" name="searchCondition">
			    <input type="hidden" value="${searchKeyword }" name="searchKeyword">
			    <input type="hidden" value="${pageIndex }" name="pageIndex">
			</form>
	    
	    <div class="card-body">
	    
	    	<h4 class="jg" style="display: inline-block;">${voteVo.voteTitle }</h4>
	    	<c:if test="${voteVo.remain > 1000 and voteVo.voteStatus=='ing'}">
				
				 	<span class="badge badge-success">진행중</span>
				
			</c:if>
			<c:if test="${(voteVo.remain <= 1000 and voteVo.remain > 0) and voteVo.voteStatus == 'ing'}">
				
				 	<span class="badge badge-warning">임박</span>
				
			</c:if>
			<c:if test="${voteVo.remain <= 0 or voteVo.voteStatus== 'finish'}">
			
					<span class="badge badge-danger"> 완료 </span>
					<c:if test="${voteVo.votedNo/voteVo.voteTotalno > 0.00}">
						&nbsp;&nbsp;
						<button class="btn btn-default">
							<li class="fas fa-download"></li> &nbsp;
							<a style="color : black;"href="/excel/voteExcel?voteId=${voteVo.voteId}"> Excel다운로드</a>
						</button>
						<br><br>
					</c:if>
			</c:if>
			
			<input type="hidden" id="todoId">
			
			<div class="div">
				<table class="table" style="margin-bottom: 0px;">
				
					<tr class="stylediff">
			            <th class="success jg">개시자</th>
			            <td style="width: 700px;">
			            	<label class="control-label" id="memid">${voteVo.memName }</label>
			            </td>
			          	
			       
			            <th class="success jg">종료일</th>		            
			            <td style=" width: 700px;">
			            	<label class="control-label" id="regDt">${voteVo.voteDeadline}</label>
			            </td>
		        	</tr>
				
					
					<tr class="stylediff">
			            <th class="success jg per">투표율</th>
			            <td colspan="3" class="jg" >
			            	<fmt:formatNumber value="${voteVo.votedNo/voteVo.voteTotalno}" type="percent"></fmt:formatNumber> 	
			            </td>
		           
		        	</tr>
				
				
					
			        <tr class="stylediff" id="pertr" >
				
			        	
				            <th class="success jg" >투표항목 <br><br>	
				            	<c:if test="${voteVo.votedNo > 0}">
				            	
						            <button id="mychartbtn" class="btn btn-default"><i class="fas fa-align-left"></i></button>
						            <button id="dchartbtn" class="btn btn-default"><i class="fas fa-chart-pie"></i></button>
					            	<button id="chartbtn" class="btn btn-default"><i class="fas fa-chart-bar"></i></button>
				            	</c:if>	                 	
				            </th>
				            
			        	
		        	         
			        	<c:if test="${status.index > 0}">
			        	 	<th class="success jg" style="border-top: none;"></th>
			        	 	<br>
						</c:if>	
						<td id="charttd">							
			            	<canvas id="dchart" style=" min-height: 300px; height: 300px; max-width: 300px; max-height: 300px; display: inline-block; float : left; width: 300px; float" width="300 " height="300" class="chartjs-render-monitor"></canvas>
							<canvas id="chart" style="min-height: 300px; height: 300px; max-width: 100%; max-height: 300px; display: inline-block; float : left; width: 347px; float" width="347" height="300" class="chartjs-render-monitor"></canvas>
			            
						</td>
						
					    <td id="pertd" > 
				  		<c:forEach items="${itemlist }" var="item" varStatus="status">
				  		
						<div class="control-label" style="padding-left: 20px;" >	
							<label class="control-label">${status.index+1 } . &nbsp; ${item.voteitemName }</label><br>
	                        <progress   value="${item.voteCount }" max="${voteVo.voteTotalno}" ></progress>                        
							&nbsp; ${item.voteCount }명 	
							<c:if test="${item.voteCount == 0}">
									( 0% )
				
							</c:if>
							<c:if test="${item.voteCount > 0}">
								( <fmt:formatNumber value="${item.voteCount/voteVo.votedNo }" type="percent"></fmt:formatNumber> )
							</c:if>
						</div>
							<br>
						</c:forEach>
			         	</td>
			        </tr>
					
					<tr class="stylediff" >
			            <th class="success jg">투표인원</th>
			            <td colspan="3" >
			            	<label class="control-label" id="voteTotalno"><i class="fas fa-user"></i> &nbsp; ${voteVo.votedNo}명 참여  </label>
			            </td>
		           
		        	</tr>
		        	
					

		       
       
	        </table>
			
		
			
			<div class="card-footer clearfix" id="btndiv" >
				<button type="button" class="btn btn-default jg" id="back">목록으로</button>		
<%-- 				투표자 : ${voteres.memId} / 로그인한 사람 : ${SMEMBER.memId }	 --%>
				<c:if test="${voteVo.memId == SMEMBER.memId }">		
					<button type="button" class="btn btn-default float-right jg" id="votedelbtn">삭제하기</button>
				</c:if>			
				<c:if test="${voteVo.voteStatus =='ing'}">		
					<button type="button" style="margin-right: 5px;"  class="btn btn-default float-right jg" id="votejoinbtn">투표참여하기</button>
				</c:if>			
				
			</div>
			
			
			 <form class="form-horizontal" role="form" id ="frm" method="post" action="${pageContext.request.contextPath}/reply/insertreply">	
				<div class="form-group">
				<hr>
					<label for="pass" class="col-sm-2 control-label jg">댓글</label>
					<div class="col-sm-12" id="replydiv">	
								
						<c:forEach items="${replylist }" var="replylist">
							<div id="replydiv" style="padding-left: 50px;">			
							<c:if test= "${replylist.del == 'N'}">
								<c:if test="${fn:substring(replylist.memFilepath,0 ,1) eq '/' }">									
									<img id="imge" style="width: 40px; height:  40px; border-radius: 50%; border: 1.5px solid #adb5bd;"  src="${replylist.memFilepath}" />
								</c:if>
								<c:if test="${fn:substring(replylist.memFilepath,0 ,2) eq 'D:' }">		
									<img id="pict" style="width:  40px; height:  40px;  border-radius: 50%; border: 1px solid #adb5bd;" src="/profileImgView?memId=${replylist.memId}" />
								</c:if>
								<label style="display: inline-block;" class="jg">${replylist.memName }</label>
								<label >( ${replylist.memId } )</label>
									
								<textarea style=" width:100%; overflow:visible; background-color:transparent; border:none;"  disabled class ="writeCon">${replylist.replyCont}</textarea>
								
								[ ${replylist.regDt} ] 	
									
								<c:if test= "${replylist.memId == SMEMBER.memId && replylist.del == 'N'}">	
									
									
									<input type="hidden" value="${replylist.replyId}">
									<input type="hidden" value="${replylist.someId}">																							
									<input id ="replydelbtn" type="button" class="btn btn-default jg" value ="삭제"/>						
								</c:if>		
											
							</c:if>		 														
							<c:if test= "${replylist.del == 'Y'}">			
												
								<p>[ 삭제된 댓글입니다. ]</p>		
								
							</c:if>	
							</div>	 														
							<hr>	
						</c:forEach>
						<br>
						<div id="replyinsertdiv" style="padding-left: 50px;">		
							 <input type="hidden" name="someId" value="${issuevo.issueId }">
							 <input type="hidden" name="categoryId" value="${issuevo.categoryId}">
							 <input type="hidden" name="reqId" value="${issuevo.reqId }">
							 <input type="hidden" name="memId" value="${issuevo.memId }">
							
							 <textarea name = "replyCont" id ="re_con" onkeyup="resize(this)" ></textarea><br>
							 <div style="width: 700px;">
								 <span>0</span> &nbsp;자 / 300 자		
								 <input id="replybtn2" type = "button" class="btn btn-default float-right jg" value = "댓글작성"><br>				
							 </div>
						 </div>
						</div>
					</div>
				
			</form>
		
		</div>
	          
	  </div>
	     
	</div>
</div>












<!-- 투표 상세보기 모달 -->
<!-- Modal to invite new Members . . . -->
<div class="modal fade" id="voteDetail" tabindex="-1 " role="dialog" style="  padding-top: 200px;">
	<div class="modal-dialog modal-sm" role="document"  >
		<div class="modal-content" style="height: 600px auto; width : 400px;">
			
			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable" style="text-align : center;">${voteVo.voteTitle }</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div id="itemdiv" class="modal-body" style="width: 100%; height: 100%;">
									
					<input type="hidden" id="nextSeq">
					
<!-- 					<label class="jg" style="float : left;">투표명 : </label> -->
<!-- 					<label class="jg" style="float : left;"></label> -->
<!-- 					<input type="text" class="form-control" id="voteTitle" name="voteTitle" style="width : 90%;"/> -->

					
					<label class="jg" style="float : left; display: inline-block;" style="width: 100%" >투표 항목</label>	
					<br>	<br>
					<div>		
					<c:forEach items="${itemlist }" var="item">
						<input type="radio" name="voteItem" value="${item.voteitemId }" style=" width : 20px; height: 20px; float : left; display: inline-block; "  >
	   				    <label class="jg" for="huey"> &nbsp;${item.voteitemName }</label>  <br>
					</c:forEach>
					<br>
					<div class="jg"><span class="jg warningVoted" style="color : red;"></span></div>
					</div>
			</div>
			
			<div class="modal-footer" >
				<button class="btn btn-success" id="regBtn">투표하기</button>
			</div>
		</div>
	</div>
</div>