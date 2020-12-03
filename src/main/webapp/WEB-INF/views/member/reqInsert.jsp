<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <c:set var="registerFlag" value="${empty reqVo.reqId ? 'create' : 'modify'}"/>
</head>
<title>협업관리프로젝트</title>
<form:form commandName="reqVo" id="detailForm" name="detailForm">
	<section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>요구사항 정의서 등록</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Text Editors</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
		<div class="row">
	        <div class="col-md-12">
	          <div class="card card-outline card-info">
	            <div class="card-header">
	                 <div class="form-group row col-md-6">
	                    <label for="inputEmail3" class="col-sm-2 col-form-label">제 목</label>
	                    <div class="col-sm-10">
	                      <form:input path="reqTitle" id="reqTitle" placeholder="제목을 입력하세요" class="form-control"/>
	                      <form:hidden path="reqId" />
	                      <form:hidden path="memId" />
	                	</div>
                  	</div>
	            </div>
	            <!-- /.card-header -->
	            <div class="card-body">
	              
	              <div class="form-group row col-md-2">
	                  <label>기간 (days):</label>
	
	                  <div class="input-group">
	                    <div class="input-group-prepend">
	                      <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
	                    </div>
	                    <form:input path="reqPeriod" class="form-control" id="reqPeriod" placeholder="60일이면 60만 적으세요."/>
	                  </div>
	                  <!-- /.input group -->
	               </div>
	              <div class="row col-md-2">
	                  <label>내용 :</label>
	              </div>
	              <form:textarea path="reqCont" id="summernote" style="display: none;"/>
	              <!-- 파일첨부 -->
	            </div>
	            <div class="card-footer">
				     <div class="row">
					     <div class="col-12">
					       <a href="#" class="btn btn-secondary" id="back">취소</a>
					       <c:choose>
						       	<c:when test="${registerFlag == 'modify' }">
						       		<a href="javascript:fn_egov_save();" class="btn btn-success float-right">수정</a>
						       	</c:when>
						       	<c:when test="${registerFlag == 'create' }">
						       		<a href="javascript:fn_egov_save();" class="btn btn-success float-right">저장</a>
						       	</c:when>
					       </c:choose>
					     </div>
					 </div>
	            </div>
	          </div>
	        </div>
	        <!-- /.col-->
	     </div>
	       
	     
	</form:form>
	
	
	<link rel="stylesheet" href="/plugins/summernote/summernote-bs4.min.css">
	<script src="/plugins/summernote/summernote-bs4.min.js"></script>
	<script src="/plugins/summernote/lang/summernote-ko-KR.js"></script>
	<script>
	
	//뒤로가기
	$("#back").on("click", function() {
		window.history.back();
	});
	
	$(function () {
	  // Summernote
	  $('#summernote').summernote({
		  height: 400,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
	  });
	  
	
	});
	
	 /* 글 등록 function */
    function fn_egov_save() {
    	frm = document.detailForm;
        	frm.action = "<c:url value="${registerFlag == 'create' ? '/req/reqInsert' : '/req/reqUpdate' }"/>";
            frm.submit();
    }
	
	
	function initData(){
		$('#reqTitle').val("텀블러 자동세척기 개발");
		$('#memId').val("pm1");
		$('#summernote').val("위잉위잉 자동세척해주는 기계개발사업입니다.");
		$('#reqPeriod').val("30");
	}
	
</script>

	
	

</body>
</html>
