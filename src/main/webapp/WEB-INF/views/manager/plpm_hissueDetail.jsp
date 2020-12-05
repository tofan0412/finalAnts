<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		hotDetail("${param.hissueId}");
		
 		// 답글 작성
		$(document).on('click','#creatChildBtn', function(){
			var hissueId = $("#hissueId").val();
		   	document.location = "/hotIssue/hissueInsertView?Parentid="+hissueId;
		})
		
		
 		// 이슈 수정
		$(document).on('click','#updateBtn', function(){
			var hissueId = $("#hissueId").val();
		   	document.location = "/hotIssue/updatehissueView?hissueId="+hissueId;
		})
		
		
		// 뒤로가기
		$(document).on('click','#back', function(){
			window.history.back();
		})
		
		
		// 핫이슈 삭제
		$(document).on('click','#deleteBtn', function(){
			var hissueId = $("#hissueId").val();
			 if(confirm("정말 삭제하시겠습니까 ?") == true){
				$(location).attr('href', '${pageContext.request.contextPath}/hotIssue/hotissuedel?hissueId='+hissueId);
			    }
			    else{
			        return ;
			    }
		})
 	})
 	
	function hotDetail(hissueId) {
		$.ajax({
			url : "/hotIssue/hissueDetail",
			method : "get",
			data : {
				hissueId : hissueId
			},
			success : function(data) {
			
				$("#hissueTitle").val(data.hotIssueVo.hissueTitle);
				$("#hissuetCont").html(data.hotIssueVo.hissuetCont);
				$("#regDt").val(data.hotIssueVo.regDt);
				$("#writer").val(data.hotIssueVo.writer);
				
				$("#hissueId").val(data.hotIssueVo.hissueId);
				$("#hissueParentid").val(data.hotIssueVo.hissueParentid);
				$("#hissueLevel").val(data.hotIssueVo.hissueLevel);
				
				if(data.todoVo.todoLevel == '1'){
					$("#creatChildBtn").hide();
				}
			}
		});
	}
</script>
<style type="text/css">
.form-control:disabled, .form-control[readonly] {
   background-color: white;
   }
</style>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px; padding-right: 410px;">
	<div class="card card-primary">
		<div class="card-header">
        	<h3 class="card-title">PM-PL 이슈 상세보기</h3>
        </div>
        <div class="card-body">
			<input type="hidden" id="hissueId">
			<input type="hidden" id="hissueParentid">
			<input type="hidden" id="hissueLevel">
		 <div class="form-group">
			<label for="hissueTitle">제목</label>
			<input type="text" id="hissueTitle" class="form-control" readonly="readonly">
		</div>
		 <div class="form-group">
			<label for="hissuetCont">내용</label>
			<div id="hissuetCont" class="form-control" style="margin-top: 0px; margin-bottom: 0px; overflow-y :scroll; height: 180px;"></div>
		</div>
		 <div class="form-group">
			<label for="writer">작성자</label>
			<input type="text" id="writer" class="form-control" readonly="readonly">
		</div>
		 <div class="form-group">
			<label for="regDt">작성일</label>
			<input type="text" id="regDt" class="form-control" readonly="readonly">
		</div>
	</div>
		<div id="btnMenu">
		<button type="button" class="btn btn-default" id="updateBtn">수정</button>
		<button type="button" class="btn btn-default" id="deleteBtn">삭제</button>
		<button type="button" class="btn btn-default" id="creatChildBtn">답글 작성</button>
		<button type="button" class="btn btn-default" id="back">뒤로가기</button>	
		</div>
</div>
</div>

</html>