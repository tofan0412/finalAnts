<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
	label{
		width : 76%;
		font-size: 1.2em;
	}
	#notice{
		padding-top:3%;
	}	
</style>

<%@include file="./noticecontentmenu.jsp"%>
<div id="notice" class="col-12 col-sm-9">
	<div class="card card-teal ">
	  <div class="card-body">
			<h3>공지사항  상세내역</h3>
			<br>
				
			<label for="noticeTitle" class="col-sm-2 control-label">제목</label>
			<label id ="noticeTitle" class="control-label">${noticevo.noticeTitle}</label>
			
			<br>
			<label for="noticeCont" class="col-sm-2 control-label">내용</label>
			<div>
			<label id ="noticeCont" class="control-label" >${noticevo.noticeCont }</label>
			</div>
			<br><br>
			<div>
			<label for="adminId" class="col-sm-2 control-label">작성자</label>
			<label id ="adminId" class="control-label" >${noticevo.adminId }</label>
			</div>
			<br>
			<label for="regDt" class="col-sm-2 control-label">작성일</label>
			<label id ="regDt" class="control-label">${noticevo.regDt }</label>
			
			<br><br><br>
			<input type= "button" value="목록" id="back"  class="btn btn-success">			

	    </div>      
	   </div>
</div>
