<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script type="text/javascript">
var id;
	$(document).ready(function(){
		$("#hotissuefileList tr").on("mousedown", function(e){
 			var hissuefId = $(this).data("hissuefid");
 			if(event.button == 2){
				 //Get window size:
			    var winWidth = $(document).width();
			    var winHeight = $(document).height();
			    //Get pointer position:
			    var posX = e.pageX;
			    var posY = e.pageY;
			    //Get contextmenu size:
			    var menuWidth = $(".contextmenu").width();
			    var menuHeight = $(".contextmenu").height();
			    //Security margin:
			    var secMargin = 10;
			    
			    $(".contextmenu").css({
			      "left": posX,
			      "top": posY-50
			    }).show();
			    id=hissuefId;
			    //Prevent browser default contextmenu.
			    return false;
 			}
		});
		
		 $(document).click(function(){
			    $(".contextmenu").hide();
			 });
	});
		
	function hotfiledown(){
	   	document.location = "/hotissueFile/hotfileDown?hissuefId="+id;
	}
	
	function hotfiledel(){
	   	document.location = "/hotissueFile/delhotfilesT?hissuefId="+id;
	}
	
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/hotissueFile/hotissuefileview'/>";
	   	document.listForm.submit();
	}
	 function search(){
		document.listForm.action = "<c:url value='/hotissueFile/hotissuefileview'/>";
		document.listForm.submit();
	 }
	 
</script>
<style type="text/css"> 
#todoTable{
	width : 1300px;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  .contextmenu {
  display: none;
  position: absolute;
  width: 150px;
  margin: 0;
  padding: 0;
  background: #FFFFFF;
  border-radius: 5px;
  list-style: none;
  box-shadow:
    0 15px 35px rgba(50,50,90,0.1),
    0 5px 15px rgba(0,0,0,0.07);
  overflow: hidden;
  z-index: 999999;
}

.contextmenu li {
  border-left: 3px solid white;
  transition: ease .2s;
}

.contextmenu li a {
  display: block;
  padding: 10px;
  color: black;
  text-decoration: none;
  transition: ease .2s;
}

.contextmenu li:hover {
  border-left: 3px solid blue;
}

.contextmenu li:hover a {
  color: black;
}

</style>
</head>
<body>
<%@include file="../layout/contentmenu.jsp"%>
<div style="padding-left: 30px; background-color: white;">
<a class="btn btn-default " href="${pageContext.request.contextPath}/hotIssue/hissueList"><i class="fas fa-edit"></i>PM-PL 이슈게시판</a>
<div id="tlqkf">
<ul class="contextmenu">
  <li><a href="#"><i class="fa fa-folder" style="padding-right: 20px;"></i>Folder</a></li>
  <li><a href="javascript:hotfiledown();"><i class="fas fa-download"  style="padding-right: 20px;"></i>Download</a></li>
  <li><a href="javascript:hotfiledel();"><i class="fas fa-trash"  style="padding-right: 20px;"></i>Delete</a></li>
</ul>
</div>	
 
<form:form commandName="hotIssueFileVo" id="listForm" name="listForm" method="post">
<div class="col-12 col-sm-12">
	<div style="padding-left: 30px; background-color: white;">
		<div class="float-left">
		    <div class="card-header with-border">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">		
						<select name="searchCondition" class="form-control col-md-3" style="width: 100px;">
							<option value="1" label="파일명"/>
						</select> 
							 <label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                         <input type="text" class="form-control" name="searchKeyword" value="${hotIssueFileVo.searchKeyword }">
		                  <a href="javascript:search();">
		                  	<button type="button" class="btn-default" style="height: 100%;">
                               <i class="fa fa-search"></i>
                          	</button>
                          </a>
					</div>
		        </div>
		    </div>
		</div>
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
				<th width="200px">유형</th>
				<th width="200px">크기</th>
			</tr> 
			<tbody id="hotissuefileList"> 
				<c:forEach items="${hotissuefileList}" var="hotissueFile" varStatus="sts" >
				    <tr data-hissuefid="${hotissueFile.hissuefId }">
					<td><c:out value="${paginationInfo.totalRecordCount - ((privatefileVo.pageIndex-1) * privatefileVo.pageUnit + sts.index)}"/>. 
						<input type="hidden" id="${hotissueFile.hissuefId }" name="${hotissueFile.hissuefId }">
					</td>	
					<td>
						<c:choose>
							<c:when test="${hotissueFile.hissuefExtension eq '3ds'}">
									<img src="/fileFormat/3ds.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'aac'}">
									<img src="/fileFormat/aac.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'ai'}">
									<img src="/fileFormat/ai.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'avi'}">
									<img src="/fileFormat/avi.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'bmp'}">
									<img src="/fileFormat/bmp.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'cad'}">
									<img src="/fileFormat/cad.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'cdr'}">
									<img src="/fileFormat/cdr.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'css'}">
									<img src="/fileFormat/css.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'dat'}">
									<img src="/fileFormat/dat.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'dll'}">
									<img src="/fileFormat/dll.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'dmg'}">
									<img src="/fileFormat/dmg.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'doc'}">
									<img src="/fileFormat/doc.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'eps'}">
									<img src="/fileFormat/eps.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'fla'}">
									<img src="/fileFormat/fla.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'flv'}">
									<img src="/fileFormat/flv.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'gif'}">
									<img src="/fileFormat/gif.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'html'}">
									<img src="/fileFormat/html.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'hwp'}">
									<img src="/fileFormat/hwp.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'indd'}">
									<img src="/fileFormat/indd.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'iso'}">
									<img src="/fileFormat/iso.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'jpg'}">
									<img src="/fileFormat/jpg.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'js'}">
									<img src="/fileFormat/js.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'midi'}">
									<img src="/fileFormat/midi.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'mov'}">
									<img src="/fileFormat/mov.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'mp3'}">
									<img src="/fileFormat/mp3.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'mpg'}">
									<img src="/fileFormat/mpg.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'pdf'}">
									<img src="/fileFormat/pdf.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'php'}">
									<img src="/fileFormat/php.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'png'}">
									<img src="/fileFormat/png.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'ppt'}">
									<img src="/fileFormat/ppt.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'pptx'}">
									<img src="/fileFormat/ppt.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'ps'}">
									<img src="/fileFormat/ps.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'psd'}">
									<img src="/fileFormat/psd.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'raw'}">
									<img src="/fileFormat/raw.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'sql'}">
									<img src="/fileFormat/sql.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'svg'}">
									<img src="/fileFormat/svg.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'tif'}">
									<img src="/fileFormat/tif.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'txt'}">
									<img src="/fileFormat/txt.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'wmv'}">
									<img src="/fileFormat/wmv.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'xls'}">
									<img src="/fileFormat/xls.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'xlsx'}">
									<img src="/fileFormat/xls.png" style="width:30px; height:30px;">
							</c:when>
							<c:when test="${hotissueFile.hissuefExtension eq 'xml'}">
									<img src="/fileFormat/xml.png" style="width:30px; height:30px;">
							</c:when> 
							<c:when test="${hotissueFile.hissuefExtension eq 'zip'}">
									<img src="/fileFormat/zip.png" style="width:30px; height:30px;">
							</c:when>
							<c:otherwise>
								<img src="/fileFormat/not.png" style="width:30px; height:30px;">
							</c:otherwise>
						</c:choose>
						${hotissueFile.hissuefFilename }
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
						${hotissueFile.regDt }
					</td>
					<td > 
						${hotissueFile.hissuefExtension}
					</td>
					<td > 
						${hotissueFile.hissuefSize }
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
</form:form>
</div>	
</body>
</html>