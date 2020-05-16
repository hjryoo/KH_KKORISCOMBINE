<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 병원 검색</title>
<style>
	h2 {font-weight: 700; font-size: 30px; color: #000; padding: 15px 0; text-align: center;}
	.searchContents{font-size:20px; margin:1% 5%; width:90%; height: 400px; border:1px solid #5d5d5d; border-radius:30px;}
	#map{width: 45%; min-width:500px; height:350px; position:absolute; display: inline-block; margin: 25px 0; right: 6%}
   	div.select-box.first{margin-top: 70px; margin-left: 50px;}
   	div.select-box.second{margin-top: 30px; margin-left: 50px;}
   	.medi-sel{margin-top:30px; margin-left: 50px;}
	.select-box > select{width: 200px;}
	.input-box {width: 400px; margin: 30px 0 0 50px !important;}
	div.input-box > input {font-size: 14px !important;}
	.button-box {display: inline-block; text-align: center; margin: 30px 0 0 50px;}
	.button-box > button {width: 100px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
	.button-box > button:hover {background: #fb929e; color: #fff;}
	
	.hospital_list{border:1px solid #5d5d5d; top:800px; margin:1% 5%; overflow-y:scroll; width:90%; height: 400px; border-radius: 50px;}
	.hospital_list::-webkit-scrollbar {display: none;}
	
	table#listArea{width:100%; border-collapse: collapse; line-height:1.5;}
	table#listArea thead th{width:30%;padding:10px;font-weight:bold; vertical-align:top; color:#000; border-bottom:1px solid #5d5d5d;}
	table#listArea thead th:last-child{width: 40%;}
	table#listArea tbody tr:hover{background: #ffdfdf; cursor: pointer;}
	table#listArea tbody th{width:30%;padding:15px; font-weight:bold; vertical-align:top;}
	table#listArea tbody td{width:30%;padding:15px; vertical-align:top; text-align:center;}
   	table#listArea tbody tr > td:last-child{min-width:40%;}
</style>
<script type="text/javascript">

   // 지역 선택
   var f_selbox = ["서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
   var s_selbox = new Array();
   s_selbox[0] = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
   s_selbox[1] = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
   s_selbox[2] = ["대덕구","동구","서구","유성구","중구"];
   s_selbox[3] = ["광산구","남구","동구", "북구","서구"];
   s_selbox[4] = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
   s_selbox[5] = ["남구","동구","북구","중구","울주군"];
   s_selbox[6] = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
   s_selbox[7] = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
   s_selbox[8] = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
   s_selbox[9]= ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
   s_selbox[10] = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
   s_selbox[11] = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
   s_selbox[12] = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
   s_selbox[13] = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
   s_selbox[14] = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
   s_selbox[15] = ["서귀포시","제주시","남제주군","북제주군"];

	function init(f){
		var f_sel = f.first;
		var s_sel = f.second;

		f_sel.options[0] = new Option(":: 시/도 ::", "");
		s_sel.options[0] = new Option(":: 구/군 ::", "");
		
		for(var i = 0; i < f_selbox.length; i++){
			f_sel.options[i+1] = new Option(f_selbox[i], f_selbox[i]);
		}
	}
	function initChange(f){
		var f_sel = f.first;
		var s_sel = f.second;
		
		var sel = f_sel.selectedIndex;
		for(var i = s_sel.length; i >= 0; i--){
			s_sel.options[i] = null;
		}
		
		s_sel.options[0] = new Option(":: 구/군 ::", "");
		
		if(sel != 0){
			for(var i = 0; i < s_selbox[sel-1].length; i++){
				s_sel.options[i+1] = new Option(s_selbox[sel-1][i], s_selbox[sel-1][i]);
			}
		}
	}

	</script>
</head>
<body onload = "init(this.form);">
	<%@ include file="../common/layout.jsp" %>
	
	<div class="container">
		<h2>병원 검색</h2>
		<div class="searchContents">
			<div id="map"></div>
			<form name="form">
				<div class="select-box first">
						<select id="first" onchange="initChange(this.form);"></select>
				</div>
				<div class="select-box second">
					<select id="second"></select>
				</div>
			</form>
			<div class="medi-sel">
				<div class="select-box">
					<select id="medical">
						<option disabled>--진료과목--</option>
						<option value="HC1">내과</option>
						<option value="HC2">외과</option>
						<option value="HC3">안과</option>
						<option value="HC4">치과</option>
						<option value="HC5">피부과</option>
						<option value="HC6">기타</option>
						<option disabled>--검사--</option>
						<option value="HI1">기초 혈액검사</option>
						<option value="HI2">심장사상충 검사</option>
						<option value="HI3">혈액형 검사</option>
						<option value="HI4">항체가 검사</option>
						<option value="HI5">내시경</option>
						<option value="HI6">초음파</option>
						<option disabled>--건강검진--</option>
						<option value="HS1">기초 종합검진</option>
						<option value="HS2">복합 종합검진</option>
						<option disabled>--예방접종--</option>
						<option value="HV1">코로나</option>
						<option value="HV2">켄넬로프</option>
						<option value="HV3">광견병</option>
						<option value="HV4">인플루엔자</option>
						<option value="HV5">반려견 종합백신</option>
						<option value="HV6">반려묘 종합백신</option>
						<option disabled>--중성화 수술--</option>
						<option value="HZ1">수컷</option>
						<option value="HZ2">암컷</option>
						<option value="HZ3">잠복고환</option>
						<option value="HZ4">기타</option>
					</select>
				</div>
			</div>
			<div class="input-box"><input type="text" name="hName" id="hName" value="" placeholder="검색할 병원명"></div>
			
			<div class="button-box"><button id="hospitalBtn">병원 검색</button></div>
		</div>
		
		<div class="hospital_list">
			<table id="listArea">
				<thead>
					<tr>
						<th>병원명</th>
						<th>연락처</th>
						<th>주소</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
				
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f3549269f64d3486484fc870940fc9dd&libraries=services,clusterer">
		</script>
		<script>
			var infowindow = new kakao.maps.InfoWindow({zIndex:1}); // 장소명 나옴
		
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.56710, 126.97836), // 지도의 중심좌표
			        level: 4, // 지도의 확대 레벨
			        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
			    }; 
	
			// 지도를 생성한다 
			var map = new kakao.maps.Map(mapContainer, mapOption);
	
			// 지도 타입 변경 컨트롤을 생성한다
			var mapTypeControl = new kakao.maps.MapTypeControl();
	
			// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);	
	
			// 지도에 확대 축소 컨트롤을 생성한다
			var zoomControl = new kakao.maps.ZoomControl();
	
			// 지도의 우측에 확대 축소 컨트롤을 추가한다
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
			// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
			if (navigator.geolocation) {
			    
			    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
			    navigator.geolocation.getCurrentPosition(function(position) {
			        
			        var lat = position.coords.latitude, // 위도
			            lon = position.coords.longitude; // 경도
			        
			        var locPosition = new kakao.maps.LatLng(lat, lon) // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
			         
			        // 마커와 인포윈도우를 표시합니다
			        displayMarker(locPosition);
			            
			      });
			    
			} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
			    
			    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
			        message = 'geolocation을 사용할수 없어요..'
			        
			    displayMarker(locPosition, message);
			}

			// 지도에 마커와 인포윈도우를 표시하는 함수입니다
			function displayMarker(locPosition, place) {

			    // 마커를 생성합니다
			    var marker = new kakao.maps.Marker({  
			        map: map, 
			        position: locPosition
			    }); 
			    
			    // 지도 중심좌표를 접속위치로 변경합니다
			    map.setCenter(locPosition); 
			    
			 // 마커에 클릭이벤트를 등록합니다
			    kakao.maps.event.addListener(marker, 'click', function() {
			        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			        infowindow.setContent('<div style="padding:5px;font-size:16px;">' + "현재위치"+ '</div>');
			        infowindow.open(map, marker);
			    });
			}
			function address(address){
			//$('td.lastTd').click(function(){
				var hpLoc = $(address).find('td').eq(1).text();
				var hpName = $(address).find('th').text();
				// 주소-좌표 변환 객체
				var geocoder = new kakao.maps.services.Geocoder();
				
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(hpLoc, function(result, status) {
	
				    // 정상적으로 검색이 완료됐으면 
				    //console.log(status);
				    //console.log(kakao.maps.services.Status.OK);
				     if (status === kakao.maps.services.Status.OK) {
	
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x); 
	
				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });
	
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new kakao.maps.InfoWindow({
				            content: '<div style="width:150px;font-size:16px;font-weight:600;text-align:center;padding:5px;">' + hpName + '</div>'
				        });
				        infowindow.open(map, marker);
				        
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});
			//});
			}
			
	</script>
	
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
    <script>
        $(function() { // 검색어 입력 후 Enter 눌렀을 때, 자동으로 버튼 클릭이벤트 발생시키기
            $("#hName").keydown(function(key) {
                if(key.keyCode == 13) {
                	$('#hospitalBtn').trigger('click');
                }
            });
        });
        
		$('#hospitalBtn').click(function(){
			console.log("11");
			var sido = $("select#first").val();
			var gugun = $("select#second").val();
			var medical = $('select#medical').val();
			var hName = $('#hName').val();
			$.ajax({
				url: '<%=request.getContextPath() %>/search.hp',
				type: 'get',
				data: {sido:sido, gugun:gugun, medical: medical, hName: hName},
				success: function(data){
					console.log("ajax success");
					console.log(data);
					$list = $("#listArea tbody");
					$list.html("");
	
					var resultStr="";
					for(var i in data){
						var href = '"<%= request.getContextPath() %>/detail.hp?hpId=' + data[i].hpId + '"';
						resultStr += "<tr onmouseenter=address(this); onclick='location.href=" + href + "';>"
									+ "<th>" + data[i].hpName + "</th>"
									+ "<td>" + data[i].hpPhone +"</td>"
									+ "<td>" + data[i].hpLoc1 + "</td></tr>";
					}
					
					$("#listArea").children("tbody").html(resultStr);
				},
				error: function(data){
					console.log('error');
				}
			});
		});
		
		$(window).click(function(){
			$('#listArea > thead').offset();
		});
	</script>
</body>
</html>