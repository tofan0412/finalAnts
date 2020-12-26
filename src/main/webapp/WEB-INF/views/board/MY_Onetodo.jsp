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
		$(document).on('click','#back', function(){
			window.history.back();
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
			$('#SearchTodoIdBar').val(todoId+":현재 선택된 일감 번호");
			
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
				$('.warningTitle').text("건의사항 제목을 지정해 주세요.");
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
		
		
	})
	
	function checkInputNum(){
		if ((event.keyCode < 48) || (event.keyCode > 57)){
	          event.returnValue = false;
	      }
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
				$("#todoCont").html(data.todoVo.todoCont);
				$("#memId").html(data.todoVo.memId);
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
 						res += '<a href="${pageContext.request.contextPath}/file/publicfileDown?pubId='+data.filelist[i].pubId+'"><input id ="files"  type="button" class="btn btn-default jg" name="'+ data.filelist[i].pubId+'" value="'+data.filelist[i].pubFilename+'" ></a>  ';
						
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
            <td style="padding-left: 20px; width: 700px; "><div class="jg" id="memId"></div></td>
            <th class="success ">진행도</th>
            <td style="padding-left: 20px; width: 700px; "><div class="jg" id="todoPercent"></div></td>
        </tr>
         
       <tr class="stylediff">
            <th class="success">기간</th>
            <td style="padding-left: 20px; width: 700px;"><div class="jg" id="todoStart"></div>~<div class="jg" id="todoEnd"></div></td>
            <th class="success">우선순위</th>
            <td style="padding-left: 20px;"><div class="jg" id="todoImportance"></div></td>
        </tr>
         
       <tr>
            <th class="success">내용</th>
            <td colspan="3" style="padding-left: 20px;"><div class="jg" id="todoCont"></div></td>
        </tr>
        <tr>
            <th class="success">첨부파일</th>
            <td colspan="3" style="padding-left: 20px;"><div id = "filediv"></div>
			</td>
        </tr>
        </table>
        <br>
	            <div id="btnMenu">
					 <button type="button" class="btn btn-default jg" id="issuebtn">이슈 작성</button>
					 <button type="button" class="btn btn-default jg" id="suggestBtn">건의 작성</button>
					 <div class="float-right">
					 <button type="button" class="btn btn-default jg" data-toggle="modal" data-target="#myModal">진행도 수정</button>	
						<button type="button" class="btn btn-default jg" id="back">뒤로가기</button>   
				 	 </div>
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
       	<input type="text" id="inpercent" name="todoPercent" maxlength="3" onkeyPress="javascript:checkInputNum();" onchange="javascript:handleChange(this);">
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

<div class="modal fade suggestInsertModal" id="suggestInsert"
	tabindex="-1" role="dialog" aria-labelledby="suggestInsertModal">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content" style="height: 600px; width: 800px;">

			<div class="modal-header">
				<h3 class="modal-title jg" id="addplLable"
					style="text-align: center;">건의사항 작성</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body" style="width: 100%; height: 100%;">
				<form id="sgtForm" name="sgtForm" action="/suggest/suggestInsert">
					<input type="text" name="sgtId" id="sgtId" hidden="hidden" />

					<div class="searchTodoArea"
						style="float: left; width: 45%; height: 400px;">
						<label class="jg" style="float: left;">선택한 일감</label>
						<!-- 사용자가 일감을 선택하지 않은 경우 .. -->
						<div class="jg">
							<span class="jg warningTodo" style="color: red;"></span>
						</div>
						<br>

						<input type="text" id="SearchTodoIdBar" name="todoId" class="jg" 
							style="width : 90%; 
								   border : 2px solid lightgrey; 
								   border-radius : 0.7rem;"
							readonly="true" placeholder="일감을 선택해 주세요.." autocomplete="off"/>
						<br><br>
					</div>

					<div class="suggestInsertArea" style="float: right; width: 50%;">
						<label class="jg" style="float: left;">건의 사항 제목</label>
						<!-- 사용자가 제목을 입력하지 않은 경우 .. -->
						<div class="jg">
							<span class="jg warningTitle" style="color: red;"></span>
						</div>
						<input id="sgtTitle" name="sgtTitle" type="text"
							style="width : 90%;
								   border : 2px solid lightgrey; 
								   border-radius : 0.7rem;"
							autocomplete="off" />
						<br>
						<br> <label class="jg">건의 사항 내용</label><br>
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
					<label class="jg">파일 첨부</label>&nbsp;&nbsp; <span class="jg">파일은 최대
						5개까지 첨부 가능합니다.</span> 
						<input name="file" type="file" class="file"
						onchange="fileRestrict($('.file')[0].files.length)"
						multiple="multiple" />
					<div class="sgtFileList"></div>
				</form>
			</div>
		</div>

		<div class="modal-footer">
			<button type="button" class="btn btn-primary jg suggestResetBtn">초기화</button>
			<button class="jg btn btn-success" id="regBtn">등록</button>
		</div>
	</div>
</div>
</div>
<!-- /Suggest Modal -->