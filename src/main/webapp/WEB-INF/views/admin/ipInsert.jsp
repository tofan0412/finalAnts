<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.insertIp{
	margin : 10px 10px 10px 10px;
	padding : 10px 10px 10px 10px;
}

</style>
<script>
$(function(){
	$('.ip').keyup(function(e){
		$('.errorMsg').empty();
		if (e.keyCode > 57 || e.keyCode < 48){
			$('.errorMsg').append("숫자만 입력할 수 있습니다.");
			$('.ip').val('');
		} 
	})
})
</script>

<div class="card insertIp" style="margin-top : 50px;">
	<%@ include file="/WEB-INF/views/admin/ipContentMenu.jsp" %>
	<!-- /contentMenuBar -->
	
	<div class="inputIpArea" style="float : left; width : 100%;">
		<input class="ip" type="text" maxlength="3">
		.<input class="ip" type="text" maxlength="3">
		.<input class="ip" type="text" maxlength="2">
		.<input class="ip" type="text" maxlength="2">
		<div>
			<span class="errorMsg" style="color : red;"></span>
		</div>		
	</div>
</div>