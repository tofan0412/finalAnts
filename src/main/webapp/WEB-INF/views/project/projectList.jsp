<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
.reqListContent {
	background-color: white;
	padding-left: 30px;
}

.reqTable {
	width: 1300px;
	border-top: 1px solid #444444;
	border-collapse: collapse;
}

th, td {
	border-bottom: 1px solid #444444;
	padding: 10px;
	text-align: center;
}
</style>
<script>
	$(function() {
		$('#reqTableList').on('click', '.accept', function() {
			var reqId = $(this).attr('reqId');
			var reqTitle = $(this).attr("reqTitle");

			$('#mkProject').modal();
			$('.modal-body .reqId').val(reqId);
			$('.modal-body .reqTitle').val(reqTitle);
		})
		
		$('#mkProjectBtn').click(function(){
			$('#pform').submit();
		})
	})
</script>
<%@include file="/WEB-INF/views/layout/contentmenu.jsp"%>

<div class="reqListContent">
	<table class="reqTable">
		<tbody id="reqTableList">
			<tr>
				<th>요구사항정의서 이름</th>
				<th>수행 기간</th>
				<th>상태</th>
				<th>결정</th>
			</tr>
			<c:forEach items="${reqList}" var="req">
				<tr>
					<td style="display: none;">${req.reqId }</td>
					<td>${req.reqTitle }</td>
					<td>${req.reqPeriod }일</td>
					<td>${req.status }</td>
					<td>
						<button reqId="${req.reqId }" reqTitle="${req.reqTitle }"
							class="btn btn-success accept">승인</button>
						<button class="btn btn-danger reject">반려</button>
					</td>
				</tr>
			</c:forEach>
			<!-- 나에게 요청된 요구사항 정의서가 아예 없는 경우 .. -->
			<c:if test="${reqList.size() == 0 }">
				<tr>
					<td class="jg">요청된 요구사항 정의서가 존재하지 않습니다..</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<span class="jg" style="float: right;">'승인'을 누르는 경우, 프로젝트 생성창으로
		이동합니다.</span>


	<!-- 프로젝트 생성 modal 창 -->
	<div class="modal fade" id="mkProject" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content" style="height: 500px;">
				<div class="modal-header">
					<h3 class="modal-title jg" id="addplLable">새 프로젝트 생성하기</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="width : 100%; height : 100%;">
					<!-- 프로젝트 정보 입력란. -->
					<form id="pform" action="/project/insertProject" method="POST" >
						<input class="reqId" name="reqId" 
							type="text" value="" hidden="hidden">
						<input class="memId" name="memId" 
							type="text" value="${SMEMBER.memId }" hidden="hidden">
						
						<label>요구사항정의서 이름</label>
						<input type="text" name="reqTitle" class="reqTitle"  value="" readonly><br>
						<input type="text" name="proName" placeholder="프로젝트 이름을 입력해 주세요 .." >
					</form>

					<!-- 프로젝트 생성 버튼 -->
					<div class="col-md-6" style="float: right">
						<button id="mkProjectBtn">프로젝트 생성</button>
					</div>

				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>
</div>