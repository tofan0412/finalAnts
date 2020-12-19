<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>noticeDetail.jsp</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<script type="text/javascript">
$(function(){
	$("#modnotice").on('click', function(){
		$(location).attr('href', '${pageContext.request.contextPath}/admin/updatenoticeView?noticeId=${noticevo.noticeId}');
	})
	$("#delnotice").on('click', function(){
        if(confirm("정말 삭제하시겠습니까 ?") == true){
			$(location).attr('href', '${pageContext.request.contextPath}/admin/delnotice?noticeId=${noticevo.noticeId}');
        }else{
        	return;
        }
	})
	$("#back").on('click',function(){
		window.history.back();
	})
})
</script>

<style type="text/css">
	label{
	
		width : auto;

	}
	#issuecont{
		display: inline-block;
		float: left;
	}
	
	.writeCon{
	width:100%; overflow:visible; background-color:transparent; border:none;
  		resize :none; 
	}
	
	#re_con{
		width: 700px;
		display :inline-block;
      	resize: none;
      	padding: 1.1em; /* prevents text jump on Enter keypress */
      	padding-bottom: 0.2em;
      	line-height: 1.6;
      	overflow-y:hidden;
	}	
 	#re_con.autosize { min-height: 60px; } 
	
	#filediv{
		display: inline-block;
		
	}
	#filelabel{
		float: left;
	}
	
	.form-control:disabled, .form-control[readonly] {
   background-color: white;
   }
  .success{
  background-color: #f6f6f6;
  width: 10%;
  text-align: center;
  }
</style>

</head>

<%@include file="./noticecontentmenu.jsp"%>
<%-- <%@include file="./eachproject.jsp"%> --%>


<body>

<div class="col-12 col-sm-12">
	<div class="card card-teal ">
		<div class="card-body" id="detailDiv">
			<br>
			<h4 class="jg">공지사항  상세내역</h4>
			<br>
			<table class="table" >
			
				<tr class="stylediff">
					<th class="success jg">제목</th>
			         	<td colspan="3">			  
			         		<label class="control-label" id="noticeTitle">${noticevo.noticeTitle}</label>
			         	</td>
			    </tr>
			    
			    <tr class="stylediff">
		            <th class="success jg">작성자</th>
		            <td style="padding-left: 20px; width: 700px;">
		            	<label class="control-label" id="adminid">${noticevo.adminId }</label>
		            </td>
		          	
		       
		            <th class="success jg">작성일</th>		            
		            <td style="padding-left: 20px; width: 700px;">
		            	<label class="control-label" id="regDt">${noticevo.regDt }</label>
		            </td>
		        </tr>
		        
		        <tr>
		            <th class="success jg" style="height: 300px;">내용</th>
		            <td colspan="3">
			           	<c:if test="${noticevo.noticeCont == '<p><br></p>'}">
							<label >[ 내용이 없습니다. ] </label>
						</c:if>
						<c:if test="${noticevo.noticeCont == null}">
							<label >[ 내용이 없습니다. ] </label>
						</c:if>
				
						<label id ="noticeCont" class="control-label">${noticevo.noticeCont }</label>
		            </td>
		        </tr>
			</table>
			
			<div class="card-footer clearfix" >
					<input type= "button" value="목록으로" id ="back" class="btn btn-default float-left jg" >
				
		 			<c:if test="${noticevo.adminId == adminId}">
						<input type= "button" value="삭제하기" id="delnotice"  class="btn btn-default float-right jg" >			
						<input type= "button" value="수정하기" id ="modnotice" class="btn btn-default float-right jg" style="margin-right: 5px;">
					</c:if>
				
            </div>
            
            
		</div>
	</div>
</div>



<!-- 
			<br><br>
			<c:if test="${noticevo.adminId == adminId}">
				<input type= "button" value="수정" id ="modnotice" class="btn btn-info">
				<input type= "button" value="목록" id="back"  class="btn btn-success">			
				<input type= "button" value="삭제" id="delnotice"  class="btn btn-danger">			
			</c:if>
 -->
 
</body>
</html>