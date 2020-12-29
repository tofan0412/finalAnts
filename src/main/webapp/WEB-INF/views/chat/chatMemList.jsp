<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  

<style>
.warning{
	color : red; 
	font-size : 0.9em;
}
.singleMem{
	color : lightblack;
	cursor : pointer;
}
.listHeader{
	text-align : center;
	color : black;
	padding-top : 5px;
	border-bottom : 2px solid #d2d6de; 
	height : 30px;
}
.selectedMem{
	border-radius : 0.4rem;
	font-size : 1.3em;
	background-color : #0080FF;
	float : left;
	height : 30px;
	margin : 5px 5px 5px 5px;
	color : white;
}
</style>
<script>
$(function(){
	MemListArr = [];
	
	var cgroupId = 0;	// 채팅방을 개설한 후, 해당 채팅방 번호를 갖는 회원 목록을 DB에 저장하기 위해 !
	
	// singleMem에 마우스가 올라왔을 때 : 살짝 진하게 배경색을 변경한다.
	$('.singleMem').on('mouseenter',function(){
		$(this).css("background-color", 'lightgrey');
	})
	
	$('.singleMem').on('mouseleave',function(){
		$(this).css("background-color", 'white');
	})
	
	// 사용자 아이디를 누르면, 초대 리스트에 추가된다.
	$('.singleMem').on("click", function(){
		var memId = $(this).attr('memId');
		
		addMember(memId);
		listMember(MemListArr);
	})
	
	// 초대리스트에 추가된 회원 아이디를 누르면, 초대 리스트에서 제거된다.
	$('.selectedMemList').on("click",".selectedMem", function(){
		var memId = $(this).attr('memId');
		delMember(memId);
		listMember(MemListArr);
	})
	
	// 사용자가 검색을 시작하면, 해당하는 프로젝트 멤버를 chatMemList에 출력한다.
	$('#keyword').keyup(function(){
		var keyword = $(this).val();
		
		// 1. 검색 조건이 아이디인 경우
		if ( $('#MemSearchOption').val() == "아이디"){
			for (var i = 0 ; i < $('.singleMem').length ; i++){
				if ($('.singleMem')[i].attributes[1].value.includes(keyword)){
					$('.singleMem')[i].style.display = 'block';
				}else{
					$('.singleMem')[i].style.display = 'none';
				}	
			}
		}
		
		// 2. 검색 조건이 별명인 경우
		if ( $('#MemSearchOption').val() == "이름"){
			for (var i = 0 ; i < $('.singleMem').length ; i++){
				if ($('.singleMem')[i].attributes[2].value.includes(keyword)){
					$('.singleMem')[i].style.display = 'block';
				}else{
					$('.singleMem')[i].style.display = 'none';
				}	
			}
		}
	})
	
})	// End of $(function(){})

function addMember(memId){
	// 기존에 추가한 회원과 겹치는지 먼저 확인 ...
	var check = 0;
	for(i = 0 ; i < MemListArr.length ; i++){
		if ( MemListArr[i] == memId ){
			$('.warning').text("이미 추가한 회원입니다.");
			check = 1;
		}
	}
	// 검사 결과 이미 추가한 회원이 아닌경우 추가할 수 있다.
	if (check != 1){
		$('.warning').text('');
		MemListArr.push(memId);		
	}
	listMember(MemListArr);
}

function delMember(memId){
	$('.warning').text('');
	MemListArr.splice(MemListArr.indexOf(memId),1); // 뒤의 개수는 몇개를 제거할 지 이다..
	listMember(MemListArr);
}

function listMember(MemListArr){
	$('.selectedMemList').empty();
	for (i = 0 ; i < MemListArr.length ; i++){
		$('.selectedMemList')
			.append("<div class=\'selectedMem jg\' memId="+MemListArr[i]+">"
						+"&nbsp;"+MemListArr[i]+"&nbsp;"
					+"<span>x</span></div>");	
	}	
}

</script>
<input type="text" id="cgroupName" placeholder="채팅방 이름을 설정하세요." 
	style="width : 97%;
		   border-radius : 1.0rem;
		   margin-bottom : 4px;
	 " autocomplete="off" >
<!-- 바깥은 chatList라는 DIV가 여전히 감싸고 있다. -->
<div style="height : 70%; color : black;" >
	<div style="float : left; width : 30%;">
		<span class="jg">Keyword</span><br>
		<input type="text" id="keyword" 
			style="border-radius : 1.0rem;
			width : 100px;" autocomplete="off" />
		<br><br>
		<span class="jg">검색 조건</span><br>
		<select id="MemSearchOption"
			style="border-radius : 1.0rem;
			background-color : lightgrey;
			height : 25px;
			width : 100px;">
			<option>아이디</option>
			<option>이름</option>
		</select>
	</div>
		
	<div style="float : left; width : 67%; height : 100%;">
		<span class="jg">프로젝트 멤버</span><br>
		<div style="height : 100%; width : 100%; border : 2px solid lightgrey; padding : 10px 10px 10px 10px; overflow : auto;">
			<c:if test="${chatMemList.size() == 0 }">
				<div class="jg" style="height : 70px; 
									   width : 80%; 
									   margin : 0 auto; 
									   text-align : center;
									   font-size : 1.0em;
									   padding-top : 140px;">
					<span>초대할 수 있는 회원이 <br>존재하지 않습니다.</span>
				</div>
			</c:if>			
			<c:if test="${chatMemList.size() > 0 }">
				<c:forEach var="i" begin="0" end="${chatMemList.size()-1 }">
					<!-- 리스트 하나하나를 자바스크립트 배열에 저장해야 한다. -->
						
					<!-- 로그인한 당사자는 리스트에서 제외되어야 한다. -->
					<c:choose>
						<c:when test="${chatMemList[i].memId != SMEMBER.memId }">
							<!-- 사용자 Id를 입력한다. -->
							<div class="singleMem jg" memId="${chatMemList[i].memId }" memName="${memInfoList[i].memName }" style="height : 70px; font-size : 1.0em;">
								
								<!-- 사용자 프로필 이미지를 출력한다. -->
								<c:if test="${fn:substring(memInfoList[i].memFilepath,0 ,1) eq '/' }">									
									<img class="img-circle" alt="이미지" style="width: 25px; height:  25px; "  src="${memInfoList[i].memFilepath}" />
								</c:if>
								<c:if test="${fn:substring(memInfoList[i].memFilepath,0 ,2) eq 'D:' }">		
									<img class="img-circle" alt="이미지" style="width:  25px; height:  25px; " src="/profileImgView?memId=${memInfoList[i].memId}" />
								</c:if>
								&nbsp;
								${chatMemList[i].memId }
								<br>
								<span style=" float : left; color : grey; font-size : 0.8em;">
									${memInfoList[i].memName }
								</span>
								<span style="float : right; font-size : 0.8em;">
									<c:if test="${memInfoList[i].memType == 'MEM' }">
										<div style="
											background-color : skyblue; 
											border : 3px solid skyblue; 
											border-radius : 0.3rem; 
											font-color : white;">
											일반회원
										</div>
									</c:if>
									<c:if test="${memInfoList[i].memType != 'MEM' }">
										<div style="background-color : red;
										 	border : 3px solid red; 
										 	border-radius : 0.3rem; 
										 	font-color : white;">
									 		관리자
								 		</div>
									</c:if>
								</span>
							</div>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
				</c:forEach>
			</c:if>
		</div>
	</div>
</div>
<br>
<span class="jg" style="color : black;">선택된 멤버</span>&nbsp;&nbsp;<span class="warning"></span>

<div style="height : 12%; width : 97%; overflow-y : auto;">
	<div class="selectedMemList" style="float : left;"></div>
</div>

<br>
<!-- Button -->	
<div class="jg" style="float : right;">
	<button class="returnBtn jg btn btn-primary">취소</button>
	<button class="NewBtn jg btn btn-primary">대화 시작하기</button>
</div>



$$$$$$$