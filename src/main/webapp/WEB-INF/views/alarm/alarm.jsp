<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
 a{
 	color : gray;
 }
</style>
<script>
  $(function () {
	var searchCondition = "${alarmVo.searchCondition}";
		if (searchCondition != "") {
			$('#searchCondition').val("" + searchCondition + "").attr("selected","selected");
		}
	  
    //메일박스전체선택/취소 
    $('.checkbox-toggle').click(function () {
      var clicks = $(this).data('clicks')
      if (clicks) {
        //Uncheck all checkboxes
        $('.mailbox-messages input[type=\'checkbox\']').prop('checked', false)
        $('.checkbox-toggle .far.fa-check-square').removeClass('fa-check-square').addClass('fa-square')
      } else {
        //Check all checkboxes
        $('.mailbox-messages input[type=\'checkbox\']').prop('checked', true)
        $('.checkbox-toggle .far.fa-square').removeClass('fa-square').addClass('fa-check-square')
      }
      $(this).data('clicks', !clicks)
    })

    
  })
  
    /* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo) {
		document.alarmForm.pageIndex.value = pageNo;
		document.alarmForm.action = "<c:url value='/alarmList'/>";
		document.alarmForm.submit();
	}
  
    /* 요구사항정의서 수정 */
	function reqUpdate(id) {
	  	document.reqForm.selectedId.value = id;
		document.reqForm.action = "<c:url value = '/req/reqStsUpdate'/>";
		document.reqForm.submit();
		
	}
  
	/* 글 목록 화면 function */
	function alarmList() {
		document.alarmForm.action = "<c:url value='/alarmList'/>";
		document.alarmForm.submit();
	}
  	
  	function readAlarm(id){
  		$.ajax({
  				url : "/alarmUpdate",
  				data : {alarmId : id},
  				method : "post",
  				dataType : "json",
  				success : function(data){
  					alarmList();
  				}
  		})
  	}
  	
  	function getReqDetail(url,alarmId){
		readAlarm(alarmId);
  		document.location = url;
  	}
  
</script>

<title>협업관리프로젝트</title>

		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											background: white;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h1 class="jg">새로운 소식</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active">새로운 소식</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		

    		<!-- Main content -->
		    <section class="content nmc" >
		    	<div class="col-md-12" >
		          <div class="card card-outline" style="border-radius: inherit; margin-top: 15px;">
		            
		            <!-- /.card-header -->
		            <div class="card-body p-0">
		              <div class="mailbox-controls">
		                <!-- Check all button -->
		                <button type="button" class="btn btn-default btn-sm checkbox-toggle"><i class="far fa-square"></i>
		                </button>
		                <div class="btn-group">
		                  <button type="button" class="btn btn-default btn-sm">
		                    <i class="far fa-trash-alt"></i>
		                  </button>
		                  <button type="button" class="btn btn-default btn-sm">
		                    <i class="fas fa-reply"></i>
		                  </button>
		                  <button type="button" class="btn btn-default btn-sm">
		                    <i class="fas fa-share"></i>
		                  </button>
		                </div>
		                <!-- /.btn-group -->
		                <button type="button" class="btn btn-default btn-sm">
		                  <i class="fas fa-sync-alt"></i>
		                </button>
		                
		              </div>
		              <div class="table-responsive mailbox-messages">
		                  	<c:if test="${alarmList.size() eq 0 }">
		                  		<div class="error-page">
							
							        <div class="error-content">
							          <h3 class="ns"><i class="fas fa-envelope"></i> 알림이 없습니다.</h3>
							          <p class="ng"> 
							            	본인이 작성한 게시물에 댓글, 답글이 달리거나 요청을 받았을 때 도착한 알림을 볼 수 있는 공간입니다.
							          </p>
							        </div>
							      </div>
		                  	</c:if>
		                <table class="table table-hover">
		                  <form:form commandName="reqVo" id="reqForm" name="reqForm" method="POST">
		                  <input type = "hidden" name="selectedId">
		                  <tbody>
		                    <c:forEach items="${alarmList }" var="a" >
			                  <tr class="alarm-row">
			                    <td>
			                      <div class="icheck-primary">
			                        <input type="checkbox" value="" class="check1">
			                        <label for="check1"></label>
			                      </div>
			                    </td>
			                    <td class="mailbox-star">
				                    <c:choose>
				                    	<c:when test="${a.alarmType eq 'req-pl' or 'res-pl' }">
				                    		<c:if test="${a.alarmStatus eq 'N' }"><i class="far fa-envelope text-default"></i></c:if>
				                    		<c:if test="${a.alarmStatus eq 'Y' }"><i class="far fa-envelope-open text-default"></i></c:if>
				                    		
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'reply'}"><i class="far fa-comment-dots"></i></c:when>
				                    	<c:when test="${a.alarmType eq 'posts'}"><i class="fab fa-replyd"></i></c:when>
				                    </c:choose>
			                    </td>
			                    <td class="mailbox-name"><a href="read-mail.html">${fn:split(a.alarmCont,',')[2]}(${fn:split(a.alarmCont,',')[1]})</a></td>
			                    <td class="mailbox-subject" style="width: 70%;">
				                    <c:choose>
				                    	<c:when test="${a.alarmType eq 'req-pl' or 'res-pl' }"><b>PL 요청</b></c:when>
				                    	<c:when test="${a.alarmType eq 'res-pl' }"><b>PL 응답</b></c:when>
				                    	<c:when test="${a.alarmType eq 'reply'}"><b>댓글</b></c:when>
				                    	<c:when test="${a.alarmType eq 'posts'}"><b>게시물</b></c:when>
				                    </c:choose>
			                    	 - <a href="javascript:getReqDetail('${fn:split(a.alarmCont,',')[3] }','${a.alarmId }')">${fn:split(a.alarmCont,',')[4]} (제목을 누르면 상세페이지로 이동합니다.)</a>
			                    </td>
			                    <td class="project-actions text-right" style="opacity: .9;">
			                      <c:if test="${a.alarmType eq 'req-pl' }">
									<a class="btn btn-success btn-sm" href="javascript:reqUpdate('${fn:split(a.alarmCont,',')[0] }');"> 수락 </a>
									<a class="btn btn-default btn-sm" href="javascript:reqDelete(${fn:split(a.alarmCont,',')[2] });"> 거부</a>
			                      </c:if>
								</td>
			                  </tr>
		                    </c:forEach>
		                  </tbody>
			             </form:form>
		                </table>
		                <!-- /.table -->
		              </div>
		              <!-- /.mail-box-messages -->
		            </div>
		            <!-- /.card-body -->
		          <form:form commandName="alarmVo" id="alarmForm" name="alarmForm" method="post">
		          	<input type="hidden" name="alarmId" value=""> 
		            <div class="card-footer p-0">
		              <div class="mailbox-controls">
		                <!-- Check all button -->
		                <button type="button" class="btn btn-default btn-sm checkbox-toggle">
		                  <i class="far fa-square"></i>
		                </button>
		                <div class="btn-group">
		                  <button type="button" class="btn btn-default btn-sm">
		                    <i class="far fa-trash-alt"></i>
		                  </button>
		                  <button type="button" class="btn btn-default btn-sm">
		                    <i class="fas fa-reply"></i>
		                  </button>
		                  <button type="button" class="btn btn-default btn-sm">
		                    <i class="fas fa-share"></i>
		                  </button>
		                </div>
		                <!-- /.btn-group -->
		                <button type="button" class="btn btn-default btn-sm">
		                  <i class="fas fa-sync-alt"></i>
		                </button>
		                
		                
		                <div class="float-right">
				        	<div class="input-group input-group-sm">
				            	<select class="form-control" name="searchCondition"
									id="searchCondition" style="font-size: 0.7em;">
									<option value="">타입</option>
									<option value="1">요청</option>
									<option value="2">댓글</option>
									<option value="3">게시물</option>
								</select>
				                <div class="input-group-append">
				                	<div class="btn btn-default">
				                  	  <a href="javascript:alarmList();">
				                   		<i class="fas fa-search"></i>
				                  	  </a>
				                    </div>
				                </div>
				            </div>
		                
		                </div>
		                <!-- /.float-right -->
		              </div>
		                  <div id="paging" class="card-tools">
							<ul class="pagination pagination-sm">
								<ui:pagination paginationInfo="${paginationInfo}" type="image"
									jsFunction="fn_egov_link_page" />
								<form:hidden path="pageIndex" />
							</ul>
						  </div>
		            </div>
				</form:form>
		          </div>
          <!-- /.card -->
        	</div>
		    </section>
</body>
</html>
