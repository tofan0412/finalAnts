<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

#mkPjtUserSearch{
	z-index: 50;
}

.inputBox{
	border : none;
	background-color : #ebf1f5;
	border-radius: 0.3rem;
	height : 30px;
	width : 80%;
	font-size : 1.15em;
}

.xBtn{
	 cursor: pointer;
}
.addedMemExceptBtn, .addingMemAddBtn{
	cursor: pointer;
}
</style>
<script>
	$(function() {
		mkPjtMemberSearchList = [];	// 검색결과에 띄울 리스트 ..
		mkPjtInviteMemList = [];	// 프로젝트에 초대할 회원 리스트..
		
		myId = "${SMEMBER.memId}"; 	
		myName = "${SMEMBER.memName}";
		// 사용자가 승인 버튼을 누르는 경우 버튼 내용이 프로젝트 생성으로 변경되며, 
		// reqList 테이블에서 status 가 accept로 변경된다.
		$('.pjtAcceptBtn').click(function(){
			var reqId = $(this).attr("reqId");
			
			var reqTitle = $(this).attr("reqTitle");
			var memId = $(this).attr("memId");
			var memName = '${SMEMBER.memName}';
			
			
			var alarmData = {
					"alarmCont" : reqId + "&&${SMEMBER.memName}&&${SMEMBER.memId}&&/req/reqDetail?reqId=" + reqId + "&&" + reqTitle + "&&ACCEPT&& ",
					"memId" 	: memId,
					"alarmType" : "res-pl"
			}
			// 알림db등록
			
			// PL 먼저 프로젝트 멤버에 등록한다. reqid, memId, String[]
			$.ajax({
				url : "/project/insertPjtMember",
				data : {memId : '${SMEMBER.memId}', reqId : reqId, inviteMemList : [memName+":"+'${SMEMBER.memId}']},
				method : "POST",
				success : function(res){
					if (res == "success"){
					}else{
						alert("프로젝트 생성을 실패하였습니다.");
						$(location).attr("href", "/project/readReqList");
					}
				}
			})
			saveResMsg(alarmData);
			$(location).attr("href", "/project/acceptOrReject?reqId="+reqId+"&status=ACCEPT");
		})
		
		$('.pjtRejectBtn').click(function(){
			var reqId = $(this).attr("reqId");
			alert(reqId + ": 반려 처리되었습니다.");
			$(location).attr("href", "/project/acceptOrReject?reqId="+reqId+"&status=REJECT");
		})
		
		// 프로젝트 생성 버튼을 누르면 모달창이 나온다.
		$('#reqTableList').on('click', '.newPjtModal', function() {
			var reqId = $(this).attr('reqId');
			var reqTitle = $(this).attr("reqTitle");

			// Modal창이므로 이전에 입력했던 내용이 유지된다. 모두 초기화 해준다.  
			$('.mkPjtMemList').empty();		// 프로젝트에 초대할 회원 리스트 비우기
			$('#mkPjtUserSearch').val("");	// 검색창 비우기
			$('.projectName').val("");		// 프로젝트 이름 비우기
			
			mkPjtMemberSearchList = [];		// 검색 결과 리스트 비우기
			mkPjtInviteMemList = [];		// 초대할 회원 리스트 비우기
			
			$('.mkPjtSearchResult').empty();// 검색 결과 비우기
			$('#mkPjtWarningText').text("");// 경고창 비우기
			$('#mkPjtFake').show();			
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
			
			// 현재 초대 리스트는 회원이름과 결합되어 있으므로, 가공해줘야 한다.
			setInviteMemList = [];
			
			if (mkPjtInviteMemList.length == 0){
				alert("최소 초대 인원은 1명입니다.");
				return;
			}
			
			for (i = 0 ; i < mkPjtInviteMemList.length ; i++){
				setInviteMemList.push(mkPjtInviteMemList[i].split(":")[1]);
			}
			
			var ajaxArr = {"inviteMemList" : mkPjtInviteMemList, "reqId" : reqId, "memId" : myId};
			
			ArrWithoutMe = [];
			for (i = 0 ; i < setInviteMemList.length ; i++){
				if (myId == setInviteMemList[i]){
					// 나 스스로한테는 알람을 보내선 안되므로, 아무것도 하지 않는다.(알람 대상 리스트에 나를 제외한다.)
				}else{
					ArrWithoutMe.push(setInviteMemList[i]);
				}
			}
			
			var alarmData = {
					"alarmCont" : reqId + "&&${SMEMBER.memName}&&${SMEMBER.memId}&&/req/reqDetail?reqId=" + reqId + "&&" + projectName ,
					"memIds"	: ArrWithoutMe,
					"alarmType" : "req-pro"
			}
			
			// 프로젝트를 먼저 생성한다.
			// 20.12.12 수정 : 프로젝트는 이미 DB상에서 생성되어 있으므로, 제목만 등록한다. 
			// 21.01.06 수정 : 프로젝트 상태를 ACTIVE로 수정한다.
			// 21.01.06 수정 : 프로젝트 생성 후 changeDate를 업로드한다. 
			$.ajax({
				url : "/project/updateProject",
				data : { "reqId" : reqId,
						 "proName" : projectName,
						 "proStatus" : "ACTIVE", 
						 "proChangeDate" : $('#clock').val()
					   },
				method : "POST",
				success : function(res){
					if ("success" == res){
						// 프로젝트 제목을 수정했으면, 이어서 프로젝트 멤버를 DB에 등록한다. 
						// 내 아이디가 프로젝트멤버에 등록될 때는, 상태가 승인 상태로 되어야 한다..! 
						$.ajax({
							url : "/project/insertPjtMember",
							data : ajaxArr,
							method : "POST",
							success : function(res){
								if (res == "success"){
									//프로젝트 초대알림 db저장
									saveReqMsg(alarmData);
									alert("프로젝트를 생성하였습니다.");
									$(location).attr("href", "/project/projectgetReq?reqId="+reqId);
								}else{
									alert("프로젝트 생성을 실패하였습니다.");
									$(location).attr("href", "/project/readReqList");
								}
							}
						})
					}
				}
			})
		})
		
		$('.mkPjtMemList').on('click', '.addedMemExceptBtn', function(){
			var memId = $(this).attr('memId');
			delMember(memId);
		})
		
		function delMember(memId){
			$('#mkPjtWarningText').text('해당 회원을 제외하였습니다.');
			$('#mkPjtWarningText')[0].style.visibility = 'visible';
			
			mkPjtInviteMemList.splice(mkPjtInviteMemList.indexOf(memId),1); // 뒤의 개수는 몇개를 제거할 지 이다..
			listMember(mkPjtInviteMemList);
		}
		
		// 사용자가 검색어를 입력하면, 자동으로 ajax를 이용해 검색한다.
		var timer = null;
		$('#mkPjtUserSearch').keyup(function(){
			if ($(this).val() != ''){
				$('#mkPjtWarningText').text("검색 중입니다..");
				$('#mkPjtFake').hide();
				$('#mkPjtWarningText')[0].style.visibility = 'visible';
			}else{
				$('#mkPjtWarningText')[0].style.visibility = 'hidden';
			}
			
			if (timer){
				window.clearTimeout(timer);
			}
			timer = window.setTimeout(function(){
				timer = null;
				$('#mkPjtWarningText').text("");
				$('.mkPjtSearchResult').empty();
				mkPjtMemberSearchList = [];
				
				var keyword = $('#mkPjtUserSearch').val();
				if (keyword == ''){
					$('.mkPjtSearchResult').empty();
				}
				else {
					$.ajax({
						url : "/project/userSearch",
						data : { keyword : keyword },
						method : "GET",
						success : function(res) {
							if (res.length == 0){	// 검색 결과가 없는 경우, 메서드 종료
								return;
							}else{	// 검색 결과가 1개 이상인 경우
								for (i = 0; i < res.length; i++) {
									mkPjtMemberSearchList.push(res[i].memName+":["+res[i].memId+"]");
								}
							}
						},
						complete : function(){
							$('#mkPjtWarningText')[0].style.visibility = 'hidden';
							$('.mkPjtSearchResult').empty();
							printSearchResult(mkPjtMemberSearchList);
						}
					})
				}
			},500);
		})
		
		// 사용자가 검색한 결과를 출력한다.
		function printSearchResult(arr){
			// 검색 결과가 존재하지 않는 경우  : (검색중입니다..) 문구를 삭제한다.
			if (arr.length == 0 ){
				$('#mkPjtWarningText')[0].style.visibility = 'hidden';
				return;
			}
			// 검색 결과가 1건 이상 존재하는 경우..
			else{
				for (j = 0 ; j < arr.length ; j++){
					name = arr[j].split(":")[0] + arr[j].split(":")[1]
					if (name.length > 15){
						name = name.substring(0,15) + "...";
					}
					
					$('.mkPjtSearchResult').append(
					"<div class=\'mkPjtSearchResultOne\' style=\'height : 50px;\'>"
						+"<span style=\'float : left;\'>"
							+ name
						+"</span>"
						+"<span class=\'addingMemAddBtn\' memId=\'"
						   + arr[j].split(":")[1].replace("[","").replace("]","") + "\' "
						   +"memName = \'"+ arr[j].split(":")[0] + "\' "
						   +"style=\'border : 2px solid #5882FA; "
						   +"float : right; "
						   +"background-color : #5882FA;"
						   +"color : white;"
						   +"border-radius : 0.45rem;\'>&nbsp;추가&nbsp;</span>"
					+"</div>");	
				} 
				$('#mkPjtWarningText')[0].style.visibility = 'hidden';
			}
		}
		
		// 검색 결과 중 하나를 클릭했을 때.. 원래는 mkPjtSearchResultOne이거임
		$('.mkPjtSearchResult').on('click', '.addingMemAddBtn', function(){
			memName = $(this).attr("memName");
			addingMemId = $(this).attr("memId");
			
			$('#mkPjtWarningText')[0].style.visibility = 'hidden';
			
			// 본인인지 아닌지, 확인해야 한다.
			if (addingMemId == "${SMEMBER.memId}") {
				$('#mkPjtWarningText').text("본인입니다.");
				$('#mkPjtWarningText')[0].style.visibility = 'visible';
				return;
			}
			// 초대할 회원 리스트 길이가 0인 경우 : 바로 넣는다.
			if (mkPjtInviteMemList.length == 0) {
				mkPjtInviteMemList.push(memName+":"+addingMemId);
				listMember(mkPjtInviteMemList);
				$('#mkPjtWarningText').text("추가하였습니다..");
				$('#mkPjtWarningText')[0].style.visibility = 'visible';
				return;
			}else{
			// 초대 회원 리스트 길이가 0이 아닌 경우 : 중복되면 안된다.
				for (i = 0; i < mkPjtInviteMemList.length; i++) {
					if ((memName+":"+addingMemId) == mkPjtInviteMemList[i]) {
						$('#mkPjtWarningText').text("이미 추가한 회원입니다.");
						$('#mkPjtWarningText')[0].style.visibility = 'visible';
						return;
					}
				}
				mkPjtInviteMemList.push(memName+":"+addingMemId);
				listMember(mkPjtInviteMemList);
				$('#mkPjtWarningText').text("추가하였습니다..");
				$('#mkPjtWarningText')[0].style.visibility = 'visible';
				return; // 추가하고 끝낸다.
			}
		})
		
		// 배열 기준으로 초대 목록 우측에 작성하기.
		function listMember(mkPjtInviteMemList) {
			$('.mkPjtMemList').empty();
			for (i = 0; i < mkPjtInviteMemList.length; i++) {
				name = mkPjtInviteMemList[i].split(":")[0] 
					+ "[" + mkPjtInviteMemList[i].split(":")[1] + "]";
				
				if (name.length > 15){
					name = name.substring(0, 15)+ "...";
				}
				
				$('.mkPjtMemList').append(
						"<div class=\'mkPjtAddedMember\' style=\'height : 50px;\'"
							+" memId='"+mkPjtInviteMemList[i]+"'>"
							+ name
							+ "<span class=\'addedMemExceptBtn\' memId=\'"+ mkPjtInviteMemList[i] + "\'"
								   +"style=\'border : 2px solid white; "
										   +"float : right; "
										   +"background-color : red;"
										   +"color : white;"
										   +"border-radius : 0.45rem;\'>&nbsp;제외&nbsp;</span>"
						+ "</div>");
			}
		}
		
		// 검색 창에서 마우스 올렸을 때 ..
		$('.mkPjtSearchResult').on('mouseenter','.mkPjtSearchResultOne',function(){
			$(this).css("background-color", 'lightgrey');
		})
		
		$('.mkPjtSearchResult').on('mouseleave','.mkPjtSearchResultOne',function(){
			$(this).css("background-color", 'white');
		})
		
		// 초대할 회원 리스트에 마우스 올렸을 때 ..
		$('.mkPjtMemList').on('mouseenter','.mkPjtAddedMember',function(){
			$(this).css("background-color", 'lightgrey');
		})
		
		$('.mkPjtMemList').on('mouseleave','.mkPjtAddedMember',function(){
			$(this).css("background-color", 'white');
		})
		
		
		
	})	//$(function(){}) 의 끝 ...
	
	/* pl응답 알림메세지 db에 저장하기 */
	function saveResMsg(alarmData){
		
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
	
	
	/* 프로젝트초대 알림메세지 db에 저장하기 */
	function saveReqMsg(alarmData){
		$.ajax({
			url : "/alarmInsert",
			data : JSON.stringify(alarmData),
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			dataType : 'text',
			success : function(data){
				let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memIds +"&&"+ alarmData.alarmType;
				socket.send(socketMsg);
			},
			error : function(err){
				console.log(err);
			}
		});
		console.log(alarmData);
	}
	
</script>

<div class="jg" style="height : 100px; 
					   background-color: #f2f2f2; 
					   margin-bottom : 20px;
					   padding-top : 10px;
					   padding-left : 10px;">
	<h2>프로젝트 생성</h2>
</div>

<div class="reqListContent">
	<table class="reqTable" style="width : 95%;">
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
							<button reqId="${req.reqId }" reqTitle="${req.reqTitle }" memId = "${req.memId }" class="btn btn-success pjtAcceptBtn">승인</button>
							<button reqId="${req.reqId }" reqTitle="${req.reqTitle }" memId = "${req.memId }" class="btn btn-danger pjtRejectBtn">반려</button>
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
					<td colspan="4" class="jg"><h4>요청된 요구사항 정의서가 존재하지 않습니다.</h4></td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<span class="jg" style="float: right; padding-right : 60px;">'승인'을 누르는 경우, 프로젝트를 생성할 수 있습니다.</span><br>
	<span class="jg" style="float: right; padding-right : 60px;">'프로젝트 생성'을 누르는 경우, 프로젝트 생성 상세 페이지로 이동합니다.</span>

	<!-- 프로젝트 생성 modal 창 -->
	<div class="modal fade jg" id="mkProject" tabindex="-1" role="dialog"
		aria-labelledby="createPjtModal">
		<div class="modal-dialog modal-lg" role="document">
			
			<div class="modal-content" style="height: 700px;">
				<div class="modal-header">
					<h3 class="modal-title" id="addplLable">새 프로젝트 생성하기</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body" style="width : 100%; height : 100%;">
					<!-- 프로젝트 정보 입력란. -->
					<input class="reqId" type="text" value="" hidden="hidden">
					<input class="memId" type="text" value="${SMEMBER.memId }" hidden="hidden">
					
					<div style="float : left; width : 50%; height : 450px;">
						<h5>요구사항정의서 이름</h5>
						<input type="text" class="reqTitle inputBox" readonly>
						<br><br>
						<h5>프로젝트 이름</h5>
						<input type="text" class="projectName inputBox" placeholder='프로젝트 이름을 입력해 주세요 ..' autocomplete="off">
						<br><br>
						<h5>멤버 검색하기</h5>
						<input type="text" id="mkPjtUserSearch" class="inputBox" 
							autocomplete="off" placeholder="회원 이름">
						<label id="mkPjtFake" style="width : 80%; height : 11px;">&nbsp;</label>
						<br>
						<div id="mkPjtWarningText" 
							style="color : red; float : left;
								   margin-top : 5px;
								   margin-left : 5px;
								   margin-bottom : 5px;"></div>
						<div class="mkPjtSearchResult" 
							style="border : 2px solid lightgrey;
								   border-radius : 0.45rem; 
								   margin-top : 15px;
								   overflow-y : auto;
								   padding : 7px 7px 7px 7px;
								   height : 200px; width : 80%;"></div>
					</div>
					
					
					<!-- 초대 리스트 -->
					<h5>초대 리스트</h5>
					<div>
						<div class="mkPjtMemList" 
							style="float : right; 
								   border : 2px solid lightgrey;
								   width : 50%; height : 300px; border-radius : 0.35rem;
								   padding : 10px 10px 10px 10px; line-height : 45px;
						 		   background-color : white; 
						 		   overflow-x : auto;
						 		   overflow-y : auto;">
						</div>
					</div>
				</div>
				
				<div class="modal-footer">
					<!-- 프로젝트 생성 버튼 -->				
					<button id="mkProjectBtn" class="btn btn-primary"
					style="width : 80%; height : 50px; margin : 0 auto;
					font-size : 1.5em;">프로젝트 생성</button>
				</div>
			</div>
		</div>
	</div>
</div>