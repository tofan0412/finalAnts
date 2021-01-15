<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<script type="text/javascript">
$(function(){
	
	todo(); // 일감 불러오기
	
	// 일감내역 숨기기
	$('#todoDetaildiv').hide();
	
	// 댓글 자동 높이 
	$('.writeCon').each(function () {	
		  this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
	}).on('input', function () {
		  this.style.height = 'auto';
		  this.style.height = (this.scrollHeight) + 'px';
	});	
	
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
	
 	// 건의사항에서 뒤로가기
	$(document).on('click','#back', function(){
		$("#listform").attr("action", "${pageContext.request.contextPath}/suggest/readSuggestList");
		listform.submit();		
	})
	
	// todo에서 뒤로가기
	$(document).on('click','#todoback', function(){
		$('#todoDetaildiv').hide();
		$('#detailDiv').show();
		window.history.back();
	})
	
	// 일감 검색을 위해 키워드를 작성한 경우 자동완성
// 	$('#todoIdModal').keyup(function(){
// 		var keyword = $(this).val();
// 		$('.warningTodo').empty();
// 		// 사용자가 입력을 한 경우, 키워드를 통해 일감을 검색한다.
// 		if (keyword != ''){
// 			$.ajax({
// 				url : "/suggest/searchTodo",
// 				data : {keyword : keyword},
// 				method : "GET",
// 				success : function(res){
// 					todoSearchList = [];
// 					for (var i = 0 ; i < res.length; i++){
// 						if (keyword == '@'){
// 							todoSearchList.push("@["+res[i].todoId+"]"+":"+res[i].todoTitle);
// 						}else{
// 							todoSearchList.push("["+res[i].todoId+"]"+":"+res[i].todoTitle);	
// 						}
// 					}
// 					autoComplete(todoSearchList);
// 				}
// 			})
// 		}
// 	})
	
	$('#sgtTitleModal').keyup(function(){
		$('.warningTitle').empty();
	})
	
	// 뒤로가기
	$(document).on('click','#back', function(){
		window.history.back();
	})
	
	// 일감링크
	$(document).on('click','#todolink', function(){
		 console.log('일감 링크')
		 todoId = $('#todoId').val()
		 
		 $('#todoDetaildiv').show();
		 $('#detailDiv').hide();
		console.log('일감 링크')
			
	})
	
	// 댓글 작성
	$('#replybtn2').on('click', function(){
		replyinsert();
	})
	
	// 댓글 작성하기 삭제 버튼
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
				   $(location).attr('href', '${pageContext.request.contextPath}/suggest/suggestDetail?sgtId='+someid);				
			 }
		})
	})
	
	
	// 답글 글자수 계산
	$('#re_con').keyup(function (e){
	    var content = $(this).val();
	  
// 	    console.log(content)
		
	    $('#counter').html("('+content.length+' / 최대 300자)");    //글자수 실시간 카운팅	  
		$('span').html(content.length);
		
	    if (content.length > 300){
	        alert("최대 300자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 300));
	        $('span').html("(200 / 최대 300자)");
	    }
	});
	
	
	// mouseover 이벤트
	$('.singleTodo').on('mouseenter',function(){
		$(this).css("background-color", 'lightgrey');
	})
	
	$('.singleTodo').on('mouseleave',function(){
		$(this).css("background-color", 'white');
	})
	
	// 목록에 있는 일감 추가하기..
	$('#modSuggestModal').on('click', '.singleTodo', function(){
		$('.warningTodo').empty();
		
		var todoId = $(this).attr("todoId");
	    var todoTitle = $(this).attr("todoTitle");
		
	    $('#todoIdModal').val(todoId+":"+todoTitle);
	})
	
	// 일감 검색 기능..
	$('#searchTodoMod').keyup(function(){
		$('.warningTodo').empty();
		var keyword = $(this).val();
		
		for (var i = 0 ; i < $('.singleTodo').length ; i++){
			if ($('.singleTodo')[i].attributes[2].value.includes(keyword)){
				$('.singleTodo')[i].style.display = 'block';
			}else{
				$('.singleTodo')[i].style.display = 'none';
			}	
		}
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
	
	$('#takeIt').click(function(){
		$('.takeItModal').modal();
	})
	
	// 해당 건의 사항을 승인한다.
	$('#suggestAcceptBtn').click(function(){
		// 건의 사항 상태를 ACCEPT로 수정한다.
		sgtId = '${suggestVo.sgtId}';
		$.ajax({
			url : "/suggest/acceptOrReject",
			data : {sgtId : sgtId, sgtStatus : 'ACCEPT'},
			async:false,
			success : function(res){
				if (res > 0){
					alert("승인 처리하였습니다.");
					var alarmData = {
							"alarmCont" : "${projectVo.reqId}&&${SMEMBER.memName}&&${SMEMBER.memId}&&/suggest/suggestDetail?sgtId=${suggestVo.sgtId }&&${projectVo.proName}&&ACCEPT&&${suggestVo.sgtTitle }",
							"memId"	: "${suggestVo.memId }",
							"alarmType" : "res-suggest"
					}
					saveSResMsg(alarmData);
					if (confirm("일감 수정페이지로 이동하시겠습니까?")) {
						// 담당자 변경 페이지로 이동한다.
						todoId = '${suggestVo.todoId}';
						$(location).attr("href", "/todo/updatetodoView?todoId="+todoId);
					}else{
						$(location).attr("href", "/suggest/readSuggestList");
					}
				}else{
					alert("승인 처리 실패했습니다.");
				}
			}
		})
	})
	
	// 해당 건의 사항을 반려한다.
	$('#suggestRejectBtn').click(function(){
		// 해당 건의사항 글의 status를 reject로 변경한다. 
		sgtId = '${suggestVo.sgtId}';
		$.ajax({
			url : "/suggest/acceptOrReject",
			data : {sgtId : sgtId, sgtStatus : 'REJECT'},
			async:false,
			success : function(res){
				if (res > 0){
					alert("반려 처리하였습니다.");
					var alarmData = {
							"alarmCont" : "${projectVo.reqId}&&${SMEMBER.memName}&&${suggestVo.sgtId }&&${projectVo.proName}&&REJECT&&${suggestVo.sgtTitle }",
							"memId"	: "${suggestVo.memId }",
							"alarmType" : "res-suggest"
					}
					saveSResMsg(alarmData);
					
					
				}else{
					alert("반려 처리에 실패하였습니다.");
				}
			}
		})
	})
	
	/* 건의사항  응답 알림메세지 db에 저장하기 */
	function saveSResMsg(alarmData){
		$.ajax({
				url : "/alarmInsert",
				data : JSON.stringify(alarmData),
				type : 'POST',
				contentType : "application/json; charset=utf-8",
				dataType : 'text',
				async:false,
				success : function(data){
					
					let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memId +"&&"+ alarmData.alarmType;
					socket.send(socketMsg);
					// 건의사항 리스트로 이동한다. 
					$(location).attr("href", "/suggest/readSuggestList");
					
				},
				error : function(err){
				}
		});
	}
	
}) // $(function(){}) END

// 자동 완성 부분 ..
// function autoComplete(todoSearchList){
// 	$('#todoIdModal').autocomplete({
// 		source : todoSearchList,
// 		select : function(event, ui){
// 			console.log(ui.item);
// 		},
// 		minLength : 1,
// 		// 모달 창 위로 떠야 한다..
// 		appendTo : $('#modSuggestModal'),
// 		focus: function(event, ui) {
//             return false;
//         }
// 	})
// }

//일감 상세보기
function todo(){

 	$.ajax({url :"/todo/myonetodo",
		   data :{todoId : "${suggestVo.todoId}"},
		   method : "get",
		   success :function(data){	
				console.log(data.todoVo.memId)	
			 
				html = '<th class="success jg">일감</th>';
				html += '<td colspan="3" id ="todo">';		  
				html += '<label id ="todoId" class="control-label"><a  data-todoid='+data.todoVo.todoId+' id="todolink" href="#">'+data.todoVo.todoTitle+'</a></label></td>'

				$('#todo').html(html);
				
				$("#todoTitle").html(data.todoVo.todoTitle);
				$("#todoCont").html(data.todoVo.todoCont);
				$("#todoMemId").html(data.todoVo.memName);
				
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

// 댓글 작성
function replyinsert() {

	$.ajax({
		url : "${pageContext.request.contextPath}/reply/insertreply",
		method : "post",
		data : {
			someId :  '${suggestVo.sgtId }',
			categoryId : '4',
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
			"alarmCont" : reqId + "&&${SMEMBER.memName}&&${SMEMBER.memId}&&/suggest/suggestDetail&&${suggestVo.sgtId}&&${suggestVo.sgtTitle}&&"+ $('#re_con').val() + "&&${projectVo.proName}",
			"memId" 	: "${suggestVo.memId}",
			"alarmType" : "reply-4"
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
				$(location).attr('href', '${pageContext.request.contextPath}/suggest/suggestDetail?sgtId=${suggestVo.sgtId }');
			},
			error : function(err){
				
			}
	});
}


//댓글작성시 작동 증가
function resize(obj) {
	  obj.style.height = "1px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
}

</script>

<style type="text/css">
label{
	width : auto;

}
#issuecont{
	display: inline-block;
	float: left;
}
.writeCon{
width:100%; overflow:visible; background-color:transparent; border:none;
 		resize :none; 
 		padding-left: 40px;
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
.form-control:disabled, .form-control[readonly] {
  background-color: white;
}
.success{
	background-color: #f6f6f6;
	width: 10%;
	text-align: center;
}


</style>
<%@include file="/WEB-INF/views/layout/contentmenu.jsp"%>
<div class="col-12 col-sm-12">
	<div class="card card-teal ">
		<!-- 이슈 상세보기 -->
		<div class="card-body" id="detailDiv">
			<form id="listform" action="${pageContext.request.contextPath}/projectMember/issuelist" method="post">
			    <input type="hidden" value="${searchCondition }" name="searchCondition">
			    <input type="hidden" value="${searchKeyword }" name="searchKeyword">
			    <input type="hidden" value="${pageIndex }" name="pageIndex">
			</form>
		
			<br>
			<h4 class="jg">건의사항 상세내역</h4>
			<br>
			
			<table class="table" >
		        <tr class="stylediff">
		            <th class="success jg">제목</th>
		         	<td colspan="3">		
		         		<label id="sgtTitle" class="control-label">${suggestVo.sgtTitle}</label>
		         	</td>						        
		        </tr> 
		        
		        <tr class="stylediff" id ="todo" >
		           
		        </tr>
		        
		        <tr class="stylediff">
		            <th class="success jg">작성자</th>
		            <td style="padding-left: 20px; width: 700px;">
		            	<label id="memId" class="control-label" >${suggestVo.memName }</label>
		            </td>
		          	
		       
		            <th class="success jg">작성일</th>		            
		            <td style="padding-left: 20px; width: 700px;">
		            	<label id="regDt" class="control-label" >${suggestVo.regDt }</label>
		            </td>
		        </tr>  
		         
		        <tr>
		            <th class="success jg" style="height: 300px;">내용</th>
		            <td colspan="3">
			            <c:if test="${suggestVo.sgtCont == ''}">
							[ 내용이 없습니다. ]
						</c:if>
						<c:if test="${suggestVo.sgtCont == null}">
							[ 내용이 없습니다. ]
						</c:if>
						<label id="sgtCont" class="control-label">${suggestVo.sgtCont }</label>
			           
		            </td>
		        </tr>
		        <tr>
		        	<th class="success jg" style="height: 150px;">첨부파일</th>
		            <td colspan="3">
			            <div id = "filediv">
							<c:if test="${suggestFileList.size() == 0}">
								<label class="jg">	[ 첨부파일이 없습니다. ] </label>
							
							</c:if>
							
							<c:forEach items="${suggestFileList }" var="files" begin ="0" varStatus="vs" end="${suggestFileList.size() }" step="1" >
																	 					
								<a href="${cp }/file/publicfileDown?pubId=${files.pubId}">
									<button id ="files${vs.index}" class="btn btn-default jg" name="${files.pubId}">
										<img name="link" src="/fileFormat/${fn:toLowerCase(files.pubExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
										 ${files.pubFilename} 다운로드
									</button>
								
								</a>
								<br>
							</c:forEach>
						</div>
					</td>
		        
		        </tr>
		    </table>
		   
				<div class="card-footer clearfix">
					<c:if test="${suggestVo.memId == SMEMBER.memId}">
						<input type="button" value="삭제하기" id="delSuggest"							
							class="btn btn-default float-right jg">
							
						<input type="button" value="수정하기" id="modSuggest"
							class="btn btn-default float-right jg" style="margin-right: 5px;">
					</c:if>
						<input type="button" value="목록으로" id="back"
							class="btn btn-default float-left jg">
						<!-- PL인 경우 해당 건의 사항에 대해 바로 처리할 수 있다. -->
						<c:if test="${projectVo.memId == SMEMBER.memId 
						             && suggestVo.sgtStatus != 'ACCEPT' 
						             && suggestVo.sgtStatus != 'REJECT'}">
							<input type="button" value="처리하기" id="takeIt"
								class="btn btn-info float-left jg" style="margin-left : 5px;">
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
						<div id="replyinsertdiv" style="padding-left: 30px;">		
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
			<!-- 건의사항 상세보기 끝-->

		<!-- 일감 상세보기 -->
	    <div id="todoDetaildiv" class="card-body">
	    	
	    	<br>
	    	<h4 class="jg">일감 상세보기</h4><br>
			<input type="hidden" id="todoId">
			
			<table class="table" >
		        <tr class="stylediff">
		            <th class="success jg">제목</th>
		         	<td colspan="3">		
		         		<label class="control-label" id="todoTitle"></label>	  
		         	</td>						        
		        </tr> 
		        <tr class="stylediff">
		            <th class="success jg">담당자</th>
		            <td>
		            	<label class="control-label" id="todoMemId"></label>
		            </td>
		          	
		       
		            <th class="success jg">우선순위</th>		            
		            <td >
		            	<label class="control-label " id="todoImportance"></label>
		            </td>
		        </tr>
		         
		         <tr class="stylediff">
		            <th class="success jg">기간</th>
		            <td colspan="3">
		            	<label class="control-label" id="todoStart"></label> 
		            	<label class="control-label"> ~ </label><label class="control-label" id="todoEnd"></label>
		            </td>
		        </tr>
         
		        <tr>
		            <th class="success jg" style="height: 300px;">할일</th>
		            <td colspan="3">
			           <label class="control-label " id="todoCont"></label>
		            </td>
		        </tr>
		    </table>  
		    <div class="card-footer clearfix" >
				<button type="button" class="btn btn-default float-left jg" id="todoback">뒤로가기</button>					
			</div>
			
		<!-- 일감 상세보기   끝-->
	</div>
	</div>
</div>

<!-- Modal to modify my Suggest . . . -->
<div class="modal fade" id="modSuggestModal" tabindex="-1" role="dialog"
	aria-labelledby="modSuggestModal">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content" style="height: 600px; width : 800px;">
			
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
					
					<div class="modSuggestLeftArea" style="float : left; width : 45%;">
						<label class="jg">일감 수정</label>
						<form:input id="sgtIdModal" path="sgtId" value="${suggestVo.sgtId}" readonly="true" hidden="hidden" />
						<!-- 사용자가 일감을 선택하지 않은 경우 .. -->
						<div class="jg"><span class="jg warningTodo" style="color : red;"></span></div>
						<form:input id="todoIdModal" path="todoId" 
							style="width : 90%;
							       border : 2px solid lightgrey; 
								   border-radius : 0.7rem;" 
							value="${suggestVo.todoId}" readonly="true" />
						<br><br>
						<label class="jg" style="float: left;">일감 제목 검색</label> 
						<input class="jg" type="text" id="searchTodoMod"
							style="width: 90%; 
								   border: 2px solid lightgrey; 
								   border-radius: 0.7rem;"
							placeholder="키워드를 입력해 주세요.." autocomplete="off"> 
						<br><br>
					
					<!-- 내 일감 목록 리스트를 출력한다. -->
					<div style="height : 250px; overflow-y : auto;">
						<c:forEach items="${myTodoList}" var="myTodo">
							<div class="jg singleTodo" todoId="${myTodo.todoId }"
								todoTitle="${myTodo.todoTitle }"
								style="width: 90%; height: 50px; overflow-y: auto;">
								
								<c:if test="${fn:length(myTodo.todoTitle) > 10 }">
									${fn:substring(myTodo.todoTitle,0,10)}...
									</c:if>
									<c:if test="${fn:length(myTodo.todoTitle) <= 10 }">
									${myTodo.todoTitle }
								</c:if> 
								
								<span style="float: right;">일감번호 : ${myTodo.todoId }</span><br>
								
								<c:if test="${myTodo.todoImportance == 'gen' }">
									<span class="jg" style="font-size: 1.0em;">일반</span>
								</c:if>
								<c:if test="${myTodo.todoImportance == 'emg' }">
									<span class="jg" style="font-size: 1.0em;">긴급</span>
								</c:if>
							</div>
							<br>
						</c:forEach>
					</div>
					</div>
					
					<div class="modSuggestRightArea" style="float : right; width : 50%;">
						<label class="jg" style="float : left;">건의 사항 제목</label>
						<!-- 사용자가 제목을 입력하지 않은 경우 .. -->
						<div class="jg"><span class="jg warningTitle" style="color : red;"></span></div>
						<form:input id="sgtTitleModal" path="sgtTitle" 
							style="width : 90%;
								   border : 2px solid lightgrey; 
							       border-radius : 0.7rem;" 
					        value="${suggestVo.sgtTitle}" autocomplete="off" />
						<br><br>
						
						<label class="jg">건의 사항 내용</label><br>
						<form:textarea id="sgtContModal" path="sgtCont" rows="3" cols="30" 
										style="resize: none; width : 90%;
											   border : 2px solid lightgrey; 
								       		   border-radius : 0.7rem;" 
										value="${suggestVo.sgtCont}" autocomplete="off" />
					</form:form>
					<br>
					
						
					<label class="jg">파일 첨부</label>&nbsp;&nbsp;
					<span class="jg">파일은 최대 5개까지 첨부 가능합니다.</span>
					<div class="sgtFileList">
						<c:forEach items="${suggestFileList }" var="file" >
							<div class="jg sgtFile" pubId="${file.pubId }">
								<a href="#">${file.pubFilename }</a>
							</div>
						</c:forEach>
					</div>
					
					<form id="suggestFileForm">
						<input name="file" type="file" class="file" 
							onchange="fileRestrict($('.file')[0].files.length)" multiple="multiple" />
						<div class="sgtFileListNew"></div>
					</form>
				</div>
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-success" id="modBtn">수정</button>
			</div>
		</div>
	</div>
</div>
<!--  /Modal -->

<div class="modal fade takeItModal" tabindex="-1" role="dialog" >
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content jg" style="width : 350px; height : 200px;">
			<div class="modal-header">
				<h3>건의사항 처리</h3>
			</div>
			
			<div class="modal-body" style="margin : 0 auto; width : 100%;">
				<button type="button" class="btn" id="suggestAcceptBtn" 
					style="width : 100%; 
						   background-color : #58ACFA;
						   height : 50px;">승인</button>
				<button type="button" class="btn" id="suggestRejectBtn"
					style="width : 100%;
						   background-color : #FFBF00;
						   height : 50px;">반려</button>
			</div>
		</div>
	</div>
</div>

