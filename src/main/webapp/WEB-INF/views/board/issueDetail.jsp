<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>


<script type="text/javascript">
$(function(){
	
	$('#todoDetaildiv').hide();
	
	$("#modissue").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/updateissueView?issueId=${issuevo.issueId}');
	})
	
	$("#delissue").on('click', function(){
        if(confirm("정말 삭제하시겠습니까 ?") == true){
			$(location).attr('href', '${pageContext.request.contextPath}/projectMember/delissue?issueId=${issuevo.issueId}');
        }else{
        	return;
        }
	})
	
	// 글씨 변환
 	if('${issuevo.issueKind}' == 'issue'){ 		
 		$('#issueKind').text('이슈');	
 			console.log('${issuevo.issueKind}')
	 		todo();
 			
 	}else if('${issuevo.issueKind}' == 'notice'){
 		$('#issueKind').text('공지사항');	
 	}
	
	
	
	// issue에서 뒤로가기
	$(document).on('click','#back', function(){
		if('${categoryId}' =='3'){ // 프로젝트 내 이슈글		
			$("#listform").attr("action", "${pageContext.request.contextPath}/projectMember/issuelist");
			listform.submit();			
		}else if('${categoryId}' == '8'){ // 나의 이슈글
			$("#listform").attr("action", "${pageContext.request.contextPath}/projectMember/myissuelist");
			listform.submit();						
		}else if('${categoryId}'=='9'){ // 나의 북마크
			$("#listform").attr("action", "${pageContext.request.contextPath}/bookmark/getallbookmark");
			listform.submit();						
		}
// 		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/issuelist?searchCondition=${searchCondition}&searchKeyword=${searchKeyword }&issueKind=${issueKind }&pageIndex=${pageIndex}');
// 		window.history.back(); 
	})
	
	// todo에서 뒤로가기
	$(document).on('click','#todoback', function(){
		$('#todoDetaildiv').hide();
		$('#detailDiv').show();
		window.history.back();
	})
	
	// 일감링크
	$(document).on('click','#todolink', function(){
		console.log('일감 링크')
		 todoId = $('#todoId').val()
		 
		 $('#todoDetaildiv').show();
		 $('#detailDiv').hide();
		console.log('일감 링크')
			
// 		 todoDetail(todoId)
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
				   $(location).attr('href', '${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId='+issueid);				
			 }
		})
	})
	
})


function resizeIt() {
// 	 $('.writeCon').on( 'keyup', 'textarea', function (e){
	        $('.writeCon').css('height', 'auto' );
	        $('.writeCon').height(  $('.writeCon').scrollHeight );
// 	     });



};
	
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
			
// 				alert(data.issueId);
				saveMsg();
				//$(location).attr('href', '${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId='+data.issueId);
		}

	});

}

function saveMsg(){
	var alarmData = {
						"alarmCont" : "${issuevo.issueId}&&${SMEMBER.memName}&&${SMEMBER.memId}&&/projectMember/eachissueDetail?issueId=${issuevo.issueId}&&${issuevo.issueTitle}"+ $('#re_con').val(),
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
				
				let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memId +"&&"+ alarmData.alarmType;
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

</head>

<!-- 이슈메뉴에서만 include -->
<c:if test="${categoryId == 3 }">
	<%@include file="../layout/contentmenu.jsp"%>
</c:if>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
	  <!-- 이슈 상세보기 -->
	  <div class="card-body" id="detailDiv">
			
			<form id="listform" action="${pageContext.request.contextPath}/projectMember/issuelist" method="post">
			    <input type="hidden" value="${searchCondition }" name="searchCondition">
			    <input type="hidden" value="${searchKeyword }" name="searchKeyword">
			    <input type="hidden" value="${issueKind }" name="issueKind">
			    <input type="hidden" value="${pageIndex }" name="pageIndex">
			</form>
			
<%-- 			${searchCondition }, --%>
<%-- 			${searchKeyword }, --%>
<%-- 			${issueKind }, --%>
<%-- 			${pageIndex } --%>
			
			<!-- 북마크, 내가작성한 이슈일 경우 프로젝트명을 찍어주기위함 -->
			<c:if test="${categoryId == 8 or categoryId == 9}">
				<c:set var="projectNAME" value="${issuevo.proName}"></c:set>
				<h1 class="jg">${projectNAME}</h1> 
				<hr><br>
			</c:if>
			
			<h3>협업이슈 상세내역</h3>
			<br>
			<div class="form-group">
				<label for="issueKind" class="col-sm-2 control-label">종류</label>
				<label id ="issueKind" class="control-label"></label> 							
			</div>
			
			<div class="form-group" id ="todo">
				
			</div>
			

			<div class="form-group">
				<label for="memid" class="col-sm-2 control-label">작성자</label>
				<label id ="memid" class="control-label">${issuevo.memName }</label> 
			</div>

			<div class="form-group">
				<label for="regDt" class="col-sm-2 control-label">작성일</label>
				<label id ="regDt" class="control-label">${issuevo.regDt }</label> 
			</div>
	
			<div class="form-group">
				<label for="issueTitle" class="col-sm-2 control-label">이슈제목</label>
				<label id ="issueTitle" class="control-label">${issuevo.issueTitle}</label>
			</div>

			<div class="form-group">
				<label id="issuecont" for="issueCont" class="col-sm-2 control-label">이슈 내용</label>
			
				<c:if test="${issuevo.issueCont == '<p><br></p>'}">
					[ 내용이 없습니다. ]
				</c:if>
				<c:if test="${issuevo.issueCont == null}">
					[ 내용이 없습니다. ]
				</c:if>
				
				<label id ="issueCont" class="control-label">${issuevo.issueCont }</label>
			</div>	
			

			<div class="form-group">
				<label id="filelabel" for="File" class="col-sm-2 control-label">첨부파일</label>
				<div id = "filediv">
					<c:if test="${filelist.size() == 0}">
						[ 첨부파일이 없습니다. ]
					</c:if>
					
					<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1" >
															 					
						<a href="${cp }/file/publicfileDown?pubId=${files.pubId}">
							<button id ="files${vs.index}" class="btn btn-default" name="${files.pubId}">
								<img name="link" src="/fileFormat/${fn:toLowerCase(files.pubExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
								 ${files.pubFilename} 다운로드
							</button>
						
						</a>
						<br>
					</c:forEach>
				</div>
			</div>
			
			
			<br>	
			<div class="card-footer clearfix" >
				
		 			<c:if test="${issuevo.memId == memId}">
						<input type= "button" value="삭제하기" id="delissue"  class="btn btn-default float-right" >			
						<input type= "button" value="수정하기" id ="modissue" class="btn btn-default float-right" style="margin-right: 5px;">
						<input type= "button" value="목록으로" id ="back" class="btn btn-default float-left" >
					</c:if>
				
            </div>
            
            
            <form class="form-horizontal" role="form" id ="frm" method="post" action="${pageContext.request.contextPath}/reply/insertreply">	
				<div class="form-group">
				<hr>
					<label for="pass" class="col-sm-2 control-label">댓글</label>
					<div class="col-sm-12" id="replydiv">					
						<c:forEach items="${replylist }" var="replylist">
							<c:if test= "${replylist.del == 'N'}">								
								<textarea disabled class ="writeCon">${replylist.replyCont}</textarea>
								[ ${replylist.memId } / ${replylist.regDt} ] 	
								
								<c:if test= "${replylist.memId == SMEMBER.memId && replylist.del == 'N'}">		
									<input type="hidden" value="${replylist.replyId}">
									<input type="hidden" value="${replylist.someId}">																							
									<input id ="replydelbtn" type="button" class="btn btn-default" value ="삭제"/>						
								</c:if>		
												
							</c:if>		 														
							<c:if test= "${replylist.del == 'Y'}">								
								<textarea disabled class ="writeCon"> [삭제된 댓글입니다.]	</textarea>					
							</c:if>		 														
							<hr>	
						</c:forEach>
						<br>
						 <input type="hidden" name="someId" value="${issuevo.issueId }">
						 <input type="hidden" name="categoryId" value="${issuevo.categoryId}">
						 <input type="hidden" name="reqId" value="${issuevo.reqId }">
						 <input type="hidden" name="memId" value="${issuevo.memId }">
							<textarea name = "replyCont" id ="re_con"  ></textarea>&nbsp;<input id="replybtn2" type = "button" class="btn btn-default" value = "댓글작성"><br>
							<span id="count"> 0</span> &nbsp;자 / 500 자 
							
					</div>
				</div>
			</form>
	    </div>
		<!-- 이슈 상세보기 끝-->  
	
	
	    <!-- 일감 상세보기 -->
	    <div id="todoDetaildiv" class="card-body">
	    
	    	<h3>일감 상세보기</h3><br>
		
			<input type="hidden" id="todoId">
			<div class="form-group">
				<label for="todoTitle" class="col-sm-2 control-label">제목</label>
				<label class="control-label" id="todoTitle"></label>
			</div>
			
			<div class="form-group">
				<label for="todoCont" class="col-sm-2 control-label">할일</label>
				<label class="control-label" id="todoCont"></label>
			</div>
			<div class="form-group">
				<label for="memId" class="col-sm-2 control-label">담당자</label>
				<label class="control-label" id="memId"></label>
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
				<label for="todoEnd" class="col-sm-2 control-label">종료 일</label>
				<label class="control-label" id="todoEnd"></label>
			</div>
			
			<div class="card-footer clearfix" >
				<button type="button" class="btn btn-default" id="todoback">뒤로가기</button>					
			</div>
		
		</div>
	   </div>
	   <!-- 일감 상세보기   끝-->



</div>

</html>