<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>

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
			    return false;
 			}
		});
		
		 $(document).click(function(){
			    $(".contextmenu").hide();
			 });
		 
			$("#pagenum a").addClass("page-link");
			
			$("#hotissueview").on('click', function(){
				$(location).attr('href', '${pageContext.request.contextPath}/hotIssue/hissueList');
			})
			
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
	width : 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    text-align: center;
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
	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 width : auto;	 
		 border: none; 
	
	}
	
	li strong{
		display: inline-block;
		text-align: center;
		width: 30px;
	}
	
	.pagingui{
		 display: inline-block;
		 text-align: center;
		 width: 30px;
		 
	}
	#paging{
		 display: inline-block;
		 width:auto; float:left; margin:0 auto; text-align:center;
		 
	}
	
</style>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<%@include file="../layout/contentmenu.jsp"%>
<div id="hhidde">
<ul class="contextmenu">
  <li class="jg"><a href="javascript:hotfiledown();"><i class="fas fa-download"  style="padding-right: 20px;"></i>Download</a></li>
  <li class="jg"><a href="javascript:hotfiledel();"><i class="fas fa-trash"  style="padding-right: 20px;"></i>Delete</a></li>
</ul>
</div>	
 
<form:form commandName="hotIssueFileVo" id="listForm" name="listForm" method="post">
<div class="col-12 col-sm-12">
	<div class="card" style="border-radius: inherit; padding : 2px;">
	<div>
	
	</div>
	<br>
		 <div class="card-header ">
			<div id="keyword" class="card-tools float-left" style="width: 450px;">
					<h3 class="jg" style="padding-left: 10px; display: inline-block;">PM-PL이슈 파일함</h3>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<button id="hotissueview" type="button" class="btn btn-default jg"><i class="fas fa-edit"></i>PM-PL 이슈게시판</button>
			</div>	
		</div>
		<div class="card-body p-0">
		<table id="todoTable" class="jg">
			<tr>
				<th style="width: 200px;">No.</th>
	            <th style="text-align:left; padding-left: 5%;width: 400px; " > 파일명</th> 
				<th> 날짜   </th>
				<th> 확장자   </th>
				<th> 용량   </th>
			</tr> 
			<tbody id="hotissuefileList"> 
				<c:forEach items="${hotissuefileList}" var="hotissueFile" varStatus="sts" >
				    <tr data-hissuefid="${hotissueFile.hissuefId }">
					<td><c:out value="${paginationInfo.totalRecordCount - ((hotissueFileVo.pageIndex-1) * hotissueFileVo.pageUnit + sts.index)}"/>. 
						<input type="hidden" id="${hotissueFile.hissuefId }" name="${hotissueFile.hissuefId }">
					</td>	
					<td class="jg" style="padding-left: 5%; text-align: left; width: 400px;">
					<img name="link" src="/fileFormat/${fn:toLowerCase(hotissueFile.hissuefExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">										 																	
					${hotissueFile.hissuefFilename }
					</td>
					<td > 
						${hotissueFile.regDt }
					</td>
					<td > 
					 ${fn:toUpperCase(hotissueFile.hissuefExtension) }
					</td>
					<c:set var="balance" value="${hotissueFile.hissuefSize }" />
					<fmt:parseNumber var="i" type="number" value="${balance}" />
					<!-- 용량이 1024KB를 초과했을 시 MB로 표시 -->
					<c:if test="${i >= 1024}">
					<td class="jg" style="text-align: center;"> <fmt:formatNumber value="${i/1024}" pattern=".00" /> MB</td>
					</c:if>
					<!-- 용량이 1024KB 이하일때 KB로 표시 -->
					<c:if test="${i < 1024}">
					<td class="jg" style="text-align: center;"> ${i} KB</td>
					</c:if>
					</tr>
					
				</c:forEach> 
				<c:if test="${hotissuefileList.size() == 0}">
				<td colspan="5" style="text-align: center;"  class="jg"><br> [ 결과가 없습니다. ] </td>
				</c:if>
			</tbody>
		</table>
		</div>  
	 <br>
	              <div id="paging" class="card-tools">
	              	<ul class="pagination pagination-sm jg" id ="pagingui">
		        		<li  class="page-item jg" id ="pagenum" >	
		        		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
		        		<form:hidden path="pageIndex" />		        		
                    
	                 </ul>
        		  </div>
        		  <br>
	          
           </div>
       </div>
</form:form>		
</body>
</html>