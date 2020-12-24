<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script type="text/javascript">
	$(function(){
		//수락버튼 click
	    $('.in').on('click',function(){
	    	var reqId = $(this).val();
	    	var reqTitle = $(this).parent().prev().prev().text().trim();
	    	var memId = $(this).prev().val().trim();
		    $.ajax({
		    	url : "${pageContext.request.contextPath}/project/updatePjtMember",
		    	data : { reqId : reqId },
		    	method : "post",
		    	success : function(data){
		    			alert("참여가 완료됐습니다.");
		    			var alarmData = {
		    					"alarmCont" : reqId + "&&${SMEMBER.memName}&&${SMEMBER.memId}&&/req/reqDetail?reqId=" + reqId + "&&" + reqTitle + "&&ACCEPT&& ",
		    					"memId" 	: memId,
		    					"alarmType" : "res-pro"
		    			}
		    			// 알림db등록
		    			savePjtResMsg(alarmData);
		    	}
		    });
	    });
		
	    $('.rejectPjt').on('click',function(eve){
	    	var reqId = $(this).val();
	    	var reqTitle = $(this).parent().prev().prev().text().trim();
	    	var memId = $(this).prev().prev().val().trim();
	    	
	    	if (confirm("정말 거절하시겠습니까?")) {
		    	var promemId  = $(this).val();
			    $.ajax({
			    	url : "${pageContext.request.contextPath}/project/deletePjtMember",
			    	data : { promemId : promemId},
			    	method : "post",
			    	success : function(data){
			    			alert("거절이 완료됐습니다.");
			    			var alarmData = {
			    					"alarmCont" : reqId + "&&${SMEMBER.memName}&&${SMEMBER.memId}&&/req/reqDetail?reqId=" + reqId + "&&" + reqTitle + "&&REJECT&& ",
			    					"memId" 	: memId,
			    					"alarmType" : "res-pro"
			    			}
			    			// 알림db등록
			    			savePjtResMsg(alarmData);
			    			
			    	}
			    });
	    	}
	    	eve.preventDefault();
	    });
		
	/* 프로젝트초대 알림메세지 db에 저장하기 */
	function savePjtResMsg(alarmData){
		
		$.ajax({
				url : "/alarmInsert",
				data : JSON.stringify(alarmData),
				type : 'POST',
				contentType : "application/json; charset=utf-8",
				dataType : 'text',
				success : function(data){
					
					let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memId +"&&"+ alarmData.alarmType;
					socket.send(socketMsg);
					document.location = "${pageContext.request.contextPath}/project/requestPjtMember";
				},
				error : function(err){
					console.log(err);
				}
		});
	}
		
		
	});//function
	

</script>
<section class="content">
		      <div class="col-12 col-sm-12">
			    <div class="card" style="border-radius: inherit; padding : 2px;">
		        
		        <br>
		        <div class="card-header  ">
		        <div id="keyword" class="card-tools float-left" style="width: 450px;">
						<h3 class="jg" style="padding-left: 10px;">프로젝트 초대 목록</h3>
				</div>
				<div id="keyword" class="card-tools float-right" style="width: 550px;">
					<div class="input-group row">
						<label for="searchCondition" style="visibility:hidden;"></label>
						
						<label for="searchKeyword" style="visibility:hidden; display:none;" class="jg"></label>
	                    <input id="searchKeyword" name="searchKeyword" style="width: 300px;" placeholder="검색어를 입력하세요." class="form-control jg" type="text" value="">
<!--  						    <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="">  -->
						<span class="input-group-append">							
							<button class="btn btn-default" type="button" id="searchBtn" onclick="search()">
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
	                        <th style="width: 150px; padding-left: 50px; text-align: center;">No.</th>
	                     	<th style="padding-left: 30px; text-align: center;" class="jg">  프로젝트 제목</th> 
							<th style="text-align: center;" class="jg">   PL </th>
							<th style="text-align: center;" class="jg"> 응답 </th>
<!-- 	                      <th style="text-align: center;">응답 상태</th> -->
	                      <th></th>
	                    </tr>
	                  </thead>
	                  <tbody>
						<c:forEach items="${pjtMemberList }" var="i" varStatus="status">
							<tr>
								<td class="jg" style="width: 150px; padding-left: 50px; text-align: center;">${status.index +1 }.</td>
								<td class="jg"  style="padding-left: 30px; text-align: center;">${i.title}</td>
								<td class="jg" style="text-align: center;"> ${i.plName }</td>
								<td class="jg" style="text-align: center;"> 
									<input type="hidden" value="${i.plId}">
									<button type="button" class="btn btn-default in jg" value="${i.reqId }"><i class="fas fa-edit "></i>수락</button>
									<button type="button" class="btn btn-default rejectPjt jg" value="${i.promemId }"><i class="fas fa-edit "></i>거절</button>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${pjtMemberList.size() == 0}">
							<td colspan="7" style="text-align: center;"  class="jg"><br> [ 초대된 프로젝트가 없습니다. ] </td>
						 </c:if>
	                  </tbody>
	                </table>
	              </div>
 
	              
	              <br>
        		  
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>




</body>
</html>