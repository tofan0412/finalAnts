<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
$(function(){

	$("#pagenum a").addClass("page-link");  
	
	$('#voteDetail').modal();
	console.log("뭔뎅")
})
</script>



<!-- 투표 상세보기 모달 -->
<!-- Modal to invite new Members . . . -->
<div class="modal fade" id="voteDetail" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content" style="height: 600px auto; width : 400px;">
			
			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable" style="text-align : center;">투표 상세보기</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div id="itemdiv" class="modal-body" style="width: 100%; height: 100%;">
									
					<input type="hidden" id="nextSeq">
					<label class="jg" style="float : left;">투표 제목</label>
					<input type="text" class="form-control" id="voteTitle" name="voteTitle" style="width : 90%;"/>
					<div class="jg"><span class="jg warningTitle" style="color : red;"></span></div>
					<!-- 사용자가 제목을 입력하지 않은 경우 .. -->
					
					<br>
					
					<label class="jg col-sm-3 control-label" style="float : left; display: inline-block;" >투표 항목</label>					
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-success" id="regBtn">등록</button>
			</div>
		</div>
	</div>
</div>