<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.insertIp{
	margin : 10px 10px 10px 10px;
	padding : 10px 10px 10px 10px;
}
.point{
	font-size : 1.0em;
	
}
</style>
<script>
$(function(){
	$('.ip').keyup(function(e){
		$('.errorMsg').empty();
		if (e.keyCode > 57 
				|| e.keyCode < 48
				&& e.keyCode != 8	// Backspace
				&& e.keyCode != 9	// Tab
				&& e.keyCode != 13	// Enter
				&& e.keyCode != 16	// shift
				&& e.keyCode != 17	// Ctrl
				&& e.keyCode != 27	// ESC
				&& e.keyCode != 37	// 왼쪽 방향키	
				&& e.keyCode != 38	// 윗 방향키
				&& e.keyCode != 39	// 오른쪽 방향키
				&& e.keyCode != 40	// 아래 방향키
				){
			$('.errorMsg').append("숫자만 입력할 수 있습니다.");
			$(this).val('');
		} 
	})
	
	$(".ipRegBtn").click(function(){
		errorCnt = 0;
		if ( $('#ip1').val() == ''  ){
			$('.errorMsg').empty();
			$('.errorMsg').append("입력하지 않은 부분이 존재합니다.");
			errorCnt++;
		}
		if ( $('#ip2').val() == ''  ){
			$('.errorMsg').empty();
			$('.errorMsg').append("입력하지 않은 부분이 존재합니다.");
			errorCnt++;
		}
		if ( $('#ip3').val() == ''  ){
			$('.errorMsg').empty();
			$('.errorMsg').append("입력하지 않은 부분이 존재합니다.");
			errorCnt++;
		}
		if ( $('#ip4').val() == ''  ){
			$('.errorMsg').empty();
			$('.errorMsg').append("입력하지 않은 부분이 존재합니다.");
			errorCnt++;
		}
		
		if ( errorCnt == 0){
			alert("등록되었습니다.");
			$("#ipForm").submit();
		}  
		
	})
})
</script>

<div class="card insertIp" style="margin-top : 50px;">
	<%@ include file="/WEB-INF/views/admin/ipContentMenu.jsp" %>
	<!-- /contentMenuBar -->
	<h5 class="jg">신규 IP 등록하기</h5>
	<div class="inputIpArea" style="float : left; width : 100%;">
		<form id="ipForm" action="/admin/insertIp" style="float : left;">
			<span class="jg">허용할 IP를 입력해 주세요.</span>
			<input class="ip" name="ip1" id="ip1" type="text" maxlength="3">
			.&nbsp;<input class="ip" name="ip2" id="ip2" type="text" maxlength="3">
			.&nbsp;<input class="ip" name="ip3" id="ip3" type="text" maxlength="2">
			.&nbsp;<input class="ip" name="ip4" id="ip4" type="text" maxlength="2">
		</form>
		<button class="ipRegBtn" style="margin-left : 10px;">등록</button>
		<div>
			<span class="errorMsg jg" style="color : red; float : left;"></span>
		</div>		
	</div>
</div>