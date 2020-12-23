<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(function() {
		memberSearchList = [];
		inviteMemList = [];
		
		reqId = '${projectId}';
		memId = "${SMEMBER.memId}";
		
		// 회원 초대 버튼을 누르면 모달창이 나온다.
		$('.inviteBtn').click(function() {
			$('#warningText').text("");
			$('.memListView').empty();
			
			// 검색창과 검색결과창 비우기..
			$('.searchResult').empty();
			$('#userSearchBar').val("");
			
			memberSearchList = [];
			inviteMemList = [];
			$('#fake').show();
			$('#inviteMember').modal();
		})
		
		// test = window.setTimeout("실행할 함수", 지연할 시간(ms 단위)); 
		// 와 같이 test 를 주고 if (test) 조건을 주면 test는 임의의 숫자값을 가지므로 실행된다.
		var timer = null;
		$('#userSearchBar').keyup(function(){
			
			if ($(this).val() != ''){
				$('#warningText').text("검색 중입니다..");
				$('#fake').hide();
				$('#warningText')[0].style.visibility = 'visible';
			}else{
				$('#warningText')[0].style.visibility = 'hidden';
			}
			
			if (timer){	// 즉 기존에 실행하려고 예정된 함수가 있는지 확인한다.
				window.clearTimeout(timer);
			}
			timer = window.setTimeout(function(){
				// 여기서부터 대기한 후에 실행할 함수를 호출한다.
				timer = null;
				
				$('#warningText').text("");
				$('.searchResult').empty();
				memberSearchList = [];
				
				var keyword = $('#userSearchBar').val();
				if (keyword == ''){
					$('.searchResult').empty();
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
									memberSearchList.push(res[i].memName+":["+res[i].memId+"]");
								}
//	 							autoComplete(memberSearchList);
							}
						},
						complete : function(){
							$('#warningText')[0].style.visibility = 'hidden';
							$('.searchResult').empty();
							
							printSearchResult(memberSearchList);
						}
					})
				}
			}, 500);
		})
		
		// setTimeout 예제...
// 		function searchFunction(searchArea, callback, delay){
// 			var timer = null;
// 			keyword.keyup(function(){
// 				if (timer){
// 					window.clearTimeout(timer);
// 				}
// 			})
// 			timer = window.setTimeout(function(){
// 				timer = null;
// 				callback();
				 
// 			}, delay);
// 		}
		
		function printSearchResult(arr){
			// 검색 결과가 존재하지 않는 경우  : (검색중입니다..) 문구를 삭제한다.
			if (arr.length == 0 ){
				$('#warningText')[0].style.visibility = 'hidden';
				return;
			}
			// 검색 결과가 1건 이상 존재하는 경우..
			else{
				for (j = 0 ; j < arr.length ; j++){
					$('.searchResult').append(
					"<div class=\'searchResultOne\' memId=\'"
					+ arr[j].split(":")[1].replace("[","").replace("]","") +"\' memName=\'"
					+ arr[j].split(":")[0] + "\' style=\'height : 50px; \' >"
						+"<span style=\'float : left;\'>"
							+arr[j].split(":")[0]
						+"</span>"
						+"<span style=\'float : left;\'>"
							+arr[j].split(":")[1]
						+"</span>"
					+"</div>");	
				} 
				$('#warningText')[0].style.visibility = 'hidden';
			}
		}
		
		$('.searchResult').on('click', '.searchResultOne', function(){
			memName = $(this).attr("memName");
			addingMemId = $(this).attr("memId");
			reqId = "${projectId}";
			
			$('#warningText')[0].style.visibility = 'hidden';
			
			// 본인인지 아닌지, 확인해야 한다.
			if (memName == "${SMEMBER.memName}") {
				$('#warningText').text("본인입니다.");
				$('#warningText')[0].style.visibility = 'visible';
				return;
			}
			
			// 넣기 전, 이미 프로젝트에 참여하고 있는 회원인지 검사해야 한다.
			$.ajax({
				url : "/projectMember/proMemList",
				data : { reqId : reqId },
				method : "POST",
				success : function(res) {
					// 검사 시작
					for (var i = 0; i < res.length; i++) {
						if (addingMemId == res[i].memId) {
							$('#warningText').text("이미 참여하고 있는 회원입니다.");
							$('#warningText')[0].style.visibility = 'visible';
							return;
						}
					}
					// 초대할 회원 리스트 길이가 0인 경우 : 바로 넣는다.
					if (inviteMemList.length == 0) {
						inviteMemList.push(memName+":"+addingMemId);
						
						listMember(inviteMemList);
						$('#warningText').text("추가하였습니다..");
						$('#warningText')[0].style.visibility = 'visible';
						return;
					}else{
					
					// 초대 회원 리스트 길이가 0이 아닌 경우 : 중복되면 안된다.
						for (i = 0; i < inviteMemList.length; i++) {
							if ((memName+":"+addingMemId) == inviteMemList[i]) {
								$('#warningText').text("이미 추가한 회원입니다.");
								$('#warningText')[0].style.visibility = 'visible';
								return;
							}
						}
						inviteMemList.push(memName+":"+addingMemId);
						
						listMember(inviteMemList);
						$('#warningText').text("추가하였습니다..");
						return; // 추가하고 끝낸다.
					}
				}
			})
		})
		
		function listMember(inviteMemList) {
			$('.memListView').empty();
			for (i = 0; i < inviteMemList.length; i++) {
				$('.memListView').append(
						"<div class=\'addedMember jg\' style=\'height : 50px;\'"
							+" memId='"+inviteMemList[i]+"'>"
							+ inviteMemList[i].split(":")[0]
							+ "[" + inviteMemList[i].split(":")[1] + "]"
						+ "</div>");
			}
		}
		
		// 사용자가 아이디를 누르는 경우 제거한다. 
		$('.memListView').on('click', '.addedMember', function() {
			var memId = $(this).attr('memId');
			delMember(memId);
		})
		
		function delMember(memId) {
			$('#warningText').text('');
			inviteMemList.splice(inviteMemList.indexOf(memId), 1);
			listMember(inviteMemList);
		}

		// 초대할 대상을 정한 후 초대하기 버튼을 누르면 해당 멤버에게 초대가 전송된다.
		$('.inviteMemBtn').click(function() {
			if (inviteMemList.length == 0){
				$('#fake').hide();
				$('#warningText').text("초대할 인원을 선택하지 않았습니다.");
				$('#warningText')[0].style.visibility = "visible";				
			}else{
				// inviteMemList를 먼저 가공해야 한다.
				setInviteMemList = [];
				for (i = 0 ; i < inviteMemList.length ; i++){
					setInviteMemList.push(inviteMemList[i].split(":")[1]);
				}
				
				var ajaxArr = {
						"inviteMemList" : setInviteMemList, // 변수명을 맞춰야 한다. inviteMemList로!
						"reqId" : reqId,
						"memId" : memId
					};
				$.ajax({
					url : "/project/insertPjtMember",
					data : ajaxArr,
					method : "POST",
					success : function(res) {
						if (res == "success") {
							// 해당 요구사항 정의서의 상태를 변경해야 한다.
							saveReqMsg();
							alert("초대를 완료하였습니다.");
							$('#inviteMember').modal("hide"); // 모달창 닫기 
						} else {
							alert("초대 실패..");
							$('#inviteMember').modal("hide");
						}
					}
				})
			}
		})
		
		function saveReqMsg(){
			// inviteMemList를 가공해야 한다.
			setInviteMemList = [];
			for (i = 0 ; i < inviteMemList.length ; i++){
				setInviteMemList.push(inviteMemList[i].split(":")[1]);
			}
			
			var alarmData = {
					"alarmCont" : reqId + "&&${SMEMBER.memName}&&${SMEMBER.memId}&&/req/reqDetail?reqId=" + reqId + "&&${projectVo.proName}" ,
					"memIds"	: setInviteMemList,
					"alarmType" : "req-pro"
			}
			
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
		
		// 마우스 over, leave 관련 이벤트
		$('.memListView').on('mouseenter','.addedMember',function(){
			$(this).css("background-color", 'lightgrey');
		})
		
		$('.memListView').on('mouseleave','.addedMember',function(){
			$(this).css("background-color", 'white');
		})
		
		// 검색 창에서 마우스 올렸을 때 ..
		$('.searchResult').on('mouseenter','.searchResultOne',function(){
			$(this).css("background-color", 'lightgrey');
		})
		
		$('.searchResult').on('mouseleave','.searchResultOne',function(){
			$(this).css("background-color", 'white');
		})
		
	});//function
</script>
<style>
#userSearch_banner {
	width: 75%;
	align: center;
	height: 35px;
}

</style>
<body class="hold-transition sidebar-mini accent-teal">

	<section class="content-header"
		style="border-bottom: 1px solid #dee2e6; background-color:#f2f2f2; padding-bottom: 0px;" >
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<c:set var="projectNAME" value="${projectVo.proName}"></c:set>
					<h1 class="jg">
						<i class="fas fa-chalkboard-teacher"></i>&nbsp;&nbsp;${projectNAME}
					</h1>
					<p class="text-sm">
						Project Leader <b>&nbsp;${projectVo.memId }</b>
					</p>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<c:if test="${projectVo.memId == SMEMBER.memId}">
							<li>
								<button class="btn btn-app inviteBtn">
									<i class="fas fa-user-plus"></i> 멤버 초대
								</button>
							</li>
						</c:if>
					</ol>
				</div>
				<!-- Main content -->
				<section class="content jg">
					<div class="col-13 col-sm-13">
						<div>
							<div class="card-header p-0 pt-1 border-bottom-0">
								<ul class="nav" id="custom-tabs-three-tab" role="tablist">
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-home-tab"
										href="${pageContext.request.contextPath}/project/outlineView">개요</a></li>
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-home-tab"
										href="${pageContext.request.contextPath}/todo/todoList">일감</a></li>
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-gantt-tab"
										href="${pageContext.request.contextPath }/ganttView">간트</a></li>
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-messages-issue"
										href="${pageContext.request.contextPath}/projectMember/issuelist">이슈</a></li>
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-settings-suggest"
										href="${pageContext.request.contextPath}/suggest/readSuggestList">건의사항</a></li>
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-calendar-tab"
										href="${pageContext.request.contextPath}/schedule/clendarView">캘린더</a></li>
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-mywork-tab"
										href="${pageContext.request.contextPath}/todo/MytodoList">내
											일감</a></li>
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-files-tab" href="/file/publicfileview">파일함</a>
									</li>
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-mywork-tab"
										href="/schedule/scheduleplaceView">일정</a></li>
									<li class="nav-item"><a class="nav-link"
										id="custom-tabs-three-vote-tab" href="/vote/votelist">투표</a></li>
									<c:if
										test="${SMEMBER.memId eq projectVo.memId or SMEMBER.memType eq 'PM'}">
										<li class="nav-item"><a class="nav-link"
											id="custom-tabs-three-files-tab"
											href="${pageContext.request.contextPath}/hotIssue/hissueList">PM-PL이슈게시판</a>
										</li>
									</c:if>
								</ul>
							</div>

						</div>
					</div>
				</section>

			</div>
		</div>
		<!-- /.container-fluid -->
	</section>

	<!-- /.content -->

	<!-- Modal to invite new Members . . . -->
	<div class="modal fade" id="inviteMember" tabindex="-1" role="dialog"
		aria-labelledby="inviteMemberModal">
		<div class="modal-dialog modal-sm-center" role="document">
			<div class="modal-content" style="height: 600px; width : 600px;">

				<div class="modal-header">
					<h3 class="modal-title jg" id="addplLable">멤버 초대하기</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body jg" 
					style="width: 100%; height: 60%; 
						   padding-right : 15px;
						   padding-left : 15px;">
					
					<div style="float : left; width : 50%;">
						<label style="margin : 5px 5px 5px 5px;">초대할 멤버의 아이디를 검색하세요.</label>
						<input type="text" id="userSearchBar" 
							style="float: left; 
								   width : 90%; 
								   border-radius : 0.45rem;
								   margin : 5px 5px 5px 5px;" autocomplete="off" placeholder="사용자의 이름을 입력하세요..">
						<label id="fake" style="width : 80%; height : 21px;">&nbsp;</label>
						<div id="warningText" 
							style="visibility: visible; 
								   float : left;
								   margin-top : 5px;
								   margin-left : 5px;
								   margin-bottom : 5px;
								   color : red;"></div>
								   
						<div class="searchResult jg" style="
							margin : 5px 5px 5px 5px;
							border : 2px solid lightgrey;
							width : 90%;
							height : 300px;
							border-radius : 0.45rem;
							padding : 7px 7px 7px 7px;
							overflow-y : auto;">
						</div>
						
					</div>
					
					<div style="float : left; width : 50%;">
						<label style="text-align : center; margin : 5px 5px 5px 5px;">초대 목록</label>
						<div class="memListView" 
							style="height : 375px; 
								   border : 2px solid lightgrey;
								   border-radius : 0.45rem;
								   padding : 7px 7px 7px 7px;
								   overflow-y : auto;">
						</div>
					</div>
				</div>
				
				<div class="modal-footer">
					<button class="btn btn-success inviteMemBtn">초대하기</button>
				</div>
			</div>
			
		</div>
	</div>
	<!--  /Modal -->