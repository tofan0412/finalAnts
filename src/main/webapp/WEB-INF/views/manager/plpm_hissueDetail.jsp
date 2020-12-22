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
		   	document.location = "/hotIssue/hissueInsertView?hissueParentid="+hissueId;
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
				var res ="";
			
				$("#hissueTitle").html(data.hotIssueVo.hissueTitle);
				$("#hissuetCont").html(data.hotIssueVo.hissuetCont);
				$("#regDt").html(data.hotIssueVo.regDt);
				$("#writer").html(data.hotIssueVo.writer);
				
				$("#hissueId").val(data.hotIssueVo.hissueId);
				$("#hissueParentid").val(data.hotIssueVo.hissueParentid);
				$("#hissueLevel").val(data.hotIssueVo.hissueLevel);
				

				if(data.filelist.length == 0){
					res += '<div class="jg" >[ 첨부파일이 없습니다. ]</div>';
					$("#filediv").html(res);
				}
				if(data.filelist.length != 0) {
					for( i = 0 ; i< data.filelist.length; i++){	
 						res += '<a href="${pageContext.request.contextPath}/hotissueFile/hotfileDown?hissuefId='+data.filelist[i].hissuefId+'"><input id ="files"  type="button" class="btn btn-default jg" name="'+ data.filelist[i].hissuefId+'" value="'+data.filelist[i].hissuefFilename+'" ></a>  ';
						
 						$("#filediv").html(res);
					}	
				}
			}
		});
	}
</script>
<style type="text/css">
  .success{
  background-color: #f6f6f6;
  width: 10%;
  text-align: center;
  }
</style>
</head>
<%@include file="../layout/contentmenu.jsp"%>
<br>
<div class="col-md-12 ns">
	<div class="card card-primary card-outline">
		<div class="card-header">
        	<h3 class="card-title jg">PM-PL 이슈 상세보기</h3>
        </div>
        <div class="card-body">
			<input type="hidden" id="hissueId">
			<input type="hidden" id="hissueParentid">
			<input type="hidden" id="hissueLevel">
		 <table class="table" >
		 <tr class="stylediff">
            <th class="success ">작성자</th>
            <td style="padding-left: 20px; width: 700px; "><div class="jg" id="writer"></div></td>
            <th class="success ">작성일</th>
            <td style="padding-left: 20px;"><div class="jg" id="regDt"></div></td>
        </tr>
        <tr class="stylediff">
            <th class="success ">제목</th>
         	<td colspan="3" style="padding-left: 20px;"><div class="jg" id="hissueTitle"></div></td>
        </tr>
		<tr>
            <th class="success">내용</th>
            <td colspan="3" style="padding-left: 20px;"><div class="jg" id="hissuetCont"></div></td>
        </tr>
        <tr>
            <th class="success">첨부파일</th>
            <td colspan="3" style="padding-left: 20px;"><div id = "filediv"></div>
			</td>
        </tr>
        </table>
		<br>
		<div id="btnMenu">
		<button type="button" class="btn btn-default jg" id="updateBtn">수정</button>
		<button type="button" class="btn btn-default jg" id="deleteBtn">삭제</button>
		<div class="float-right">
		<button type="button" class="btn btn-default jg" id="creatChildBtn">답글 작성</button>
		<button type="button" class="btn btn-default jg" id="back">뒤로가기</button>
		</div>	
		</div>
	</div>
</div>
</div>

</html>