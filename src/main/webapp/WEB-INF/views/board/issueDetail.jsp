<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<script type="text/javascript">
$(function(){
	$("#modissue").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/updateissueView?issueId=${issuevo.issueId}');
	})
	$("#delissue").on('click', function(){
        if(confirm("정말 삭제하시겠습니까 ?") == true){
			$(location).attr('href', '${pageContext.request.contextPath}/projectMember/delissue?issueId=${issuevo.issueId}');
        }else{
        	return;
        }
	})
})
</script>

<style type="text/css">
	label{
	
		width : auto;
		height : 30px;
		font-size: 1.2em;
	}
/* 	.col-sm-2{ */
/* 		font-size: 1.3em; */
/* 		font-weight: bold; */
/* 	} */
</style>

</head>

<%@include file="./issuecontentmenu.jsp"%>
<%-- <%@include file="./eachproject.jsp"%> --%>


<body>

<div class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
<!-- 		<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
			<h3>협업이슈 상세내역</h3>
			<br>
			
			<label for="memId" class="col-sm-2 control-label">작성자</label>
			<label id ="memId" class="control-label">${issuevo.memId }</label>
			
			<br>
			<label for="regDt" class="col-sm-2 control-label">작성일</label>
			<label id ="regDt" class="control-label">${issuevo.regDt }</label>
			
			<br>
			<label for="issueTitle" class="col-sm-2 control-label">이슈제목</label>
			<label id ="issueTitle" class="control-label">${issuevo.issueTitle}</label>
			
			
			<br>
			<label for="issueCont" class="col-sm-2 control-label">이슈 내용</label>
			<label id ="issueCont" class="control-label">${issuevo.issueCont }</label>
			
			<br><br>
			
			<label for="File" class="col-sm-2 control-label">첨부파일</label>
			<c:if test="${filelist.size() == 0}">
				[ 첨부파일이 없습니다. ]
			</c:if>
			
			<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1" >
							
				<a href="${cp }/file/publicfileDown?pubId=${files.pubId}"><input id ="files${vs.index}"  type="button" class="btn btn-default" name="${files.pubId}" value="${files.pubFilename} 다운로드" ></a>
			</c:forEach>
			
			<br><br><br><br>
			<c:if test="${issuevo.memId == memId}">
				<input type= "button" value="수정하기" id ="modissue" class="btn btn-default">
				<input type= "button" value="삭제하기" id="delissue"  class="btn btn-default">			
			</c:if>
				


	    </div>      
	   </div>
<!-- 	 </div>       -->
</div>

</body>
</html>