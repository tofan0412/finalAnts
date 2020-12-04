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
			
				$("#hissueTitle").html(data.hotIssueVo.hissueTitle);
				$("#hissuetCont").html(data.hotIssueVo.hissuetCont);
				$("#regDt").html(data.hotIssueVo.regDt);
				$("#writer").html(data.hotIssueVo.writer);
				
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
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div style="padding-left: 30px;"><h3>PM-PL 이슈 상세보기</h3><br>
		
		
		<input type="hidden" id="hissueId">
		<input type="hidden" id="hissueParentid">
		<input type="hidden" id="hissueLevel">
		
		<label for="hissueTitle" class="col-sm-1 control-label">제목</label>
		<label class="control-label" id="hissueTitle"></label><br><br>
		
		<label for="hissuetCont" class="col-sm-1 control-label">내용</label>
		<label class="control-label" id="hissuetCont"></label><br><br>
		
		<label for="writer" class="col-sm-1 control-label">작성자</label>
		<label class="control-label" id="writer"></label><br><br>
		
		<label for="regDt" class="col-sm-1 control-label">작성일</label>
		<label class="control-label" id="regDt"></label><br><br>

		<div id="btnMenu">
		<button type="button" class="btn btn-default" id="updateBtn">수정</button>
		<button type="button" class="btn btn-default" id="deleteBtn">삭제</button>
		<button type="button" class="btn btn-default" id="creatChildBtn">답글 작성</button>
		<button type="button" class="btn btn-default" id="back">뒤로가기</button>	
		</div>
</div>
</html>