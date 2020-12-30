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
 	color : currentcolor;
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
	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 padding : 6px; 
		 border: none; 
	
	}	
	li strong{
		display: inline-block;
		text-align: center;

		padding : 6px; 
	}
	td{
		padding: 10px 5px 10px 7px !important;
	}
	.badge123{
		font-size: 97%;
		font-weight: 600;
	}
	#alarmPost p{
		margin: 0px;
		display: inline;
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
		document.alarmForm.action = "<c:url value='${pageContext.request.contextPath}/alarmList'/>";
		document.alarmForm.submit();
	}
  
   
	/* 글 목록 화면 function */
	function alarmList() {
		document.alarmForm.action = "<c:url value='${pageContext.request.contextPath}/alarmList'/>";
		document.alarmForm.submit();
	}
  	
	/* 알림삭제 */
	function alarmDelete(selectData){
		if (confirm("정말 삭제하시겠습니까?")) {
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
	}
	/* 읽은 알림 상태변경 */
	function readAlarm(url,alarmId,alarmType,reqId,id){
		$.ajax({
				url  : "/alarmUpdate",
				data : {alarmId : alarmId},
				method : "post",
				dataType : "json",
				success : function(data){
					if(alarmType.includes('reply') || alarmType == 'posts' || alarmType.includes('suggest')){
						getPage(url,alarmType,reqId,id);
					}else{
						document.location = url;
					}
				}
		});
	}
	
	/* 해당 페이지로 이동 */
	function getPage(url,alarmType,reqId,id){
		document.getPageForm.url.value = url;
		document.getPageForm.alarmType.value = alarmType;
		document.getPageForm.reqId.value = reqId;
		document.getPageForm.id.value = id;
		
		document.getPageForm.action = "<c:url value='${pageContext.request.contextPath}/getAlarmPage'/>";
		document.getPageForm.submit();
	}
  
</script>

<title>협업관리프로젝트</title>
	<form:form commandName="alarmVo" id="getPageForm" name="getPageForm" method="post">
		<form:hidden path="url"/>
		<form:hidden path="reqId"/>
		<form:hidden path="alarmType"/>
		<form:hidden path="id"/>
	</form:form>

	<form:form commandName="alarmVo" id="alarmForm" name="alarmForm" method="post">
		    <!-- Content Header (Page header) -->
		    <section class="content-header" style="
											background: white;">
		      <div class="container-fluid">
		        <div class="row mb-2">
		          <div class="col-sm-6">
		            <h3 class="jg" style="padding-left: 6%;"><i class="nav-icon fas fa-bullhorn"></i>&nbsp;&nbsp;새로운 소식</h3>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right">
		              <li class="breadcrumb-item san jg"><a href="${pageContext.request.contextPath}/member/mainpage">Home</a></li>
              		  <li class="breadcrumb-item active jg">새로운 소식</li>
		            </ol>
		          </div>
		        </div>
		      </div><!-- /.container-fluid -->
		    </section>
		

    		<!-- Main content -->
		    <section class="content nmc" >
		    	<div class="col-md-11" style="margin: auto;">
		          <div class="card card-outline" style="border-radius: inherit; margin-top: 15px;">
		            
		            <!-- /.card-header -->
		            <div class="card-body p-0" style="font-size: 0.9em;">
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
		                <table class="table table-hover ns" style="font-size: 1em;">
		                  <tbody>
		                  	
		                    <c:forEach items="${alarmList }" var="a" varStatus="i">
		                      <c:if test="${a.alarmStatus eq 'N' }"><tr class="alarm-row" style="height: 30px; width: 100%;"></c:if>
		                      <c:if test="${a.alarmStatus eq 'Y' }"><tr class="alarm-row" style="background-color: rgba(0,0,0,.03); height: 30px; width: 100%;"></c:if>
			                  
			                    <td style="width: 6%; text-align: right; ">
			                      <div class="icheck-primary">
			                        <input type="checkbox" value="${a.alarmId }" class="check1" name= "alarmDel">
			                        <label for="check1"></label>
			                      </div>
			                    </td>
			                    <td class="mailbox-star" style="width: 6%; text-align: center;">
				                    <c:choose>
				                    	<c:when test="${a.alarmType eq 'req-pl' or a.alarmType eq 'res-pl' or a.alarmType eq 'req-pro' or a.alarmType eq 'res-pro'}">
				                    		<c:if test="${a.alarmStatus eq 'N' }"><i class="far fa-envelope text-default"></i></c:if>
				                    		<c:if test="${a.alarmStatus eq 'Y' }"><i class="far fa-envelope-open text-default"></i></c:if>
				                    	</c:when>
				                    	<c:when test="${fn:contains(a.alarmType,'reply')}">
				                    		<c:if test="${a.alarmStatus eq 'N' }"><i class="far fa-comment-dots"></i></c:if>
				                    		<c:if test="${a.alarmStatus eq 'Y' }"><i class="far fa-comment-dots"></i></c:if>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'posts'}">
				                    		<c:if test="${a.alarmStatus eq 'N' }"><i class="fab fa-replyd"></i></c:if>
				                    		<c:if test="${a.alarmStatus eq 'Y' }"><i class="fab fa-replyd"></i></c:if>
				                    	</c:when>
				                    </c:choose>
			                    </td>
			                 
			                    <td class="mailbox-name" style="width: 15%; ">${fn:split(a.alarmCont,'&&')[1]}(${fn:substring(fn:split(a.alarmCont,'&&')[2],0,10)})</td>
			                    <td class="mailbox-subject">
				                    <c:choose>
				                    	<c:when test="${a.alarmType eq 'req-pl'}"><span id="newalarm" class="right badge badge123" style="background: #fed770;">PL요청</span>
					                    	  &nbsp;<a style="font-weight: bold;" href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }')">${fn:split(a.alarmCont,'&&')[4]}</a>
					                    	  <a class="btn btn-sm" href="${pageContext.request.contextPath}/project/readReqList" style="color: #0099ff;"><i class="fas fa-sign-in-alt" style="color: #0099ff;"></i> 응답 </a>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'res-pl' }"><span id="newalarm" class="right badge badge123" style="background: #fed770;">PL응답</span>
					                    	  &nbsp;<a style="font-weight: bold;" href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }')">${fn:split(a.alarmCont,'&&')[4]} </a>
					                    	  &nbsp;<span style="font-size: 0.9em; color: darkslategray;">[
					                    	  			<c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'ACCEPT'}">PL요청을 수락했습니다.</c:if>
					                    	  			<c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'REJECT'}">PL요청을 거절했습니다.</c:if>
					                    	  			]
					                    	  		</span>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'req-pro' }"><span id="newalarm" class="right badge badge123" style="background: lightblue;">초대</span>
					                    	  &nbsp;<a style="font-weight: bold;" href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }')">${fn:split(a.alarmCont,'&&')[4]}</a>
					                    	  <a class="btn btn-sm" href="${pageContext.request.contextPath}/project/requestPjtMember" style="color: #0099ff;"><i class="fas fa-sign-in-alt" style="color: #0099ff;"></i> 응답 </a>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'res-pro' }"><span id="newalarm" class="right badge badge123" style="background: lightblue;">초대 결과</span>
					                    	  &nbsp;<a style="font-weight: bold;" href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }')">${fn:split(a.alarmCont,'&&')[4]} </a>
					                    	  &nbsp;<span style="font-size: 0.9em; color: darkslategray;">[
					                    	  			<c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'ACCEPT'}">프로젝트 초대를 수락했습니다.</c:if>
					                    	  			<c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'REJECT'}">프로젝트 초대를 거절했습니다.</c:if>
					                    	  			]
					                    	  		</span>
				                    	</c:when>
				                    	<c:when test="${fn:contains(a.alarmType,'reply')}"><span id="newalarm" class="right badge badge123" style="background: gainsboro; margin-bottom: 5px;">댓글</span>
					                    	 &nbsp;<a style="font-weight: bold;" href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }','${fn:split(a.alarmCont,'&&')[0]}','${fn:split(a.alarmCont,'&&')[4]}')">  ${fn:substring(fn:split(a.alarmCont,'&&')[6],0,30)}</a>
					                    	 <br>
					                    	 <span style="font-size: 0.9em; color: darkslategray">
					                    	 	<c:if test="${a.alarmType eq 'reply-3' }">[이슈]</c:if>
					                    	 	<c:if test="${a.alarmType eq 'reply-4' }">[건의사항]</c:if>
					                    	 	<c:if test="${a.alarmType eq 'reply-6' }">[일정]</c:if>
					                    	 	<c:if test="${a.alarmType eq 'reply-10' }">[투표]</c:if>
					                    	 </span>
					                    	 ${fn:substring(fn:split(a.alarmCont,'&&')[5],0,30)}
					                    	 &nbsp;<span style="font-size: 0.8em; color: darkslategray">from.${fn:substring(fn:split(a.alarmCont,'&&')[7],0,13)}</span>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'posts'}"><span id="newalarm" class="right badge badge123" style="background: #87C488; margin-bottom: 5px;">답글</span>
					                    	 &nbsp;<a style="font-weight: bold;" href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }','${fn:split(a.alarmCont,'&&')[0]}','${fn:split(a.alarmCont,'&&')[4]}')">  ${fn:substring(fn:split(a.alarmCont,'&&')[6],0,30)}</a>
					                    	 &nbsp;<div style="display: inline; color: darkslategray" id="alarmPost"> ${fn:substring(fn:replace(fn:split(a.alarmCont,'&&')[7], '<br>', '&nbsp;'),0,30)} </div>
					                    	 <br><span style="font-size: 0.9em; color: darkslategray;">[PM-PL이슈게시판]&nbsp;</span>${fn:substring(fn:split(a.alarmCont,'&&')[5],0,30) }
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'suggest'}"><span id="newalarm" class="right badge badge123" style="background: #f249; margin-bottom: 5px;">건의사항</span>
					                    	 &nbsp;<a style="font-weight: bold;" href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }','${fn:split(a.alarmCont,'&&')[0]}','${fn:split(a.alarmCont,'&&')[4]}')">  ${fn:substring(fn:split(a.alarmCont,'&&')[6],0,30)}</a>
					                    	 &nbsp;<div style="display: inline; color: darkslategray" id="alarmPost"> ${fn:substring(fn:replace(fn:split(a.alarmCont,'&&')[7], '<br>', '&nbsp;'),0,30)} </div>
					                    	 <br><span style="font-size: 0.9em; color: darkslategray;">[일감]&nbsp;&nbsp;</span>${fn:substring(fn:split(a.alarmCont,'&&')[5],0,30) }
					                    	 &nbsp;<span style="font-size: 0.8em; color: darkslategray;">from.${fn:substring(fn:split(a.alarmCont,'&&')[8],0,13) }</span>
				                    	</c:when>
				                    	<c:when test="${a.alarmType eq 'res-suggest'}"><span id="newalarm" class="right badge badge123" style="background: #f249; margin-bottom: 5px;">건의사항 결과</span>
											 &nbsp;<a style="font-weight: bold;" href="javascript:readAlarm('${fn:split(a.alarmCont,'&&')[3] }','${a.alarmId }','${a.alarmType }','${fn:split(a.alarmCont,'&&')[0]}','${fn:split(a.alarmCont,'&&')[3]}')">  ${fn:substring(fn:split(a.alarmCont,'&&')[6],0,30)}</a>					                    	  
											 &nbsp;<span style="font-size: 0.9em; color: darkslategray;">[
					                    	  			<c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'ACCEPT'}">건의사항이 승인됐습니다.</c:if>
					                    	  			<c:if test="${fn:split(a.alarmCont,'&&')[5] eq 'REJECT'}">건의사항이 반려됐습니다.</c:if>
					                    	  			]
					                    	  		</span>
				                    	</c:when>
				                    </c:choose>
			                    </td>
			                    
			                    <td>${a.regDt }</td>
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
		            </div>
		            <div id="paging" class="card-tools">
			           	<ul class="pagination pagination-sm jg" id ="pagingui">
					       	<li  class="page-item jg" id ="pagenum" >	
					       	<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="fn_egov_link_page"  /></li>
					       	<form:hidden path="pageIndex" />		        		
			            </ul>
		        	</div>
		          </div>
          <!-- /.card -->
        	</div>
		    </section>
	</form:form>
</body>
</html>
