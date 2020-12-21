<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
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
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"	rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style> 
	#summernote{
		width : 100%;
		height : 250px;
	}
</style>
</head>
 
<body>	
	
	<%@include file="../layout/contentmenu.jsp"%>

<br>
	<div style="padding-left: 30px; padding-right: 30px;">
	<form method="post" action="${pageContext.request.contextPath }/schedule/scheduleUpdate" id="sform" id="sform">    
			<div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title jg"><c:out value="${projectVo.proName}"/></h3>
              </div>
              <div class="card-body">
                <div class="form-group">
            		<input class="form-control" name="scheTitle" placeholder="제목" value="${scheduleVo.scheTitle}">
                </div>
                <div class="form-group">
                <textarea id="summernote" name="scheCont" placeholder="내용">${scheduleVo.scheCont}</textarea>
				
                </div>
                
                <div class="form-group">
					<label class="jg">시작일 &nbsp;</label>
	                <input class="form-control jg" style="display:inline-block; width: 200px;" type='date' id="startDt" name="startDt" value="${scheduleVo.startDt}"/><br>
					<label class="jg">종료일 &nbsp;</label>
	                <input class="form-control jg" style="display:inline-block; width: 200px;" type='date' id="endDt" name="endDt" value="${scheduleVo.endDt}"/><br>
                </div>
<!--                 <div class="form-group" id="addDiv"> -->
<!-- 					<input type="submit" class="btn btn-default float-left jg" id="addbtn" value="장소 추가">  -->
<!--                 </div> -->
                <br>
 
                 
                <!-- style="display:none" -->
                <div class="form-group" style="display:none">
				<div class="float-left">
					<input type='button' id="map1" value="지도+" /><br>
				</div>
					scheId : 
                	<input type='text' name="scheId" value="${scheduleVo.scheId}"/><br>
	                x
	                <input type='text' id='x' name="xVal" value="${scheduleVo.xVal}"/><br>
					y
	                <input type='text' id='y' name="yVal" value="${scheduleVo.yVal}"/><br>
                	 categoryId : 
					 <input type='text' name="categoryId" value="6"/><br>
					 reqId : 
					 <input type='text' name="reqId" value="${projectId}"/><br>
					 memId : 
					 <input type='text' name="memId" value="${SMEMBER.memId }"/><br>
					 del : 
					 <input type='text' name="del" value="N"/><br>
<!-- 					 주소 : -->
					 <input type='text' id="juso7" name="juso" value="${scheduleVo.juso }"/><br>
                </div>
                
              <div id="addDiv">
              	
              		<button type="button" class="btn btn-default float-left jg" id="addbtn"><i class="fas fa-plus"></i>장소추가</button>    
<!--               	<input type="button" class="btn btn-default float-left jg" id="addbtn" value="장소추가">     -->
              </div>  
              <br>
              
              <div id="mapdiv">
                <div id="keyword" class="card-tools float-left" style="width: 400px;">
	                <div class="input-group row">
		                <input type="text" id="address" value="" class="form-control" placeholder="검색어를 입력하세요.">
		               	<span class="input-group-append">		
							<button type="button" id="submit" class="btn btn-default jg" style="width: 120px;">
								<i class="fa fa-fw fa-search"></i>주소검색</button>
						</span>
						<!-- display:none; -->
					</div>
				</div>
				<br>
				<!-- style="display:none" -->
				<div class="form-group" style="display:none">
					<input id="juso" name="juso2" type="text" value="${scheduleVo.juso }"> <br>
				</div>
				
				<div id="map" style="width:100%;height:400px;"></div>
		       </div>
			
				<br>
                 
              </div>
              <div class="card-footer clearfix"> 
            
                  <input type="submit" class="btn btn-default float-left jg" id="regBtn" value="수정"> 
<!--                   <button type="button" class="btn btn-default float-left jg" id="regBtn" onclick="scheInsert()"><i class="fas fa-pencil-alt"></i> 작성</button> -->
 				 
                
              </div>
            </div>
        </form>
	</div>






<script type="text/javascript">

var x = 0;
var y = 0;
var add = "";
	$(document).ready(function(){
	

		if('${scheduleVo.juso}' == '' || '${scheduleVo.juso}' == null ){
			$('#mapdiv').hide();
			add= "on";
		}else if('${scheduleVo.juso}' != '' || '${scheduleVo.juso}' != null ){
			$('#mapdiv').show();
			add= "off";
		}
		
		$('#addbtn').on('click', function(){
	 		$('#addDiv').hide();
	 		$('#mapdiv').show();
	 		
	 	})
		
		
	  	$('#summernote').summernote({
			  height: 250,                 // 에디터 높이
			  minHeight: 250,             // 최소 높이
			  maxHeight: 500,             // 최대 높이
			  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",					// 한글 설정
		});  
	 	// 등록
	 	$("#regBtn").on("click", function() {
			$("#sform").submit();
		});
	 	
	 	// 뒤로가기
		$("#back").on("click", function() {
			window.history.back();
		});
	 	
/* 		$("#map1").on("click", function() {
			document.getElementById('map').style.display="block";
		}); */
	 	
	 	
	});

var contentString = '송촌동 우리집';

var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(36.350365, 127.3853066),
    zoom: 17,	//지도의 초기 줌 레벨
    minZoom: 7,	//지도의 최소 줌 레벨
    zoomControl: true,	//줌 컨트롤의 표시 여부
    zoomControlOptions: {
    position: naver.maps.Position.LEFT_BOTTOM
    },
	mapTypeControl : true // 일반ㆍ위성 지도보기 컨트롤 표시 (기본값 표시안함)

});  


//클릭이벤트를 적용하여 경고창으로 위도 경도를 봅니다.
naver.maps.Event.addListener(map, 'click', function(e){
	x= e.coord.lat();
	y= e.coord.lng();
	
	// 지도를 클릭하면 아래 내용이 실행됩니다.
	$("#value").text(x + ', ' + y); 
	$("#x").val(x); 
	$("#y").val(y); 
	marker.setPosition(e.latlng)	// 클릭한 지점으로 마커 이동
	// e 는 클릭시 넘어오는 이벤트 (네이밍은 원하는 대로 하셔도 됩니다)
	// e 에서 필요한 것을 꺼내서 쓰면 됩니다.
	// e.coord.lat() 는 위도 (Latitude)  보통 약어로 lat
	// e.coord.lng() 는 경도 (Longitude) 보퉁 약어로 lng
});

if(add == "off"){
	
	var marker = new naver.maps.Marker({	
		
		map: map 
	});
}else if(add="on"){
	var marker = new naver.maps.Marker({	
		position : new naver.maps.LatLng(x,y),
		map: map 
	});
}

	
/* var marker = new naver.maps.Marker({
	position : new naver.maps.LatLng(x,y),
	title:contentString,
	map:map
}); */




var infoWindow = new naver.maps.InfoWindow({
    anchorSkew: true
});

map.setCursor('pointer');

function searchCoordinateToAddress(latlng) {

    infoWindow.close();

    naver.maps.Service.reverseGeocode({
        coords: latlng,
        orders: [
            naver.maps.Service.OrderType.ADDR,
            naver.maps.Service.OrderType.ROAD_ADDR
        ].join(',')
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }

        var items = response.v2.results,
            address = '',
            htmlAddresses = [];

        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
            item = items[i];
            address = makeAddress(item) || '';
            addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';

            htmlAddresses.push((i+1) +'. '+ addrType +' '+ address);
            var juso = document.getElementById('juso7');
            juso.value = address;
        }
		
        infoWindow.setContent([
            '<div style="padding:10px;min-width:200px;line-height:150%;">',
            '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
            htmlAddresses.join('<br />'),
            '</div>'
        ].join('\n'));

        infoWindow.open(map, latlng);
    });
}

function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        query: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }

        if (response.v2.meta.totalCount === 0) {
            return alert('잘못된 주소입니다. 다시 검색하세요' /* + response.v2.meta.totalCount */);
        }

        var htmlAddresses = [],
            item = response.v2.addresses[0],
            point = new naver.maps.Point(item.x, item.y);

        if (item.roadAddress) {
            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
        }
        
        if (item.jibunAddress) {
            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
            var juso = document.getElementById('juso7');
            juso.value = item.jibunAddress;
        }
		
        if (item.englishAddress) {
            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
        }

        infoWindow.setContent([
            '<div style="padding:10px;min-width:200px;line-height:150%;">',
            '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
            htmlAddresses.join('<br />'),
            '</div>'
        ].join('\n'));

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
            searchAddressToCoordinate($('#address').val());
        }
    });

    $('#submit').on('click', function(e) {
        e.preventDefault();

        searchAddressToCoordinate($('#address').val());
    });
    
    searchAddressToCoordinate($('#juso').val());
}

function makeAddress(item) {
    if (!item) {
        return;
    }

    var name = item.name,
        region = item.region,
        land = item.land,
        isRoadAddress = name === 'roadaddr';

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

    return [sido, sigugun, dongmyun, ri, rest].join(' ');
}

function hasArea(area) {
    return !!(area && area.name && area.name !== '');
}

function hasData(data) {
    return !!(data && data !== '');
}

function checkLastString (word, lastString) {
    return new RegExp(lastString + '$').test(word);
}
 
function hasAddition (addition) {
    return !!(addition && addition.value);
}

naver.maps.onJSContentLoaded = initGeocoder;
naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
</script>
			
<!-- 	<div style="padding-left: 30px; padding-right: 30px;"><h3>일정 수정</h3> -->
<%-- 		<form method="post" action="${pageContext.request.contextPath }/schedule/scheduleUpdate" id="sform">     --%>
<!-- 			<div class="card card-primary card-outline"> -->
<!--               <div class="card-header"> -->
<%--                 <h3 class="card-title"><c:out value="${projectVo.proName}"/></h3> --%>
<!--               </div> -->
<!--               <div class="card-body"> -->
<!--                 <div class="form-group"> -->
<%--                   <input class="form-control" name="scheTitle" placeholder="제목" value="${scheduleVo.scheTitle}"> --%>
<!--                 </div> -->
<!--                 <div class="form-group"> -->
<%--                 <textarea id="summernote" name="scheCont" value="${scheduleVo.scheCont}">${scheduleVo.scheCont}</textarea> --%>
				
<!--                 </div> -->
                
<!--                 <div class="form-group"> -->
<!-- 					시작일 &nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;&nbsp;  -->
<%-- 	                <input type='date' id='startDt' name="startDt" value="${scheduleVo.startDt}"/><br> --%>
<!-- 					종료일 &nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;&nbsp; -->
<%-- 	                <input type='date' id='endDt' name="endDt" value="${scheduleVo.endDt}"/><br> --%>
<!--                 </div> -->
  				
                 
<!--                 <br>  -->
                 
<!--                 style="display:none" -->
<!--                 <div class="form-group" style="display:none"> -->
<!--                 	scheId :  -->
<%--                 	<input type='text' name="scheId" value="${scheduleVo.scheId}"/><br> --%>
<!-- 	                x :  -->
<%-- 	                <input type='text' id='xVal' name="xVal" value="${scheduleVo.xVal}"/><br> --%>
<!-- 					y:  -->
<%-- 	                <input type='text' id='yVal' name="yVal" value="${scheduleVo.yVal}"/><br> --%>
<!--                 	categoryId :  -->
<!-- 					<input type='text' name="categoryId" value="6"/><br> -->
<!-- 					reqId :  -->
<%-- 					<input type='text' name="reqId" value="${projectId}"/><br> --%>
<!-- 					memId :  -->
<%-- 					<input type='text' name="memId" value="${SMEMBER.memId }"/><br> --%>
<!-- 					del :  -->
<!-- 					<input type='text' name="del" value="N"/><br> -->
<!-- 					주소 : -->
<%-- 					<input type='text' id="juso7" name="juso" value="${scheduleVo.juso}"/><br> --%>
<!--                 </div> -->
<!--               </div> -->
<!--               <div class="card-footer"> -->
<!--                 <div class="float-right"> -->
<!--                   <button type="button" class="btn btn-default" id="back"><i class="fas fa-times"></i> 취소</button> -->
<!--                   <button type="button" class="btn btn-primary" id="regBtn"><i class="far fa-pencil-alt"></i> 작성</button> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </div> -->
<%--         </form> --%>
<!-- 		</div> -->

</body>
</html>