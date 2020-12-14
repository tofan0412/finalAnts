<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>

<style type="text/css">


	#pagenum a{
		 display: inline-block;
		 text-align: center;
		 width : auto;	 
		 border: none; 
		background: transparent;
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
/* 		 text-align: center; */
		 width:auto; float:left; margin:0 auto; text-align:center;"
		 
	}
	#searchBtn {
	    color: #fff;
	    background-color: #007bffab;
	    border-color: #007bff;
	    box-shadow: none;
	}	
	
	.badge{
		height: 20px;
	}
	
	
</style>

<script type="text/javascript">
$(function(){

	$("#pagenum a").addClass("page-link");  
	
	
	$('#insertvote').on('click', function(){
		
		// 모달창 초기화
		$('#voteTitle').val('');
		$('#voteDeadline').val('');
		$('input[name=voteItemName]').next().remove();
		$('input[name=voteItemName]').remove();
		$('input[name=ItemName]').val('');
		$('#nextSeq').val('');
		
// 		$('#voteInsert').modal();
		nextSeq();
	})
	
	
	
	
	
	itemSlotCnt =2;
	maxItemSlot = 5;
	// 투표항목 빼기 버튼
	$('#itemdiv').on('click', '#btnMinus', function(){
   	   if(itemSlotCnt > 1){
   			itemSlotCnt--;
   		   console.log(itemSlotCnt);
   	   }
   	   console.log("minus clicked!!");
//    	   $(this).prev().prev().remove();
   	   $(this).prev().remove();
   	   $(this).remove();
   	   $('#itemaddbtn').show();
   	   
    })
	
     
	// 투표항목 추가 버튼
	$('#itemaddbtn').on('click', function(){
	   itemSlotCnt++;
 	   console.log("click!!");
 	   var html = '<input type="search" class="form-control voteItemName" id="voteItemName" name="voteItemName"  style="display: inline-block; width: 90%;">'
			     +'<button type="button" id="btnMinus" class="btn btn-light" style=" display: inline-block; float :right; outline: 0; border: 0;">'
		         + '<i class="fas fa-fw fa-minus" style=" font-size:10px;"></i>'
				 + '</button>'	
 	   $(this).next().next().append(html);  
 	   
 	   if(itemSlotCnt >= maxItemSlot){
 		   $(this).hide();
  		   alert("투표항목은 총 "+maxItemSlot+"개 까지만 가능합니다.");
 	   }
	})
	
	
	// 투표 등록 버튼 클릭
	$('#regBtn').click(function(){
		voteitems = []
		const date = new Date()
		
		console.log(date)
		votetitle = date;
		votedeadline = $('#voteDeadline').val();
		

		for(i=0; i<$('.voteItemName').length;i++){	
			console.log($('.voteItemName').eq(i).val()) 
			if($('.voteItemName').eq(i).val() != '' ){			
				voteitems.push( $('.voteItemName').eq(i).val());
			}
		}

		cnt = 0;
		
		// 각 칸이 빈칸인지 아닌지를 확인해야 한다.
		if ($('#voteTitle').val().length == 0){
			$('.warningTitle').text("제목을 작성해 주세요.");
			cnt++;
		}
		if ($('#voteItemName').val().length == 0){
			$('.warningItem').text("투표항목을 작성해 주세요.");
			cnt++;
		}
		if ($('#voteDeadline').val().length == 0){
			$('.warningDate').text("마감일을 작성해 주세요.");
			cnt++;
		}
		if (cnt == 0){				
			insertvote(voteitems);			
		}
	})
	
	
	
})


// 날짜 형식 변환
function changedateType(){
	a = $('#voteDeadline').val()
	Y = a.substring(0,4) // 년
	M = a.substring(5,7) //월
	D = a.substring(8,10) //일
	H = a.substring(11,13) //시
	m = a.substring(14) //분

	votedeadline = Y+M+D+H+m
	console.log(votedeadline)
}

const date = new Date()
console.log(date)

// 다음 투표 id
function nextSeq(){	
	
	$.ajax({url :"${pageContext.request.contextPath}/vote/voteinsertView",
		 method : "get",
		 success :function(data){	
			 console.log(data)
			 $('#nextSeq').val(data.nextSeq);
			 $('#voteInsert').modal();
			 
			
			 // 현재 날짜로 날짜 설정
// 			 document.getElementById('voteDeadline').value= date.toISOString().slice(0, -1);
			 $('#voteDeadline').attr('min', date.toISOString().slice(0, 16));
		 }
	})
}


// 투표테이블 작성
function insertvote(voteitems){
	votetitle = $('#voteTitle').val();

	a = $('#voteDeadline').val()
	Y = a.substring(0,4) // 년
	M = a.substring(5,7) //월
	D = a.substring(8,10) //일
	H = a.substring(11,13) //시
	m = a.substring(14) //분

	votedeadline = Y+M+D+H+m
	
	$.ajax({url :"${pageContext.request.contextPath}/vote/voteinsert",
		 method : "post",
		 data : {voteTitle : votetitle,
			  	 voteDeadline : votedeadline ,
			  	 voteId :  $('#nextSeq').val() },
		 success :function(data){	
			 
			 for(i=0; i<voteitems.length;i++){
					insertvoteItem(voteitems[i])
			} 
		    alert('투표테이블 등록');
		
		 }
	})
}

// 투표 아이템(투표항목) 작성
function insertvoteItem(voteitems){
	console.log(voteitems)
	$.ajax({url :"${pageContext.request.contextPath}/vote/voteiteminsert",
		 method : "post",
		 data : {voteitemName : voteitems,
			 	 voteId :  $('#nextSeq').val()},
		 success :function(data){	
			 
// 		    alert('투표아이템 테이블 등록');
		   
			$(location).attr('href', '${pageCContext.request.contextPath}/voCte/votelist');
		 }
	})
}


// 투표 상세보기 
function itemdetail(voteid){
	$.ajax({url :"${pageContext.request.contextPath}/vote/voteDetail",
		 method : "get",
		 data : {voteId :  voteid},
		 success :function(data){				 
			 res ='';
// 			 console.log(data)
			 for(i=0;i<data.itemlist.length;i++){
				 res += '<input type="radio" name="voteitem" value='+data.itemlist[i].voteitemName+'>';
				 console.log(data.itemlist[i])
			 }
			
// 			 $('#itemdiv').html(res);
			 
			 
// 			 $('#voteDetail').modal();
			 
		 }
	})
}





/* pagination 페이지 링크 function */
 function fn_egov_link_page(pageNo){
 	document.listForm.pageIndex.value = pageNo;
 	document.listForm.action = "<c:url value='/vote/votelist'/>";
    document.listForm.submit();
 }
 
 function search(){
	 	document.listForm.action = "<c:url value='/vote/votelist'/>";
	    document.listForm.submit();
}
 
 
 
	 
</script>

<%@include file="../layout/contentmenu.jsp"%>

<!-- 	<div class="tab-pane fade" id="custom-tabs-three-issue" role="tabpanel" aria-labelledby="custom-tabs-three-issue-tab"> -->
<form:form commandName="voteVo" id="listForm" name="listForm" method="post">
	
			<section class="content" >
		      <div class="col-12 col-sm-12">
			      <div class="card" style="border-radius: inherit; padding : 2px;">
			      
			    <div class="container-fluid">
		        <div class="row mb-2">
		         <br>
		          <div class="col-sm-6">
		          <br>
		            <h1 class="jg" style=" padding-left : 10px;">투표</h1>
		          </div>
		          <div class="col-sm-6">
		            <ol class="breadcrumb float-sm-right"  style="background : white">
		              <li class="breadcrumb-item san jg"><a href="#">Home</a></li>
		              <li class="breadcrumb-item active jg">투표</li>
		            </ol>
		          </div>
		        </div>
		        </div>
		        
		        <div class="card-header  ">
				<div id="keyword" class="card-tools float-right" style="width: 450px;">
					<div class="input-group row">
						<label for="searchCondition" style="visibility:hidden;"></label>
																
						
        				<form:select path="searchCondition" class="form-control col-md-3 jg" style="width: 100px;">
							<form:option value="1" label="제목"/>
							<form:option value="2" label="작성자"/>
						</form:select> 
						
						
						<label for="searchKeyword" style="visibility:hidden; display:none;"></label>
	                    <form:input style="width: 300px;" path="searchKeyword" placeholder="검색어를 입력하세요." class="form-control jg"/>
<!--  						    <input id="content" class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="">  -->
						<span class="input-group-append">							
							<button class="btn btn-primary" type="button" id="searchBtn" onclick="search()" >
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
	                        <th class="jg" style="width: 150px; padding-left: 50px; text-align: center;">No.</th>
	                     	<th class="jg" style="padding-left: 30px; text-align: center;"> 투표제목</th> 
							<th class="jg" style="text-align: center;"> 마감일  </th>
							<th class="jg" style="text-align: center;"> 투표율  </th>
							<th class="jg" style="text-align: center;">  상태   </th>
							<th class="jg" style="text-align: center;"> 작성자 </th>
<!-- 	                      <th style="text-align: center;">응답 상태</th> -->
<!-- 	                      <th></th> -->
	                    </tr>
	                  </thead>
	                  <tbody>
	                      
                       <c:forEach items = "${votelist }" var ="vote" varStatus="status">
                      	   <tr>
			                    <td class="jg" style="width: 150px; padding-left: 50px; text-align: center;"><c:out value="${  ((voteVo.pageIndex-1) * voteVo.pageUnit + (status.index+1))}"/>.</td>
							
								<td class="jg" style="padding-left: 30px; text-align: center;"><a href="${pageContext.request.contextPath}/vote/voteDetail?voteId=${vote.voteId }">${vote.voteTitle}</a></td>
								<td class="jg" style="text-align: center;"> ${vote.voteDeadline }</td>
								<td class="jg" style="text-align: center;"> <fmt:formatNumber value="${vote.votedNo/vote.voteTotalno }" type="percent"></fmt:formatNumber></td>
							
								<c:if test="${vote.remain > 1000 and vote.voteStatus=='ing'}">
									<td style="text-align: center;"> 
									 	<span class="badge badge-success ">진행중</span>
									</td>
								</c:if>
								<c:if test="${(vote.remain <= 1000 and vote.remain > 0) and vote.voteStatus == 'ing'}">
									<td style="text-align: center;"> 
									 	<span class="badge badge-warning ">임박</span>
									</td>
								</c:if>
								<c:if test="${vote.remain <= 0 or vote.voteStatus== 'finish'}">
									<td style="text-align: center;" >
										<span class="badge badge-danger "> 완료 </span>
									</td>
								</c:if>
<%-- 								<td style="text-align: center;"><button class="votebtn">투표하기</button><input type="hidden" value="${vote.voteId }"></td> --%>
								<td class="jg" style="text-align: center;"> ${vote.memName }</td>
<!-- 		                     	<td style="text-align: center;"> -->
								 
							</tr>
						 </c:forEach> 
						 <c:if test="${votelist.size() == 0}">
							<td colspan="7" style="text-align: center;" class="jg"><br>[ 결과가 없습니다. ]</td>
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
        		  <div class="card-footer clearfix">
	                <button id="insertvote" type="button" class="btn btn-default float-right jg"><i class="fas fa-plus"></i>등 록</button>
	              </div>
        		 
        		  
        		  
	              <!-- /.card-body -->
	            </div>
             </div>
		    </section>
			<br>
		

</form:form>	
<!-- </div> -->



<!-- 투표 등록 모달 -->
<!-- Modal to invite new Members . . . -->
<div class="modal fade" id="voteInsert" tabindex="-1" role="dialog"
	aria-labelledby="inviteMemberModal" style=" padding-top: 100px;">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content" style="height: 600px auto; width : 400px;">
			
			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable" style="text-align : center;">투표 작성</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body" style="width: 100%; height: 100%;">
									
					<input type="hidden" id="nextSeq">
					<label class="jg" style="float : left;">투표 제목</label>
					<input type="text" class="form-control" id="voteTitle" name="voteTitle" style="width : 90%;"/>
					<div class="jg"><span class="jg warningTitle" style="color : red;"></span></div>
					<!-- 사용자가 제목을 입력하지 않은 경우 .. -->
					
					<br>
					
					<label class="jg col-sm-3 control-label" style="float : left; display: inline-block;" >투표 항목</label>
					<button type="button" id="itemaddbtn" class="btn btn-light filebtn" style="outline: 0; border: 0;">
						<i class="fas fa-fw fa-plus" style=" font-size:15px; width : 100px;">&nbsp;항목 추가</i>
					</button> <br>
					
					<div class="form-group" id="itemdiv">
						<input type="search" class="form-control voteItemName" id="voteItemName" name="ItemName"  style="display: inline-block; width: 90%;"> 			
						<input type="search" class="form-control voteItemName" id="voteItemName" name="ItemName"  style="display: inline-block; width: 90%;"> 
										
					</div>
					<div class="jg"><span class="jg warningItem" style="color : red;"></span></div>
					
					<label class="jg">마감일</label><br>
					<input type="datetime-local" class="form-control" id="voteDeadline" name="voteDeadline" style="width : 70%;" >
					<div class="jg"><span class="jg warningDate" style="color : red;"></span></div>				
			</div>
			
			<div class="modal-footer">
				<button class="btn btn-success" id="regBtn">등록</button>
			</div>
		</div>
	</div>
</div>

