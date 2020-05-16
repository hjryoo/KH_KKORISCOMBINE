<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%

 	String year = null;
 	String month = null;
 	String day = "01";

 	Calendar cal = Calendar.getInstance();
 	java.text.DateFormat df = null;

	 if ((year = request.getParameter("year")) == null){
		 df = new SimpleDateFormat("yyyy");
 		 year = df.format(cal.getTime());
	 }

	 if ((month = request.getParameter("month")) == null){
  		df = new SimpleDateFormat("MM");
 		 month = df.format(cal.getTime());
	 }

 	df = new SimpleDateFormat("yyyyMM");
 
	if (df.format(cal.getTime()).equals(year + month)){
 		df = new SimpleDateFormat("dd");
 		day = df.format(cal.getTime());
	}
	
	String url = request.getContextPath() + "/detail.hp?hpId=" + request.getParameter("hpId");
	String prev = null;
	String next = null;
	
 	if (Integer.parseInt(month) == 1){
  		prev = url + "&year=" + (Integer.parseInt(year) - 1) + "&month=12";
 	} else{
  		String prevMonth = "0" + (Integer.parseInt(month) - 1);
  
		if (prevMonth.length() == 3){
 			prevMonth = prevMonth.substring(1);
		}
  		prev = url + "&year=" + year + "&month=" + prevMonth;
 	}

 	if (Integer.parseInt(month) == 12){
  		next = url + "&year=" + (Integer.parseInt(year) + 1) + "&month=01";
 	} else {
  		String nextMonth = "0" + (Integer.parseInt(month) + 1);
  		if (nextMonth.length() == 3){
   			nextMonth = nextMonth.substring(1);
  		}
  		next = url + "&year=" + year + "&month=" + nextMonth;
 	}
%>
<%
	Hospital hp = (Hospital)request.getAttribute("hp");
	ArrayList<HpMedical> hmList = (ArrayList<HpMedical>)request.getAttribute("hmList");
	HashMap<String, String> cateMap = (HashMap<String, String>)request.getAttribute("cateMap");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 병원 예약</title>
<style>
	div.contents {width: 100%; height: 100%;}
	
	div.hpInfo, form#rsForm {position: relative; width: 100%; padding: 0 2%; height: 400px; margin-top: 30px;}
	form#rsForm {height: 300px;}
	div.hpInfo > div, form#rsForm > div {display:inline-block; width: 45%; height: 100%; vertical-align: middle; margin: 0 2%;}
	div.hpInfo > div.left.border > p {margin-top: 164px;}
	div.hpInfo > div.hpImg > img {width: 100%;}
	div.hpInfo > div.right > div.right-contents > p {font-size: 18px; margin-bottom: 10px;}
	div.hpInfo > div.right > div.right-contents > p.hpName {font-size: 24px; font-weight: 600; margin-bottom: 30px;}
	div.hpInfo > div.right > div.right-contents > p.hpIntro {font-size: 16px; margin-top: 10px; border-top: 1px solid #dfdfdf; border-bottom: 1px solid #dfdfdf; padding: 10px 0;}
	p {text-align: center; color: #000;}
	p.comment {font-size: 14px;}
	span > span {font-size: 14px; display: inline;}
	.border {border: 1px solid #000;}
	
	form#rsForm > div.left > div.select-box {margin-bottom: 20px;}
	span {display: block; font-size: 18px;}
	form#rsForm > div.left > div {display: inline-block; width: 45%; height: 100%; margin: 0 1%; vertical-align: middle;}
	form#rsForm > div.left > div.calendar {height: 200px; overflow: hidden;}
	form#rsForm > div.left > div.rsInfo {padding: 50px 20px 0 20px;}
	form#rsForm > div.left > div.rsInfo > div.select-box {width: 80%;}
	form#rsForm > div.left > div.rsInfo > div.hmFee {margin-top: 10px;}
	form#rsForm > div.left > div.rsInfo > div.hmFee > span {font-size: 22px; font-weight: 600; text-align: center;}
	form#rsForm > div.right > div.petInfo {padding: 10px 0; height: 70px;}
	form#rsForm > div.right > div.petInfo > span {display: inline-block; width: 49%; font-size: 16px;}
	textarea {display: inline; width: 100%; height: 80px; font-size: 16px; outline: none; resize: none; padding: 5px;}
	select#rsTime > option:disabled {color: #dfdfdf;}
	
	/* 캘린더 */
	table {border: 0; color: #000;}
	table.cal {width: 100%;}
	table.inner {width: 100%;}
	table.inner td {font-size: 20; font-weight: 600;}
	td {vertical-align: middle;}
	table.date td > p {text-align: center; font-size: 16px; font-weight: 600; margin: 0;}
	table.date tr:not(:nth-of-type(1)) > td > p {cursor: pointer;}
	.day {font-weight: 600;}
	.red {color: #ff4848}
	.blue {color: #0042ed}
	.black {color: #000}
	.onclick {background: #aedefc}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents">
			<h2>병원 예약</h2>
			<div class="hpInfo">
				<% if(hp.getHpPhoto() == null){ %>
				<div class="left border"><p>등록된 사진이 없습니다.</p></div>
				<% } else{%>
				<div class="left hpImg" style="text-align: center;"><img style="height: 400px; width: auto;"  src="<%=request.getContextPath() %>/thumbnail_uploadFiles/<%= hp.getHpPhoto()%>"></div>
				<% } %>
				<div class="right">
				<div class="right-contents">
					<p class="hpName"><%= hp.getHpName() %></p>
					<% if(hp.getHpLoc2() != null){ %>
					<p>[<%= hp.getHpZip() %>] <%= hp.getHpLoc1() %> <%=hp.getHpLoc2() %></p>
					<% } else{ %>
					<p>[<%= hp.getHpZip() %>] <%= hp.getHpLoc1() %></p>
					<% } %>
					<p><i class="fas fa-phone-alt"></i> <%= hp.getHpPhone() %></p>
					<p>
						진료시간: <%= hp.getHpStart() %>:00 ~ <%= hp.getHpEnd() %>:00
						<% if(hp.getHpLunch() != 404){ %>
						<br>점심시간: <%= hp.getHpLunch() %>:00 ~ <%= hp.getHpLunch()+1 %>:00
						<% } %>
					</p>
					<% if(hp.getHpIntro() != null){ %>
					<p class="hpIntro"><%= hp.getHpIntro() %></p>
					<% } %>
				</div>
				</div>
			</div>
			<form action="<%= request.getContextPath() %>/complete.rs" method="post" name="rsForm" id="rsForm">
				<input type="hidden" name="hpId" value="<%= hp.getHpId() %>">
				<div class="left">
					<div class="calendar">
						<table class="cal header"> <!-- 캘린더 헤더 -->
					 		<tr>
					  			<td>
							 		<table class="inner">
							    		<tr>
							     			<td align=center valign=middle height=25>
							      				<a href=<%=prev%>><b class="prev">&lt;</b></a>
							     				<b><%=year%> <%=month%></b>
							      				<a href=<%=next%>><b class="next">&gt;</b></a>
							     			</td>
							    		</tr>
							   		</table>
					 	 		</td>
					 		</tr>
						</table>
						<table class="cal date">
							<tr align=center>
								<td width=40 class="day red">Sun</td>
								<td width=40 class="day">Mon</td>
								<td width=40 class="day">Tue</td>
								<td width=40 class="day">Wed</td>
								<td width=40 class="day">Thu</td>
								<td width=40 class="day">Fri</td>
								<td width=40 class="day blue">Sat</td>
							</tr>
						
						<%
							cal.set(Integer.parseInt(year), Integer.parseInt(month) - 1 , 1);
							int indent = cal.get(Calendar.DAY_OF_WEEK);
							cal.add(Calendar.MONTH, 1);
						 	cal.add(Calendar.DATE, -1);
						 	int numberOfDays = cal.get(Calendar.DATE);
						
						 	for (int i = 1; i < indent; i++){
						  		if (i == 1){
						   			out.println("<tr valign='top' height='30'>");
						  		}
						  		out.println("<td width='30'></td>");
						 	}	
						
						 	Calendar today = Calendar.getInstance();
						 	df = new SimpleDateFormat("yyyyMMdd");
						 
						 	for (int i = 1; i <= numberOfDays; i++){
						  		String cssClass = "black";
						  		String dayDescript = "";
						 		day = "0" + i;
						
						  		if (day.length() == 3){
						   			day = day.substring(1);
						  		}
						
						  		if (((indent + i) - 1) % 7 == 1){  // 일요일
						   			out.println("<tr valign='top' height='30'>");
						   			cssClass = "red";
						  		}
						  		else if (((indent + i) - 1) % 7 == 0){
						   			cssClass = "blue";
						  		}
						
						  		if (df.format(today.getTime()).equals(year + month + day)){
						   			out.println("<td width='30' class='onclick'>");
						  		} else {
						   			out.println("<td width='30'>");
						  		}
						
						  		out.println("<p class=" + cssClass + ">" + i + "</p>");
						  		out.println(dayDescript);
						  		out.println("</td>");
						  
						  		if (((indent + i) - 1) % 7 == 0){
						   			out.println("</tr>"); //토요일
						  		}
						 	}
						
						
						 	if(((indent == 6) && (numberOfDays > 30) ) || ( (indent == 7) && (numberOfDays > 29) ) ){
						  		if (41-numberOfDays-indent > 0){
						   			for (int i = 43 - numberOfDays - indent; i > 0; i--){
						    			out.println("<td> </td>");
						   			}
						  		}
						  		out.println("</tr>");
						 	} else if ( (numberOfDays != 28) || (indent > 1) ){
						  		if (36-numberOfDays-indent > 0){
						   			for (int i = 36 - numberOfDays - indent; i > 0; i--){
						    			out.println("<td> </td>");
						   			}
						  		}
						  		out.println("</tr>");
						 	}
						%>
						</table>
					</div>
					<div class="rsInfo" id="rsInfo">
						<span>내원 시간</span>
						<div class="select-box">
							<select name="rsTime" id="rsTime">
								<option value=404>선택해주세요</option>
							<%
								int start = hp.getHpStart();
								int end = hp.getHpEnd() - 1; // 진료종료시간에 예약할 수 없으니 -1
								int lunch = hp.getHpLunch();
								
								if(start > end){
									end = 24;
								}
							%>
							<% for(int i = start; i <= end; i++){ %>
								<% if(lunch == i) continue; %>
								<% if(i < 10){ %>
								<option value=<%= i %>>0<%= i %>:00</option>
								<% } else{ %>
								<option value=<%= i %>><%= i %>:00</option>
								<% } %>
							<% } %>
							</select>
						</div>
						<span>진료 내용</span>
						<div class="select-box">
							<select name="hmCate" id="hmCate">
								<option value=404>선택해주세요</option>
							<% for(HpMedical hm : hmList){ %>
								<option value=<%= hm.getHmCate() %>><%= cateMap.get(hm.getHmCate()) %></option>
							<% } %>
							</select>
						</div>
						<div class="hmFee">
							<span id="title"></span>
							<span id="hmResult"></span>
							<p class="comment" id="comment"></p>
						</div>
					</div>
				</div>
				<div class="right">
					<span>진료 받을 반려동물 <span> (등록되어있는 프로필 정보가 그대로 병원에 접수됩니다.)</span></span>
					<div class="select-box">
						<select name="pet" id="pet">
						<% if(loginUser != null){ %>
							<option value=404>선택해주세요</option>
						<% } else{ %>
							<option value=500>로그인 후 이용 가능합니다</option>
						<% } %>
						</select>
					</div>
					<div class="petInfo">
						<span id="petName"></span>
						<span id="petGender"></span>
						<span id="petSpec"></span>
						<span id="petWeight"></span>
					</div>
					<span>특이사항</span>
					<textarea name="rsMemo" placeholder="특이사항 및 추가 접수내용이 있을 경우 작성해주세요"></textarea>
					<div class="input-submit"><input type="submit" value="예약하기"></div>
				</div>
			</form>
		</div>
	</div>
	<script>
		$(function(){
			var hpId = '<%= hp.getHpId() %>';
			
			var year = <%= year %>;
			var month = <%= month %>;
			if(month < 10)
				month = "0" + month;
			var day = $('table.date tr').find('td.onclick').children('p').text();
			
			$('div.right-contents').each(function(){ // 병원정보영역 수직중앙으로 위치 조정
				var marginTop = 200 - $(this).height()/2;
				$(this).css('margin-top', marginTop);
			});
			
			$('table.date tr:not(:nth-of-type(1)) > td').click(function(){ // 날짜 선택
				$('table.date td').removeClass('onclick');
				$(this).addClass('onclick');
			});
			
			$('select#rsTime').click(function(){ // 해당 날짜에 예약가능한 시간만 선택할 수 있도록 설정
				var day = $('table.date tr').find('td.onclick').children('p').text();
				if(day < 10)
					day = "0" + day;
				$(this).find('option').prop('disabled', false); // 초기화
				
				$.ajax({
					url: '<%= request.getContextPath() %>/search.rs',
					type: 'post',
					data: {hpId: hpId, year: year, month: month, day: day},
					success: function(data){
						for(var i in data){
							$('select#rsTime').children("[value='" + data[i] + "']").prop('disabled', true);
							//$('select#rsTime').val(data[i]); // option의 index를 가져오기 위한 일시적 selected
							//var idx = $('select#rsTime option').index($('select#rsTime option:selected'));
							//$('select#rsTime option:eq(' + idx + ')').prop('disabled', true);
						}
						
						//$('select#rsTime').val('404');
					}
				});
			});
			
			$('select#hmCate').click(function(){
				var cate = $(this).val();
				$.ajax({
					url: '<%= request.getContextPath()%>/searchfee.hp',
					type: 'post',
					data: {hpId: hpId, cate: cate},
					success: function(data){
						if(data != null){
							var min = data.hmMin.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
							var max = data.hmMax.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
							$('span#title').text('예상진료비');
							$('span#hmResult').text(min + "원 ~ " + max + "원");
							$('p#comment').text('* 진료내용에 따라 추가비용이 발생할 수 있습니다.');
						} else{
							$('span#title').text('');
							$('span#hmResult').text('');
							$('p#comment').text('');
						}
					}
				});
			});
			
			<% if(loginUser != null){ %> // 일반 회원으로 로그인 했을 경우에만 실행
			
			var petList = null;
			
			$('select#pet').each(function(){
				var userId = '<%= loginUser.getUsId() %>';
				$.ajax({
					url: '<%= request.getContextPath() %>/list.pet',
					type: 'post',
					data: {userId: userId},
					success: function(data){
						petList = data;
						if(data.length != 0){
							var $select = $('select#pet');
							
							for(var i in data){
								var $option = $('<option>');
								$option.val(data[i].petNum);
								$option.text(data[i].petName);
								$select.append($option);
							}
						} else{
							alert('등록된 반려동물이 없습니다. 등록 후 이용해주세요.');
						}
					}
				});
			});
			
			$('select#pet').click(function(){
				var petNum = $(this).val();
				var idx = 0;
				if(petNum != 404){
					for(var i in petList){
						if(petNum == petList[i].petNum){
							idx = i;
							break;
						}
					}
					
					var petGender = petList[idx].petGender;
					if(petGender == 'M'){
						petGender = '♂';
					} else{
						petGender = '♀';
					}
					$('span#petName').text('이름 : ' + petList[idx].petName);
					$('span#petGender').text('성별 : ' + petGender);
					$('span#petSpec').text('품종 : ' + petList[idx].petSpec);
					$('span#petWeight').text('몸무게 : ' + petList[idx].petWeight + 'kg');
				} else{
					$('span#petName').text('');
					$('span#petGender').text('');
					$('span#petSpec').text('');
					$('span#petWeight').text('');
				}
			});
			<% } %>
			
			$('form > div.left').click(function(){ // 날짜 변경 시 input값 변경
				var day = $('table.date tr').find('td.onclick').children('p').text();
				if(day < 10){
					day = "0" + day;
				}
				var date = year + "-" + month + "-" + day;
				$('input[name=rsDate]').val(date);
			});
			
			$('form > div.left').each(function(){ // 오늘 날짜 로드되면서 대입
				var date = year + "-" + month + "-" + day;
				var $input = $('<input type="hidden" name="rsDate">');
				$input.val(date);
				$(this).before($input);
			});
			
			var submit = false;
			$('form').submit(function(){
				var time = $('select#rsTime').val();
				var cate = $('select#hmCate').val();
				var pet = $('select#pet').val();
				
				var day = $('table.date tr').find('td.onclick').children('p').text();
				if(day < 10)
					day = "0" + day;
				var today = new Date();
				var rsDate = new Date(year+"-"+month+"-"+day + " " + $('select#rsTime').val()+":00:00");
				
				if(!submit){
					if(time == 404){
						alert('내원 시간을 선택해주세요.');
					} else if(cate == 404){
						alert('진료 과목을 선택해주세요.');
					} else if(pet == 404){
						alert('진료 받을 반려동물을 선택해주세요.');
					} else if(rsDate - today < 0){
						alert('현재시각 이후 일정으로 예약해주시기 바랍니다.');
					} else if(<%= loginUser == null %>){
						alert('일반회원이 아니면 예약이 불가합니다.');
					} else{
						return true;
					}
					return false;
				}
			});
			
			$('select#hmCate').each(function(){
				$option1 = $('<option>');
				$option1.prop('disabled', true).text('--진료과목--');
				$option2 = $('<option>');
				$option2.prop('disabled', true).text('--검사--');
				$option3 = $('<option>');
				$option3.prop('disabled', true).text('--건강검진--');
				$option4 = $('<option>');
				$option4.prop('disabled', true).text('--예방접종--');
				$option5 = $('<option>');
				$option5.prop('disabled', true).text('--중성화수술--');
				
				var opList = $(this).children('option');
				for(var i in opList){
					var value = opList.eq(i).val();
 					if(value.includes('HC')){
 						opList.eq(i).before().before($option1);
 						$option1 = null;
					} else if(value.includes('HI')){
						opList.eq(i).before().before($option2);
 						$option2 = null;
					} else if(value.includes('HS')){
						opList.eq(i).before().before($option3);
 						$option3 = null;
					} else if(value.includes('HV')){
						opList.eq(i).before().before($option4);
 						$option4 = null;
					} else if(value.includes('HZ')){
						opList.eq(i).before().before($option5);
 						$option5 = null;
 						break;
					}
 				}
			});
		});
	</script>
</body>
</html>