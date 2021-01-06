<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript">
	$(document).ready(function() {
		todoDetail("${param.todoId}");
		
		//진행도 수정
		$(document).on('click','#modalBtn', function(){
			if($('#inpercent').val()==''){
				
				alert("진행도를 입력해주세요!");
			}
			else{
			document.proForm.action = "<c:url value='/todo/progressChange'/>";
			document.proForm.submit();
			}
		})
		
		// 뒤로가기
		$(document).on('click','#backtolist', function(){
			location.href ="${pageContext.request.contextPath}/todo/MytodoList";
		})
		
		// 이슈작성 버튼
		$('#issuebtn').on('click', function(){
			title = $('#todoTitle').html();
			id = $('#todoId').val();
			
			$('#todoid').val(id)
			$('#todotitle').val(title)		
			
			$('#issuefrm').submit();	
			
		})
		
		// 건의사항 작성 버튼
		$('#suggestBtn').click(function(){
			todoId = $('#todoId').val();
			title = $('#todoTitle').html();
			
			$('#SearchTodoIdBar').val(todoId+":"+title);
			
			$('.warningTodo').empty();
			$('.warningTitle').empty();
			$('.sgtFileList').empty();
			$('.file').val('');
			$('#sgtTitle').val('');
			$('#sgtCont').val('');
			
			$('#suggestInsert').modal();
		})
		
		// 건의 사항 작성 중 초기화 하고 싶을 때
		// 초기화 버튼 클릭시 내용 초기화 -> 모달창 열고 닫을 때도 적용된다.
		$('.suggestResetBtn').click(function(){
			$('.warningTodo').empty();
			$('.warningTitle').empty();
			$('.sgtFileList').empty();
			$('.file').val('');
			$('#sgtTitle').val('');
			$('#sgtCont').val('');
		})
		
		
		// 건의 사항 등록 버튼 눌렀을 때
		$('#regBtn').click(function(){
			cnt = 0;
			// 각 칸이 빈칸인지 아닌지를 확인해야 한다.
			if ($('#SearchTodoIdBar').val().length == 0){
				$('.warningTodo').text("일감을 지정해 주세요.");
				cnt++;
			}
			if ($('#sgtTitle').val().length == 0){
				$('.warningTitle').text("건의사항 제목을 입력해 주세요.");
				cnt++;
			}
			
			if ($('#sgtCont').val().length == 0){
				$('.warningCont').text("건의사항 내용을 입력해 주세요.");
				cnt++;
			}
			
			if (cnt == 0){
				// Insert 하면 된다.
				// 파일부터 먼저 넣자.
				// formData는 전역변수로 선언하였다..
				formData = new FormData($('#suggestFileForm')[0]);
				//지정해주는 경우, 자동으로 데이터가 저장된다.
				
	// 			for(var i = 0 ; i < fileCnt ; i++){
	// 				formData.append("files", $('.file')[0].files[i]);	
	// 			}
				$.ajax({
					url : "/suggest/suggestFileInsert",
					type : "POST",
					data : formData,
					contentType : false,
					processData : false,
					success : function(res){
						alert("작성하였습니다.");
						var sgtSeq = res.sgtSeq;
						$('#sgtId').val(sgtSeq);
						$('#sgtForm').submit();
					}
				})
			}
		})
		
		$('#sgtTitle').keyup(function(){
			$('.warningTitle').empty();
		})
	
		$('#sgtCont').keyup(function(){
			$('.warningCont').empty();
		})
	})
	
	//진행도 수정시 소수점 첫째자리까지 입력가능하고 0~100까지 입력가능하게
	function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode;
        if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        // Textbox value    
        var _value = event.srcElement.value;    
        // 소수점(.)이 두번 이상 나오지 못하게
        var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
        if (_pattern0.test(_value)) {
            if (charCode == 46) {
                return false;
            }
        }

        // 소수점 첫째자리까지만 입력가능
        var _pattern2 = /^\d*[.]\d{1}$/; // 현재 value값이 소수점 첫째짜리 숫자이면 더이상 입력 불가
        if (_pattern2.test(_value)) {
            alert("소수점 첫째자리까지만 입력가능합니다.");
            return false;
        }  
        return true;
    }

	 function handleChange(input) {
	       if (input.value < 0){
	    	   alert("진행도는 0 ~ 100까지 입력가능합니다.");
	       	return false;
	       }
	       if (input.value > 100) {
	    	   alert("진행도는 0 ~ 100까지 입력가능합니다.");
	       	return false;
	       }
	     }
	 
	 
	function todoDetail(todoId) {
		$.ajax({
			url : "/todo/myonetodo",
			method : "get",
			data : {
				todoId : todoId
			},
			success : function(data) {
				var res ="";
				$("#todoTitle").html(data.todoVo.todoTitle);
				
				if(data.todoVo.todoCont =='<p><br></p>' || data.todoVo.todoCont == null){
					cont = '<div class="jg" >[ 내용이 없습니다. ] </div>' 
					$("#todoCont").html(cont);
				}else{
					$("#todoCont").html(data.todoVo.todoCont);
				}
				$("#memId").html(data.todoVo.memName);
				if(data.todoVo.todoImportance =='emg'){
					$("#todoImportance").html('긴급');
				}
				if(data.todoVo.todoImportance =='gen'){
					$("#todoImportance").html('일반');
				}
				$("#todoStart").html(data.todoVo.todoStart);
				$("#todoEnd").html(data.todoVo.todoEnd);
				$("#todoPercent").html(data.todoVo.todoPercent+"%");
				$("#todoId").val(data.todoVo.todoId);
				$("#todoId_in").val(data.todoVo.todoId);
				$("#reqId").val(data.todoVo.reqId);
				
				
				if(data.filelist.length == 0){
					res += '<div class="jg" >[ 첨부파일이 없습니다. ]</div>';
					$("#filediv").html(res);
				}
				if(data.filelist.length != 0) {
					for( i = 0 ; i< data.filelist.length; i++){	
						
 						res += '<a href="${pageContext.request.contextPath}/file/publicfileDown?pubId='+data.filelist[i].pubId+'">';
 						res += '<button id ="files" class="btn btn-default jg" name="'+ data.filelist[i].pubId+'">'
 						res += '<img name="link" src="/fileFormat/'+data.filelist[i].pubExtension.toLowerCase()+'.png" onerror="this.src="/fileFormat/not.png;" style="width:30px; height:30px;">'
 						res += ''+data.filelist[i].pubFilename+'.'+data.filelist[i].pubExtension+' 다운로드'
 						res += '</button><br>'
						 
//  						<input id ="files"  type="button" class="btn btn-default jg" name="'+ data.filelist[i].pubId+'" value="'+data.filelist[i].pubFilename+'" ></a>  ';
						
 						$("#filediv").html(res);
					}	
				}
			}
		});
	}
	
	// 파일 갯수 제한, 파일 용량 제한..
	function fileRestrict(fileNum){
		$('.sgtFileList').empty();
		if (fileNum > 5){
			alert("파일은 최대 5개까지 첨부할 수 있습니다.");
			$('.file').val('');
			fileCnt = 0;
		}
		else{
			fileCnt = fileNum;
			for(var i = 0 ; i < fileNum ; i++){
				if ( $('.file')[0].files[i].size/1024/1024 >= 20 ){
					alert("20MB 이상의 파일은 업로드할 수 없습니다.("+$('.file')[0].files[i].name+")");
					$('.sgtFileList').empty();
					$('.file').val('');
					fileCnt = 0;
					return;
				}else{
					$('.sgtFileList').append($('.file')[0].files[i].name+"<br>");
				}
			}
		}
	}
	
</script>

<style type="text/css">
.form-control:disabled, .form-control[readonly] {
   background-color: white;
   }
  .success{
  background-color: #f6f6f6;
  width: 10%;
  text-align: center;
  }
#todoStart{
	display: inline-block;
	margin-right: 10px;
	}
#todoEnd{
	display: inline-block;
	margin-left: 10px;
	}
</style>

<%@include file="../layout/contentmenu.jsp"%>

<form id="issuefrm" method="post" action="${pageContext.request.contextPath}/projectMember/insertmytodoissueView">
	 <input type="hidden" id="todoid" name="todoId" value="">
	 <input type="hidden" id="todotitle"name=todoTitle value="">
</form>	

<br>
	<div class="col-md-12 ns">
		<div class="card card-primary card-outline" id="cardTodo">
            <div class="card-header">
              <h3 class="card-title jg">일감 상세보기</h3>
            </div>
            <div class="card-body">
                   	<input type="hidden" id="todoId">
	    <table class="table" >
        <tr class="stylediff">
            <th class="success ">제목</th>
         	<td colspan="3" style="padding-left: 20px;"><div class="jg" id="todoTitle"></div></td>
        </tr>
           
         
        <tr class="stylediff">
            <th class="success ">담당자</th>
            <td style="padding-left: 20px; width: 45%; "><div class="jg" id="memId"></div></td>
            <th class="success ">진행도</th>
            <td style="padding-left: 20px; width: 45%; "><div class="jg" id="todoPercent"></div></td>
        </tr>
         
       <tr class="stylediff">
            <th class="success">기간</th>
            <td style="padding-left: 20px; width: 45%;"><div class="jg" id="todoStart"></div>~<div class="jg" id="todoEnd"></div></td>
            <th class="success">우선순위</th>
            <td style="padding-left: 20px;  width: 45%;"><div class="jg" id="todoImportance"></div></td>
        </tr>
         
       <tr>
            <th class="success" style="height: 300px;">일감 내용</th>
            <td colspan="3" style="padding-left: 20px;">
            	<div class="jg" id="todoCont"></div>
            </td>
        </tr>
        <tr>
            <th class="success" style="height: 150px;">첨부파일</th>
            <td colspan="3" style="padding-left: 20px;"><div id = "filediv"></div>
			</td>
        </tr>
        </table>
	    	<div id="btnMenu" class="card-footer">
	            <c:if test="${SMEMBER.memId eq projectVo.memId && projectVo.proStatus == 'ACTIVE' }">
					<button type="button" class="btn btn-default jg float-left" id="backtolist">목록으로</button>   
	            	<button type="button" class="btn btn-default jg float-right" style="margin-left: 5px;"id="issuebtn">이슈 작성</button>
					<button type="button" class="btn btn-default jg float-right" data-toggle="modal" data-target="#myModal">진행도 수정</button>	
			    </c:if>
	            <c:if test="${SMEMBER.memId ne projectVo.memId && projectVo.proStatus == 'ACTIVE'}"> <!-- PL이 아닌 경우에만 건의 사항을 작성할 수 있다. -->
	           	 	<button type="button" class="btn btn-default jg float-left" id="back">목록으로</button>   
	            	<button type="button" class="btn btn-default jg float-right" style="margin-left: 5px;"id="issuebtn">이슈 작성</button>
					<button type="button" class="btn btn-default jg float-right" style="margin-left: 5px;" id="suggestBtn">건의 작성</button>
					<button type="button" class="btn btn-default jg float-right" data-toggle="modal" data-target="#myModal">진행도 수정</button>	
			    </c:if>
			</div>
              
            </div>
          </div>
		
	
</div>

 
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header jg">
        <h4 class="modal-title" id="myModalLabel">진행도 수정</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-body">
       	<p class="jg">진행도를 입력해주세요!(숫자만 입력가능)</p>
       	<form id="proForm" name="proForm" method="post">
       	<input type="hidden" name="todoId" id="todoId_in">
       	<input type="hidden" name="reqId" id="reqId">
       	<input type="text" name="todoPercent" onkeypress="return isNumberKey(event)" onkeyup="this.value=this.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');" onchange="javascript:handleChange(this);"/>
       	</form>
      </div>           
      <div class="modal-footer">
        <button type="button" class="btn btn-default jg" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-default jg" id="modalBtn">등록</button>
    		
      </div>
    </div>
  </div>
</div>


<!-- Suggest Modal -->

<div class="modal fade suggestInsertModal jg" id="suggestInsert"
	tabindex="-1" role="dialog" aria-labelledby="suggestInsertModal">
	<div class="modal-dialog modal-lg-center" role="document">
		<div class="modal-content" style="height: 700px; width: 500px;">

			<div class="modal-header">
				<h3 class="modal-title" id="addplLable"
					style="text-align: center;">건의사항 작성</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body" style="width: 100%; margin : 0 auto;">
				<form id="sgtForm" name="sgtForm" action="/suggest/suggestInsert">
					<input type="text" name="sgtId" id="sgtId" hidden="hidden" />
						<label style="float: left;">선택한 일감</label>
						<!-- 사용자가 일감을 선택하지 않은 경우 .. -->
						<div>
							<span class="warningTodo" style="color: red; margin-left : 5px;"></span>
						</div>
						<input type="text" id="SearchTodoIdBar" name="todoId"  
							style="width : 90%; 
								   border : 2px solid lightgrey; 
								   border-radius : 0.7rem;"
							readonly="true" placeholder="일감을 선택해 주세요.." autocomplete="off"/>
						<br><br>
						
						<label style="float: left;">건의 사항 제목</label>
						<!-- 사용자가 제목을 입력하지 않은 경우 .. -->
						<div>
							<span class="warningTitle" style="color: red; margin-left : 5px;"></span>
						</div>
						<input id="sgtTitle" name="sgtTitle" type="text"
							style="width : 90%;
								   border : 2px solid lightgrey; 
								   border-radius : 0.7rem;"
							autocomplete="off" />
						<br>
						<br> <label>건의 사항 내용</label>
						<span class="warningCont" style="color: red; margin-left : 5px;"></span>
						<br>
						<textarea id="sgtCont" name="sgtCont" rows="3" cols="30"
							style="resize: none; 
											   width : 90%;
											   border : 2px solid lightgrey; 
								   			   border-radius : 0.7rem;"
							autocomplete="off"></textarea>
				</form>
				<br>
				<form id="suggestFileForm">
					<!-- 파일 첨부하기.. -->
					<label>파일 첨부</label>&nbsp;&nbsp; <span class="jg">파일은 최대
						5개까지 첨부 가능합니다.</span><br>
						<input name="file" type="file" class="file"
						onchange="fileRestrict($('.file')[0].files.length)"
						multiple="multiple" />
					<div class="sgtFileList"></div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary suggestResetBtn">초기화</button>
				<button class="btn btn-success" id="regBtn">등록</button>
			</div>
		</div>

		
	</div>
</div>
</div>
<!-- /Suggest Modal -->