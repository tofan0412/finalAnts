<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function(){

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
		
		window.history.back();
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
	
	// 댓글 작성
	$('#replybtn2').on('click', function(){
		replyinsert();
	})
	
})

// 댓글작성시 작동 증가
function resize(obj) {
	  obj.style.height = "1px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
}


//댓글 작성
function replyinsert() {
		
	$.ajax({
	
		url : "${pageContext.request.contextPath}/reply/insertreply",
		method : "post",
		data : {
			someId :  '${voteVo.voteId }',
			categoryId : '10',
			replyCont : $('#re_con').val()
			
		},
		success : function(data) {
			
				console.log(data.someId)
				$(location).attr('href', '${pageContext.request.contextPath}/vote/voteDetail?voteId='+data.someId);
		}

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
	
	h3{
		display: inline-block;
	}
	
	.writeCon{
	width:100%; overflow:visible; background-color:transparent; border:none;
  		resize :none; 
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
 	#re_con.autosize { min-height: 60px; } 
	
</style>

<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
	    
	    <!-- 일감 상세보기 -->
	    <div id="todoDetail" class="card-body">
	    
	    	<h3 class="jg">${voteVo.voteTitle }</h3>
	    	<c:if test="${voteVo.remain > 1000 and voteVo.voteStatus=='ing'}">
				<td style="text-align: center;"> 
				 	<span class="badge badge-success">진행중</span>
				</td>
			</c:if>
			<c:if test="${(voteVo.remain <= 1000 and voteVo.remain > 0) and voteVo.voteStatus == 'ing'}">
				<td style="text-align: center;"> 
				 	<span class="badge badge-warning">임박</span>
				</td>
			</c:if>
			<c:if test="${voteVo.remain <= 0 or voteVo.voteStatus== 'finish'}">
				<td style="text-align: center;" >
					<span class="badge badge-danger"> 완료 </span>
				</td>
			</c:if>
	    	<hr> <br>
		
			<input type="hidden" id="todoId">
			
			<div class="div">
<!-- 				<label for="voteitemName" class="control-label labels" id="votesort"  style=" float : left;">투표항목</label>				 -->
				<c:forEach items="${itemlist }" var="item" varStatus="status">
						
						<label for="voteitemName" class="control-label labels jg" id="votesort"  style=" float : left;">
							<c:if test="${status.index == 0}">				
								투표항목	
							</c:if>
						</label>
						
						
						<div class="control-label float-left">		
							<label class="control-label float-left">${status.index+1 } . &nbsp; ${item.voteitemName }</label><br>
						
                      		<label class="control-label  float-left per"  style=" float : left;">
	                         	<progress   value="${item.voteCount }" max="${voteVo.voteTotalno}"></progress>                        
								&nbsp; ${item.voteCount }명 	
								<c:if test="${item.voteCount == 0}">
										( 0% )
					
								</c:if>
								<c:if test="${item.voteCount > 0}">
									( <fmt:formatNumber value="${item.voteCount/voteVo.votedNo }" type="percent"></fmt:formatNumber> )
								</c:if>
							</label>		
						</div>
						<br>	
				</c:forEach>
			</div>
			<br>
			
			<br>
			<div class="div">
				<input type="hidden" value="${voteVo.voteId}" id="voteid">
				<label for="voteTotalno" class="control-label labels jg">투표인원</label>
				
				<label class="control-label" id="voteTotalno">${voteVo.votedNo}명 / ${voteVo.voteTotalno}명  </label> 
				
			</div>
			<br>
			<div class="div">
				<label for="voteTotalno" class="control-label labels jg">투표율</label>
		
				<label class="control-label" id="votePercent">	
					<fmt:formatNumber value="${voteVo.votedNo/voteVo.voteTotalno}" type="percent"></fmt:formatNumber> 		
				</label>
				
			</div>
			<br>
			<div class="div">
				<label for="voteDeadline" class="control-label labels jg">종료일</label>
				<label class="control-label" id="voteDeadline">${voteVo.voteDeadline}</label>
			</div>
			<br>
			<div class="div">
				<label for="memId" class="control-label labels jg">개시자</label>
				<label class="control-label" id="memId">${voteVo.memName }</label>
			</div>
			<hr>
			
			<div class="card-footer clearfix" id="btndiv" >
				<button type="button" class="btn btn-default jg" id="back">목록으로</button>		
				투표자 : ${voteres.memId} / 로그인한 사람 : ${SMEMBER.memId }	
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
							<div id="replydiv" style="padding-left: 40px;">			
							<c:if test= "${replylist.del == 'N'}">
								<label class="jg">${replylist.memId }</label>
									
								<textarea style="width:100%; overflow:visible; background-color:transparent; border:none;"  disabled class ="writeCon">${replylist.replyCont}</textarea>
								
<!-- 								</div> -->
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
						<div id="replyinsertdiv" style="padding-left: 30px;">		
						
							
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