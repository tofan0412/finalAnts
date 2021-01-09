<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
	$('.pmAcceptBtn').click(function(){
		conf = confirm("해당 회원의 권한을 PM으로 변경하시겠습니까?");
		if(conf){
			memId = $(this).attr("memId"); 
			memType = 'PM';
			msgIdx = $(this).attr("msgIdx");

			$(location).attr('href', "/member/memTypeUpdate?memType="+memType+"&memId="+memId+"&msgIdx="+msgIdx);
		}
	})
	
	$('.pmRejectBtn').click(function(){
		conf = confirm("반려 처리하시겠습니까?");
		
		if (conf){
			msgIdx = $(this).attr("msgIdx");
			msgStatus = "REJECT";
			
			$(location).attr("href", "/msg/msgUpdate?msgStatus="+msgStatus+"&msgIdx="+msgIdx);
		}
	})
	
	$('.adminAnswerBtn').click(function(){
		memId = $(this).attr("memId");
		
		$('#adminAnswerArea').val('');			
		$('#adminAnswerModal').modal();
	})
	
	$('.ansSubmitBtn').click(function(){
		cont = $('#adminAnswerArea').val();
		
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
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>상태</th>
					<th>유형</th>
					<th>&nbsp;&nbsp;</th>
				</tr>
				<c:forEach items="${msgList }" var="msg">
					<tr>	
						<td>1</td>
						<td>${msg.msgTitle }</td>
						<td>${msg.msgWriter }</td>
						<td>${msg.regDt }</td>
						<td>
							<c:if test="${msg.msgStatus eq 'WAIT' }">
								<span style="border : 3px solid #FFBF00;
									         background-color: #FFBF00;
									         border-radius : 0.3rem;">
							         &nbsp;대기&nbsp;
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
							<c:if test="${msg.msgType eq 'PM'}">
								권한 요청
							</c:if>
							<c:if test="${msg.msgType eq 'ISSUE' }">
								일반 문의
							</c:if>
						</td>
						<td>
							<c:if test="${msg.msgStatus eq 'WAIT' && msg.msgType eq 'PM' }">
								<button type="button" memId="${msg.msgWriter }" msgIdx="${msg.msgIdx }" class="btn btn-primary pmAcceptBtn">처리</button>
								<button type="button" msgIdx="${msg.msgIdx }" class="btn btn-danger pmRejectBtn">반려</button>
							</c:if>
							<c:if test="${msg.msgStatus eq 'WAIT' && msg.msgType eq 'ISSUE' }">
								<button type="button" memId="${msg.msgWriter }" class="btn btn-success adminAnswerBtn">답변</button>
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
		<div class="modal-content" style="height: 350px; width : 550px;">
			
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