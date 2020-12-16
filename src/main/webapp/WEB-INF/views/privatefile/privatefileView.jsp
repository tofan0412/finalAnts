<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="/resources/upload/jquery.uploadifive.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/resources/upload/uploadifive.css">

<style>
body{
	min-width: 1000px;
}
.uploadifive-button {
	float: left;
	margin-right: 10px;
}
#queue {
	border: 1px solid black;
	height: 250px;
	overflow: auto;
	margin-bottom: 10px;	
	padding-left : 2px;
	width: 98%;
	text-align: center;
	
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

#pagenum a{
	 display: inline-block;
	 text-align: center;
	 width : auto;	
	 padding : 6px; 
	 border: none; 
	 background: transparent;
}

.pagination-sm .page-item:first-child .page-link {
    border-top-left-radius: .2rem;
    border-bottom-left-radius: .2rem;
}

li strong{
	display: inline-block;
	text-align: center;
	padding : 6px; 
/* 	width: 30px; */
}

#paging{
	 display: inline-block;
	 width:auto; float:left; margin:0 auto; text-align:center;"
	 
}

.option{
	height: 50px;
	width: 150px;
	padding: 5px;
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
</style>


<script type="text/javascript">

var id;
	$(document).ready(function(){
				
		$('#div').hide()
		
		$(document).tooltip({
			// 툴팁에 title 속성에 html 적용시키기
			content: function() {
		    	return $(this).prop('title');
		    }
		});
		
		// 삭제
		$(document).on('click',".delbtn", function(){
			privid = $(this).attr("id")
			console.log(privid)
	        if(confirm("정말 삭제하시겠습니까 ?") == true){
				$(location).attr('href', '/privatefile/privatefileDelete?privId='+privid);
	        }else{
	        	return;
	        }
		})
     
		// 마우스 올려놨을때
		$("#privatefileList tr").on("mouseenter",function(){
			$(this).css("backgroundColor","#F0F8FF");
		});

		// 마우스 우클릭시
		$("#privatefileList tr").on("mousedown", function(e){
			console.log('click')
			var privfileId = $(this).data("privid");
			console.log(privfileId)
			
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
		    id=privfileId;

		    //Prevent browser default contextmenu.
		    return false;
			}
		
		

		 
		});
		 $(document).click(function(){
			    $(".contextmenu").hide();
		 });
		
		
		
		
		// 마우스가 벗어났을때
		$("#privatefileList tr").on("mouseleave",function(){
			$(this).css("backgroundColor","white");
		});  
     	  
		var QueueCnt =0;
		var uploadCnt = 0;
     	// 드래그앤 드랍 파일등록 
 		
		$('#file_upload').uploadifive({
			'uploadScript'     : '/privatefile/privateInsert',
			'fileObjName'     : 'file',    
			'auto'             : false,
			'queueID'          : 'queue',				
			"fileType": '.gif, .jpg, .png, .jpeg, .bmp, .doc, .ppt, .xls, .xlsx, .docx, .pptx, .zip, .rar, .pdf',
			 "multi": true,
             "height": 30,
             "width": 100,
             "buttonText": "파일찾기",
             "fileSizeLimit": "20MB",
             "uploadLimit": 10,
			'onUploadComplete' : function(file, data) { 
				uploadCnt +=1;	
				finishUpload();
			},
			'onCancel': function (file) {// 파일이 큐에서 취소되거나 제거 될 때 트리거됩니다.					
				QueueCnt--;
				if(QueueCnt == 0){
					$('#dragdiv').show();
				}
			}, 			
			'onAddQueueItem'   : function(file) { // 대기열에 추가되는 각 파일에 대해 트리거됩니다.
				QueueCnt++;
				$('#dragdiv').hide();
			},
			'onClearQueue': function (queue) { // clearQueue 함수 중에 트리거 됨
				
			}
			
		});
		
     	
     	// 파일 등록 버튼
     	$('#fileregbtn').on('click', function(){
     		console.log('클릭모달')
     		uploadCnt = 0;
     		$('#filemodal').modal();
     	
     	})
     	
     	// 파일 등록
     	$('#regBtn').on('click', function(){
     		console.log('클릭모달')
     		$('#file_upload').uploadifive('upload');     	
     	})
		
     	// 모달창에서 모든 파일이 업로드 성공시
     	function finishUpload(){
     		if(uploadCnt == $('.uploadifive-queue-item').length){
     			console.log("닫아라랑아")
     			$('#modal').modal("hide");
     			$(location).attr('href', '/privatefile/privatefileView');
     		}
     	}
     	
     	
	});
	
	
	// 파일 다운로드
	function privfiledown(){
	   	document.location = "/privatefile/privatefileDown?privId="+id;
	}
	// 파일 삭제
	function privfiledel(){
	   	document.location = "/privatefile/privatefileDelete?privId="+id;
	}
	
		
	function fn_egov_link_page(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/privatefile/privatefileView'/>";
	   	document.listForm.submit();
	}
	 function search(){
		 document.listForm.pageIndex.value = 1;
		document.listForm.action = "<c:url value='/privatefile/privatefileView'/>";
		document.listForm.submit();
	}
	 	
	 
</script>

<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<div id="div">
	<%@include file="../layout/contentmenu.jsp"%>
</div>
<ul class="contextmenu">
  <li><a href="javascript:privfiledown();"><i class="fas fa-download"  style="padding-right: 20px;"></i>Download</a></li>
  <li><a href="javascript:privfiledel();"><i class="fas fa-trash"  style="padding-right: 20px;"></i>Delete</a></li>
</ul>

<form:form commandName="privatefileVo" id="listForm" name="listForm" method="post">

<section class="content" >
  <div class="col-12 col-sm-12">
  
  	
		<!-- 파일등록  -->
	   <div class="card" style="border-radius: inherit; padding : 2px;">
	      
	    <div class="container-fluid">
	        <div class="row mb-2">
	     
	          <div class="col-sm-6">
	          <br><br>
	            <h1 class="jg" style=" padding-left : 10px;">개인 파일함</h1>
	          </div>
	          <div class="col-sm-6">
	          <br>
	            <ol class="breadcrumb float-sm-right"  style="background : white">
	              <li class="breadcrumb-item san jg"><a href="#">Home</a></li>
	              <li class="breadcrumb-item active jg">개인 파일함</li>
	            </ol>
	          </div>
	        </div>
        </div>
        
    
        
	<div style="padding-left: 30px; background-color: white;">
	
		<br>
		<div class="float-left">
		    <div class="card-header">
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">		
						<form:select path="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">				
							<form:option value="1" label="파일명"/>
							<form:option value="2" label="날짜"/>
						</form:select> 
						
							 <label for="searchKeyword" style="visibility:hidden; display:none;"></label>
							 <form:input style="width: 300px;" path="searchKeyword"  placeholder="검색어를 입력하세요." class="form-control jg"/>
<%-- 	                         <input type="text" class="form-control jg" name="searchKeyword" placeholder="검색어를 입력하세요." value="${privatefileVo.searchKeyword }"> --%>
		                 
			                 <span class="input-group-append">							
								<button class="btn btn-default" type="button" id="searchBtn" onclick="search()" >
									<i class="fa fa-fw fa-search"></i>
								</button>
							 </span>
		                  	
                         
					</div>
		        </div>
		    </div>
		</div>
		<div class="float-right">
		    <div class="card-header with-border">
						<label class="jg">사용량 : 
							<c:set var = "total" value = "0" />
							<c:forEach items="${totalSize}" var="totalSize" varStatus="sts" >
								<c:set var= "total" value="${total + totalSize}"/> 
							</c:forEach>
							<c:if test="${total == 0 }">
								0 KB
							</c:if>
							<c:if test="${total < 1024 and total >0}">
								<fmt:formatNumber value="${total}" pattern=".00"></fmt:formatNumber> KB
							</c:if>
							<c:if test="${total >= 1024 and total/1024 < 1024}">
								<fmt:formatNumber value="${total/1024}" pattern=".00"></fmt:formatNumber> MB
							</c:if>
							<c:if test="${total/1024 >= 1024}">
								<fmt:formatNumber value="${total/1024/1024}" pattern=".00"></fmt:formatNumber> GB
							</c:if>
							
                        </label> 	
		    </div>
		</div>
		<div class="card-body p-0">
		<table id="todoTable">
			<tr>
				<th class="jg" style="width: 150px;  text-align: center;">No.</th> 
				<th class="jg" style="padding-left:60px;">파일명</th>
				<th class="jg" width="200px"  >파일사이즈</th>
				<th class="jg" width="150px " >확장자</th>
				<th class="jg" width="200px" style="padding-right:30px;">수정한 날짜</th>
<!-- 				<th class="jg" width="110px" style="padding-left:20px;">삭제</th> -->
			
			</tr> 
			<tbody id="privatefileList"> 
				
				<c:forEach items="${privatefileList}" var="privatefile" varStatus="sts" >
						
						<c:set var="orginalName" value="${privatefile.privFilename}"/>
						<c:set var="nameLength" value="${fn:length(orginalName)}"/>
						<c:set var="cutName" value="${fn:substring(orginalName, nameLength-5, nameLength)}"/>
						<c:set var="filename" value="${fn:substringAfter(cutName,'.')}"/>
						
				    <tr data-privid="${privatefile.privId}" title="시퀸스 : ${privatefile.privId} <br>
																	수정한 날짜: ${privatefile.regDt } <br>
																	파일이름 : ${privatefile.privFilename } <br>
																	파일경로 : ${privatefile.privFilepath} <br>
																	파일사이즈 : ${privatefile.privSize } KB<br>
																	확장자: ${filename} <br>
																	작성자 : ${privatefile.memId} <br>
																	">
																	
					<td style="width: 150px;  text-align: center;" class="jg"><c:out value="${((privatefileVo.pageIndex-1) * privatefileVo.pageUnit + sts.index+1)}"/>. 
						<input type="hidden" id="${privatefile.privId }" name="${privatefile.privId }">
					</td>	
					<td class="jg" style="padding-left:30px;">

						<img name="link" src="/fileFormat/${fn:toLowerCase(filename)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
						${privatefile.privFilename }

					</td>
					
					<c:set var="balance" value="${privatefile.privSize}" />
					<fmt:parseNumber var="i" type="number" value="${balance}" />
					
					<!-- 용량이 1024KB를 초과했을 시 MB로 표시 -->
					<c:if test="${i >= 1024}">
						<td class="jg" style="padding-left:23px;"> <fmt:formatNumber value="${i/1024}" pattern=".00" /> MB</td>
					</c:if>
					<!-- 용량이 1024KB 이하일때 KB로 표시 -->
					<c:if test="${i < 1024}">
						<td class="jg" style="padding-left:23px;"> ${i} KB</td>
					</c:if>
				
				
					<td  class="jg"> 
					 	${fn:toUpperCase(filename) }
					
					</td>
					
					<td  class="jg" style="padding-right: 30px;"> 
						${privatefile.regDt }
					</td>
					<%-- <td>
						<a href="/privatefile/privatefileDown?privId=${privatefile.privId}">
						<input type="button" value="다운로드"/>
						</a>
					</td> --%>
<!-- 					<td> -->
<%-- 						<a href="/privatefile/privatefileDelete?privId=${privatefile.privId}"> --%>
<%-- 						<input type="button" class="delbtn jg" id="${privatefile.privId}" value="삭제"/> --%>
<!-- 						</a> -->
<!-- 					</td> -->
					
					
					</tr>
					
				</c:forEach> 
				
			</tbody>
		</table>
		</div>  
	</div>
		<br>
		<c:if test="${privatefileList.size() == 0}">
			<p class="jg" style="text-align: center;">[등록된 파일이 없습니다.]</p>
		</c:if>
           <div id="paging" class="card-tools">
           	<ul class="pagination pagination-sm jg" id ="pagingui">
           	
      		<li  class="page-item jg" id ="pagenum" >	
      		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
      		<form:hidden path="pageIndex" />		        		
                
            </ul>
  		  </div>
  		
  		 
	 	<div class="card-footer clearfix">
          <button id="fileregbtn" type="button" class="btn btn-default float-left jg"><i class="fas fa-plus"></i>파일추가</button>
        </div>
	
	 </div>
	
	</div>

</section>
</form:form>	


</body>


<!-- 투표 등록 모달 -->
<!-- Modal to invite new Members . . . -->
<div class="modal fade" id="filemodal" tabindex="-1" role="dialog"
	aria-labelledby="inviteMemberModal" style=" padding-top: 150px;">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content" style="height: 600px auto; width : 500px;">
			
			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable" style="text-align : center;">파일 등록</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body" style="width: 100%; height: 100%;">
									
				<form>
				
					<div id="queue">
						<div id ="dragdiv" class="jg" style=" 	color: lightgray; text-align: center; padding-top: 25px;"><img src="/fileFormat/addfile.png" style="width:30px; height:30px;">마우스로 파일을 끌어오세요</div>
					</div>
					
<!-- 					<div class="content" style="display: none"> -->
					<input id="file_upload" name="file" type="file" multiple="true"/>
<!-- 					</div> -->
				</form>			
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-success" id="regBtn">등록</button>
			</div>
		</div>
	</div>
</div>


