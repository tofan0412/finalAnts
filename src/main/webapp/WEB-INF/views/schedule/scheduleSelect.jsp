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
</style>	
<%@include file="../layout/contentmenu.jsp"%>
<body>
	<c:if test="${not empty scheduleVo.juso}">
		<div id="map" style="width:100%;height:400px;"></div>
		<!-- <div id="value"></div> -->
	</c:if>
			
	<div id="map" style="width:100%;height:400px; display:none;">
		<input type="hidden" id="xVal" name="xVal" type="text" value="${scheduleVo.xVal }"> <br>
		<input type="hidden" id="yVal" name="yVal" type="text" value="${scheduleVo.yVal }"> <br>
		<input type="hidden" id="categoryId" name="categoryId" type="text" value="${scheduleVo.categoryId }"> <br>
		<input type="hidden" id="reqId" name="reqId" type="text" value="${scheduleVo.reqId }"> <br>
		<input type="hidden" id="del" name="del" type="text" value="${scheduleVo.del }"> <br>
	</div>
	
	
	<div class="card card-primary card-outline">

		<div class="card-header"><h3>일정 상세내역</h3>
			<div class="float-right">
				<a href="/schedule/scheduleUpdateView?scheId=${scheduleVo.scheId}"><input type="button" class="btn btn-primary" value="수정"></a> 
				<a href="/schedule/scheduleDelete?scheId=${scheduleVo.scheId}"><input type="button" class="btn btn-primary" value="삭제"></a><br>
			</div>
				제목 <input id="scheId" name="scheId" value="${scheduleVo.scheTitle}" style="border:none;" readonly> <br>
				아이디 <input id="memId" name="memId" type="text" value="${scheduleVo.memId }" style="border:none;" readonly> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				등록일<input id="regDt" name="regDt" type="text" value="${scheduleVo.regDt }" style="border:none;" readonly> <br>
			<h3 class="card-title" style="display:none;">
				<c:out value="${projectVo.proName}" />
			</h3>
		</div>
			
		
		<div class="card-body">
			<div class="form-group">
			</div> 
			<div class="form-group">
				시작일 : <input id="startDt" name="startDt" type="text" value="${scheduleVo.startDt }" style="border:none;" readonly> <br>
				종료일 : <input id="endDt" name="endDt" type="text" value="${scheduleVo.endDt }" style="border:none;" readonly> <br><br>
				장소 : <input id="juso" name="juso" type="text" value="${scheduleVo.juso }" style="border:none;" readonly>
			</div> 
			<br>  
			<div class="form-group"> 
				<h4>내용</h4><br>
				<textarea id="scheCont" name="scheCont" value="${scheduleVo.scheCont }" style="border:1px solid;" readonly>${scheduleVo.scheCont }</textarea>
			</div>
		</div> 
		<div class="card-footer">
			<button type="button" class="btn btn-default" id="back">
				<i class="fas fa-times"></i> 취소
			</button>
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

		//클릭이벤트를 적용하여 경고창으로 위도 경도를 봅니다.
		naver.maps.Event.addListener(map, 'click', function(e) {
			x = e.coord.lat();
			y = e.coord.lng();

			// 지도를 클릭하면 아래 내용이 실행됩니다.
			$("#value").text(x + ', ' + y);
			$("#x").val(x);
			$("#y").val(y);
			marker.setPosition(e.latlng) // 클릭한 지점으로 마커 이동
			// e 는 클릭시 넘어오는 이벤트 (네이밍은 원하는 대로 하셔도 됩니다)
			// e 에서 필요한 것을 꺼내서 쓰면 됩니다.
			// e.coord.lat() 는 위도 (Latitude)  보통 약어로 lat
			// e.coord.lng() 는 경도 (Longitude) 보퉁 약어로 lng
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
		// 뒤로가기
		$("#back").on("click", function() {
			window.history.back();
		});
		 	
	});
</script>

</body>
</html>