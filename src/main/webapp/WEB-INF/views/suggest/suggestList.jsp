<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style type="text/css">
#pagenum a {
	display: inline-block;
	text-align: center;
	width: auto;
	border: none;
	background: transparent;
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
	/* 		 text-align: center; */
	width: auto;
	float: left;
	margin: 0 auto;
	text-align: center;
	"
}

#searchBtn {
	color: #fff;
	background-color: #007bffab;
	border-color: #007bff;
	box-shadow: none;
}
th,td{
	text-align : center;
}
</style>
<script type="text/javascript">
$(function(){
	todoSearchList = [];
	
	$('#insertSuggestBtn').click(function(){
		$('#todoId').val('');
		$('#sgtTitle').val('');
		$('#sgtCont').val('');
		$('.warningTodo').empty();
		$('.warningTitle').empty();
		
		$('#suggestInsert').modal();
	})
	
	$('#todoId').keyup(function(){
		var keyword = $(this).val();
		$('.warningTodo').empty();
		
		// 사용자가 입력을 한 경우, 키워드를 통해 일감을 검색한다.
		if (keyword != ''){
			$.ajax({
				url : "/suggest/searchTodo",
				data : {keyword : keyword},
				method : "GET",
				success : function(res){
					todoSearchList = [];
					for (var i = 0 ; i < res.length; i++){
						if (keyword == '@'){
							todoSearchList.push("@["+res[i].todoId+"]"+":"+res[i].todoTitle);
						}else{
							todoSearchList.push("["+res[i].todoId+"]"+":"+res[i].todoTitle);	
						}
					}
					autoComplete(todoSearchList);
				}
			})
		}
	})
	
	$('#sgtTitle').keyup(function(){
		$('.warningTitle').empty();
	})
	
	// 자동 완성 부분 ..
	function autoComplete(todoSearchList){
		$('#todoId').autocomplete({
			source : todoSearchList,
			select : function(event, ui){
				console.log(ui.item);
			},
			minLength : 1,
			// 모달 창 위로 떠야 한다..
			appendTo : $('#suggestInsert'),
			focus: function(event, ui) {
	            return false;
	        }
		})
	}
	
	$('#regBtn').click(function(){
		cnt = 0;
		// 각 칸이 빈칸인지 아닌지를 확인해야 한다.
		if ($('#todoId').val().length == 0){
			$('.warningTodo').text("일감을 지정해 주세요.");
			cnt++;
		}
		if ($('#sgtTitle').val().length == 0){
			$('.warningTitle').text("건의사항 제목을 지정해 주세요.");
			cnt++;
		}
		if (cnt == 0){
			$('#sgtForm').submit();
		}
	})
	
})

/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/projectMember/issuelist'/>";
	    document.listForm.submit();
	}
</script>

<%@include file="/WEB-INF/views/layout/contentmenu.jsp"%>

<form:form commandName="suggestVo" id="listForm" name="listForm" method="post">
	<section class="content">
		<div class="col-12 col-sm-12">
			<div class="card" style="border-radius: inherit; padding: 2px;">
				<div class="container-fluid">
					<div class="row mb-2">
						<br>
						<div class="col-sm-6">
							<br>
							<h1 class="jg" style="padding-left: 10px;">건의 사항 리스트</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right" style="background: white">
								<li class="breadcrumb-item san"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">건의 사항 리스트</li>
							</ol>
						</div>
					</div>
				</div>

				<div class="card-header">
					<div id="keyword" class="card-tools float-right"
						style="width: 550px;">
						<div class="input-group row">
							<label for="searchCondition" style="visibility: hidden;"></label>

							<form:select path="searchCondition" cssClass="use"
								class="form-control col-md-3" style="width: 100px;">
								<form:option value="1" label="작성자" />
								<form:option value="2" label="제목" />
								<form:option value="3" label="내용" />
							</form:select>

							<label for="searchKeyword"
								style="visibility: hidden; display: none;"></label>
							<form:input style="width: 300px;" path="searchKeyword"
								cssClass="txt" placeholder="검색어를 입력하세요." class="form-control" />
							<span class="input-group-append">
								<button class="btn btn-primary" type="button" id="searchBtn"
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
								<th style="width: 150px; padding-left: 50px;">No.</th>
								<th style="padding-left: 30px;">건의사항 제목</th>
								<th>작성자</th>
								<th>날짜</th>
								<th>해당일감</th>
								<th>처리현황</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${suggestList }" var="suggest" varStatus="status">
								<tr>

									<td style="width: 150px; padding-left: 50px;"><c:out
											value="${  ((suggest.pageIndex-1) * suggest.pageUnit + (status.index+1))}" />.</td>

									<td style="padding-left: 30px;">
										<a href="#">${suggest.sgtTitle }</a>
									</td>
											
									<td>${suggest.memId }</td>
									<td>${suggest.regDt }</td>
									<td>${suggest.todoId }</td>
									<!-- 건의사항 상태 : 대기, 승인, 반려에 따른 출력 -->
									<c:if test="${'WAIT' == suggest.sgtStatus }">
										<td>대기</td>
									</c:if>
									<c:if test="${'Y' == suggest.sgtStatus }">
										<td>승인</td>
									</c:if>
									<c:if test="${'N' == suggest.sgtStatus }">
										<td>반려</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<br>
				<div id="paging" class="card-tools">
					<ul class="pagination pagination-sm" id="pagingui">

						<li class="page-item" id="pagenum"><ui:pagination
								paginationInfo="${paginationInfo}" type="image"
								jsFunction="fn_egov_link_page" /></li>
						<form:hidden path="pageIndex" />

					</ul>
				</div>
				<br>
				<div class="card-footer clearfix">
					<button id="insertSuggestBtn" type="button"
						class="btn btn-default float-right">
						<i class="fas fa-plus"></i>등 록
					</button>
				</div>



				<!-- /.card-body -->
			</div>
		</div>
	</section>
	<br>
</form:form>

<!-- Modal to invite new Members . . . -->
<div class="modal fade" id="suggestInsert" tabindex="-1" role="dialog"
	aria-labelledby="inviteMemberModal">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content" style="height: 600px; width : 400px;">
			
			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable" style="text-align : center;">건의사항 작성</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body" style="width: 100%; height: 100%;">
				<form:form commandName="suggestVo" id="sgtForm" name="sgtForm" 
							action="/suggest/suggestInsert">
					
					<label class="jg" style="float : left;">일감 검색</label>
					<div class="jg"><span class="jg warningTodo" style="color : red;"></span></div>
					
					<form:input id="todoId" path="todoId" style="width : 90%;"/>
					<!-- 사용자가 일감을 선택하지 않은 경우 .. -->
					
					<br><br>
					
					<label class="jg" style="float : left;">건의 사항 제목</label>
					<div class="jg"><span class="jg warningTitle" style="color : red;"></span></div>
					<form:input id="sgtTitle" path="sgtTitle" style="width : 90%;"/>
					<!-- 사용자가 제목을 입력하지 않은 경우 .. -->
					
					<br><br>
					
					<label class="jg">건의 사항 내용</label><br>
					<form:textarea id="sgtCont" path="sgtCont" rows="3" cols="30" 
									style="resize: none; width : 90%;"/>
				</form:form>
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-success" id="regBtn">등록</button>
			</div>
		</div>
	</div>
</div>
<!--  /Modal -->