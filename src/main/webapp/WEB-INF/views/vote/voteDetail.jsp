<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function(){

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
	
})
</script>


<style type="text/css">
	label{
		width : 100px auto;
		font-size: 1.2em;
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
	
</style>

<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
	    
	    <!-- 일감 상세보기 -->
	    <div id="todoDetail" class="card-body">
	    
	    	<h3 class="jg">투표 상세보기</h3>
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
				<label for="voteTitle" class="control-label labels jg">제목</label>
				<label class="control-label jg" id="voteTitle">${voteVo.voteTitle }</label>
			</div>
			<br>
			<div class="div">
<!-- 				<label for="voteitemName" class="control-label labels" id="votesort"  style=" float : left;">투표항목</label>				 -->
				<c:forEach items="${itemlist }" var="item" varStatus="status">
						
						<label for="voteitemName" class="control-label labels jg" id="votesort"  style=" float : left;">
							<c:if test="${status.index == 0}">				
								투표항목	
							</c:if>
						</label>
						
						
						<div class="control-label float-left">		
							<label class="control-label jg float-left">${status.index+1 } . &nbsp; ${item.voteitemName }</label><br>
						
                      		<label class="control-label jg float-left per"  style=" float : left;">
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
				<label for="voteTotalno" class="control-label labels jg">투표인원</label>
				
				<label class="control-label jg" id="voteTotalno">${voteVo.votedNo}명 / ${voteVo.voteTotalno}명  </label> 
				
			</div>
			<br>
			<div class="div">
				<label for="voteTotalno" class="control-label labels jg">투표율</label>
		
				<label class="control-label jg" id="votePercent">	
					<fmt:formatNumber value="${voteVo.votedNo/voteVo.voteTotalno}" type="percent"></fmt:formatNumber> 		
				</label>
				
			</div>
			<br>
			<div class="div">
				<label for="voteDeadline" class="control-label labels jg">종료일</label>
				<label class="control-label jg" id="voteDeadline">${voteVo.voteDeadline}</label>
			</div>
			<br>
			<div class="div">
				<label for="memId" class="control-label labels jg">개시자</label>
				<label class="control-label jg" id="memId">${voteVo.memName }</label>
			</div>
			<hr>
			
			<div class="card-footer clearfix" id="btndiv" >
				<button type="button" class="btn btn-default jg" id="back">뒤로가기</button>		
				투표자 : ${voteres.memId} / 로그인한 사람 : ${SMEMBER.memId }	
				<c:if test="${voteVo.memId == SMEMBER.memId }">		
					<button type="button" class="btn btn-default float-right jg" id="votedelbtn">삭제하기</button>
				</c:if>			
				<c:if test="${voteVo.voteStatus =='ing'}">		
					<button type="button" style="margin-right: 5px;"  class="btn btn-default float-right jg" id="votejoinbtn">투표참여하기</button>
				</c:if>			
				
			</div>
		
		</div>
	    
	          
	   </div>
	   <!-- 일감 상세보기   끝-->	   
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