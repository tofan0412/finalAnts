<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
/* bootstrap모달창에서 autocomplete 안먹을 때 설정 */
  .ui-autocomplete {
  	z-index:2147483647;
  }

</style>

</head>
<title>협업관리프로젝트</title>
	<form:form commandName="reqVo" id="listForm" name="listForm" method="post">

		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											border-bottom: 1px solid #dee2e6;
											background: white;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1 class="jg">요구사항 정의서</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">요구사항 정의서</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		

    <!-- Main content -->
		    <section class="content">
		      <div class="col-md-12">
			      <div class="card" style="border-radius: inherit;">
	              <div class="card-header">
	                <h3 class="card-title">요구사항 정의서 등록</h3>
	
	                <div class="card-tools">
	                  <ul class="pagination pagination-sm float-right">
	                    <li class="page-item"><a class="page-link" href="#">«</a></li>
	                    <li class="page-item"><a class="page-link" href="#">1</a></li>
	                    <li class="page-item"><a class="page-link" href="#">2</a></li>
	                    <li class="page-item"><a class="page-link" href="#">3</a></li>
	                    <li class="page-item"><a class="page-link" href="#">»</a></li>
	                  </ul>
	                </div>
	              </div>
	              <!-- /.card-header -->
	              <div class="card-body p-0">
	                <table class="table">
	                  <thead>
	                    <tr>
	                      <th style="width: 100px;">No.</th>
	                      <th>제목</th>
	                      <th>기간</th>
	                      <th style="text-align: center;">담당자</th>
	                      <th style="text-align: center;">응답 상태</th>
	                      <th></th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                      <c:forEach items="${reqList }" var="req" varStatus="sts" >
		                    	<tr>
			                      <td><c:out value="${paginationInfo.totalRecordCount - ((reqVo.pageIndex-1) * reqVo.pageUnit + sts.index)}"/>. 
			                      	  <input type="hidden" id="${req.reqId }" name="${req.reqId }">
			                      </td>
			                      <td>${req.reqTitle }</td>
			                      <td>${req.reqPeriod }일</td>
		                    	  <td style="text-align: center;">
		                    	  	<c:choose>
			                      	  <c:when test="${req.plId==null }">
			                      	  	<a class="btn btn-default btn-sm" data-toggle="modal" data-target="#addpl">
			                              <i class="fas fa-envelope"></i>
			                               PL등록
			                          	</a>
			                      	  </c:when>
			                      	  <c:otherwise>${req.plId }</c:otherwise>
			                      	</c:choose>
		                    	  </td>
			                      <td style="text-align: center;">
			                      	<c:choose>
			                      	  <c:when test="${req.status eq '대기' }"><span class="badge badge-warning">${req.status }</span></c:when>
			                      	  <c:when test="${req.status eq '반려' }"><span class="badge badge-danger">${req.status }</span></c:when>
			                      	  <c:when test="${req.status eq '수락' }"><span class="badge badge-success">${req.status }</span></c:when>
			                      	</c:choose>
			                      <td class="project-actions text-right" style="opacity: .9;">
			                          <a class="btn btn-primary btn-sm" href="javascript:reqDetail(${req.reqId });">
			                              <i class="fas fa-folder"></i>
			                              	보기
			                          </a>
			                          <a class="btn btn-info btn-sm" href="javascript:reqUpdate(${req.reqId });">
			                              <i class="fas fa-pencil-alt"></i>
			                               	수정
			                          </a>
			                          <a class="btn btn-danger btn-sm" href="javascript:reqDelete(${req.reqId });">
			                              <i class="fas fa-trash"></i>
			                              	삭제
			                          </a>
			                      </td>
			                    </tr>
	                      </c:forEach>
	                  
	                  </tbody>
	                </table>
	              </div>
	              
	              <div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm float-right">
	                    <li class="page-item"><a class="page-link" href="#">«</a></li>
		        			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page"  />
		        			<form:hidden path="pageIndex" />
	                    <li class="page-item"><a class="page-link" href="#">»</a></li>
	                 </ul>
        		  </div>
        		  
        		  <div class="card-footer clearfix">
	                <a class="btn btn-app float-right" href="javascript:fn_egov_reqInsert();">
                  		<i class="fas fa-edit"></i> 작성하기
                	</a>
	              </div>
        		  
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>
	</form:form>
	
	<!-- PL등록 모달창 -->
	<div class="modal fade" id="addpl" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content" style="height: 500px;">
	      <div class="modal-header">
	        <h3 class="modal-title jg" id="addplLable">팀원에게 프로젝트관리를 요청해보세요!</h3>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	      </div>
	      <div class="modal-body">
	      	<form:form commandName="memberVo" id="addplForm" name="addplForm" method="post">
	          <div class="col-md-6" style="float: left">
	            <label for="recipient-name" class="control-label">이메일:</label>
	            <input type="text" class="form-control" id="searchInput" name="memId"> <!-- searchInput id에 -->
	          </div>
	        </form:form>
	        
	        <div class="col-md-6" style="float: right">
	          <img alt="" src="/dist/img/addpl.png" style="width: 100%; margin-right: 4%;">
	        </div>
	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary" onclick="fn_egov_addpl()">요청 보내기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
<script type="text/javascript">
	
	$(function() {	
		// 해당 id에서 값이 입력되면 실행
		$("#searchInput").autocomplete({
			//자동완성 대상
			source : function( request, response ) {
	             $.ajax({
	                    type: 'get',
	                    url: "/req/json",
	                    dataType : "json",
	                    //검색데이터 보내기
	                    data : request,
	                    success: function(data) {
	                        //서버에서 json 데이터 response 후 목록에 추가
	                        response(
	                            $.map(data, function(item) {
	                                return {
	                                    label   : item.memId ,	//UI에서 표시되는 값
	                                    value   : item.memId ,	//선택시 input태그에 표시되는 값
	                                    memName : item.memName  //사용자 설정값으로 담을 수 도 있다. 
	
	                                }
	                            })
	                        );
	                    }
	               });
	            },	
			select : function(event, ui) {	//아이템 선택시
				console.log(ui);//사용자가 오토컴플릿이 만들어준 목록에서 선택을 하면 반환되는 객체
				console.log(ui.item.label);	
				console.log(ui.item.value);	
				console.log(ui.item.test);	
				
			},
			focus : function(event, ui) {	
				return false;//한글 에러 잡기용도로 사용됨
			},
			minLength: 1,// 최소 글자수
			autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
			classes: {	
			    "ui-autocomplete": "highlight"
			},
			delay: 100,	//검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
		  //disabled: false, //자동완성 기능 끄기
			position: { my : "right top", at: "right bottom" },	
			close : function(event, ui){	//자동완성창 닫아질때 호출
				
				//checkmemId();
			}
		})
		
	});

	/* 요구사항정의서 삭제하기 */
	function reqDelete(reqId){
		if(confirm("삭제한 정보는 복구할 수 없습니다. 정말 삭제하시겠습니까?")){
			document.location = "/req/reqDelete?reqId="+reqId;
		}else{
	
		}
	}
	
	/* 요구사항정의서 수정하기 */
	function reqUpdate(reqId){
	   	document.location = "/req/reqUpdateView?reqId="+reqId;
	}
	
	/* 요구사항정의서 상세보기 */
	function reqDetail(reqId){
		document.location = "/req/reqDetail?reqId="+reqId;
	}
	
	/* 글 등록 화면 function */
	function fn_egov_reqInsert() {
	   	document.location = "<c:url value='/req/reqInsertView'/>";
	}

	/* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/req/reqList'/>";
	   	document.listForm.submit();
	}
	
	/* 사용자 아이디 체크하기 */
	function checkmemId(){
		$.ajax({url  : "/member/memberCheck",
				data : $('#plForm').serialize(),
				method : "POST",
				success: function(data){
					if(data.cnt == 1){
						$('#memberCheck').append
					}
				}
		})
	}
	
	// addpl plId,status(대기)로 변경
	function reqModify(reqVo){
		
	}

</script>
	

</body>
</html>
