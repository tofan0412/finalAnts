<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(function() {
		SearchListBanner = [];
		inviteMemListBanner = [];
		reqId = '${projectId}';
		memId = "${SMEMBER.memId}";
		
		// 회원 초대 버튼을 누르면 모달창이 나온다.
		$('.inviteBtn').click(function() {

			$('.warningBanner').empty();
			$('.MemListBanner').empty();
			$('#userSearchBanner').val("");

			SearchListBanner = [];
			inviteMemListBanner = [];
			$('#inviteMember').modal();
		})

		$('#userSearchBanner').keyup(function() {
			$('.warningBanner').empty();
			
			var keyword = $(this).val();

			if (keyword != '') {
				$.ajax({
					url : "/project/userSearch",
					data : { keyword : keyword },
					method : "GET",
					success : function(res) {
						SearchListBanner = [];	// 검색 결과 리스트 초기화.
						if (res.length == 0){	// 검색 결과가 없는 경우, 메서드 종료
							return;
						}else{	// 검색 결과가 1개 이상인 경우
							for (var i = 0; i < res.length; i++) {
								SearchListBanner.push(res[i].memId);
							}
							autoComplete(SearchListBanner);	
						}
					}
				})
			} 
		})

		// 자동 완성 부분 ..
		function autoComplete(SearchListBanner) {
			$('#userSearchBanner').autocomplete({
				source : SearchListBanner,
				select : function(event, ui) {},
				minLength : 2,
				appendTo : $('#inviteMember'),	// 모달 창 위로 떠야 한다..
				focus : function(event, ui) {
					return false;
				}
			})
		}

		// 사용자가 추가 버튼을 누를 때 ..
		$('.addMemBtnBanner').click(function() {
			addingMemId = $('#userSearchBanner').val();
			reqId = "${projectId}";
			
			alert("현재 프로젝트 번호는? " + reqId);
			alert("추가하고자 하는 회원 아이디는? " + addingMemId); 
			
			if (addingMemId == "${SMEMBER.memId}") {
				$('.warningBanner').text("본인입니다.");
				return;
			}

			var DBCheck = "";		// DB에 존재하는가?
			var existCheck = "";	// 이미 참여한 회원인가?
			var addedCheck = "";	// 이미 초대할 리스트에 추가되어 있는가?
			
			// DB에 존재하는지 확인
			$.ajax({
				url : "/project/chkMemId",
				data : { memId : addingMemId },
				method : "POST",
				success : function(res) {
					alert("DB에 존재하는지 확인합니다..");
					if (res == "accept") {
						alert("DB에 존재합니다.");
						DBCheck = "pass";
					}else{
						DBCheck = "noop";
						$('.warningBanner').text("존재하지 않는 회원입니다.");
						return;
					}
				}
			})
			if (DBCheck == "pass"){
				$.ajax({
					url : "/projectMember/proMemList",
					data : { reqId : reqId },
					method : "POST",
					success : function(res) {
						alert("이미 추가된 플젝 회원인지 검사합니다..");
						for (var i = 0; i < res.length; i++) {
							if (addingMemId == res[i].memId) {
								$('.warningBanner').text("이미 참여하고 있는 회원입니다.");
								existCheck = "noop";
								return;
							}else{
								existCheck = "pass";
							}
						}
					}
				})
			}

			if (existCheck == "pass"){
				// 초대할 회원 리스트 길이가 0인 경우 : 바로 넣는다.
				if (inviteMemListBanner.length == 0) {
					$('.warningBanner').text('');
					inviteMemListBanner.push(memId);
					listMember(inviteMemListBanner);
					return;
				}
			
				// 이미 초대할 회원이 리스트에 존재하는 경우 : 중복되면 안된다.
				for (i = 0; i < inviteMemListBanner.length; i++) {
					if (addingMemId == inviteMemListBanner[i]) {
						$(".warningBanner").text('');
						$('.warningBanner').text("이미 추가한 회원입니다.");
						addedCheck = "noop";
						return;
					}else{
						addedCheck = "pass";
					}
				}
			}
			if (addedCheck == "pass"){
				$('.warningBanner').text('');
				inviteMemListBanner.push(memId);
				listMember(inviteMemListBanner);
				return; // 추가하고 끝낸다.
			}
			alert("마지막입니다. 종료합니다.");
			return;
		})
		///////////////// 추가 끝 /////////////////

		function listMember(inviteMemListBanner) {
			$('.MemListBanner').empty();
			for (i = 0; i < inviteMemListBanner.length; i++) {
				$('.MemListBanner').append(
						"<div class=\'addedMemIdBanner jg\' memId='"+inviteMemListBanner[i]+"'>"
								+ inviteMemListBanner[i] + "</div>");
			}
		}

		function delMember(memId) {
			$('.warningBanner').text('');
			inviteMemListBanner.splice(inviteMemListBanner.indexOf(memId), 1); // 뒤의 개수는 몇개를 제거할 지 이다..
			listMember(inviteMemListBanner);
		}

		// 사용자가 아이디를 누르는 경우 제거한다. 
		$('.MemListBanner').on('click', '.addedMemIdBanner', function() {
			var memId = $(this).attr('memId');
			delMember(memId);
		})

		// 초대할 대상을 정한 후 초대하기 버튼을 누르면 해당 멤버에게 초대가 전송된다.

		$('.inviteMemBtn').click(function() {
			if (inviteMemListBanner.length == 0){
				alert("초대할 대상을 선택하지 않았습니다.");
			}else{
				var ajaxArr = {
						"inviteMemList" : inviteMemListBanner, // 변수명을 맞춰야 한다. inviteMemList로!
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
						} else {
							console.log("인원 초대 실패..")
						}
					}
				})
			}
		})
		
		function saveReqMsg(){
			var alarmData = {
					"alarmCont" : reqId + "&&${SMEMBER.memName}&&${SMEMBER.memId}&&/req/reqDetail?reqId=" + reqId + "&&${projectVo.proName}" ,
					"memIds"	: inviteMemListBanner,
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

				<div class="modal-body jg" style="width: 100%; height: 60%;">
					
					<div style="float : left; width : 50%;">
						<label>초대할 멤버의 아이디를 검색하세요.</label>
						<div class="warningBanner" style="color: red;"></div>
						<input type="text" id="userSearchBanner" 
							style="float: left; border-radius : 0.45rem;">
							
						<button class="btn btn-success addMemBtnBanner" style="height : 30px;">
							ADD
						</button>
					</div>
					
					<div style="float : right; width : 50%;">
						<label style="text-align : center;">초대 목록</label>
						<div class="MemListBanner" style="height : 450px; overflow-y : auto;">
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