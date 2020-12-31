<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	
	body{
		min-width: 800px;
	}

	#pagenum a{
		 display: inline-block;
		 text-align: center;
		  padding : 6px; 	 
		 border: none; 
		background: transparent;
	}
	
	li strong{
		display: inline-block;
		text-align: center;
		 padding : 6px; 
	}
	
	.pagingui{
		 display: inline-block;
		 text-align: center;
		 width: 30px;
		 
	}
	#paging{
		 display: inline-block;
/* 		 text-align: center; */
		 width:auto; float:left; margin:0 auto; text-align:center;"
		 
	}	
	
	 .contextmenu {
		  display: none;
		  position: absolute;
		  width: 180px;
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
		
		#recent, #old{
			background-color:transparent;  
		 	border:0px transparent solid;
		 	outline: none;
		}
	
</style>

<script type="text/javascript">

var pubid;
var someid;
var category;

$(function(){
	
	$("#insertissue").on('click', function(){
		
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/insertissueView');
	})
	
	
	if(${sort} == 2){
		$('#old').css("color","#00a2e4");
	}else if(${sort} == 1 || ${sort} == null){
		$('#recent').css("color","#00a2e4");
	}
	  

	$("#pubfileList tr").on("mousedown", function(e){
			console.log('click')
			var pubfileId = $(this).data("pubfileid");
			var someId = $(this).data("someid");
			var categoryId = $(this).data("categoryid");
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
		    pubid=pubfileId;
		    someid=someId;
		    category = categoryId;
		    
		    //Prevent browser default contextmenu.
		    return false;
			}
	 
	});
		

	 $(document).click(function(){
		    $(".contextmenu").hide();
	 });
	 
	// 마우스 올려놨을때
	$("#pubfileList tr").on("mouseenter",function(){
		$(this).css("backgroundColor","#F0F8FF");
	});

	// 마우스가 벗어났을때
	$("#pubfileList tr").on("mouseleave",function(){
		$(this).css("backgroundColor","white");
	});

	
})

// 파일 다운로드
function pubfiledown(){
   	document.location = "/file/publicfileDown?pubId="+pubid;

}
// 파일 복사
function pubfilecopy(){
   	document.location = "/privatefile/copyfile?pubId="+pubid;
   	alert('내 파일함으로 복사되었습니다.')
}

// 해당 게시글로 이동
function goboard(){
	if(category == 1){ // 일감
		document.location = "/todo/onetodoView?todoId="+someid;
	}else if(category== 3){// 이슈
		document.location = "/projectMember/eachissueDetail?issueId="+someid;
	}else if(category == 4){ //건의사항
		document.location = "/suggest/suggestDetail?sgtId="+someid;
	}else if(category == 6){ //일정
		document.location = "/schedule/scheduleSelect?scheId="+someid;
	}
   
//    	alert('이동 되었습니다.')
}


/* pagination 페이지 링크 function */
 function fn_egov_link_page(pageNo){
 	document.listForm.pageIndex.value = pageNo;
 	document.listForm.action = "<c:url value='/file/publicfileview'/>";
    document.listForm.submit();
 }
 
 
 function search(){
		document.listForm.pageIndex.value = 1;
	 	document.listForm.action = "<c:url value='/file/publicfileview'/>";
	    document.listForm.submit();
}

 
function oldsort(){
	 	document.listForm.pageIndex.value = 1;
	 	document.listForm.sort.value = 2;
	 	document.listForm.action = "<c:url value='/file/publicfileview'/>";
	    document.listForm.submit();
}

function recentsort(){
	 	document.listForm.pageIndex.value = 1;
	 	document.listForm.sort.value = 1;
	 	document.listForm.action = "<c:url value='/file/publicfileview'/>";
	    document.listForm.submit();
}
 
	 
</script>
</head>

<%-- <%@include file="./issuecontentmenu.jsp"%> --%>
<%@include file="../layout/contentmenu.jsp"%>

<body  oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<!-- 	<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->

<ul class="contextmenu">
  <li><a href="javascript:pubfilecopy();"><i class="fa fa-folder" style="padding-right: 20px; width: 30px;"></i>내 파일함으로</a></li>
  <li><a href="javascript:pubfiledown();"><i class="fas fa-download"  style="padding-right: 20px; width: 30px;"></i>다운로드</a></li>
  <li><a href="javascript:goboard();"><i class="fas fa-clipboard"  style="padding-right: 20px; width: 30px;"></i>해당게시글로</a></li>
</ul>

<form:form commandName="publicFileVo" id="listForm" name="listForm" method="post">

		    <!-- Content Header (Page header) -->
		    
		    
		  
		    
		    
<!-- 		 	<h3>협업이슈 리스트</h3> -->
<!-- 				<input type= "button" value="작성하기" id="insertissue"> -->
	
			<section class="content" >
		      <div class="col-12 col-sm-12">
			      <div class="card" style="border-radius: inherit; padding : 2px;">
			      
<!-- 				    <div class="container-fluid"> -->
<!-- 				        <div class="row mb-2"> -->
<!-- 				         <br> -->
<!-- 				          <div class="col-sm-6"> -->
<!-- 				          <br> -->
<!-- 				            <h2 class="jg" style=" padding-left : 10px;">파일함</h2> -->
<!-- 				          </div> -->
<!-- 				          <div class="col-sm-6"> -->
<!-- 				            <ol class="breadcrumb float-sm-right"  style="background : white"> -->
<!-- 				              <li class="breadcrumb-item san jg"><a href="#">Home</a></li> -->
<!-- 				              <li class="breadcrumb-item active jg">파일함</li> -->
<!-- 				            </ol> -->
<!-- 				          </div> -->
<!-- 				        </div> -->
<!-- 			        </div> -->
		        
		        <br>
		        <div class="card-header  ">
		        <div id="keyword" class="card-tools float-left"
						style="width: 450px;">
						<h3 class="jg" style="padding-left: 10px; display: inline-block;">파일함</h3>
						&nbsp;
						<form:hidden path="sort" />
						<form:button id="recent" onclick="javascript:recentsort();" >최신순</form:button> &nbsp;
						<form:button id="old" onclick="javascript:oldsort();" >오래된순</form:button> &nbsp;
				</div>	
				<div id="keyword" class="card-tools float-right" style="width: 450px;">
					<div class="input-group row">
						<label for="searchCondition" style="visibility:hidden;"></label>
						
<%-- 						<form:select path="pubExtension" id="extensionselect" cssClass="use" class="form-control col-md-3" style="width: 100px;"> --%>
<%-- 							<form:option value="all" label="전체파일"/> --%>
<%-- 							<form:option value="jpg" label="jpg"/> --%>
<%-- 							<form:option value="png" label="png"/> --%>
<%-- 							<form:option value="gif" label="gif"/> --%>
<%-- 							<form:option value="xlsx" label="xlsx"/> --%>
<%-- 							<form:option value="txt" label="txt"/> --%>
<%-- 							<form:option value="pptx" label="pptx"/> --%>
<%-- 							<form:option value="other" label="기타형식"/> --%>
<%-- 						</form:select> --%>
						
						
        				<form:select path="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">
							<form:option value="1" label="파일명"/>
							<form:option value ="2" label="소유자" />
							<form:option value="3" label="확장자" />
						</form:select> 
						
						
						<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                    <form:input style="width: 300px;" path="searchKeyword"  placeholder="검색어를 입력하세요." class="form-control jg"/>
<!--  						    <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="">  -->
						<span class="input-group-append">							
							<button class="btn btn-default" type="button" id="searchBtn" onclick="search()" >
								<i class="fa fa-fw fa-search"></i>
							</button>
						</span>
						
						<!-- end : search bar -->
					</div>
					<br>
		        </div>
		        
		      </div><!-- /.container-fluid -->

	              <!-- /.card-header -->
	              <div class="card-body p-0">
	                <table class="table">
	                  <thead>
	                    <tr>
	            
	                    
	                        <th style="width:10%; padding-left: 20px;  text-align: center;" class="jg">No.</th>
	                     	<th style="padding-left: 30px; width: 30%;" class="jg"> 파일명</th> 
	                     	<th style="text-align: center; width: 11%; " class="jg"> 카테고리명</th> 
							<th style="text-align: center; width: 11%;" class="jg"> 소유자 </th>
							<th style="text-align: center; width: 15%;" class="jg"> 날짜   </th>
							<th style="text-align: center; width: 10%;" class="jg"> 확장자   </th>
							<th style="text-align: center; width: 12%;" class="jg"> 용량   </th>
<!-- 		                    <th></th> -->
	                    </tr>
	                  </thead>
	                  <tbody id ="pubfileList">
	                
	                      
	                       <c:forEach items = "${pubfilelist  }" var ="file" varStatus="status">
								<tr data-pubfileid="${file.pubId }" data-someid="${file.someId}" data-categoryid="${file.categoryId}">
				                 	<td class="jg" style="width:10%;  text-align: center;">
				                 	
										<c:if test="${sort == 1}">
					                    	<c:out value="${paginationInfo.totalRecordCount - ((publicFileVo.pageIndex-1) * publicFileVo.pageUnit + status.index)}"/>.
				                    	</c:if>
				                    	<c:if test="${sort == 2}">
					                    	<c:out value="${  ((publicFileVo.pageIndex-1) * publicFileVo.pageUnit + (status.index+1))}"/>.
				                    	</c:if>
									</td>	
									<td class="jg" style="padding-left: 30px; text-align: left; width:30%;">
									<input type="hidden" id="${file.pubId}" name="${file.pubId}">		
									<input type="hidden" id="${file.pubFilename}" name="${file.pubFilename}">		
										
										<img name="link" src="/fileFormat/${fn:toLowerCase(file.pubExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">										 																	
									 		${file.pubFilename}
									</td>
									<c:if test="${file.categoryId == '1'}">
										<c:set var="category" value="일감"> </c:set>
										<td class="jg" style="text-align: center; width: 11%;"> ${category}</td>
									</c:if>
									<c:if test="${file.categoryId == '3'}">
										<c:set var="category" value="이슈"> </c:set>
										<td class="jg" style="text-align: center; width: 11%;"> ${category}</td>
									</c:if>
									<c:if test="${file.categoryId == '4'}">
										<c:set var="category" value="건의사항"> </c:set>
										<td class="jg" style="text-align: center; width: 11%;"> ${category}</td>
									</c:if>
									<c:if test="${file.categoryId == '6'}">
										<c:set var="category" value="일정"> </c:set>
										<td class="jg" style="text-align: center; width: 11%;"> ${category}</td>
									</c:if>
									<td class="jg" style="text-align: center; width: 11%;"> ${file.memId }</td>
									<td class="jg" style="text-align: center; width: 15%;"> ${file.regDt }</td>
									<td class="jg" style="text-align: center; width: 10%;"> ${fn:toUpperCase(file.pubExtension) }</td>

									<c:set var="balance" value="${file.pubSize}" />
									<fmt:parseNumber var="i" type="number" value="${balance}" />
									
									<!-- 용량이 1024KB를 초과했을 시 MB로 표시 -->
									<c:if test="${i >= 1024}">
										<td class="jg" style="text-align: center; width: 12%;"> <fmt:formatNumber value="${i/1024}" pattern=".00" /> MB</td>
									</c:if>
									<!-- 용량이 1024KB 이하일때 KB로 표시 -->
									<c:if test="${i < 1024}">
										<td class="jg" style="text-align: center; width: 12%;"> ${i} KB</td>
									</c:if>
<!-- 			                        <td style="text-align: center;"> -->
								</tr>
							 </c:forEach> 

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
        		
        		 
        		  
        		  
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>
			<br>
		

</form:form>	
<!-- </div> -->
</body>
</html>