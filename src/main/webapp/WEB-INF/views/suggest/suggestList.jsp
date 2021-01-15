<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<style type="text/css">
#pagenum a {
	display: inline-block;
	text-align: center;
	width: auto;
	border: none;
}

li strong {
	display: inline-block;
	text-align: center;
	width: 30px;
}

.pagingui {
	display: inline-block;
	text-align: center;
	width: 30px;
}

#paging {
	display: inline-block;
	width: auto;
	float: left;
	margin: 0 auto;
	text-align: center;
	"
}

th, td {
	text-align: center;
}

#queue {
	border: 1px solid #E5E5E5;
	height: 177px;
	width: 90%;
	overflow: auto;
	margin-bottom: 10px;
	padding: 0 3px 3px;
}
</style>

<script type="text/javascript">
$(function(){
	todoSearchList = [];
	fileCnt = 0;
	
	$('.suggestInsertModal').on('click', '.singleTodo', function(){
		$('.warningTodo').empty();
		
		var todoId = $(this).attr("todoId");
	    var todoTitle = $(this).attr("todoTitle");
	    
	    $('#SearchTodoIdBar').val(todoId+":"+todoTitle);
	    
	})
	
	$('#insertSuggestBtn').click(function(){
		// 사용자 입력란 비우기
		$('#SearchTodoIdBar').val('');
		$('#sgtTitle').val('');
		$('#sgtCont').val('');
		// 경고 관련 div 비우기
		$('.warningTodo').empty();
		$('.warningTitle').empty();
		// 파일 관련 div 비우기
		$('.sgtFileList').empty();
		$('.file').val('');
		
		$('#suggestInsert').modal();
	})
	
	$('#searchTodo').keyup(function(){
		$('.warningTodo').empty();
		var keyword = $(this).val();
		
		for (var i = 0 ; i < $('.singleTodo').length ; i++){
			if ($('.singleTodo')[i].attributes[3].value.includes(keyword)){
				$('.singleTodo')[i].style.display = 'block';
			}else{
				$('.singleTodo')[i].style.display = 'none';
			}	
		}
	})
	
	// 초기화 버튼 클릭시 내용 초기화 -> 모달창 열고 닫을 때도 적용된다.
	$('.suggestResetBtn').click(function(){
		$('.warningTodo').empty();
		$('.warningTitle').empty();
		$('.sgtFileList').empty();
		$('.file').val('');
		$('#SearchTodoIdBar').val('');
		$('#sgtTitle').val('');
		$('#sgtCont').val('');
	})
	
	$('#sgtTitle').keyup(function(){
		$('.warningTitle').empty();
	})
	
	$('#sgtCont').keyup(function(){
		$('.warningCont').empty();
	})
	
// 	// 자동 완성 부분 ..
// 	function autoComplete(todoSearchList){
// 		$('#todoId').autocomplete({
// 			source : todoSearchList,
// 			select : function(event, ui){
// 				console.log(ui.item);
// 			},
// 			minLength : 1,
// 			// 모달 창 위로 떠야 한다..
// 			appendTo : $('#suggestInsert'),
// 			focus: function(event, ui) {
// 	            return false;
// 	        }
// 		})
// 	}

	// mouseover 이벤트
	$('.singleTodo').on('mouseenter',function(){
		$(this).css("background-color", 'lightgrey');
	})
	
	$('.singleTodo').on('mouseleave',function(){
		$(this).css("background-color", 'white');
	})
	
	$('#regBtn').click(function(){
		cnt = 0;
		// 각 칸이 빈칸인지 아닌지를 확인해야 한다.
		if ($('#SearchTodoIdBar').val().length == 0){
			$('.warningTodo').text("일감을 지정해 주세요.");
			cnt++;
		}
		if ($('#sgtTitle').val().length == 0){
			$('.warningTitle').text("건의사항 제목을 입력해 주세요.");
			cnt++;
		}
		
		if ($('#sgtCont').val().length == 0){
			$('.warningCont').text("건의사항 내용을 입력해 주세요.");
			cnt++;
		}
		
		if (cnt == 0){
			// Insert 하면 된다.
			// 파일부터 먼저 넣자.
			// formData는 전역변수로 선언하였다..
			formData = new FormData($('#suggestFileForm')[0]);
			//지정해주는 경우, 자동으로 데이터가 저장된다.
			
// 			for(var i = 0 ; i < fileCnt ; i++){
// 				formData.append("files", $('.file')[0].files[i]);	
// 			}
			$.ajax({
				url : "/suggest/suggestFileInsert",
				type : "POST",
				data : formData,
				contentType : false,
				processData : false,
				success : function(res){
					alert("작성하였습니다.");
					var sgtSeq = res.sgtSeq;
					$('#sgtId').val(sgtSeq);
					var todoTitle = $('#SearchTodoIdBar').val();
					var alarmData = {
	    					"alarmCont" : "${projectVo.reqId}&&${SMEMBER.memName}&&${SMEMBER.memId}&&/suggest/suggestDetail&&" + sgtSeq + "&&" + todoTitle + "&&" + $('#sgtTitle').val() + "&&" + $('#sgtCont').val() +"&&${projectVo.proName}" ,
	    					"memId" 	: "${projectVo.memId}",
	    					"alarmType" : "suggest"
	    			}
					saveSReqMsg(alarmData);
				
				}
			});
		}
	});
	
	/* 건의사항 요청 알림메세지 db에 저장하기 */
	function saveSReqMsg(alarmData){
		$.ajax({
				url : "/alarmInsert",
				data : JSON.stringify(alarmData),
				type : 'POST',
				contentType : "application/json; charset=utf-8",
				dataType : 'text',
				success : function(data){
					
					let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memId +"&&"+ alarmData.alarmType;
					socket.send(socketMsg);
					$('#sgtForm').submit();
				},
				error : function(err){
					console.log(err);
				}
		});
	}
	
	
})// $(function(){}) 종료..

/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/suggest/readSuggestList'/>";
	    document.listForm.submit();
	}
	
	function search(){
	 	document.listForm.pageIndex.value = 1;
	 	document.listForm.action = "<c:url value='/suggest/readSuggestList'/>";
	    document.listForm.submit();
	}
	
	// 파일 갯수 제한, 파일 용량 제한..
	function fileRestrict(fileNum){
		$('.sgtFileList').empty();
		if (fileNum > 5){
			alert("파일은 최대 5개까지 첨부할 수 있습니다.");
			$('.file').val('');
			fileCnt = 0;
		}
		else{
			fileCnt = fileNum;
			for(var i = 0 ; i < fileNum ; i++){
				if ( $('.file')[0].files[i].size/1024/1024 >= 20 ){
					alert("20MB 이상의 파일은 업로드할 수 없습니다.("+$('.file')[0].files[i].name+")");
					$('.sgtFileList').empty();
					$('.file').val('');
					fileCnt = 0;
					return;
				}else{
					$('.sgtFileList').append($('.file')[0].files[i].name+"<br>");
				}
			}
		}
	}
</script>

<%@include file="/WEB-INF/views/layout/contentmenu.jsp"%>

<form:form commandName="suggestVo" id="listForm" name="listForm"
	method="post">
	<section class="content">
		<div class="col-12 col-sm-12">
			<div class="card" style="border-radius: inherit;">
				<br>
				<div class="card-header">
					<div id="keyword" class="card-tools float-left"
						style="width: 450px;">
						<h3 class="jg" style="padding-left: 10px;">건의 사항 리스트</h3>
					</div>
					<div id="keyword" class="card-tools float-right"
						style="width: 450px;">
						<div class="input-group row">
							<label for="searchCondition" style="visibility: hidden;"></label>

							<form:select path="searchCondition"
								class="form-control col-md-3 jg" style="width: 100px;">
								<form:option value="1" label="작성자" />
								<form:option value="2" label="제목" />
								<form:option value="3" label="내용" />
							</form:select>

							<label for="searchKeyword"
								style="visibility: hidden; display: none;"></label>
							<form:input style="width: 300px;" path="searchKeyword"
								placeholder="검색어를 입력하세요." class="form-control jg" />
							<span class="input-group-append">
								<button class="btn btn-default" type="button" id="searchBtn"
									onclick="search()">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>

							<!-- end : search bar -->
						</div>
						<br>
					</div>
				</div>
				<!-- /.container-fluid -->

				<!-- /.card-header -->
				<div class="card-body p-0">
					<table class="table">
						<thead>
							<tr>
								<th class="jg" style="width: 150px; padding-left: 50px;">No.</th>
								<th class="jg" style="padding-left: 30px;">건의사항 제목</th>
								<th class="jg">작성자</th>
								<th class="jg">작성일</th>
<!-- 								<th class="jg">해당일감</th> -->
								<th class="jg">처리현황</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${suggestList }" var="suggest"
								varStatus="status">
								<tr>

									<td class="jg" style="width: 10%; padding-left: 50px;"><c:out
											value="${  ((suggest.pageIndex-1) * suggest.pageUnit + (status.index+1))}" />.</td>

									<td class="jg" style="padding-left: 30px; text-align : left;"><a
										href="/suggest/suggestDetail?sgtId=${suggest.sgtId }&memId=${suggest.memId }"
										>${suggest.sgtTitle }</a>
									</td>

									<td class="jg" style="width : 10%;">${suggest.memName }</td>
									<td class="jg" style="width : 15%;">${suggest.regDt }</td>
<%-- 									<td class="jg">${suggest.todoId }</td> --%>
									<!-- 건의사항 상태 : 대기, 승인, 반려에 따른 출력 -->
									<c:if test="${'WAIT' == suggest.sgtStatus }">
										<td class="jg" style="width : 10%;">
											<span 
												style="border : 3px solid #FFBF00;
												       background-color: #FFBF00;
												       border-radius : 0.3rem;">
												       &nbsp;대기&nbsp;
									       </span>
										</td>
									</c:if>
									<c:if test="${'ACCEPT' == suggest.sgtStatus }">
										<td class="jg" style="width : 10%;">
											<span 
												style="border : 3px solid #088A29;
												       background-color: #088A29;
												       border-radius : 0.3rem;
												       color : white;">
												       &nbsp;승인&nbsp;
									       </span>
										</td>
									</c:if>
									<c:if test="${'REJECT' == suggest.sgtStatus }">
										<td class="jg" style="width : 10%;">
											<span 
												style="border : 3px solid #FF0000;
												       background-color: #FF0000;
												       border-radius : 0.3rem;
												       color : white;">
												       &nbsp;반려&nbsp;
									       </span>
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<br>
				<div id="paging" class="card-tools">
					<ul class="pagination pagination-sm jg" id="pagingui">

						<li class="page-item jg" id="pagenum"><ui:pagination
								paginationInfo="${paginationInfo}" type="image"
								jsFunction="fn_egov_link_page" /></li>
						<form:hidden path="pageIndex" />

					</ul>
				</div>

				<div class="card-footer clearfix">
					<c:if test="${projectVo.proStatus == 'ACTIVE' }">
						<button id="insertSuggestBtn" type="button"
							class="btn btn-default float-left jg">
							<i class="fas fa-edit"></i>등 록
						</button>
					</c:if>
				</div>


				<!-- /.card-body -->
			</div>
		</div>
	</section>
	<br>
</form:form>

<div class="modal fade suggestInsertModal" id="suggestInsert"
	tabindex="-1" role="dialog" aria-labelledby="suggestInsertModal">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content" style="height: 600px; width: 800px;">

			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable"
					style="text-align: center;">건의사항 작성</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body" style="width: 100%; height: 100%;">
				<form:form commandName="suggestVo" id="sgtForm" name="sgtForm"
					action="/suggest/suggestInsert">
					<form:input path="sgtId" id="sgtId" type="text" hidden="hidden" />

					<div class="searchTodoArea"
						style="float: left; width: 45%; height: 400px;">
						<label class="jg" style="float: left;">선택한 일감</label>
						<!-- 사용자가 일감을 선택하지 않은 경우 .. -->
						<div class="jg">
							<span class="jg warningTodo" style="color: red;"></span>
						</div>
						<br>

						<form:input id="SearchTodoIdBar" class="jg" path="todoId"
							style="width : 90%; 
								   border : 2px solid lightgrey; 
								   border-radius : 0.7rem;"
							readonly="true" placeholder="일감을 선택해 주세요.." autocomplete="off" />

						<br><br>
						<!-- 일감 검색 searchBar -->
						<label class="jg" style="float: left;">일감 제목 검색</label> <input
							class="jg" type="text" id="searchTodo"
							style="width: 90%; border: 2px solid lightgrey; border-radius: 0.7rem;"
							placeholder="키워드를 입력해 주세요.." autocomplete="off"> 
						<br><br>
						<div style="overflow-y : auto; height : 60%;" >
							<c:forEach items="${myTodoList}" var="myTodo">
								<div class="jg singleTodo" todoId="${myTodo.todoId }" id="getTodo"
									todoTitle="${myTodo.todoTitle }"
									style="width: 90%; height: 50px;">
									
									<c:if test="${fn:length(myTodo.todoTitle) > 10 }">
									${fn:substring(myTodo.todoTitle,0,10)}...
									</c:if>
									<c:if test="${fn:length(myTodo.todoTitle) <= 10 }">
									${myTodo.todoTitle }
									</c:if>
									 
									<span style="float: right;">일감번호 : ${myTodo.todoId }</span> <br>
									<c:if test="${myTodo.todoImportance == 'gen' }">
										<span class="jg" style="font-size: 1.0em;">일반</span>
									</c:if>
									<c:if test="${myTodo.todoImportance == 'emg' }">
										<span class="jg" style="font-size: 1.0em;">긴급</span>
									</c:if>
								</div>
								<br>
							</c:forEach>
						</div>
					</div>

					<div class="suggestInsertArea jg" style="float: right; width: 50%;">
						<label style="float: left;">건의 사항 제목</label>
						<!-- 사용자가 제목을 입력하지 않은 경우 .. -->
						<div>
							<span class="warningTitle" style="color: red;"></span>
						</div>
						<form:input id="sgtTitle" path="sgtTitle"
							style="width : 90%;
								   border : 2px solid lightgrey; 
								   border-radius : 0.7rem;" maxlength="25"
							autocomplete="off" placeholder="25자 내로 입력해 주세요." />
						<br>
						<br> <label class="jg">건의 사항 내용</label>
						<span class="jg warningCont" style="color: red;"></span>
						<br>
						<form:textarea id="sgtCont" path="sgtCont" rows="3" cols="30"
							style="resize: none; 
											   width : 90%;
											   border : 2px solid lightgrey; 
								   			   border-radius : 0.7rem;"
							autocomplete="off" />
				</form:form>
				<br>
				<form id="suggestFileForm">
					<!-- 파일 첨부하기.. -->
					<label class="jg">파일 첨부</label>&nbsp;&nbsp; <span class="jg">파일은 최대
						5개까지 첨부 가능합니다.</span> 
						<input name="file" type="file" class="file"
						onchange="fileRestrict($('.file')[0].files.length)"
						multiple="multiple" />
					<div class="sgtFileList"></div>
				</form>
			</div>
		</div>

		<div class="modal-footer">
			<button type="button" class="btn btn-primary jg suggestResetBtn">초기화</button>
			<c:if test="${projectVo.memId ne SMEMBER.memId }">
				<button class="jg btn btn-success" id="regBtn">등록</button>
			</c:if>
		</div>
	</div>
</div>
</div>
