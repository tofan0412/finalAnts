<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
$(function(){
	todoSearchList = [];
	$('#todoDetail').hide();
	removeList = [];
	fileCnt = $('.sgtFile').length;	// 현재 모달창 목록에 존재하는 파일 갯수
	newFileCnt = 0;					// 새롭게 업로드할 파일의 갯수
	sgtId = "${suggestVo.sgtId}";
	
	$('.sgtFileList').on('click', '.sgtFile', function(){
		$(this).css('display', 'none');
		fileCnt = fileCnt -1;
		removeList.push($(this).attr('pubId'));
	})
	
	// 건의사항 수정하기
	$('#modSuggest').click(function(){
		$('#todoIdModal').val("${suggestVo.todoId}:현재 일감 번호");
		$('#sgtTitleModal').val("${suggestVo.sgtTitle}");
		$('#sgtContModal').val("${suggestVo.sgtCont}");
		$('.warningTodo').empty();
		$('.warningTitle').empty();
		$('.sgtFile').css('display', 'block');
		
		fileCnt = $('.sgtFile').length;
		removeList = [];
		$('.file').val('');
		$('.sgtFileListNew').empty();
		
		$('#modSuggestModal').modal();
	})
	
	$('#delSuggest').click(function(){
		var factor = confirm("삭제하시겠습니까?");
		if (factor){
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
			// 파일 먼저 수정한다. 
			// removeList길이를 확인한다.
			if (removeList.length != 0){	// 사용자가 삭제할 리스트를 추가했다면 ..
				$.ajax({
					url : "/suggest/suggestFileMod",
					data : {"removeList" : removeList},
					method : "POST",
					success : function(res){
						window.location.reload();
					}
				})	
			}
			// 새로 올린 파일 업로드하기..
			formData = new FormData($('#suggestFileForm')[0]);
			$.ajax({
				url : "/suggest/suggestFileInsert?sgtId="+sgtId,
				type : "POST",
				data : formData,
				contentType : false,
				processData : false,
				success : function(res){
					window.location.reload();
				}
			})
			// 이후 게시글을 수정한다. 
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

// 파일 갯수 제한, 파일 용량 제한..
function fileRestrict(fileNum){
	$('.sgtFileListNew').empty();
	if (fileNum + fileCnt > 5){	// 기존에 존재하는 파일 개수 + 추가할 파일 개수가 5개가 넘어선 안된다.
		alert("파일은 최대 5개까지 첨부할 수 있습니다.");
		$('.file').val('');
		newFileCnt = 0;
	}
	else{
		newFileCnt = fileNum;	// 새롭게 업로드할 파일의 갯수
		for(var i = 0 ; i < fileNum ; i++){
			if ( ($('.file')[0].files[i].size/1024)/1024 >= 20 ){
				alert("20MB 이상의 파일은 업로드할 수 없습니다.("+$('.file')[0].files[i].name+")");
				$('.sgtFileListNew').empty();
				$('.file').val('');
				newFileCnt = 0;
				return;
			}else{
				$('.sgtFileListNew').append($('.file')[0].files[i].name+"<br>");
			}
		}
	}
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
	font-size: 1.2em;
}
#issuecont{
	display: inline-block;
	float: left;
}
.writeCon{
	resize :none;
	width: 500px  ;
	height: 100px; 
}
#re_con{
	width: 500px;
	height: 100px;
   	resize: none;
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
#queue {
	border: 1px solid #E5E5E5;
	height: 177px;
	width : 90%;
	overflow: auto;
	margin-bottom: 10px;
	padding: 0 3px 3px;
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
				
				<!-- 파일 목록 출력하기  -->
				<label class="col-sm-2 control-label" >첨부 파일 목록</label>
				<div class="form-group">
					<c:forEach items="${suggestFileList }" var="file" >
						<div class="fileListOrigin" pubId="${file.pubId }"><a href="/suggest/suggestFileDownload?pubId=${file.pubId }">${file.pubFilename } (${file.pubSize }KB)</a>
						</div>						
					</c:forEach>
					<c:if test="${suggestFileList eq null }">
						<span class="jg">첨부한 파일이 없습니다.</span>
					</c:if>
				</div>
				
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
		<div class="modal-content" style="height: 800px; width : 400px;">
			
			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable" style="text-align : center;">건의사항 수정</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body" style="width: 100%; height: 100%;">
				<form:form commandName="suggestVo" id="sgtForm" name="sgtForm" 
							action="/suggest/suggestMod" enctype="multipart/form-data">
					
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
				<br>
				
					
				<label class="jg">파일 첨부</label>&nbsp;&nbsp;
				<span>파일은 최대 5개까지 첨부 가능합니다.</span>
				<div class="sgtFileList">
					<c:forEach items="${suggestFileList }" var="file" >
						<div class="jg sgtFile" pubId="${file.pubId }">
							<a href="#">${file.pubFilename }</a>
						</div>
					</c:forEach>
				</div>
				
				<form id="suggestFileForm">
					파일 첨부하기..		
					<input name="file" type="file" class="file" 
						onchange="fileRestrict($('.file')[0].files.length)" multiple="multiple" />
					<div class="sgtFileListNew"></div>
				</form>
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-success" id="modBtn">수정</button>
			</div>
		</div>
	</div>
</div>
<!--  /Modal -->
