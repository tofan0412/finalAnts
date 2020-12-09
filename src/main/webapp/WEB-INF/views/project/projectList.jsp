<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
#userSearch{
	z-index: 50;
}
</style>
<script>
	$(function() {
		SearchList = [];	// 자동완성 검색에 띄울 리스트 ..
		inviteMemList = [];	// 프로젝트에 초대할 회원 리스트..
		me = "${SMEMBER.memId}"; 	
		
		// 사용자가 승인 버튼을 누르는 경우 버튼 내용이 프로젝트 생성으로 변경되며, 
		// reqList 테이블에서 status 가 accept로 변경된다.
		$('.accept').click(function(){
			var reqId = $(this).attr("reqId");
			alert(reqId + ": 승인 처리되었습니다.");
			$(location).attr("href", "/project/acceptOrReject?reqId="+reqId+"&status=ACCEPT");
		})
		
		$('.reject').click(function(){
			var reqId = $(this).attr("reqId");
			alert(reqId + ": 반려 처리되었습니다.");
			$(location).attr("href", "/project/acceptOrReject?reqId="+reqId+"&status=REJECT");
		})
		
		// 프로젝트 생성 버튼을 누르면 모달창이 나온다.
		$('#reqTableList').on('click', '.newPjtModal', function() {
			var reqId = $(this).attr('reqId');
			var reqTitle = $(this).attr("reqTitle");

			// Modal창이므로 이전에 입력했던 내용이 유지된다. 모두 초기화 해준다.  
			$('.warning').empty();
			$('.MemList').empty();
			$('.projectName').val("");
			$('#userSearch').val("");
			
			SearchList = [];
			inviteMemList = [];
			$('#mkProject').modal();
			
			$('.modal-body .reqId').val(reqId);
			$('.modal-body .reqTitle').val(reqTitle);
		})
		
		// 사용자가 프로젝트 생성 버튼을 누르면 프로젝트를 생성한다. 
		$('#mkProjectBtn').click(function(){
			var reqId = $('.reqId').val();
			var projectName = $('.projectName').val();
			cnt = 0;
			
			// 사용자가 프로젝트 명을 작성하지 않으면 반환 ..
			if ( $(".projectName").val() == ''){
				alert("프로젝트 명을 입력해 주세요.");
				return;
			}
			
			//생성 직전, 자기 자신 아이디를 추가한다. 
			inviteMemList.push(me);
			var ajaxArr = {"inviteMemList" : inviteMemList, "reqId" : reqId, "memId" : me};
			
			// 프로젝트를 먼저 생성한다.
			$.ajax({
				url : "/project/insertProject",
				data : {	reqId : reqId, 
							memId : me, 
							proName : projectName },
				method : "POST",
				success : function(res){
					if ("success" == res){
						// 프로젝트 생성을 완료했으면, 이어서 프로젝트 멤버를 DB에 등록한다. 
						// 내 아이디가 프로젝트멤버에 등록될 때는, 상태가 승인 상태로 되어야 한다..! 
						$.ajax({
							url : "/project/insertPjtMember",
							data : ajaxArr,
							method : "POST",
							success : function(res){
								if (res == "success"){
									// 해당 요구사항 정의서의 상태를 변경해야 한다.
// 									console.log("프로젝트가 생성되었습니다.");
									alert("프로젝트를 생성하였습니다.");
								}else{
// 									console.log("프로젝트 생성에 실패하였습니다..");
								}
							}
						})
					}
				}
			})
		})
		
		// 사용자가 초대할 멤버를 추가할 때
		$('.addMemBtn').click(function(){
			// 사용자가 입력한 아이디를 변수로 저장한다. 
			var memId = $('#userSearch').val();
			
			// 나는 초대할 수 없다. 
			if (memId == "${SMEMBER.memId}"){
				$('.warning').text("본인입니다.");
				return;
			}
			
			// 기존에 추가한 회원인지 아닌지를 확인하는 값.
			var check = 0;
			
			// 1차적으로 DB에서 검증이 필요.(DB에 존재하는지 안하는지..)  
			$.ajax({
				url : "/project/chkMemId",
				data : {memId : memId},
				method : "POST",
				success : function(res){
					console.log(res);
					if ("accept" == res){	// DB 상에 존재하는 회원아이디임을 나타낸다 ! 
						
						// 만약 inviteMemList 길이가 0인 경우, 최초로 넣는 것이므로 바로 패스.
						if (inviteMemList.length == 0){
							$('.warning').text('');
							inviteMemList.push(memId);	// 배열에 추가하고
							listMember(inviteMemList);	// View 목록 수정.
						}
						
					// inviteMemList 목록의 길이가 0이 아닌 경우 이미 추가했는지 안했는지를 검증해야 한다.
						else{
							for(i = 0 ; i < inviteMemList.length ; i++){
								if ( inviteMemList[i] == memId ){
									$(".warning").text('');
									$('.warning').text("이미 추가한 회원입니다.");
									check = 1;
								}
							}
							if (check != 1){	// 기존에 추가하지 않은 회원인 경우, 추가한다.
								$('.warning').text('');
								inviteMemList.push(memId);
								listMember(inviteMemList);
							}
						}
					}
					else{
						$(".warning").text('');
						$(".warning").append("존재하지 않는 사용자 이름입니다.");
					}
				}
			})
		})
		
		// 사용자가 아이디를 누르는 경우 제거한다. 
		$('.MemList').on('click', '.addedMemId', function(){
			var memId = $(this).attr('memId');
			delMember(memId);
		})
		
		
		function delMember(memId){
			$('.warning').text('');
			inviteMemList.splice(inviteMemList.indexOf(memId),1); // 뒤의 개수는 몇개를 제거할 지 이다..
			listMember(inviteMemList);
		}
		
		function listMember(inviteMemList){
			$('.MemList').empty();
			for (i = 0 ; i < inviteMemList.length ; i++){
				$('.MemList').append("<div class=\'addedMemId jg\' memId='"+inviteMemList[i]+"'>"+inviteMemList[i]+"</div>");	
			}	
		}
		
		// 사용자가 프로젝트에 초대할 아이디를 입력하는 경우 자동완성 기능을 사용한다.		
		
		// 사용자가 프로젝트 이름을 입력하려고 하면 에러 메시지를 지운다.
		$('.projectName').keyup(function(){
			$('.error').empty();
		})
		
		$('#userSearch').keyup(function(){
			var keyword = $(this).val();
			if (keyword != ''){
				$.ajax({
					url : "/project/userSearch",
					data : {keyword : keyword},
					method : "GET",
					success : function(res){
						SearchList = [];
						for (var i = 0 ; i < res.length; i++){
							SearchList.push(res[i].memId);
						}
						autoComplete(SearchList);
					}
				})
			}
		})
		// 자동 완성 부분 ..
		function autoComplete(SearchList){
			$('#userSearch').autocomplete({
				source : SearchList,
				select : function(event, ui){
					console.log(ui.item);
				},
				minLength : 2,
				// 모달 창 위로 떠야 한다..
				appendTo : $('#mkProject'),
				focus: function(event, ui) {
		            return false;
		            //event.preventDefault();
		        }
			})
		}
		
	})
	
	/* pl요청 알림메세지 db에 저장하기 */
	function saveMsg(){
		var alarmData = {
							"alarmCont" : $('#modalReqId').val() + ",${SMEMBER.memName},${SMEMBER.memId},/req/reqDetail?reqId="+$('#modalReqId').val()+","+ $('#modalReqName').val(),
							"memId" 	: $('#searchInput').val(),
							"alarmType" : "req-pl"
		}
		console.log(alarmData);
		
		$.ajax({
				url : "/alarmInsert",
				data : JSON.stringify(alarmData),
				type : 'POST',
				contentType : "application/json; charset=utf-8",
				dataType : 'text',
				success : function(data){
					
					let socketMsg = "${SMEMBER.memName}," + alarmData.alarmCont +","+ alarmData.memId +","+ alarmData.alarmType;
					socket.send(socketMsg);
					
				},
				error : function(err){
					console.log(err);
				}
		});
	}
	
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
						<c:if test="${req.status == 'WAIT' }">
							<button reqId="${req.reqId }" class="btn btn-success accept">승인</button>
							<button reqId="${req.reqId }" class="btn btn-danger reject">반려</button>
						</c:if>
						<c:if test="${req.status == 'ACCEPT' }">
							<button reqId="${req.reqId }" reqTitle="${req.reqTitle }"
							class="btn btn-success newPjtModal">프로젝트 생성</button>
						</c:if>
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
	<span class="jg" style="float: right; padding-right : 60px;">'승인'을 누르는 경우, 프로젝트 생성창으로
		이동합니다.</span>


	<!-- 프로젝트 생성 modal 창 -->
	<div class="modal fade" id="mkProject" tabindex="-1" role="dialog"
		aria-labelledby="createPjtModal">
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
					<input class="reqId" type="text" value="" hidden="hidden">
					<input class="memId" type="text" value="${SMEMBER.memId }" hidden="hidden">
					
					<div class="mkPjtContent" style="width : 600px; height : 300px; background-color : lightgreen;">
						<div style="float : left">
						<label class="jg">요구사항정의서 이름</label><br>
						<input type="text" class="reqTitle"  value="" readonly><br><br>
						<label class="jg">프로젝트 이름</label><br>
						<input type="text" class="projectName" placeholder="프로젝트 이름을 입력해 주세요 .." >
						<br>
						
						<!-- 프로젝트 이름 입력 안했을 때 나오는 에러 문구.. with JSR303 -->
						<span class="error" style="color : red;">
							<form:errors path="projectVo.proName" class="jg"/>
						</span>
						<br><br>
						
						<label class="jg">프로젝트 초대 멤버</label><br>
						<input type="text" id="userSearch">
						<button class="btn btn-success addMemBtn" type="button">추가</button>
						<div class="warning jg" style="color : red; "></div>
						</div>
						<label class="jg">프로젝트 멤버 목록</label><br>
						<div class="MemList" style="height : 100%; overflow : scroll;">
							<span class="jg addedMemId"></span>
						</div>
					</div>
					
					<!-- 프로젝트 생성 버튼 -->
					<br>
					<div class="col-md-6" style="float : bottom-right;">
						<button id="mkProjectBtn">프로젝트 생성</button>
					</div>

				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>
</div>