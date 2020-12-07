<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>


<script type="text/javascript">
$(function(){
	
// 	resizeIt();	
    
	$('#todoDetail').hide();
	
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
		
		window.history.back();
	})
	
	// todo에서 뒤로가기
	$(document).on('click','#todoback', function(){
		$('#todoDetail').hide();
		$('#detailDiv').show();
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
			
// 				alert(data.issueId);
				$(location).attr('href', '${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId='+data.issueId);
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

<%-- <%@include file="./issuecontentmenu.jsp"%> --%>
<%@include file="../layout/contentmenu.jsp"%>

<body>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <!-- 이슈 상세보기 -->
	  <div class="card-body" id="detailDiv">
<!-- 		<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
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
				<label id ="memid" class="control-label">${issuevo.memId }</label> 
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
									
						<a href="${cp }/file/publicfileDown?pubId=${files.pubId}"><input id ="files${vs.index}"  type="button" class="btn btn-default" name="${files.pubId}" value="${files.pubFilename} 다운로드" ></a>
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
					<div class="col-sm-12">					
						<c:forEach items="${replylist }" var="replylist">
							<c:if test= "${replylist.del == 'N'}">								
								<textarea disabled class ="writeCon">${replylist.replyCont}</textarea>
								[ ${replylist.memId } / ${replylist.regDt} ] 	<hr>
								
<%-- 								<c:if test= "${issueVo.memId == 'pl1' && replylist.del == 'N'}">								 --%>
<%-- 									<a href = "${cp}/reply/delreply?replyId=${replylist.replyId}&someId=${replylist.someId}"> --%>
<!-- 											<input id ="delbtn2" type="button" class="btn btn-default" value ="삭제"/></a>								 -->
<%-- 								</c:if>							 --%>
							</c:if>		 														
							<c:if test= "${replylist.del == 'Y'}">								
								<textarea disabled class ="reply_con"> [삭제된 댓글입니다.]	</textarea>	<br>						
							</c:if>		 														
								
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
	    <div id="todoDetail" class="card-body">
	    
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





</body>
</html>