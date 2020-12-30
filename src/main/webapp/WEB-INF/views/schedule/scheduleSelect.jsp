<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@include file="../layout/contentmenu.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<link rel="icon" href="../../favicon.ico">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- 네이버 지도 로드 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=e6rqd9yxsp&callback=CALLBACK_FUNCTION"></script>
<!-- 서브 모듈 로드 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=YOUR_CLIENT_ID&submodules=panorama,geocoder"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=YOUR_CLIENT_ID&submodules=panorama"></script>
<!-- 썸머노트  -->		
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<style>
#scheId, #memId, #regDt{
	padding-left : 50px;
	padding-top : 10px;
	padding-bottom : 10px;
}
#scheCont{
	width : 100%;
	height : 400px;
}
#juso{
	width : 100%;
}
.form-control:disabled, .form-control[readonly] {
	background-color: white;
}
.success{
	background-color: #f6f6f6;
	width: 10%;
	text-align: center;
}
#re_con{
	width: 700px;
	display :inline-block;
    resize: none;
    padding: 1.1em; /* prevents text jump on Enter keypress */
    padding-bottom: 0.2em;
    line-height: 1.6;
    overflow-y:hidden;
}		
#re_con.autosize { 
	min-height: 60px; 
}
#tx{
	background-color:transparent; 
	border:none; 
	width:100%; 
	overflow:visible;	
}	
.writeCon{
   width:100%; overflow:visible; background-color:transparent; border:none;
		resize :none; 
		padding-left:40px;
}	
</style>	

<body>
<div class="col-12 col-sm-12">
	<div class="card card-teal ">
	
	    <form id="listform" action="${pageContext.request.contextPath}/schedule/scheduleplaceView" method="post">
		    <input type="hidden" value="${searchCondition }" name="searchCondition">
		    <input type="hidden" value="${searchKeyword }" name="searchKeyword">
		    <input type="hidden" value="${pageIndex }" name="pageIndex">
		</form>
	
	<div class="card-body" id="detailDiv">	
	
			<br>
			<h4 class="jg">일정 상세내역</h4>
			<br>
			<table class="table" >
		        <tr class="stylediff">
		            <th class="success jg">제목</th>
		         	<td colspan="3">			  
		         		<label class="control-label" id="issueTitle">${scheduleVo.scheTitle}</label>
		         	</td>
		        </tr>
	
	
		         
		        <tr class="stylediff">
		            <th class="success jg">작성자</th>
		            <td style=" width: 40%;">
		            	<label class="control-label">${scheduleVo.memName }</label>
		            </td>
		          	
		       
		            <th class="success jg">등록일</th>		            
		            <td style="width: 40%;">
		            	<label class="control-label" >${scheduleVo.regDt }</label>
		            </td>
		        </tr>
		         
		        <tr class="stylediff">
		            <th class="success jg">시작일</th>
		            <td style="width: 40%;">
		            	<label class="control-label">${scheduleVo.startDt }</label> 		
		            </td>
		            
		            <th class="success jg">종료일</th>
		            <td style="width: 40%;">
		            	<label class="control-label">${scheduleVo.endDt }</label> 		
		            </td>
		           
		        </tr>		        
		        <tr>
		            <th class="success jg" style="height: 300px;">내용</th>
		            <td colspan="3">
			           	<c:if test="${scheduleVo.scheCont == '<p><br></p>'}">
							<label >[ 내용이 없습니다. ] </label>
						</c:if>
						<c:if test="${scheduleVo.scheCont == null}">
							<label >[ 내용이 없습니다. ] </label>
						</c:if>				
						<label id ="issueCont" class="control-label">${scheduleVo.scheCont }</label>
		            </td>
		        </tr>
		        
		        <tr class="stylediff" id="place">
					
						<th class="success jg" style="height: 300px;"  >장소</th>
						<td  colspan="3">
							<label id ="issueKind" class="control-label">${scheduleVo.juso }</label> 	
							<div id="map" style="width:100%;height:400px;"></div>
							
									
							<div id="map" style="width:100%;height:400px; display:none;">
								<input type="hidden" id="xVal" name="xVal" type="text" value="${scheduleVo.xVal }"> <br>
								<input type="hidden" id="yVal" name="yVal" type="text" value="${scheduleVo.yVal }"> <br>
								<input type="hidden" id="categoryId" name="categoryId" type="text" value="${scheduleVo.categoryId }"> <br>
								<input type="hidden" id="reqId" name="reqId" type="text" value="${scheduleVo.reqId }"> <br>
								<input type="hidden" id="del" name="del" type="text" value="${scheduleVo.del }"> <br>
							</div>
						</td>
						
		         </tr>
		         <tr>
		            <th class="success jg" style="height: 150px;">첨부파일</th>
		            <td colspan="3">
			            <div id = "filediv">
							<c:if test="${filelist.size() == 0}">
								<label>	[ 첨부파일이 없습니다. ] </label>
							
							</c:if>
							
							<c:forEach items="${filelist }" var="files" begin ="0" varStatus="vs" end="${filelist.size() }" step="1" >
																	 					
								<a href="${cp }/file/publicfileDown?pubId=${files.pubId}">
									<button id ="files${vs.index}" class="btn btn-default jg" name="${files.pubId}">
										<img name="link" src="/fileFormat/${fn:toLowerCase(files.pubExtension)}.png" onerror="this.src='/fileFormat/not.png';" style="width:30px; height:30px;">
										 ${files.pubFilename} 다운로드
									</button>
								
								</a>
								<br>
							</c:forEach>
						</div>
					</td>
		        </tr>
	        </table>
	        
	   	 	<div class="card-footer clearfix">
				<input type= "button" value="목록으로" id ="back" class="btn btn-default float-left jg" >
			
	    		<c:if test="${scheduleVo.memId == SMEMBER.memId}">
					<input type= "button" value="삭제하기" id="delsche"  class="btn btn-default float-right jg" >			
					<input type= "button" value="수정하기" id ="modsche" class="btn btn-default float-right jg" style="margin-right: 5px;">
				</c:if>
			</div>
		
		
			<form class="form-horizontal" role="form" id ="frm" method="post" action="${pageContext.request.contextPath}/schedule/scheduleinsertreply">	
				<div class="form-group">
				<hr>	
					<label for="pass" class="col-sm-2 control-label jg">댓글</label>
					<div class="col-sm-12" id="replydiv">	
												
						<c:forEach items="${replylist }" var="replylist">
							<div id="replydiv" style="padding-left: 50px;">			
							<c:if test= "${replylist.del == 'N'}">
								<c:if test="${fn:substring(replylist.memFilepath,0 ,1) eq '/' }">									
									<img id="imge" style="width: 40px; height:  40px; border-radius: 50%; border: 1.5px solid #adb5bd;"  src="${replylist.memFilepath}" />
								</c:if>
								<c:if test="${fn:substring(replylist.memFilepath,0 ,2) eq 'D:' }">		
									<img id="pict" style="width:  40px; height:  40px;  border-radius: 50%; border: 1px solid #adb5bd;" src="/profileImgView?memId=${replylist.memId}" />
								</c:if>
								<label style="display: inline-block;" class="jg">${replylist.memName }</label>
								<label >( ${replylist.memId } )</label>
									
								<textarea style=" width:100%; overflow:visible; background-color:transparent; border:none;"  disabled class ="writeCon">${replylist.replyCont}</textarea>
								
								[ ${replylist.regDt} ] 	
									
								<c:if test= "${replylist.memId == SMEMBER.memId && replylist.del == 'N'}">	
									
									
									<input type="hidden" value="${replylist.replyId}">
									<input type="hidden" value="${replylist.someId}">																							
									<input id ="replydelbtn" type="button" class="btn btn-default jg" value ="삭제"/>						
								</c:if>		
											
							</c:if>	 														
							<c:if test= "${replylist.del == 'Y'}">			
																
								<p>[ 삭제된 댓글입니다. ]</p>		
												
							</c:if>	
							</div>	 														
							<hr>	
						</c:forEach>	
						<br>		
						<div id="replyinsertdiv" style="padding-left: 50px;">			
							<input type="hidden" name="someId" value="${scheduleVo.scheId}">
							<input type="hidden" name="categoryId" value="${scheduleVo.categoryId}">
							<input type="hidden" name="reqId" value="${scheduleVo.reqId}">
							<input type="hidden" name="memId" value="${scheduleVo.memId}">
											
							<textarea name = "replyCont" id ="re_con" onkeyup="resize(this)" ></textarea><br>
							<div style="width:700px;">	
								<span>0</span> &nbsp;자 / 300 자		
								<input id="replybtn2" type = "button" class="btn btn-default float-right jg" value = "댓글작성"><br>				
							</div>
						</div>
					</div>
				</div>
			</form>	
	
		</div>
	</div>
</div>	
	
<script type="text/javascript">
		var x = 0;
		var y = 0;
		var contentString = '송촌동 우리집';

		var map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng($("#xVal").val(), $("#yVal").val()),
			zoom : 17, //지도의 초기 줌 레벨
			minZoom : 1, //지도의 최소 줌 레벨
			zoomControl : true, //줌 컨트롤의 표시 여부
			zoomControlOptions : {
				position : naver.maps.Position.LEFT_BOTTOM
			},
			mapTypeControl : true
		// 일반ㆍ위성 지도보기 컨트롤 표시 (기본값 표시안함)

		});

		

		var marker = new naver.maps.Marker(
				{
					position : new naver.maps.LatLng($("#xVal").val(), $(
							"#yVal").val()),
					map : map
				});

		/* var marker = new naver.maps.Marker({
		 position : new naver.maps.LatLng(x,y),
		 title:contentString,
		 map:map
		 }); */

		var infoWindow = new naver.maps.InfoWindow({
			anchorSkew : true
		});

		map.setCursor('pointer');

		function searchAddressToCoordinate(address) {
			naver.maps.Service
					.geocode(
							{
								query : address
							},
							function(status, response) {
								if (status === naver.maps.Service.Status.ERROR) {
									return alert('Something Wrong!');
								}

								if (response.v2.meta.totalCount === 0) {
									return alert('잘못된 주소입니다. 다시 검색하세요' /* + response.v2.meta.totalCount */);
								}

								var htmlAddresses = [], item = response.v2.addresses[0], point = new naver.maps.Point(
										item.x, item.y);

								if (item.roadAddress) {
									htmlAddresses.push('[도로명 주소] '
											+ item.roadAddress);
								}

								if (item.jibunAddress) {
									htmlAddresses.push('[지번 주소] '
											+ item.jibunAddress);
								}

								if (item.englishAddress) {
									htmlAddresses.push('[영문명 주소] '
											+ item.englishAddress);
								}

								infoWindow
										.setContent([
												'<div style="padding:10px;min-width:200px;line-height:150%;">',
												'<h4 style="margin-top:5px;">검색 주소 : '
														+ address
														+ '</h4><br />',
												htmlAddresses.join('<br />'),
												'</div>' ].join('\n'));

								map.setCenter(point);
								infoWindow.open(map, point);
							});
		}

		function initGeocoder() {
			if (!map.isStyleMapReady) {
				return;
			}

			map.addListener('click', function(e) {
				searchCoordinateToAddress(e.coord);
			});

			$('#address').on('keydown', function(e) {
				var keyCode = e.which;

				if (keyCode === 13) { // Enter Key
					searchAddressToCoordinate($("#juso").val());
				}
			});

			$('#submit').on('click', function(e) {
				e.preventDefault();

				searchAddressToCoordinate($("#juso").val());
			});
	
		}

		function makeAddress(item) {
			if (!item) {
				return;
			}

			var name = item.name, region = item.region, land = item.land, isRoadAddress = name === 'roadaddr';

			var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';

			if (hasArea(region.area1)) {
				sido = region.area1.name;
			}

			if (hasArea(region.area2)) {
				sigugun = region.area2.name;
			}

			if (hasArea(region.area3)) {
				dongmyun = region.area3.name;
			}

			if (hasArea(region.area4)) {
				ri = region.area4.name;
			}

			if (land) {
				if (hasData(land.number1)) {
					if (hasData(land.type) && land.type === '2') {
						rest += '산';
					}

					rest += land.number1;

					if (hasData(land.number2)) {
						rest += ('-' + land.number2);
					}
				}

				if (isRoadAddress === true) {
					if (checkLastString(dongmyun, '면')) {
						ri = land.name;
					} else {
						dongmyun = land.name;
						ri = '';
					}

					if (hasAddition(land.addition0)) {
						rest += ' ' + land.addition0.value;
					}
				}
			}

			return [ sido, sigugun, dongmyun, ri, rest ].join(' ');
		}

		function hasArea(area) {
			return !!(area && area.name && area.name !== '');
		}

		function hasData(data) {
			return !!(data && data !== '');
		}

		function checkLastString(word, lastString) {
			return new RegExp(lastString + '$').test(word);
		}

		function hasAddition(addition) {
			return !!(addition && addition.value);
		}

		naver.maps.onJSContentLoaded = initGeocoder;
		naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
		
			
	$(document).ready(function(){
		
		if('${scheduleVo.juso}' == '' || '${scheduleVo.juso}' == null ){
			$('#place').hide();
		}
		
		// 뒤로가기
		$("#back").on("click", function() {
// 			$("#listform").attr("action", "${pageContext.request.contextPath}/vote/votelist");
			listform.submit();	
		});
		
		// 수정하기 버튼
		$("#modsche").on('click', function(){
			$(location).attr('href', '${pageContext.request.contextPath}/schedule/scheduleUpdateView?scheId=${scheduleVo.scheId}');
		})
		
		// 삭제하기 버튼
		$("#delsche").on('click', function(){
	        if(confirm("정말 삭제하시겠습니까 ?") == true){
				$(location).attr('href', '/schedule/scheduleDelete?scheId=${scheduleVo.scheId}');
	        }else{
	        	return;
	        }
		})
		 	
	});
		
			
//댓글 작성
function replyinsert() {
	someId : '${scheduleVo.scheId}';
	$.ajax({
		
		url : "${pageContext.request.contextPath}/reply/insertreply",
		method : "post",
		data : {	
			someId : '${scheduleVo.scheId}',
			categoryId : '${scheduleVo.categoryId}',
			reqId : '${scheduleVo.reqId}',
			replyCont : $('#re_con').val()	
		},	
		success : function(data) {	
			saveMsg();
		}
	});
}	

//댓글알림
function saveMsg(){
	var alarmData = {
						"alarmCont" : "${projectVo.reqId}&&${SMEMBER.memName}&&${SMEMBER.memId}&&/projectMember/eachissueDetail&&${scheduleVo.scheId}&&${scheduleVo.scheTitle}&&"+ $('#re_con').val() + "&&${projectVo.proName}",
						"memId" 	: "${scheduleVo.memId}",
						"alarmType" : "reply-6"
	}
	
	$.ajax({
			url : "/alarmInsert",
			data : JSON.stringify(alarmData),
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			dataType : 'text',
			success : function(data){
				
				let socketMsg = alarmData.alarmCont +"&&"+ alarmData.memId +"&&"+ alarmData.alarmType;
				socket.send(socketMsg);
				$(location).attr('href', '/schedule/scheduleSelect?scheId=${scheduleVo.scheId}');
				
			},
			error : function(err){
				console.log(err);
			}
	});
}

		
// 댓글작성시 작동 증가
function resize(obj) {
	obj.style.height = "1px";
	obj.style.height = (12+obj.scrollHeight)+"px";
}

		
$(function(){
	// 댓글 높이 자동 맞춤
	$('.writeCon').each(function () {	
		  this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
	}).on('input', function () {
		  this.style.height = 'auto';
		  this.style.height = (this.scrollHeight) + 'px';
	});

	
	// 댓글 작성
	$('#replybtn2').on('click', function(){
		replyinsert();
	})
	
	// 댓글 작성하기 삭제 버튼
	$('#replydiv').on('click','#replydelbtn', function(){
		if(confirm("댓글을 정말 삭제하시겠습니까 ?") == true){   
			
			var someid = $(this).prev().val();
			var replyid = $(this).prev().prev().val();
			issueid = '${scheduleVo.scheId }'
			$.ajax({url :"/reply/delreply",
				   data :{replyId: replyid,
					       someId: someid, 
					       reqId : '${scheduleVo.reqId}'},
				   method : "get",
				   success :function(data){
					   $(location).attr('href', '/schedule/scheduleSelect?scheId=${scheduleVo.scheId}');
				 }
			})
		}else{
        	return;
        }
	})
				
	// 답글 글자수 계산
	$('#re_con').keyup(function (e){
	    var content = $(this).val();
	  
	    $('#counter').html("('+content.length+' / 최대 300자)");    //글자수 실시간 카운팅	  
		$('span').html(content.length);
		
	    if (content.length > 300){
	        alert("최대 300자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 300));
	        $('span').html("(200 / 최대 300자)");
	    }
	});
})
</script>
</body>
