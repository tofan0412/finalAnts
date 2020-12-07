<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- autoComplete 기능을 위해 필요한 애들 ... -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
$(function(){
	// 회원 초대 버튼을 누르면 모달창이 나온다.
	$('.inviteBtn').click(function(){
		$('#inviteMember').modal();
	})
	
	$('#userSearch').keyup(function(){
		var keyword = $(this).val();
// 		console.log("사용자 입력 : "+ keyword);

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
			appendTo : $('#userSearch'),
			focus: function(event, ui) {
	            return false;
	            //event.preventDefault();
	        }
		})
	}
	
	
})
</script>
<style>
#userSearch{
	width : 95%;
	align : center;
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
	<div class="col-12 col-sm-9">
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
						href="#custom-tabs-three-issue">이슈</a></li>
					<li class="nav-item"><a class="nav-link"
						id="custom-tabs-three-settings-suggest"
						href="#custom-tabs-three-suggest">건의사항</a></li>
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
						id="custom-tabs-three-mywork-tab" href="#">일정</a></li>
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
		aria-labelledby="exampleModalLabel">
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
					<label class="jg">초대할 멤버의 아이디를 검색하세요.</label>
					<input id="userSearch">
					<br>
					<div class="searchMemList">
						<label class="jg">초대 목록</label>
						
					</div>
				</div>
				
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>

	<!--  /Modal -->
