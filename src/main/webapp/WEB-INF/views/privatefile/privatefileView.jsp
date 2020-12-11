<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/resources/upload/jquery.min.js" type="text/javascript"></script>
<script src="/resources/upload/jquery.uploadifive.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/resources/upload/uploadifive.css">

<title>Insert title here</title>
<style>
body{
	min-width: 1000px;
	min-height: 1000px;
}
.uploadifive-button {
	float: left;
	margin-right: 10px;
}
#queue {
	border: 1px solid blue;
	height: 177px;
	overflow: auto;
	margin-bottom: 10px;
	padding: 0 3px 3px;
	width: 98%;
	text-align: center;
	color: lightgray;
	line-height: 170px;
}
#todoTable {
	width: 98%;
	border-top: 1px solid #444444;
	border-collapse: collapse;
	border-bottom: 1px solid #444444;
}
th, td {
	padding: 10px;
	style="border:none;"
}
th{
	border-bottom: 1px solid #444444;
}
.delbtn{
	background-color: white;
	border-radius: 15px;
	padding-left: 10px;
	padding-right: 10px;
	text-align: center;
	border: 1px solid lightblue;
} 
.tooltip-inner {
   min-width: 650px;
    /* If max-width does not work, try using width instead */
   max-width: 650px; 
}

/* .delbtn{
	background-color: red;
	border-radius: 100%;
	text-align: center;
	font-size: 10px;
	font-weight: 900;
	color: white;
	border: 1px solid red;
}  */
</style>


<script type="text/javascript">
	$(document).ready(function(){
		
		
		$(document).tooltip({
			// 툴팁에 title 속성에 html 적용시키기
			content: function() {
		    	return $(this).prop('title');
		    }
		});
     
		// 마우스 올려놨을때
		$("#privatefileList tr").on("mouseenter",function(){
			$(this).css("backgroundColor","#F0F8FF");
			
			  
		/* 	$.ajax({ type: 'GET', 
				url: '/privatefile/privatefileSelect', 
				dataType : 'json',
				data: { "privId" : $(this).data("privid") }, 
				success: function(data){
					alert(data);
					$(this).attr('title', data.privateVo); 
				}
				
			}); //end ajax  */
			 
		});

		// 마우스가 벗어났을때
		$("#privatefileList tr").on("mouseleave",function(){
			$(this).css("backgroundColor","white");
		});  
     	  
     	// 드래그앤 드랍 파일등록 
 		$(function() {
			$('#file_upload').uploadifive({
				'uploadScript'     : '/privatefile/privateInsert',
				'fileObjName'     : 'file',    
				'auto'             : true,
				'queueID'          : 'queue',
				'onUploadComplete' : function(file, data) { 
					
					console.log(data); 
					location.reload();	// 페이지 새로고침
				}
				
			});
		});
		 
	});	
		
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/privatefile/privatefileView'/>";
	   	document.listForm.submit();
	}
	 function search(){
		document.listForm.action = "<c:url value='/privatefile/privatefileView'/>";
		document.listForm.submit();
	}
	 	
	 
</script>

</head>
<body>
	개인 파일함
<%@include file="../layout/contentmenu.jsp"%>

<form:form commandName="privatefileVo" id="listForm" name="listForm" method="post">
<div class="col-12 col-sm-12">
	<div style="padding-left: 30px; background-color: white;">
		<c:if test="${SMEMBER.memId ne null}"></c:if>
	
		<!-- 파일등록  -->
		<form>
		<div id="queue">파일을 등록하려면 파일을 끌어다 놓으세요</div>
		<div class="content" style="display: none">
		<input id="file_upload" name="file" type="file" multiple="true"/>
		</div>
		</form>
		
		<br>
		<div class="float-left">
		    <div class="card-header with-border">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">		
						<form:select path="searchCondition" cssClass="use" class="form-control col-md-3" style="width: 100px;">				
							<form:option value="1" label="날짜"/>
							<form:option value="2" label="파일명"/>
						</form:select> 
							 <label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                         <input type="text" class="form-control" name="searchKeyword" value="${privatefileVo.searchKeyword }">
		                  <a href="javascript:search();">
		                  	<button type="button" class="btn-default" style="height: 100%;">
                               <i class="fa fa-search"></i>
                          	</button>
                          </a>
					</div>
		        </div>
		    </div>
		</div>
		<div class="card-body p-0">
		<table id="todoTable">
			<tr>
				<th width="80px">No.</th> 
				<th style="padding-left:45px;">파일명</th>
				<th></th>  
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th width="200px">수정한 날짜</th>
				<th width="200px">파일사이즈</th>
				<th width="110px" style="padding-left:20px;">삭제</th>
			
			</tr> 
			<tbody id="privatefileList"> 
				<c:forEach items="${privatefileList}" var="privatefile" varStatus="sts" >
						
						<c:set var="orginalName" value="${privatefile.privFilename}"/>
						<c:set var="nameLength" value="${fn:length(orginalName)}"/>
						<c:set var="cutName" value="${fn:substring(orginalName, nameLength-5, nameLength)}"/>
						<c:set var="filename" value="${fn:substringAfter(cutName,'.')}"/>
						
				    <tr "data-privid="${privatefile.privId}" title="시퀸스 : ${privatefile.privId} <br>
																	수정한 날짜: ${privatefile.regDt } <br>
																	파일이름 : ${privatefile.privFilename } <br>
																	파일경로 : ${privatefile.privFilepath} <br>
																	파일사이즈 : ${privatefile.privSize } KB<br>
																	확장자: ${filename} <br>
																	작성자 : ${privatefile.memId} <br>
																	">
					<td><c:out value="${paginationInfo.totalRecordCount - ((privatefileVo.pageIndex-1) * privatefileVo.pageUnit + sts.index)}"/>. 
						<input type="hidden" id="${privatefile.privId }" name="${privatefile.privId }">
					</td>	
					<td>
						
						<c:choose>
							 
							
							<c:when test="${filename eq '3ds'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/3ds.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'aac'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/aac.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'ai'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/ai.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'avi'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/avi.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'bmp'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/bmp.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							
							
							<c:when test="${filename eq 'cad'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/cad.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'cdr'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/cdr.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'css'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/css.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'dat'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/dat.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'dll'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/dll.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							
							
							<c:when test="${filename eq 'dmg'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/dmg.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'doc'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/doc.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'eps'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/eps.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'fla'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/fla.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'flv'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/flv.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							
							
							<c:when test="${filename eq 'gif'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/gif.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'html'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/html.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'hwp'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/hwp.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'indd'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/indd.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'iso'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/iso.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							
							
							<c:when test="${filename eq 'jpg'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/jpg.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'js'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/js.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'midi'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/midi.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'mov'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/mov.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'mp3'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/mp3.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							
							
							<c:when test="${filename eq 'mpg'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/mpg.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'pdf'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/pdf.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'php'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/php.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'png'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/png.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'ppt'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/ppt.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'pptx'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/ppt.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							
							
							<c:when test="${filename eq 'ps'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/ps.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'psd'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/psd.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'raw'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/raw.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'sql'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/sql.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'svg'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/svg.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							
							
							<c:when test="${filename eq 'tif'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/tif.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'txt'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/txt.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'wmv'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/wmv.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'xls'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/xls.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							<c:when test="${filename eq 'xlsx'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/xls.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							
							
							<c:when test="${filename eq 'xml'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/xml.png" style="width:30px; height:30px;">
								</a>
							</c:when> 
							<c:when test="${filename eq 'zip'}">
								<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
									<img src="/fileFormat/zip.png" style="width:30px; height:30px;">
								</a>
							</c:when>
							
							
							<c:otherwise>
								<img src="/fileFormat/not.png" style="width:30px; height:30px;">
							</c:otherwise>
						</c:choose>
						 
						<a>${privatefile.privFilename }</a>
					</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					
					<td > 
						${privatefile.regDt }
					</td>
					<td style="padding-left:23px;"> 
						${privatefile.privSize } KB
					</td>
					<%-- <td>
						<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
						<input type="button" value="다운로드"/>
						</a>
					</td> --%>
					<td>
						<a href="/privatefile/privatefileDelete?privId=${privatefile.privId}">
						<input type="button" class="delbtn" value="삭제"/>
						</a>
					</td>
					</tr>
					
				</c:forEach> 
			</tbody>
		</table>
		</div>  
		  
		<div id="paging" class="card-tools" style="padding-right:2%">
		    <ul class="pagination pagination-sm float-right">
		   		<li class="page-item"><a class="page-link" href="#">«</a></li>
				<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page"  />
				<form:hidden path="pageIndex" />
			    <li class="page-item"><a class="page-link" href="#">»</a></li>
		    </ul>
        </div>
	</div>
</div>
</form:form>	
</body>
</html>