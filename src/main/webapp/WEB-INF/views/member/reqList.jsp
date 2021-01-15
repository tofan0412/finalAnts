<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
/* bootstrap모달창에서 autocomplete 안먹을 때 설정 */
.ui-autocomplete {
	z-index: 2147483647;
}

.dropbtn {
	border: none;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: white;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	min-width: 200px;
	z-index: 1;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: #ddd;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown:hover .dropbtn {
	background-color: #3e8e41;
}
td{
	padding: 12px 5px 5px 12px !important;
}
	
	
#pagenum a{
	 display: inline-block;
	 text-align: center;
	 padding : 6px; 
	 border: none; 
	
}
	
li strong{
	display: inline-block;
	text-align: center;

	padding : 6px; 
}
	
.pagingui{
	 display: inline-block;
	 text-align: center;
	 width: 30px;
	 
}
#paging{
	 display: inline-block;
	 width:auto; float:left; margin:0 auto; text-align:center;"
	 
}
	
.option{
	height: 50px;
	width: 150px;
	padding: 5px;
}
</style>

</head>
<title>협업관리프로젝트</title>
<c:if test="${SMEMBER.memType == 'PM' }">

<form:form commandName="reqVo" id="listForm" name="listForm"
	method="post" >
	<form:hidden path="memId" />
	<input type="hidden" name="selectedId" />

	<!-- Content Header (Page header) -->
	<section class="content-header"
		style="
											border-bottom: 1px solid #dee2e6;
											background: white;">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h3 class="jg">요구사항 정의서</h3>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item san"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">요구사항 정의서</li>
				</ol>
			</div>
		</div>
	</div>
	<!-- /.container-fluid --> </section>

	<!-- Main content -->
	<section class="content" >
	<div class="col-md-12">
		<div class="card" style="border-radius: inherit;">
			<div class="card-header">
				<h3 class="card-title"></h3>
					<div class="input-group mb-3 ">
						<select class="form-control col-md-1" name="searchCondition" style="font-size: 0.8em;"
							id="searchCondition">
							<option value="0">제목</option>
							<option value="1">기간</option>
							<option value="2">담당자</option>
						</select>
						<!-- /btn-group -->
						<form:input path="searchKeyword" class="form-control col-md-2" style="font-size: 0.8em;" />
						<a href="javascript:fn_egov_reqList();">
							<button type="button" class="btn-default " style="height: 100%; ">
								<i class="fa fa-search"></i>
							</button>
						</a>
					</div>
				
			</div>
			<!-- /.card-header -->
			<div class="card-body p-0">
				<table class="table jg">
					<thead>
						<tr>
							<th style="width: 10%; text-align: center; ">No.</th>
							<th style="">제목</th>
							<th style="width: 5%;">기간</th>
							<th style="width: 10%; text-align: center;">담당자</th>
							<th style="width: 10%; text-align: center;">응답 상태</th>
							<th style="width: 15%; text-align: center;">진행도</th>
							<th style="width: 5%;"></th>
							<th style="width: 20%;"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${reqList }" var="req" varStatus="sts">
							<tr>
								<td style="padding-left: 24px!important; text-align: center;"><c:out
										value="${paginationInfo.totalRecordCount - ((reqVo.pageIndex-1) * reqVo.pageUnit + sts.index)}" />.
									<form:hidden path="reqId" />
								</td>
								<td>
									<a href="javascript:reqDetail('<c:out value="${req.reqId }"/>');">
										${req.reqTitle }
									</a> 
								
								</td>
								<td>${req.reqPeriod }일</td>
								<c:choose>
									<c:when test="${req.plId eq null }">
										<td style="text-align: center;"><a
											class="btn btn-default btn-sm addplModal" data-toggle="modal"
											data-target="#addpl" reqId="${req.reqId}" reqName="${req.reqTitle }"> <i
												class="fas fa-envelope"></i> PL등록
										</a></td>
									</c:when>
									<c:otherwise>
										<td class="plDelete" style="text-align: center;">
											<div class="dropdown">
												<button class="dropbtn btn btn-default btn-sm">${req.plName }</button>
												<div class="dropdown-content " style="text-align: left; width: max-content; font-size: 0.8em;">
												  <a class="">
													<div class="media">
										              <div class="media-body">
										                <span class="dropdown-item-title text-sm" >
										                  ${req.plName }
										                </span>
										                <span class="text-sm">[&nbsp;${req.plId }&nbsp;]</span>
										              </div>
										            </div>
												  </a>
												  <div class="dropdown-divider"></div>
												  <a class="text-sm" href="javascript:plDelete(${req.reqId},'${req.plId }');">삭제</a>
												</div>
											</div>
										</td>
									</c:otherwise>
								</c:choose>
								<td style="text-align: center;" class="ns"><c:choose>
										<c:when test="${req.status eq 'WAIT' }">
											<span class="badge badge-warning">대기</span>
										</c:when>
										<c:when test="${req.status eq 'REJECT' }">
											<span class="badge badge-danger">거절</span>
										</c:when>
										<c:when test="${req.status eq 'ACCEPT' }">
											<span class="badge badge-success">수락</span>
										</c:when>
									</c:choose>
								</td>
								<!-- 프로젝트가 생성되지 않았을 때 -->
								<td><c:choose>
										<c:when test="${req.proId eq null}">
											<span>프로젝트 생성 전 입니다</span>
										</c:when>
										<c:when test="${req.proId != null }">
											<div class="progress progress-xs progress-striped active">
												<!-- 프로젝트 진행도 -->
												<fmt:parseNumber value="${req.proPercent}" var="NUM" />
												<c:if
													test="${req.proPercent eq '0' or req.proPercent eq null}">
													<div class="progress-bar bg-danger"
														style="width: <c:out value="${NUM+1}" />%"></div>
												</c:if>
												<c:if
													test="${req.proPercent+0 != 0  and req.proPercent+0 <= 59+0}">
													<div class="progress-bar bg-warning"
														style="width: <c:out value="${NUM+1}" />%"></div>
												</c:if>
												<c:if
													test="${req.proPercent+0 >=60+0 and req.proPercent+0 <= 99+0}">
													<div class="progress-bar bg-primary"
														style="width: <c:out value="${NUM+1}" />%"></div>
												</c:if>
												<c:if test="${req.proPercent eq '100'}">
													<div class="progress-bar bg-danger"
														style="width: <c:out value="${NUM+1}" />%"></div>
												</c:if>
											</div>
										</c:when>
									</c:choose>
								</td>
								<c:choose>
									<c:when test="${req.proPercent eq '0' or req.proPercent eq null }">
										<td class="project-actions text-center">0 %</td>
									</c:when>
									<c:otherwise>
										<td class="project-actions text-center">${req.proPercent } %</td>
									</c:otherwise>
								</c:choose>
								<td class="project-actions text-right" style="opacity: .9; padding-right: 60px!important;">
									<c:if test="${req.proStatus eq null}">
										<a class="btn btn-danger btn-xs" href="javascript:reqDelete(${req.reqId });"> 
											<i class="fas fa-trash"></i> 삭제
										</a>
									</c:if>
									<a class="btn btn-default btn-xs" href="javascript:reqDetail('<c:out value="${req.reqId }"/>');">
										<i class="fas fa-folder"></i> 보기 
									</a> 
									<a class="btn btn-success btn-xs" href="javascript:reqUpdate(${req.reqId });"> 
										 <i class="fas fa-pencil-alt"></i> 수정
									</a>
								</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>
			<!-- paging -->
			<div id="paging" class="card-tools">
	           	<ul class="pagination pagination-sm jg" id ="pagingui">
		     		<li  class="page-item jg" id ="pagenum" >	
		     		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
		     		<form:hidden path="pageIndex" />		        		
	            </ul>
        	</div>

			<div class="card-footer clearfix">
				<button type="button" class="btn btn-default btn-flat" style="font-size: 0.7em;" id="back">뒤로가기</button>
				<a class="btn btn-app float-right"
					href="javascript:fn_egov_reqInsert();"> <i class="fas fa-edit"></i>
					작성하기
				</a>
			</div>

			<!-- /.card-body -->
		</div>
	</div>
	</section>

</form:form>

<!-- PL등록 모달창 -->
<div class="modal fade" id="addpl" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content" style="height: 500px;">
			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable">팀원에게 프로젝트관리를 요청해보세요!</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="plForm" name="plForm" method="post">
					<div class="col-md-6" style="float: left">
						<input type="hidden" name="jsonView" value="Y">
						<input type="hidden" id="modalReqId" name="reqId" value="">
						<input type="hidden" id="modalReqName" name="reqName" value="">
						<input type="hidden" name="status" value="WAIT"> <label
							for="recipient-name" class="control-label">이메일:</label> <input
							type="text" class="form-control" id="searchInput" name="memId" placeholder="이름을 입력해 검색해 보세요!">
						<div class="card-title error-page jg" id="memIdCheck"
							style="width: auto"></div>
					</div>
				</form>

				<div class="col-md-6" style="float: right">
					<img alt="" src="/dist/img/addpl.png"
						style="width: 100%; margin-right: 4%;">
				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="addplBtn">요청
					보내기</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	var searchCondition = "${reqVo.searchCondition}";
	if (searchCondition != "") {
		$('#searchCondition').val("" + searchCondition + "").attr("selected",
				"selected");
	}
	
	if(${plDelMsg == 0}){
		alert("pl을 삭제할 수 없습니다.")
	}
	
	toastr.options = {
			  "closeButton": false,
			  "debug": false,
			  "newestOnTop": false,
			  "progressBar": false,
			  "positionClass": "toast-top-full-width",
			  "preventDuplicates": true,
			  "onclick": null,
			  "showDuration": "300",
			  "hideDuration": "1000",
			  "timeOut": "5000",
			  "extendedTimeOut": "1000",
			  "showEasing": "swing",
			  "hideEasing": "linear",
			  "showMethod": "fadeIn",
			  "hideMethod": "fadeOut"
			}
	
	//뒤로가기
	$("#back").on("click", function() {
		window.history.back();
	});

	$(function() {
		

		/* pl등록버튼 클릭*/
		$('.addplModal').on('click', function() {
			var reqId = $(this).attr("reqId");
			var reqName = $(this).attr("reqName");
			console.log(reqId);
			$('#modalReqId').val(reqId);
			$('#modalReqName').val(reqName);

		});

		/* memId입력창에서 키업이벤트 발생시 */
		$('#searchInput').on('keyup', function() {
			memIdCheck();
		});
		
		/* memId 자동완성 */
		$("#searchInput").autocomplete({
			//자동완성 대상
			source : function(request, response) {
				$.ajax({
					type : 'get',
					url : "/req/json",
					dataType : "json",
					data : request,
					success : function(data) {
						response($.map(data, function(item) {
							return {
								label : item.memName+"["+item.memId+"]", // 자동완성 결과표시 값
								value : item.memId, // 선택시 memId 값 표시
								memName : item.memName

							}
						}));
					}
				});
			},
			select : function(event, ui) { //아이템 선택시

			},
			focus : function(event, ui) {
				return false;//한글 에러 잡기용도로 사용됨
			},
			minLength : 1,// 검색시작 글자 수 
			autoFocus : true, //첫번째 항목 자동 포커스
			classes : {
				"ui-autocomplete" : "highlight"
			},
			delay : 100, //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
			//disabled: false, //자동완성 기능 끄기
			position : {
				my : "right top",
				at : "right bottom"
			},
			close : function(event, ui) { //자동완성창 닫아질때 호출
				// 존재하는 회원인지 체크
				memIdCheck();
			}
		});

		/* pl요청 전송버튼 클릭 */
		$('#addplBtn').on('click', function() {
			var memIdCheck = $('#memIdCheck').attr('memIdCheckFlag');
			
			if(memIdCheck == 'true'){
				//memId를 plId로 바꾸기
				$('#searchInput').attr('name', 'plId');
				
				// 전송한 정보 db저장
				$.ajax({
					url : "/req/reqUpdate",
					data : $('#plForm').serialize(),
					method : "POST",
					success : function(data){
						saveMsg();
						$("#addpl .close").click();
						
					}
				});
			}
			else{
				toastr["warning"]("요청할 수 없습니다.");
			}
		});

	});
	
	/* pl요청 알림메세지 db에 저장하기 */
	function saveMsg(){
		var alarmData = {
							"alarmCont" : $('#modalReqId').val() + "&&${SMEMBER.memName}&&${SMEMBER.memId}&&/req/reqDetail?reqId="+$('#modalReqId').val()+"&&"+ $('#modalReqName').val(),
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
					
					let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memId +"&&"+ alarmData.alarmType;
					socket.send(socketMsg);
					fn_egov_reqList();
					
				},
				error : function(err){
					console.log(err);
				}
		});
	}
	/* 사용자 아이디 체크하기 */
	function memIdCheck() {
		$.ajax({
					url : "/req/memIdCheck",
					data : $('#plForm').serialize(),
					method : "POST",
					success : function(data) {
						// 메세지 추가
						if (data.memberVo == null) {
							$('#memIdCheck')
									.html(
											'<div><h3><i class="fas fa-exclamation-triangle text-warning"></i> 해당하는 회원이 없습니다.</h3><p>pl요청은 회원에게만 할 수 있습니다.</p></div>');
							$('#memIdCheck').attr('memIdCheckFlag', 'false');
						} else {
							$('#memIdCheck')
									.html(
											'<div><h3><i class="fas fa-check fa-2x text-success"></i> 요청을 보낼 수 있습니다.</h3></div>');
							$('#memIdCheck').attr('memIdCheckFlag', 'true');
						}
					}
				})
	}

	/* 요구사항정의서 삭제하기 */
	function reqDelete(id) {
		//pm이면 삭제 아니면 불가
		if(${SMEMBER.memType == 'PM'}){
			if (confirm("삭제한 정보는 복구할 수 없습니다. 정말 삭제하시겠습니까?")) {
				document.listForm.selectedId.value = id;
				document.listForm.action = "<c:url value = '${pageContext.request.contextPath}/req/reqDelete'/>";
				document.listForm.submit();
			}
		}else{
			alert("삭제 권한이 없습니다.");
		}
	}

	/* pl 삭제하기 */
	function plDelete(id,plId) {
		if(${SMEMBER.memType == 'PM'}){
			if (confirm("pl삭제시 복구 할 수 없으며 재등록을 해야합니다. 삭제하시겠습니까?")) {
				document.listForm.selectedId.value = id;
				document.listForm.memId.value = plId;
				document.listForm.action = "<c:url value = '${pageContext.request.contextPath}/req/plDelete?plId=" +plId+ "'/>";
				document.listForm.submit();
			}
		}else{
			alert("삭제권한이 없습니다.");
		}
	}

	/* 요구사항정의서 수정페이지보기 */
	function reqUpdate(id) {
		document.listForm.selectedId.value = id;
		document.listForm.action = "<c:url value = '${pageContext.request.contextPath}/req/reqUpdateView'/>";
		document.listForm.submit();
	}

	/* 요구사항정의서 상세보기 */
	function reqDetail(id) {
		document.listForm.selectedId.value = id;
		document.listForm.action = "<c:url value ='${pageContext.request.contextPath}/req/reqDetail'/>";
		document.listForm.submit();
	}

	/* 글 등록 화면 function */
	function fn_egov_reqInsert() {
		document.listForm.action = "<c:url value='${pageContext.request.contextPath}/req/reqInsertView'/>";
		document.listForm.submit();
	}

	/* 글 목록 화면 function */
	function fn_egov_reqList() {
		document.listForm.action = "<c:url value='${pageContext.request.contextPath}/req/reqList'/>";
		document.listForm.submit();
	}

	/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo) {
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='${pageContext.request.contextPath}/req/reqList'/>";
		document.listForm.submit();
	}

	
</script>
</c:if>

<c:if test="${SMEMBER.memType != 'PM' }">
	<br>
	<h1>권한이 없습니다!</h1>
</c:if>

</body>
</html>
