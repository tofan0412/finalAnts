<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
$(function(){
	todoSearchList = [];
	$('#todoDetail').hide();
	
	// 건의사항 수정하기
	$('#modSuggest').click(function(){
		$('#todoIdModal').val("${suggestVo.todoId}:현재 일감 번호");
		$('#sgtTitleModal').val("${suggestVo.sgtTitle}");
		$('#sgtContModal').val("${suggestVo.sgtCont}");
		$('.warningTodo').empty();
		$('.warningTitle').empty();
		
		$('#modSuggestModal').modal();
	})
	
	$('#delSuggest').click(function(){
		var factor = confirm("삭제하시겠습니까?");
		if (factor){
			var sgtId = "${suggestVo.sgtId}";
			$(location).attr("href", "/suggest/delSuggest?sgtId="+sgtId);
		}
		
	})
	
	// 일감 검색을 위해 키워드를 작성한 경우 자동완성
	$('#todoIdModal').keyup(function(){
		var keyword = $(this).val();
		$('.warningTodo').empty();
		// 사용자가 입력을 한 경우, 키워드를 통해 일감을 검색한다.
		if (keyword != ''){
			$.ajax({
				url : "/suggest/searchTodo",
				data : {keyword : keyword},
				method : "GET",
				success : function(res){
					todoSearchList = [];
					for (var i = 0 ; i < res.length; i++){
						if (keyword == '@'){
							todoSearchList.push("@["+res[i].todoId+"]"+":"+res[i].todoTitle);
						}else{
							todoSearchList.push("["+res[i].todoId+"]"+":"+res[i].todoTitle);	
						}
					}
					autoComplete(todoSearchList);
				}
			})
		}
	})
	
	$('#sgtTitleModal').keyup(function(){
		$('.warningTitle').empty();
	})
	
	// 뒤로가기
	$(document).on('click','#back', function(){
		window.history.back();
	})
	
	// 일감링크
	$(document).on('click','#todolink', function(){
		 todoId = $(this).data("todoid")
		 
		 $('#todoDetail').show();
		 $('#detailDiv').hide();
			
		 todoDetail(todoId)
	})
	
	// 댓글 작성
	$('#replybtn2').on('click', function(){
		replyinsert();
	})
	$('#replydiv').on('click','#replydelbtn', function(){
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
				   $(location).attr('href', '${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId='+issueid);				
			 }
		})
	})
	
	// 수정하기 버튼 클릭시..
	$('#modBtn').click(function(){
		cnt = 0;
		// 각 칸이 빈칸인지 아닌지를 확인해야 한다.
		if ($('#todoIdModal').val().length == 0){
			$('.warningTodo').text("일감을 지정해 주세요.");
			cnt++;
		}
		if ($('#sgtTitleModal').val().length == 0){
			$('.warningTitle').text("건의사항 제목을 지정해 주세요.");
			cnt++;
		}
		if (cnt == 0){
			$('#sgtForm').submit();
		}
	})
}) // $(function(){}) END

// 자동 완성 부분 ..
function autoComplete(todoSearchList){
	$('#todoIdModal').autocomplete({
		source : todoSearchList,
		select : function(event, ui){
			console.log(ui.item);
		},
		minLength : 1,
		// 모달 창 위로 떠야 한다..
		appendTo : $('#modSuggestModal'),
		focus: function(event, ui) {
            return false;
        }
	})
}

//일감 상세보기
function todo(){

 	$.ajax({url :"/todo/myonetodo",
		   data :{todoId : "${issuevo.todoId}"},
		   method : "get",
		   success :function(data){	
				console.log(data.todoVo)	
			 
				html = '<label for="todoId" class="col-sm-2 control-label">일감</label>'
				html += '<label id ="todoId" class="control-label"><a  data-todoid='+data.todoVo.todoId+' id="todolink" href="#">'+data.todoVo.todoTitle+'</a></label>'

				$('#todo').html(html);
				
				$("#todoTitle").html(data.todoVo.todoTitle);
				$("#todoCont").html(data.todoVo.todoCont);
				$("#memId").html(data.todoVo.memId);
				
				if(data.todoVo.todoImportance =='gen'){
					$("#todoImportance").html('일반');
				}else if(data.todoVo.todoImportance =='emg'){
					$("#todoImportance").html('긴급');
				}
				$("#todoStart").html(data.todoVo.todoStart);
				$("#todoEnd").html(data.todoVo.todoEnd);
				$("#todoId").val(data.todoVo.todoId);
		 }
	})
}

// 일감 상세보기
function todoDetail(todoId) {
	$.ajax({
		url : "/todo/myonetodo",
		method : "get",
		data : {
			todoId : todoId
		},
		success : function(data) {
			console.log(data)
			
			$('#todoDetail').show();
			$('#detailDiv').hide();
			
			$("#todoTitle").html(data.todoVo.todoTitle);
			$("#todoCont").html(data.todoVo.todoCont);
			$("#memId").html(data.todoVo.memId);
			if(data.todoVo.todoImportance =='gen'){
				$("#todoImportance").html('일반');
			}else if(data.todoVo.todoImportance =='emg'){
				$("#todoImportance").html('긴급');
			}
			
			$("#todoStart").html(data.todoVo.todoStart);
			$("#todoEnd").html(data.todoVo.todoEnd);
			$("#todoId").val(data.todoVo.todoId);
		}
	});
}


// 댓글 작성
function replyinsert() {
		someId : '${issuevo.issueId }';
	$.ajax({
	
		url : "${pageContext.request.contextPath}/reply/insertreply",
		method : "get",
		data : {
			someId :  '${issuevo.issueId }',
			categoryId : '${issuevo.categoryId}',
			replyCont : $('#re_con').val()
			
		},
		success : function(data) {
			saveMsg();
		}
	});
}

function saveMsg(){
	var alarmData = {
						"alarmCont" : "${issuevo.issueId},${SMEMBER.memName},${SMEMBER.memId},/projectMember/eachissueDetail?issueId=${issuevo.issueId},${issuevo.issueTitle}"+ $('#re_con').val(),
						"memId" 	: "${issuevo.memId}",
						"alarmType" : "reply"
	}
	console.log(alarmData);
	
	$.ajax({
			url : "/alarmInsert",
			data : JSON.stringify(alarmData),
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			dataType : 'text',
			success : function(data){
				
				let socketMsg = alarmData.alarmCont +","+ alarmData.memId +","+ alarmData.alarmType;
				socket.send(socketMsg);
			},
			error : function(err){
				console.log(err);
			}
	});
}
</script>

<style type="text/css">
	label{
		width : auto;
/* 		height : 30px; */
		font-size: 1.2em;
	}
	#issuecont{
		display: inline-block;
		float: left;
	}
	
/*  	.writeCon.autosize { min-height: 50px; }  */
	
	.writeCon{
 		resize :none;
/* 		background-color:transparent; */
		width: 500px  ;
  		height: 100px; 
/* 		min-height: 50px; */  
/*   		overflow: visible;  */
/*   		overflow-y:hidden; */

	}
	
	#re_con{
		width: 500px;
		height: 100px;
      	resize: none;
/*       	background-color:transparent; */
      	padding: 1.1em; /* prevents text jump on Enter keypress */
      	padding-bottom: 0.2em;
      	line-height: 1.6;
	}	
	
	#filediv{
		display: inline-block;
		
	}
	#filelabel{
		float: left;
	}
</style>
<%@include file="/WEB-INF/views/layout/contentmenu.jsp"%>
<div class="col-12 col-sm-9">
	<div class="card card-teal ">
		<!-- 이슈 상세보기 -->
		<div class="card-body" id="detailDiv">
			<h3>건의사항 상세내역</h3>
			<br>
			<div class="form-group" id="todo"></div>

			<div class="form-group">
				<label for="memId" class="col-sm-2 control-label">작성자</label> 
				<label id="memId" class="control-label">${suggestVo.memId }</label>
				
				<div class="form-group">
					<label for="regDt" class="col-sm-2 control-label">작성일</label> 
					<label id="regDt" class="control-label">${suggestVo.regDt }</label>
				</div>
				
				<div class="form-group">
					<label for="sgtTitle" class="col-sm-2 control-label">제목</label>
					<label id="sgtTitle" class="control-label">${suggestVo.sgtTitle}</label>
				</div>
				
				<div class="form-group">
					<label for="todoId" class="col-sm-2 control-label">일감 번호</label>
					<label id="todoId" class="control-label"><a href="#">${suggestVo.todoId}</a></label>
				</div>

				<div class="form-group">
					<label id="sgtCont" for="sgtCont" class="col-sm-2 control-label">내용</label>
					<c:if test="${suggestVo.sgtCont == ''}">
					[ 내용이 없습니다. ]
				</c:if>
					<c:if test="${suggestVo.sgtCont == null}">
					[ 내용이 없습니다. ]
				</c:if>
					<label id="sgtCont" class="control-label">${suggestVo.sgtCont }</label>
				</div>
				<br>
				
				<div class="card-footer clearfix">
					<c:if test="${suggestVo.memId == SMEMBER.memId}">
						<input type="button" value="삭제하기" id="delSuggest"
							
							class="btn btn-default float-right">
						<input type="button" value="수정하기" id="modSuggest"
							class="btn btn-default float-right" style="margin-right: 5px;">
					</c:if>
						<input type="button" value="목록으로" id="back"
							class="btn btn-default float-left">
				</div>


				<form class="form-horizontal" role="form" id="frm" method="post"
					action="${pageContext.request.contextPath}/reply/insertreply">
					<div class="form-group">
						<hr>
						<label for="pass" class="col-sm-2 control-label">댓글</label>
						<div class="col-sm-12" id="replydiv">
							<c:forEach items="${replylist }" var="replylist">
								<c:if test="${replylist.del == 'N'}">
									<textarea disabled class="writeCon">${replylist.replyCont}</textarea>
								[ ${replylist.memId } / ${replylist.regDt} ] 	
								
								<c:if
										test="${replylist.memId == SMEMBER.memId && replylist.del == 'N'}">
										<input type="hidden" value="${replylist.replyId}">
										<input type="hidden" value="${replylist.someId}">
										<input id="replydelbtn" type="button" class="btn btn-default"
											value="삭제" />
									</c:if>

								</c:if>
								<c:if test="${replylist.del == 'Y'}">
									<textarea disabled class="writeCon"> [삭제된 댓글입니다.]	</textarea>
								</c:if>
								<hr>
							</c:forEach>
							<br> <input type="hidden" name="someId"
								value="${issuevo.issueId }"> <input type="hidden"
								name="categoryId" value="${issuevo.categoryId}"> <input
								type="hidden" name="reqId" value="${issuevo.reqId }"> <input
								type="hidden" name="memId" value="${issuevo.memId }">
							<textarea name="replyCont" id="re_con"></textarea>
							&nbsp;<input id="replybtn2" type="button" class="btn btn-default"
								value="댓글작성"><br> <span id="count"> 0</span>
							&nbsp;자 / 500 자

						</div>
					</div>
				</form>

			</div>
			<!-- 이슈 상세보기 끝-->

			<!-- 일감 상세보기 -->
			<div id="todoDetail" class="card-body">

				<h3>일감 상세보기</h3>
				<br> <input type="hidden" id="todoId">
				<div class="form-group">
					<label for="todoTitle" class="col-sm-2 control-label">제목</label> <label
						class="control-label" id="todoTitle"></label>
				</div>

				<div class="form-group">
					<label for="todoCont" class="col-sm-2 control-label">할일</label> <label
						class="control-label" id="todoCont"></label>
				</div>
				<div class="form-group">
					<label for="memId" class="col-sm-2 control-label">담당자</label> <label
						class="control-label" id="memId"></label>
				</div>

				<div class="form-group">
					<label for="todoImportance" class="col-sm-2 control-label">우선순위</label>

					<label class="control-label" id="todoImportance"></label>
				</div>

				<div class="form-group">
					<label for="todoStart" class="col-sm-2 control-label">시작 일</label>
					<label class="control-label" id="todoStart"></label>
				</div>

				<div class="form-group">
					<label for="todoEnd" class="col-sm-2 control-label">종료 일</label> <label
						class="control-label" id="todoEnd"></label>
				</div>

				<div class="card-footer clearfix">
					<button type="button" class="btn btn-default" id="todoback">뒤로가기</button>
				</div>
			</div>
		</div>
		<!-- 일감 상세보기   끝-->
	</div>
</div>

<!-- Modal to modify my Suggest . . . -->
<div class="modal fade" id="modSuggestModal" tabindex="-1" role="dialog"
	aria-labelledby="inviteMemberModal">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content" style="height: 600px; width : 400px;">
			
			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable" style="text-align : center;">건의사항 수정</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body" style="width: 100%; height: 100%;">
				<form:form commandName="suggestVo" id="sgtForm" name="sgtForm" 
							action="/suggest/suggestMod">
					
					<label class="jg" style="float : left;">일감 수정</label>
					<form:input id="sgtIdModal" path="sgtId" value="${suggestVo.sgtId}" readonly="readonly" hidden="hidden" />
					<!-- 사용자가 일감을 선택하지 않은 경우 .. -->
					<div class="jg"><span class="jg warningTodo" style="color : red;"></span></div>
					<form:input id="todoIdModal" path="todoId" style="width : 90%;" value="${suggestVo.todoId}:현재 일감 번호" />
					<br><br>
					
					<label class="jg" style="float : left;">건의 사항 제목</label>
					<!-- 사용자가 제목을 입력하지 않은 경우 .. -->
					<div class="jg"><span class="jg warningTitle" style="color : red;"></span></div>
					<form:input id="sgtTitleModal" path="sgtTitle" style="width : 90%;" value="${suggestVo.sgtTitle}" />
					<br><br>
					
					<label class="jg">건의 사항 내용</label><br>
					<form:textarea id="sgtContModal" path="sgtCont" rows="3" cols="30" 
									style="resize: none; width : 90%;" value="${suggestVo.sgtCont}" />
				</form:form>
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-success" id="modBtn">수정</button>
			</div>
		</div>
	</div>
</div>
<!--  /Modal -->
