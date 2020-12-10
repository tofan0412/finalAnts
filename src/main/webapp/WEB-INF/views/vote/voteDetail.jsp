<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<script type="text/javascript">
$(function(){

	$("#pagenum a").addClass("page-link");  
	
	console.log("뭔뎅")
	
	// 투표하기 버튼
	$(document).on('click', '#votejoinbtn', function(){	
		$('input[type=radio]').prop('checked',false);
		$('#voteDetail').modal();
	})
	
	// 투표완료 버튼
	$('#regBtn').on('click', function(){		
		var vote = $("input[type=radio]:checked").val();
		var voteid =  '${voteVo.voteId}';
		console.log(voteid)
		$(location).attr('href', '${pageContext.request.contextPath}/vote/voteMember?voteitemId='+vote+'&voteId='+voteid);
	})
	
	// 뒤로가기
	$(document).on('click','#back', function(){
		
		window.history.back();
	})
	

	// 투표율 구하기
	a = Math.round(${voteVo.votedNo}/${voteVo.voteTotalno} * 100)
	a += '%'
	$('#votePercent').html(a)
	
		
})
</script>


<style type="text/css">
	label{
	
		width : auto;
/* 		height : 30px; */
		font-size: 1.2em;
	}
	
</style>

<%@include file="../layout/contentmenu.jsp"%>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
	    
	    <!-- 일감 상세보기 -->
	    <div id="todoDetail" class="card-body">
	    
	    	<h3>투표 상세보기</h3><br>
		
			<input type="hidden" id="todoId">
			
			<div class="form-group ">
				<label for="voteTitle" class="col-sm-2 control-label">제목</label>
				<label class="control-label" id="voteTitle">${voteVo.voteTitle }</label>
			</div>
			
			<div class="form-group " >
				<label for="voteitemName" class="control-label col-sm-2" style=" float : left;">투표항목</label>				
				<c:forEach items="${itemlist }" var="item" varStatus="status">				
						<label class="control-label col-sm-10 float-right">${status.index+1 } . &nbsp; ${item.voteitemName } 
												&nbsp; ${item.voteCount }명</label><br>					
				</c:forEach>
			</div>
			<br>
			<div class="form-group">
				<label for="memId" class="control-label col-sm-2">개시자</label>
				<label class="control-label" id="memId">${voteVo.memId }</label>
			</div>
			
			<div class="form-group">
				<label for="voteTotalno" class="col-sm-2 control-label">투표인원</label>
				
				<label class="control-label " id="voteTotalno">${voteVo.votedNo}명 / ${voteVo.voteTotalno}명  </label> 
				
			</div>
			<div class="form-group">
				<label for="voteTotalno" class="col-sm-2 control-label">투표율</label>
		
				<label class="control-label " id="votePercent"> </label>
				
			</div>
			
			<div class="form-group">
				<label for="voteDeadline" class="col-sm-2 control-label">종료일</label>
				<label class="control-label" id="voteDeadline">${voteVo.voteDeadline}</label>
			</div>
			
			
			<div class="card-footer clearfix" id="btndiv" >
				<button type="button" class="btn btn-default" id="back">뒤로가기</button>		
				${voteres.memId} / ${SMEMBER.memId }				
				<c:if test="${voteres.memId ne SMEMBER.memId }">
					<button type="button" class="btn btn-default float-right" id="votejoinbtn">투표참여하기</button>
				</c:if>
				
				<c:if test="${voteres.memId ne SMEMBER.memId }">
					<button type="button" class="btn btn-default float-right" id="votejoinbtn">투표참여하기</button>
				</c:if>
				
							
			</div>
		
		</div>
	    
	          
	   </div>
	   <!-- 일감 상세보기   끝-->
	   
	
	   
</div>












<!-- 투표 상세보기 모달 -->
<!-- Modal to invite new Members . . . -->
<div class="modal fade" id="voteDetail" tabindex="-1 " role="dialog" style="  padding-top: 150px;">
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
<!-- 					<input type="radio" name="voteItem" style=" width : 20px; height: 20px; float : left; display: inline-block; "  >   -->
<!-- 					  <label class="jg" for="huey"> &nbsp;Huey2</label><br> -->
<!-- 					<input type="radio" name="voteItem" style=" width : 20px; height: 20px; float : left; display: inline-block; " > -->
<!-- 					  <label class="jg" for="huey"> &nbsp;Huey3</label><br> -->
					</div>
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-success" id="regBtn">투표하기</button>
			</div>
		</div>
	</div>
</div>