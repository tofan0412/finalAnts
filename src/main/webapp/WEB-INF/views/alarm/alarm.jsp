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
</style>
<script>
toastr.options = {
  	  "closeButton": false,
  	  "debug": false,
  	  "newestOnTop": false,
  	  "progressBar": false,
  	  "positionClass": "toast-top-right",
  	  "preventDuplicates": false,
  	  "onclick": null,
  	  "showDuration": "300",
  	  "hideDuration": "1000",
  	  "timeOut": "5000",
  	  "extendedTimeOut": "1000",
  	  "showEasing": "swing",
  	  "hideEasing": "linear",
  	  "showMethod": "fadeIn",
  	  "hideMethod": "fadeOut"
  	}  	
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
    });
	
    $('.delBtn').on('click',function(){
	    var selectData = [];
	    $("input[name='alarmDel']:checked").each(function(){
	    	selectData.push($(this).val());
	    });
	    
	    if(selectData.length <= 0){
	    	toastr.warning('삭제할 알림이 없습니다.');
	    }else{
		    alarmDelete(selectData);
	    }
    });

    
  }); //function
  
    /* pagination 페이지 링크 function */
	function fn_egov_link_page(pageNo) {
		document.alarmForm.pageIndex.value = pageNo;
		document.alarmForm.action = "<c:url value='/alarmList'/>";
		document.alarmForm.submit();
	}
  
   
	/* 글 목록 화면 function */
	function alarmList() {
		document.alarmForm.action = "<c:url value='/alarmList'/>";
		document.alarmForm.submit();
	}
  	
	/* 알림삭제 */
	function alarmDelete(selectData){
		$.ajax({
				url : "/alarmDelete",
				data : JSON.stringify(selectData),
				method : "post",
				contentType : "application/json; charset=utf-8",
				dataType : "text",
				success : function(data){
					alarmList();
				}
		});
	}
	
	function readAlarm(url,alarmId,alarmType,reqId){
		$.ajax({
				url  : "/alarmUpdate",
				data : {alarmId : alarmId},
				method : "post",
				dataType : "json",
				success : function(data){
					if(alarmType == 'reply'){
						getReply(url,reqId);
					}else{
						getPage(url);
					}
				}
		});
	}
	function getReply(url,reqId){
		document.location = url+"&reqId="+reqId;
	}
	function getPage(url){
		document.location = url;
	}
  
</script>

<title>협업관리프로젝트</title>
	<form:form commandName="alarmVo" id="alarmForm" name="alarmForm" method="post">
		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											background: white;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6" style="color: dimgray">
		            <h4 class="jg"><i class="nav-icon fas fa-bullhorn"></i>&nbsp;&nbsp;새로운 소식</h4>
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
		                  <button type="button" class="btn btn-default btn-sm delBtn">
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
							          <p class="ns"> 
							            	본인이 작성한 게시물에 댓글, 답글이 달리거나 요청을 받았을 때 도착한 알림을 볼 수 있는 공간입니다.
							          </p>
							        </div>
							      </div>
		                  	</c:if>
		                <table class="table table-hover">
		                  <tbody>
		                    <c:forEach items="${alarmList }" var="a" varStatus="i">
		                      <c:if test="${a.alarmStatus eq 'N' }"><tr class="alarm-row" ></c:if>
		                      <c:if test="${a.alarmStatus eq 'Y' }"><tr class="alarm-row" style="background-color: rgba(0,0,0,.075)"></c:if>
			                  
			                    <td>
			                      <div class="icheck-primary">
			                        <input type="checkbox" value="${a.alarmId }" class="check1" name= "alarmDel">
			                        <label for="check1"></label>
			                      </div>
			                    </td>
			                    <td class="mailbox-star">
				                    <c:choose>
				                    	<c:when test="${a.alarmType eq 'req-pl' or a.alarmType eq 'res-pl' or a.alarmType eq 'req-pro'}">
				                    		<c:if test="${a.alarmStatus eq 'N' }"><i class="far fa-envelope text-default"></i></c:if>
				                    		<c:if test="${a.alarmStatus eq 'Y' }"><i class="far fa-envelope-open text-default"></i></c:if>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'reply'}">
				                    		<c:if test="${a.alarmStatus eq 'N' }"><i class="far fa-comment-dots"></i></c:if>
				                    		<c:if test="${a.alarmStatus eq 'Y' }"><i class="far fa-comment-dots"></i></c:if>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'posts'}">
				                    		<c:if test="${a.alarmStatus eq 'N' }"><i class="fab fa-replyd"></i></c:if>
				                    		<c:if test="${a.alarmStatus eq 'Y' }"><i class="fab fa-replyd"></i></c:if>
				                    	</c:when>
				                    </c:choose>
			                    </td>
			                    <td class="mailbox-name"><a href="read-mail.html">${fn:split(a.alarmCont,'&&')[2]}(${fn:split(a.alarmCont,'&&')[1]})</a></td>
			                    <td class="mailbox-subject" style="width: 70%;">
				                    <c:choose>
				                    	<c:when test="${a.alarmType eq 'req-pl' or 'res-pl' }"><b>PL 요청</b>
					                    	 - <a href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }')">${fn:split(a.alarmCont,'&&')[4]}</a>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'res-pl' }"><b>PL 응답</b>
					                    	 - <a href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }')">${fn:split(a.alarmCont,'&&')[4]} : ${fn:split(a.alarmCont,'&&')[5] } </a>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'reply'}"><b>댓글</b>
					                    	 - <a href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }',${fn:split(a.alarmCont,'&&')[0]})">${fn:split(a.alarmCont,'&&')[4]} : ${fn:split(a.alarmCont,'&&')[5] } </a>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'posts'}"><b>게시물</b>
					                    	 - <a href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }')">${fn:split(a.alarmCont,'&&')[4]} : ${fn:split(a.alarmCont,'&&')[5] } </a>
				                    	</c:when>
				                    </c:choose>
			                    </td>
			                    <td class="project-actions text-right" style="opacity: .9;">
			                      <c:if test="${a.alarmType eq 'req-pl' }">
									<a class="btn btn-default btn-sm" href="/project/readReqList"><i class="fas fa-sign-in-alt"></i> 응답 </a>
			                      </c:if>
								</td>
			                  </tr>
		                    </c:forEach>
		                  </tbody>
		                </table>
		                <!-- /.table -->
		              </div>
		              <!-- /.mail-box-messages -->
		            </div>
		            <!-- /.card-body -->
		          	<input type="hidden" name="alarmId" value=""> 
		            <div class="card-footer p-0">
		              <div class="mailbox-controls">
		                <!-- Check all button -->
		                <button type="button" class="btn btn-default btn-sm checkbox-toggle">
		                  <i class="far fa-square"></i>
		                </button>
		                <div class="btn-group">
		                  <button type="button" class="btn btn-default btn-sm delBtn">
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
							<ul class="pagination pagination-sm jg" id="pagingui">
								<ui:pagination paginationInfo="${paginationInfo}" type="image"
									jsFunction="fn_egov_link_page" />
								<form:hidden path="pageIndex" />
							</ul>
						  </div>
						  
						  
						  
		            </div>
		          </div>
          <!-- /.card -->
        	</div>
		    </section>
	</form:form>
</body>
</html>
