<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
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
			$("#listform").attr("action", "${pageContext.request.contextPath}/hotIssue/hissueList");
			listform.submit();			
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

<form id="listform" action="${pageContext.request.contextPath}/hotIssue/hissueList" method="post">
    <input type="hidden" value="${searchCondition }" name="searchCondition">
    <input type="hidden" value="${searchKeyword }" name="searchKeyword">
    <input type="hidden" value="${pageIndex }" name="pageIndex">
</form>

<c:if test="${dbsize eq '1'}">
<c:forEach items="${hotlist }" var= "hot1" varStatus="sts" >
<div class="col-md-12 ns">
	<div class="card card-primary card-outline">
		<div class="card-header">
        	<h3 class="card-title jg">PM-PL 이슈 상세보기</h3>
        </div>
        <div class="card-body">
			<input type="hidden" id="hissueId" value="${hot1.hissueId }">
			<input type="hidden" id="hissueParentid" value="${hot1.hissueParentid }">
			<input type="hidden" id="hissueLevel" value="${hot1.hissueLevel }">
		 <table class="table">
		 <tr class="stylediff">
            <th class="success ">작성자</th>
            <td style="padding-left: 20px; width: 700px; "><div class="jg" id="writer" >${hot1.writer }</div></td>
            <th class="success ">작성일</th>
            <td style="padding-left: 20px;"><div class="jg" id="regDt">${hot1.regDt }</div></td>
        </tr>
        <tr class="stylediff">
            <th class="success ">제목</th>
         	<td colspan="3" style="padding-left: 20px;"><div class="jg" id="hissueTitle">${hot1.hissueTitle }</div></td>
        </tr>
		<tr>
            <th class="success" style="height: 300px;">내용</th>
            <td colspan="3" style="padding-left: 20px;"><div class="jg" id="hissuetCont">${hot1.hissuetCont }</div></td>
        </tr>
        <tr>
            <th class="success" style="height: 150px;">첨부파일</th>
            <td colspan="3" style="padding-left: 20px;">
            <div id = "filediv">
            <!-- 파일이 있는 경우 -->
            <c:if test="${not empty filelist}">
            	<c:forEach items="${filelist }" var= "filel1" varStatus="sts" >
            		<a href="${pageContext.request.contextPath}/hotissueFile/hotfileDown?hissuefId=${filel1.hissuefId}">
						<button id ="files${sts.index}" class="btn btn-default jg" name="${filel1.hissuefId}">
							<img name="link" src="/fileFormat/${fn:toLowerCase(filel1.hissuefExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
							 ${filel1.hissuefFilename} 다운로드
						</button>
					
					</a>
					<br>
<%--             		<a href="${pageContext.request.contextPath}/hotissueFile/hotfileDown?hissuefId=${filel1.hissuefId}"> --%>
<%--             		<input id ="files"  type="button" class="btn btn-default jg" name="${filel1.hissuefId}" value="${filel1.hissuefFilename}"></a> --%>
            	</c:forEach>
            </c:if>
            <!-- 파일이 없는 경우 -->
            <c:if test="${empty filelist}">
            	<div class="jg" >[ 첨부파일이 없습니다. ]</div>
            </c:if>
            </div>
			</td>
        </tr>
        </table>
		<!-- 로그인한사람이 글쓴이일때 -->
		<c:if test="${hot1.memId eq SMEMBER.memId }">
		<div id="btnMenu" class="card-footer">
		<button type="button" class="btn btn-default jg float-right" style="margin-left: 5px;" id="deleteBtn">삭제</button>
		<button type="button" class="btn btn-default jg float-right" id="updateBtn">수정</button>
		<button type="button" class="btn btn-default jg float-left" id="back">목록으로</button>
		</div>
		</c:if>
		<c:if test="${hot1.memId ne SMEMBER.memId }">
		<!-- 로그인한 사람이 글쓴이가 아닐때-->
		<div id="btnMenu">
		<div class="float-right">
		<button type="button" class="btn btn-default jg" id="creatChildBtn">답글 작성</button>
		<button type="button" class="btn btn-default jg" id="back">목록 보기</button>
		</div>	
		</div>
		</c:if>
	</div>
</div>
</div>
</c:forEach>
</c:if>

<c:if test="${dbsize eq '2'}">
<c:forEach items="${hotlist }" var= "hot1" varStatus="sts" >
<c:if test="${sts.index eq '0'}">
<div class="col-md-12 ns">

	

	<div class="card card-primary card-outline">
		<div class="card-header">
        	<h3 class="card-title jg">PM-PL 이슈 상세보기</h3>
        </div>
        <div class="card-body">
			<input type="hidden" id="hissueId" value="${hot1.hissueId }">
			<input type="hidden" id="hissueParentid" value="${hot1.hissueParentid }">
			<input type="hidden" id="hissueLevel" value="${hot1.hissueLevel }">
		 <table class="table">
		 <tr class="stylediff">
            <th class="success ">작성자</th>
            <td style="padding-left: 20px; width: 700px; "><div class="jg" id="writer" >${hot1.writer }</div></td>
            <th class="success ">작성일</th>
            <td style="padding-left: 20px;"><div class="jg" id="regDt">${hot1.regDt }</div></td>
        </tr>
        <tr class="stylediff">
            <th class="success ">제목</th>
         	<td colspan="3" style="padding-left: 20px;"><div class="jg" id="hissueTitle">${hot1.hissueTitle }</div></td>
        </tr>
		<tr>
            <th class="success">내용</th>
            <td colspan="3" style="padding-left: 20px;"><div class="jg" id="hissuetCont">${hot1.hissuetCont }</div></td>
        </tr>
        <tr>
            <th class="success">첨부파일</th>
            <td colspan="3" style="padding-left: 20px;">
            <div id = "filediv">
            <!-- 파일이 있는 경우 -->
            <c:if test="${not empty filelist}">
            	<c:forEach items="${filelist }" var= "filel1" begin ="0" varStatus="vs" end="${filelist.size() }" step="1">
            		<a href="${pageContext.request.contextPath}/hotissueFile/hotfileDown?hissuefId=${filel1.hissuefId}">
						<button id ="files${sts.index}" class="btn btn-default jg" name="${filel1.hissuefId}">
							<img name="link" src="/fileFormat/${fn:toLowerCase(filel1.hissuefExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
							 ${filel1.hissuefFilename} 다운로드
						</button>
					
					</a>
					<br>
            	</c:forEach>
            </c:if>
            <!-- 파일이 없는 경우 -->
            <c:if test="${empty filelist}">
            	<div class="jg" >[ 첨부파일이 없습니다. ]</div>
            </c:if>
            </div>
			</td>
        </tr>
        </table>
		<br>
		<!-- 로그인한사람이 글쓴이일때 -->
		<c:if test="${hot1.memId eq SMEMBER.memId }">
		<div id="btnMenu">
		<button type="button" class="btn btn-default jg" id="updateBtn">수정</button>
		<button type="button" class="btn btn-default jg" id="deleteBtn">삭제</button>
		<div class="float-right">
		<button type="button" class="btn btn-default jg" id="back">목록 보기</button>
		</div>	
		</div>
		</c:if>
		<c:if test="${hot1.memId ne SMEMBER.memId }">
		<!-- 로그인한 사람이 글쓴이가 아닐때-->
		<div id="btnMenu">
		<div class="float-right">
		<button type="button" class="btn btn-default jg" id="back">목록 보기</button>
		</div>	
		</div>
		</c:if>
		
	</div>
</div>
</div>
</c:if>
<c:if test="${sts.index eq '1'}">
<div class="col-md-12 ns" style="padding-top: 1%;">
	<div class="card card-primary card-outline">
		<div class="card-header">
        	<h3 class="card-title jg">답글 상세보기</h3>
        </div>
        <div class="card-body">
		 <table class="table" >
		 <tr class="stylediff">
            <th class="success ">작성자</th>
            <td style="padding-left: 20px; width: 700px; "><div class="jg" id="writer2">${hot1.writer }</div></td>
            <th class="success ">작성일</th>
            <td style="padding-left: 20px;"><div class="jg" id="regDt">${hot1.regDt }</div></td>
        </tr>
        <tr class="stylediff">
            <th class="success ">제목</th>
         	<td colspan="3" style="padding-left: 20px;"><div class="jg" id="hissueTitle2">${hot1.hissueTitle }</div></td>
        </tr>
		<tr>
            <th class="success">내용</th>
            <td colspan="3" style="padding-left: 20px;"><div class="jg" id="hissuetCont2">${hot1.hissuetCont }</div></td>
        </tr>
        <tr>
            <th class="success">첨부파일</th>
            <td colspan="3" style="padding-left: 20px;">
            <div id = "filediv2">
            <!-- 파일이 있는 경우 -->
            <c:if test="${not empty filelist2}">
            	<c:forEach items="${filelist }" var= "filel1" begin ="0" varStatus="vs" end="${filelist.size() }" step="1">
            		<a href="${pageContext.request.contextPath}/hotissueFile/hotfileDown?hissuefId=${filel1.hissuefId}">
						<button id ="files${sts.index}" class="btn btn-default jg" name="${filel1.hissuefId}">
							<img name="link" src="/fileFormat/${fn:toLowerCase(filel1.hissuefExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
							 ${filel1.hissuefFilename} 다운로드
						</button>
					</a>
					<br>
            	</c:forEach>
            	
            </c:if>
            <!-- 파일이 없는 경우 -->
            <c:if test="${empty filelist2}">
            	<div class="jg" >[ 첨부파일이 없습니다. ]</div>
            </c:if>
            </div>
            
			</td>
        </tr>
        </table>
		<br>
	</div>
</div>
</div>
</c:if>
</c:forEach>
</c:if>
</html>