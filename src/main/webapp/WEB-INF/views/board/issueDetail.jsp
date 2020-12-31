<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
$(function(){
	
	// 댓글 높이 자동 맞춤
	$('.writeCon').each(function () {	
		  this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
	}).on('input', function () {
		  this.style.height = 'auto';
		  this.style.height = (this.scrollHeight) + 'px';
	});

	// 일감내역 숨기기
	$('#todoDetaildiv').hide();
	
	// 수정하기 버튼
	$("#modissue").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/updateissueView?issueId=${issuevo.issueId}');
	})
	
	// 삭제하기 버튼
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
		if('${categoryId}' =='3' || '${categoryId}' =='2'){ // 프로젝트 내 이슈글		
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
			
	})
	
	// 댓글 작성
	$('#replybtn2').on('click', function(){
		replyinsert();
	})
	
	// 댓글 작성하기 삭제 버튼
	$('#replydiv').on('click','#replydelbtn', function(){
		if(confirm("댓글을 정말 삭제하시겠습니까 ?") == true){   
			
			var someid = $(this).prev().val();
			var replyid = $(this).prev().prev().val();
			issueid = '${issuevo.issueId }'
			console.log(replyid)
			console.log(someid)
			$.ajax({url :"/reply/delreply",
				   data :{replyId: replyid,
					       someId: someid, 
					       reqId : '${issuevo.reqId}'},
				   method : "get",
				   success :function(data){	
					   console.log(data)
					   $(location).attr('href', '${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId='+issueid+'&reqId='+reqId);				
				 }
			})
		}else{
        	return;
        }
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
	
	

	

})


	
//일감 상세보기
function todo(){

 	$.ajax({url :"/todo/myonetodo",
		   data :{todoId : "${issuevo.todoId}"},
		   method : "get",
		   success :function(data){	
				console.log(data.todoVo)	
			 
				html = '<th class="success jg">일감</th>';
				html += '<td colspan="3" id ="todo">';		  
				html += '<label  id ="todoId" class="control-label"><a  data-todoid='+data.todoVo.todoId+' id="todolink" href="#">'+data.todoVo.todoTitle+'</a></label></td>'

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


//댓글 작성
function replyinsert() {
		someId : '${issuevo.issueId }';
	$.ajax({
	
		url : "${pageContext.request.contextPath}/reply/insertreply",
		method : "post",
		data : {
			someId :  '${issuevo.issueId }',
			categoryId : '${issuevo.categoryId}',
			replyCont : $('#re_con').val(),
			reqId : '${issuevo.reqId}'
			
		},
		success : function(data) {
				saveMsg(reqId);
		}

	});

}
//댓글알림
function saveMsg(reqId){
	var alarmData = {
						"alarmCont" : reqId + "&&${SMEMBER.memName}&&${SMEMBER.memId}&&/projectMember/eachissueDetail&&${issuevo.issueId}&&${issuevo.issueTitle}&&"+ $('#re_con').val() + "&&${projectVo.proName}",
						"memId" 	: "${issuevo.memId}",
						"alarmType" : "reply-3"
	}
	
	$.ajax({
			url : "/alarmInsert",
			data : JSON.stringify(alarmData),
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			dataType : 'text',
			success : function(data){
				
				let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memId +"&&"+ alarmData.alarmType;
				socket.send(socketMsg);
				$(location).attr('href', '${pageContext.request.contextPath}/projectMember/eachissueDetail?issueId=${issuevo.issueId }');
				
			},
			error : function(err){
				console.log(err);
			}
	});
}



// 댓글작성시 작동 증가
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
  			padding-left:40px;
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
	
	.form-control:disabled, .form-control[readonly] {
   background-color: white;
   }
  .success{
  background-color: #f6f6f6;
  width: 10%;
  text-align: center;
  }
</style>

</head>

<!-- 이슈메뉴에서만 include -->
<c:if test="${categoryId == 3 || categoryId == 2}">
	<%@include file="../layout/contentmenu.jsp"%>
</c:if>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
		<c:if test="${categoryId == 8 or categoryId == 9}">
			<br>
			<c:set var="projectNAME" value="${issuevo.proName}"></c:set>
			<h3 class="jg" style="padding-left:10px;">${projectNAME}</h3> 
			<hr>
		</c:if>
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
			
			
			<br>
			<h4 class="jg">협업이슈 상세내역</h4>
			<br>
			<table class="table" >
		        <tr class="stylediff">
		            <th class="success jg">이슈제목</th>
		         	<td colspan="3">			  
		         		<label class="control-label" id="issueTitle">${issuevo.issueTitle}</label>
		         	</td>
		        </tr>
	
				
			
		        <tr class="stylediff" id ="todo" >
		           
		        </tr>
		     
		        
		         
		        <tr class="stylediff">
		            <th class="success jg">작성자</th>
		            <td style="width: 700px;">
		            	<label class="control-label" id="memid">${issuevo.memName }</label>
		            </td>
		          	
		       
		            <th class="success jg">작성일</th>		            
		            <td style="width: 700px;">
		            	<label class="control-label" id="regDt">${issuevo.regDt }</label>
		            </td>
		        </tr>
		         
		        <tr class="stylediff">
		            <th class="success jg">종류</th>
		            <td colspan="3">
		            	<label id ="issueKind" class="control-label"></label> 		
		            </td>
		           
		        </tr>
         
		        <tr>
		            <th class="success jg" style="height: 300px;">이슈 내용</th>
		            <td colspan="3">
			           	<c:if test="${issuevo.issueCont == '<p><br></p>'}">
							<label >[ 내용이 없습니다. ] </label>
						</c:if>
						<c:if test="${issuevo.issueCont == null}">
							<label >[ 내용이 없습니다. ] </label>
						</c:if>
				
						<label id ="issueCont" class="control-label">${issuevo.issueCont }</label>
		            </td>
		        </tr>
		        <tr>
		            <th class="success jg" style="height: 150px;">첨부파일</th>
		            <td colspan="3">
			            <div id = "filediv">
							<c:if test="${filelist.size() == 0}">
								<label>	[ 첨부파일이 없습니다. ] </label>
							
							</c:if>
							
							<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1" >
																	 					
								<a href="${cp }/file/publicfileDown?pubId=${files.pubId}">
									<button id ="files${vs.index}" class="btn btn-default jg" name="${files.pubId}">
										<img name="link" src="/fileFormat/${fn:toLowerCase(files.pubExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
										 ${files.pubFilename}.${files.pubExtension} 다운로드
									</button>
								
								</a>
								<br>
							</c:forEach>
						</div>
					</td>
		        </tr>
	        </table>

				
			<div class="card-footer clearfix" >
					<input type= "button" value="목록으로" id ="back" class="btn btn-default float-left jg" >
				
		 			<c:if test="${issuevo.memId == SMEMBER.memId}">
						<input type= "button" value="삭제하기" id="delissue"  class="btn btn-default float-right jg" >			
						<input type= "button" value="수정하기" id ="modissue" class="btn btn-default float-right jg" style="margin-right: 5px;">
					</c:if>
            </div>
            
            
            <form class="form-horizontal" role="form" id ="frm" method="post" action="${pageContext.request.contextPath}/reply/insertreply">	
				<div class="form-group">
				<hr>
					<label for="pass" class="col-sm-2 control-label jg">댓글</label>
					<div class="col-sm-12" id="replydiv">	
								
						<c:forEach items="${replylist }" var="replylist">
							<div id="replydiv" style="padding-left: 50px;">			
							<c:if test= "${replylist.del == 'N'}">
<!-- 								<div class="mailbox-attachment-icon has-img" id="pictureView" style="border: 1px solid white; height: 50px; width:50px; margin: 0 auto; display: inline-block;"> -->
								<c:if test="${fn:substring(replylist.memFilepath,0 ,1) eq '/' }">									
									<img id="imge" style="width: 40px; height:  40px; border-radius: 50%; border: 1.5px solid #adb5bd;"  src="${replylist.memFilepath}" />
								</c:if>
								<c:if test="${fn:substring(replylist.memFilepath,0 ,2) eq 'D:' }">		
									<img id="pict" style="width:  40px; height:  40px;  border-radius: 50%; border: 1px solid #adb5bd;" src="/profileImgView?memId=${replylist.memId}" />
								</c:if>
<!-- 								</div> -->
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
						<div id="replyinsertdiv" style="padding-left: 50px;">		
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
		<!-- 이슈 상세보기 끝-->  
	
	
	    <!-- 일감 상세보기 -->
	    <div id="todoDetaildiv" class="card-body">
	    	
	    	<br>
	    	<h4 class="jg">일감 상세보기</h4><br>
			<input type="hidden" id="todoId">
			
			<table class="table" >
		        <tr class="stylediff">
		            <th class="success jg">제목</th>
		         	<td colspan="3">		
		         		<label class="control-label " id="todoTitle"></label>	  
		         	</td>						        
		        </tr> 
		        <tr class="stylediff">
		            <th class="success jg">담당자</th>
		            <td>
		            	<label class="control-label " id="memId"></label>
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
<!-- 		        <tr> -->
<!-- 		            <th class="success jg" style="height: 150px;">첨부파일</th> -->
<!-- 		            <td colspan="3"> -->
<!-- 			            <div id = "filediv"> -->
<%-- 							<c:if test="${filelist.size() == 0}"> --%>
<!-- 								<label class="jg">	[ 첨부파일이 없습니다. ] </label> -->
							
<%-- 							</c:if> --%>
							
<%-- 							<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1" > --%>
																	 					
<%-- 								<a href="${cp }/file/publicfileDown?pubId=${files.pubId}"> --%>
<%-- 									<button id ="files${vs.index}" class="btn btn-default jg" name="${files.pubId}"> --%>
<%-- 										<img name="link" src="/fileFormat/${fn:toLowerCase(files.pubExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;"> --%>
<%-- 										 ${files.pubFilename} 다운로드 --%>
<!-- 									</button> -->
								
<!-- 								</a> -->
<!-- 								<br> -->
<%-- 							</c:forEach> --%>
<!-- 						</div> -->
<!-- 					</td> -->
<!-- 		        </tr> -->
			 </table>
			
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="todoTitle" class="col-sm-2 control-label jg">제목</label> -->
<!-- 				<label class="control-label jg" id="todoTitle"></label> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="todoCont" class="col-sm-2 control-label jg">할일</label> -->
<!-- 				<label class="control-label jg" id="todoCont"></label> -->
<!-- 			</div> -->
<!-- 			<div class="form-group"> -->
<!-- 				<label for="memId" class="col-sm-2 control-label jg">담당자</label> -->
<!-- 				<label class="control-label jg" id="memId"></label> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="todoImportance" class="col-sm-2 control-label jg">우선순위</label>				 -->
<!-- 				<label class="control-label jg" id="todoImportance"></label> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="todoStart" class="col-sm-2 control-label jg">시작 일</label> -->
<!-- 				<label class="control-label jg" id="todoStart"></label> -->
<!-- 			</div> -->
			
<!-- 			<div class="form-group"> -->
<!-- 				<label for="todoEnd" class="col-sm-2 control-label jg">종료 일</label> -->
<!-- 				<label class="control-label jg" id="todoEnd"></label> -->
<!-- 			</div> -->
			
			<div class="card-footer clearfix" >
				<button type="button" class="btn btn-default float-left jg" id="todoback">뒤로가기</button>					
			</div>
		
		</div>
	   </div>
	   <!-- 일감 상세보기   끝-->



</div>

</html>