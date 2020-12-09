<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
$(function(){

	$("#pagenum a").addClass("page-link");  
	
	$('#voteInsert').modal();
	
	
})
</script>

<!-- Modal to invite new Members . . . -->
<div class="modal fade" id="voteInsert" tabindex="-1" role="dialog"
	aria-labelledby="inviteMemberModal">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content" style="height: 600px auto; width : 400px;">
			
			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable" style="text-align : center;">투표 작성</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body" style="width: 100%; height: 100%;">
									
					
					<label class="jg" style="float : left;">투표 제목</label>
					<div class="jg"><span class="jg warningTitle" style="color : red;"></span></div>
					<input type="text" class="form-control" id="voteTitle" name="voteTitle" style="width : 90%;"/>
					<!-- 사용자가 제목을 입력하지 않은 경우 .. -->
					
					<br><br>
					
					<label class="jg col-sm-3 control-label" style="float : left; display: inline-block;" >투표 항목</label>
					<button type="button" id="itemaddbtn" class="btn btn-light filebtn" style="outline: 0; border: 0;">
						<i class="fas fa-fw fa-plus" style=" font-size:15px; width : 100px;">&nbsp;항목 추가</i>
					</button> <br>
					
					<div class="form-group" id="itemdiv">
						<input type="search" class="form-control" id="voteItemName" name="voteItemName"  style="display: inline-block; width: 90%;"> 
						<button type="button" id="btnMinus" class="btn btn-light" style=" display: inline-block; float :right; outline: 0; border: 0;">
							<i class="fas fa-fw fa-minus" style=" font-size:10px;"></i>
						</button>				
					</div>
					<div class="jg"><span class="jg warningItem" style="color : red;"></span></div>
					
					<label class="jg">마감일</label><br>
					<input type="datetime-local" class="form-control" id="voteDeadline" name="voteDeadline" style="width : 50%;" >
					<div class="jg"><span class="jg warningDate" style="color : red;"></span></div>
					
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-success" id="regBtn">등록</button>
			</div>
		</div>
	</div>
</div>
