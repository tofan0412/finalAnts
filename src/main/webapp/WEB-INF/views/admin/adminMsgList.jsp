<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.adminMsgList{
	margin : 10px 10px 10px 10px;
	padding : 10px 10px 10px 10px;	
}
#msgTable th{
	border-bottom: 2px solid lightgrey;  
}
</style>
<script>
function fn_egov_link_page(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/msg/msgList'/>";
    document.listForm.submit();
}

$(function(){
	var msgTo = "";
	var msgNum = "";
	
	// 승인 처리 : 해당 멤버의 memType을 PM으로 변경하고, 해당 메시지의 상태를 ACCEPT로 변경한다.
	$('.pmAcceptBtn').click(function(){
		conf = confirm("해당 회원의 권한을 PM으로 변경하시겠습니까?");
		if(conf){
			memId = $(this).attr("memId"); 
			memType = 'PM';
			msgIdx = $(this).attr("msgIdx");

			$(location).attr('href', "/member/memTypeUpdate?memType="+memType+"&memId="+memId+"&msgIdx="+msgIdx);
		}
	})
	
	// 반려 처리하기 : msg 테이블에서 해당 메시지에 대해 REJECT로 변경
	$('.pmRejectBtn').click(function(){
		conf = confirm("반려 처리하시겠습니까?");
		
		if (conf){
			msgIdx = $(this).attr("msgIdx");
			msgStatus = "REJECT";
			
			$(location).attr("href", "/msg/msgUpdate?msgStatus="+msgStatus+"&msgIdx="+msgIdx);
		}
	})
	
	/* 답변 버튼을 누르면 새로운 모달창이 나온다. */
	$('.adminAnswerBtn').click(function(){
		msgTo = $(this).attr("memId");
		msgNum = $(this).attr("msgIdx");
		
		$('#adminAnswerArea').val('');			
		$('#adminAnswerModal').modal();
	})
	
	/* 관리자가 사용자 질문에 대해 답변한 거 알람 테이블에 저장하기 */
	$('.ansSubmitBtn').click(function(){
		cont = $('#adminAnswerArea').val();
		regDt = $('#clock').val();
		msgType = "ANSWER";
		msgStatus = "ANSWER";
		msgWriter = "ADMIN";
		
		cnt = 0;
		if (cont == ""){
			alert("내용을 입력해 주세요..");
			cnt++;
		}
		if (cnt < 1){
			$.ajax({
				url : "/msg/insertMsg", 
				method : "POST",
				data : {msgCont : cont, msgWriter : msgWriter, 
					    regDt : regDt, msgStatus : msgStatus, msgType : msgType, 
					    msgReceiver : msgTo},
				success : function(res){
					if (res > 0){
						// 상태값 바꿔줘야 한다.
						msgStatus = "ANSWERED";
						$(location).attr("href", "/msg/msgUpdate?msgStatus="+msgStatus+"&msgIdx="+msgNum);
						
						alert("답변을 작성하였습니다.");
						$(location).attr("href", "/msg/msgList");
					}
				}
			})
		}
	})
	
})
</script>
<form:form commandName="msgVo" id="listForm" name="listForm" method="post">
	<div class="jg card adminMsgList" style="height : 700px;">
		<h1 class="nav-icon fas fa-envelope" style="margin-left : 10px; margin-top : 10px;">&nbsp;쪽지 관리</h1> <br> <br>
		<div style="height : 100%; overflow-y : auto;">
			<table id="msgTable" class="table" style="text-align: center;">
				<tr>
					<th>No.</th>
					<th>유형</th>
					<th>내용</th>
					<th>작성일</th>
					<th>작성자</th>
					<th>상태</th>
					<th>&nbsp;&nbsp;</th>
				</tr>
				<c:forEach items="${msgList }" var="msg" varStatus="status">
					<tr>	
						<td>
							<c:out value="${((msg.pageIndex-1) * msg.pageUnit + (status.index+1))}"/>.
						</td>
						
						<td>
							<c:if test="${msg.msgType eq 'PM'}">
								<span style="border : 3px solid lightgrey;
									         background-color: lightgrey;
									         border-radius : 0.3rem;
									         color : black;">
							         &nbsp;권한 요청&nbsp;</span>
							</c:if>
							<c:if test="${msg.msgType eq 'ISSUE' }">
								<span style="border : 3px solid lightgrey;
									         background-color: lightgrey;
									         border-radius : 0.3rem;
									         color : black;">
							         &nbsp;일반 문의&nbsp;</span>
							</c:if>
						</td>
						
						<td style="width : 45%; text-align : left;">
							<a href="#">
								<c:if test="${fn:length(msg.msgCont) > 30 }">
									${fn:substring(msg.msgCont,0,10) }...
								</c:if>
								<c:if test="${fn:length(msg.msgCont) <= 30 }">
									${msg.msgCont }
								</c:if>
							</a>
						</td>
						<td>${msg.regDt }</td>
						
						<c:if test="${fn:length(msg.msgWriter) > 10 }">
							<td style="width : 10%;">${fn:substring(msg.msgWriter,0,10)}...</td>
						</c:if>
						<c:if test="${fn:length(msg.msgWriter) <= 10 }">
							<td style="width : 10%;">${msg.msgWriter }</td>
						</c:if>
						
						<td>
							<c:if test="${msg.msgStatus eq 'WAIT' }">
								<span style="border : 3px solid #FFBF00;
									         background-color: #FFBF00;
									         border-radius : 0.3rem;">
							         &nbsp;대기&nbsp;
						       </span>
							</c:if>
							<c:if test="${msg.msgStatus eq 'ANSWERED' }">
								<span style="border : 3px solid #4bcbfc;
									         background-color: #4bcbfc;
									         border-radius : 0.3rem;">
							         &nbsp;답변완료&nbsp;
						       </span>
							</c:if>
							<c:if test="${msg.msgStatus eq 'ACCEPT' }">
								<span style="border : 3px solid #088A29;
									         background-color: #088A29;
									         border-radius : 0.3rem;
									         color : white;">
							         &nbsp;승인&nbsp;
						        </span>
							</c:if>
							<c:if test="${msg.msgStatus eq 'REJECT' }">
								<span style="border : 3px solid #FF0000;
									         background-color: #FF0000;
									         border-radius : 0.3rem;
									         color : white;">
									         &nbsp;반려&nbsp;
						       </span>
							</c:if>
						</td>
						
						<td>
							<c:if test="${msg.msgStatus eq 'WAIT' && msg.msgType eq 'PM' }">
								<button type="button" memId="${msg.msgWriter }" msgIdx="${msg.msgIdx }" class="btn btn-primary pmAcceptBtn">처리</button>
								<button type="button" msgIdx="${msg.msgIdx }" class="btn btn-danger pmRejectBtn">반려</button>
							</c:if>
							<c:if test="${msg.msgStatus eq 'WAIT' && msg.msgType eq 'ISSUE' }">
								<button type="button" memId="${msg.msgWriter }" msgIdx="${msg.msgIdx }" class="btn btn-success adminAnswerBtn">답변</button>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<br>
		<span class="jg" style="float : right; margin-right : 10px;">*권한 요청을 처리하는 경우, 해당 회원의 권한이 즉시 PM으로 변경됩니다.</span>
		<br><br>
		<div id="paging" class="card-tools" style="margin : 0 auto;">
			<ul class="pagination pagination-sm jg" id="pagingui">
		
				<li class="page-item jg" id="pagenum"><ui:pagination
						paginationInfo="${paginationInfo}" type="image"
						jsFunction="fn_egov_link_page" /></li>
				<form:hidden path="pageIndex" />
		
			</ul>
		</div>
	</div>
</form:form>

<!-- 모달창 -->
<div class="modal fade jg" id="adminAnswerModal" tabindex="-1" role="dialog"
	aria-labelledby="adminAnswerModal">
	<div class="modal-dialog modal-sm-center" role="document">
		<div class="modal-content" style="height: 400px; width : 500px;">
			
			<div class="modal-header">
				<h3 class="modal-title" id="addplLable">답변</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<label>답변 내용</label><br>
				<textarea id="adminAnswerArea" placeholder="최대 20자까지 입력 가능합니다." maxlength="20" rows="5" cols="20" style="width : 100%; resize: none;" ></textarea>
			</div>
			
			<div class="modal-footer" style="overflow-y : auto; text-align : left; height : 25%;">
				<button class="btn btn-primary ansSubmitBtn" style="float : right;">제출</button>
			</div>
		</div>
	</div>
</div>