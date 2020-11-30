<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<link href="http://fonts.googleapis.com/earlyaccess/nanumpenscript.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/jejumyeongjo.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/kopubbatang.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumbrushscript.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/hanna.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanummyeongjo.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/jejuhallasan.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
<style>
.np{font-family: 'Nanum Pen Script', cursive;}
.jg{font-family: 'Jeju Gothic', sans-serif;}
.jm{font-family: 'Jeju Myeongjo', serif;}
.kb{font-family: 'KoPub Batang', serif;}
.nb{font-family: 'Nanum Brush Script', cursive;}
.ns{font-family: 'Noto Sans KR', sans-serif;}
.hn{font-family: 'Hanna', sans-serif;}
.ng{font-family: 'Nanum Gothic', sans-serif;}
.nm{font-family: 'Nanum Myeongjo', serif;}
.jh{font-family: 'Jeju Hallasan', cursive;}
.ngc{font-family: 'Nanum Gothic Coding', monospace;}


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){ 
	
	$("a nav-link").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/projectMember/insertissueView');
	})
})
</script>


</head>
<title>협업관리프로젝트</title>
<body class="hold-transition sidebar-mini accent-teal">

		    <section class="content-header" style="border-bottom: 1px solid #dee2e6; background: linear-gradient(-10deg, #007bff, lightgoldenrodyellow) fixed;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1 class="jg">협업관리툴 개발</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">협업관리툴 개발</li>
		            </ol>
		          </div>
		        </div>
		        <div class="row mb-2">
		        	<p style = "color : lightslategray;">프로젝트 설명을 입력하세요.</p>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		
		    <!-- Main content -->
		    <section class="content" style="margin-top: 13px;">
		      <div class="col-12 col-sm-9">
	            <div class="card card-teal card-outline card-tabs">
	              <div class="card-header p-0 pt-1 border-bottom-0">
	                <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
	                
	                <c:forEach items = "${categorylist }" var ="category">
	               		          
			               <li class="nav-item">
		                    	 <a class="nav-link " id="${category.categoryId }" data-toggle="pill" href="projectMember/issuelist" role="tab" aria-controls="custom-tabs-three" aria-selected="false">${category.categoryName }</a>
		                   </li>

				 	</c:forEach> 
				 	
                   	<c:if test="${categorylist.size() == 4 }" >
			               <li class="nav-item">
                    			<a class="nav-link" id="custom-tabs-three-mywork-tab" data-toggle="pill" href="#custom-tabs-three-mywork" role="tab" aria-controls="custom-tabs-three-mywork" aria-selected="false">내 일감</a>
                  		   </li>
	                 </c:if>
	                 
	   
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-calendar-tab" data-toggle="pill" href="#custom-tabs-three-calendar" role="tab" aria-controls="custom-tabs-three-calendar" aria-selected="false">캘린더</a>
	                  </li>
	              
	                  <li class="nav-item">
	                    <a class="nav-link" id="custom-tabs-three-files-tab" data-toggle="pill" href="#custom-tabs-three-files" role="tab" aria-controls="custom-tabs-three-files" aria-selected="false">파일함</a>
	                  </li>
	                </ul>
	              </div>
	             
	            </div>
          	</div>
		      
		      
		      
		    </section>
		    <!-- /.content -->
	
	
	
</body>
</html>
