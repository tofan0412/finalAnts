<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>네이버API 지도</title>
    <!-- 네이버 지도 로드 -->
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=e6rqd9yxsp&callback=CALLBACK_FUNCTION"></script>
	<!-- 서브 모듈 로드 -->
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=YOUR_CLIENT_ID&submodules=panorama,geocoder"></script>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=YOUR_CLIENT_ID&submodules=panorama"></script>
	
	<link rel="icon" href="../../favicon.ico">
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"	rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	
</head>
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
</style>	
<%@include file="../layout/contentmenu.jsp"%>
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
<%-- 			      <c:if test="${not empty scheduleVo.juso}"> --%>
					
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
						
<%-- 			        </c:if> --%>
		         </tr>
	        </table>
	        
	    <div class="card-footer clearfix">
			<input type= "button" value="목록으로" id ="back" class="btn btn-default float-left jg" >
			
	    	<c:if test="${scheduleVo.memId == SMEMBER.memId}">
				<input type= "button" value="삭제하기" id="delsche"  class="btn btn-default float-right jg" >			
				<input type= "button" value="수정하기" id ="modsche" class="btn btn-default float-right jg" style="margin-right: 5px;">
			</c:if>
		</div>
	
	
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

			searchAddressToCoordinate($("#juso").val());
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
			console.log("수정버튼")
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
</script>

</body>
</html>