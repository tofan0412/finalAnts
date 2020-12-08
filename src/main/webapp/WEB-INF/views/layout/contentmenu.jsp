<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- autoComplete 기능을 위해 필요한 애들 ... -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
$(function(){
	SearchListBanner = [];
	inviteMemListBanner = [];
	reqId = '${projectId}';
	memId = "${SMEMBER.memId}";
	
	// 회원 초대 버튼을 누르면 모달창이 나온다.
	$('.inviteBtn').click(function(){
		
		$('.warningBanner').empty();
		$('.MemListBanner').empty();
		$('#userSearchBanner').val("");
		
		SearchListBanner = [];
		inviteMemListBanner = [];
		$('#inviteMember').modal();
	})
	
	
	$('#userSearchBanner').keyup(function(){
		var keyword = $(this).val();

		if (keyword != ''){
			$.ajax({
				url : "/project/userSearch",
				data : {keyword : keyword},
				method : "GET",
				success : function(res){
					SearchListBanner = [];
					for (var i = 0 ; i < res.length; i++){
						SearchListBanner.push(res[i].memId);
					}
					autoComplete(SearchListBanner);
				}
			})
		}
	})
	
	// 자동 완성 부분 ..
	function autoComplete(SearchListBanner){
		$('#userSearchBanner').autocomplete({
			source : SearchListBanner,
			select : function(event, ui){
				console.log(ui.item);
			},
			minLength : 2,
			// 모달 창 위로 떠야 한다..
			appendTo : $('#inviteMember'),
			focus: function(event, ui) {
	            return false;
	        }
		})
	}
	
	// 사용자가 추가 버튼을 누를 때 ..
	$('.addMemBtnBanner').click(function(){
		var memId = $('#userSearchBanner').val();
		
		// 나는 초대할 수 없다. 
		if (memId == "${SMEMBER.memId}"){
			$('.warningBanner').text("본인입니다.");
			return;
		}
		
		// 기존에 추가한 회원인지 아닌지를 확인하는 값.
		check = 0;
		
		// 1차적으로 DB에서 검증이 필요.(DB에 존재하는지 안하는지..)  
		$.ajax({
			url : "/project/chkMemId",
			data : {memId : memId},
			method : "POST",
			success : function(res){
				console.log(res);
				if ("accept" == res){	// DB 상에 존재하는 회원아이디임을 나타낸다 ! 
					
					// 이미 프로젝트에 참여하고 있는 멤버인지 확인해야 한다. 
					$.ajax({
						url : "/projectMember/proMemList",
						data : {reqId : reqId},
						method : "POST",
						success : function(res){
							// 프로젝트를 생성한 시점에서, PL이 있기 때문에 멤버는 최소 1명이다. 
							for (var i = 0 ; i < res.length ; i++){
								
								// 이미 프로젝트에 참여하고 있는 회원이라면 . . . 
								if(memId == res[i].memId){
									$('.warningBanner').text("이미 참여하고 있는 회원입니다.");
									break;	//for문을 벗어난다.
								}
								else{	// DB상 존재하고, 프로젝트에 참여하지 않은 회원이다.
									// 만약 inviteMemList 길이가 0인 경우, 최초로 넣는 것이므로 바로 패스.
									if (inviteMemListBanner.length == 0){
										$('.warningBanner').text('');
										inviteMemListBanner.push(memId);	// 배열에 추가하고
										listMember(inviteMemListBanner);	// View 목록 수정.
										break;
									}
									// inviteMemList 목록의 길이가 0이 아닌 경우 이미 추가했는지 안했는지를 검증해야 한다.
									else{
										for(i = 0 ; i < inviteMemListBanner.length ; i++){
											if ( inviteMemListBanner[i] == memId ){
												$(".warningBanner").text('');
												$('.warningBanner').text("이미 추가한 회원입니다.");
												check = 1;
											}
										}
										if (check != 1){	// 기존에 추가하지 않은 회원인 경우, 추가한다.
											$('.warningBanner').text('');
											inviteMemListBanner.push(memId);
											listMember(inviteMemListBanner);
										}
									}
								}
							}
						}
					})
				}
				else{	// DB상 존재하지 않는 경우..
					$(".warningBanner").text('');
					$(".warningBanner").append("존재하지 않는 사용자 이름입니다.");
				}
			}
		})
	})
	
	function listMember(inviteMemListBanner){
		$('.MemListBanner').empty();
		for (i = 0 ; i < inviteMemListBanner.length ; i++){
			$('.MemListBanner')
			.append("<div class=\'addedMemIdBanner jg\' memId='"+inviteMemListBanner[i]+"'>"+inviteMemListBanner[i]+"</div>");	
		}	
	}
	
	function delMember(memId){
		$('.warningBanner').text('');
		inviteMemListBanner.splice(inviteMemListBanner.indexOf(memId),1); // 뒤의 개수는 몇개를 제거할 지 이다..
		listMember(inviteMemListBanner);
	}
	
	// 사용자가 아이디를 누르는 경우 제거한다. 
	$('.MemListBanner').on('click', '.addedMemIdBanner', function(){
		var memId = $(this).attr('memId');
		delMember(memId);
	})
	
	// 초대할 대상을 정한 후 초대하기 버튼을 누르면 해당 멤버에게 초대가 전송된다.
	
	$('.inviteMemBtn').click(function(){
		var ajaxArr = {"inviteMemList" : inviteMemListBanner, 	// 변수명을 맞춰야 한다. inviteMemList로!
					   "reqId" 		   : reqId,
					   "memId"		   : memId};
		$.ajax({
			url : "/project/insertPjtMember",
			data : ajaxArr,
			method : "POST",
			success : function(res){
				if (res == "success"){
					// 해당 요구사항 정의서의 상태를 변경해야 한다.
					alert("초대를 완료하였습니다.");
				}else{
					console.log("인원 초대 실패..")
				}
			}
		})
		
		
	})
})
</script>
<style>
#userSearch_banner{
	width : 75%;
	align : center;
	height : 35px;
}

</style>
<body class="hold-transition sidebar-mini accent-teal">

	<section class="content-header"
		style="border-bottom: 1px solid #dee2e6;
			   background: linear-gradient(-10deg, #007bff, lightgoldenrodyellow) fixed;">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<c:set var="projectNAME" value="${projectVo.proName}"></c:set>
				<h1 class="jg">${projectNAME}</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item san"><a href="#">Home</a></li>&nbsp;&nbsp;

					<c:if test="${projectVo.memId == SMEMBER.memId}">
						<li><button class="btn btn-success inviteBtn" style="float: right;">멤버
								초대</button></li>
					</c:if>
				</ol>
			</div>

		</div>
		<div class="row mb-2">
			<p style="color: lightslategray;">프로젝트 설명을 입력하세요.컬럼 만들어야 하나..
				회의하자!</p>
		</div>
	</div>
	<!-- /.container-fluid --> </section>

	<!-- Main content -->
	<section class="content" style="margin-top: 13px;">
	<div class="col-12 col-sm-12">
		<div class="card card-teal card-outline card-tabs">
			<div class="card-header p-0 pt-1 border-bottom-0">
				<ul class="nav nav-tabs" id="custom-tabs-three-tab">
					<li class="nav-item"><a class="nav-link active"
						id="custom-tabs-three-home-tab"
						href="${pageContext.request.contextPath}/todo/todoList">일감</a></li>
					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-gantt-tab" href="#custom-tabs-three-gantt">간트</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-messages-issue"
						href="${pageContext.request.contextPath}/projectMember/issuelist">이슈</a></li>
					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-settings-suggest"
						href="${pageContext.request.contextPath}/suggest/readSuggestList">건의사항</a></li>
					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-calendar-tab"
						href="#custom-tabs-three-calendar">캘린더</a></li>
					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-mywork-tab"
						href="${pageContext.request.contextPath}/todo/MytodoList">내
							일감</a></li>
					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-files-tab" href="/publicfile/publicfileview">파일함</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-mywork-tab" href="/schedule/scheduleplaceView">일정</a></li>
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
	<!-- /.content -->

	<!-- Modal to invite new Members . . . -->
	<div class="modal fade" id="inviteMember" tabindex="-1" role="dialog"
		aria-labelledby="inviteMemberModal">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content" style="height: 500px;">
				
				<div class="modal-header">
					<h3 class="modal-title jg" id="addplLable">멤버 초대하기</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body" style="width: 100%; height: 100%;">
					<label class="jg" style="text-align : center;">초대할 멤버의 아이디를 검색하세요.</label>
					<div class="warningBanner jg" style="color : red;"></div>
					<input type="text" id="userSearchBanner" style="float : left;">
					<button class="btn btn-success addMemBtnBanner">추가</button>
					<br>
					
					<label class="jg">초대 목록</label>
					<div class="MemListBanner"></div>
					
				</div>
				
				<div class="modal-footer">
					<button class="btn btn-success inviteMemBtn">초대하기</button>
				</div>
			</div>
		</div>
	</div>

	<!--  /Modal -->
