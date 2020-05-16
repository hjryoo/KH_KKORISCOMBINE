<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="reservation.model.vo.*, pet.model.vo.*" %>
<% 
	HashMap<String, Object> objMap = (HashMap<String, Object>)request.getAttribute("objMap");
	Reservation rs = (Reservation)objMap.get("rs");
	Hospital hp = (Hospital)objMap.get("hp");
	Pet pet = (Pet)objMap.get("pet");
	HashMap<String, String> cate = (HashMap<String, String>)objMap.get("cate");
	ArrayList<HpMedical> hmList = (ArrayList<HpMedical>)objMap.get("hmList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 예약 변경</title>
<style>
	div.contents {width: 70%; height: 700px; top: calc(50% - 350px); text-align: center;}
	
	div.info {display: inline-block; font-size: 18px; margin-top: 20px;}
	table {width: 100%;}
	td {border: 1px solid #000; padding: 10px 20px; color: #000;}
	tr > td:nth-of-type(1) {width: 25%;}
	tr > td:nth-of-type(2) {text-align: left;}
	table.main tr > td:nth-of-type(1) {background: #ffdfdf;}
	p.title {text-align: left; font-weight: 600; margin-top: 20px;}
	textarea {display: inline; width: 100%; height: 80px; outline: none; resize: none; padding: 5px;}
	
	div.hmCate {width: 50% !important;}
	
	.button-box {display: inline-block; text-align: center; margin: 30px;}
	.button-box > button {width: 100px; height: 30px; cursor: pointer; background: #aedefc; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
	.button-box > button:hover {color: #fff;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents">
			<h2>예약 변경</h2>
			<form action="<%= request.getContextPath() %>/update.rs">
				<div class="info">
					<p class="title">예약 정보</p>
					<input type="hidden" name="rsNum" value="<%= rs.getRsNum() %>">
					<table class="main">
						<tr>
							<td>동물병원</td>
							<td><%= hp.getHpName() %></td>
						</tr>
						<tr>
							<td>예약일시</td>
						<%
							SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy년 MM월 dd일");
							SimpleDateFormat sdf2 = new SimpleDateFormat("HH");
							String date = sdf1.format(rs.getRsDate());
							String time = sdf2.format(rs.getRsDate());
							
							SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
							String rsDate = sdfDate.format(rs.getRsDate());
						%>
							<td>
								<%= date %>
								<input type="hidden" name="rsDate" value="<%= rsDate %>">
								<div class="select-box">
									<select name="rsTime" id="rsTime">
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
							</td>
						</tr>
						<tr>
							<td>진료과목</td>
							<td>
								<div class="select-box hmCate">
									<select name="hmCate" id="hmCate">
									<% for(HpMedical hm : hmList){ %>
										<option value=<%= hm.getHmCate() %>><%= cate.get(hm.getHmCate()) %></option>
									<% } %>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td>예상진료비</td>
							<td id="hmResult"></td>
						</tr>
						<tr>
							<td>반려동물</td>
							<td>
								<div class="select-box">
									<select name="pet" id="pet">
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td>특이사항</td>
							<% if(rs.getRsMemo() != null){ %>
							<td><textarea name="rsMemo" placeholder="특이사항 및 추가 접수내용"><%= rs.getRsMemo() %></textarea></td>
							<% } else{ %>
							<td><textarea name="rsMemo" placeholder="특이사항 및 추가 접수내용"></textarea></td>
							<% } %>
						</tr>
					</table>
					<div class="button-box"><button>변경</button></div>
				</div>
			</form>
		</div>
	</div>
	<script>
		$('select#hmCate').click(function(){
			var cate = $(this).val();
			$.ajax({
				url: '<%= request.getContextPath()%>/searchfee.hp',
				type: 'post',
				data: {hpId: '<%= hp.getHpId() %>', cate: cate},
				success: function(data){
					if(data != null){
						var min = data.hmMin.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						var max = data.hmMax.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						$('td#hmResult').text(min + "원 ~ " + max + "원");
					}
				}
			});
		});
		
		<%
			String dateArr[] = rsDate.split("-"); 
			String year = dateArr[0];
			String month = dateArr[1];
			String day = dateArr[2];
		%>
		var year = '<%= year %>';
		var month = '<%= month %>';
		var day = '<%= day %>';
		
		var submit = false;
		$('form').submit(function(){
			var time = $('select#rsTime').val();
			
			var today = new Date();
			var rsDate = new Date(year+"-"+month+"-"+day + " " + $('select#rsTime').val()+":00:00");
			
			if(!submit){
				if(rsDate - today < 0){
					alert('현재시각 이후 일정으로 예약해주시기 바랍니다.');
					return false;
				} else{
					return true;
				}
			}				
		});
		
		$('select#rsTime').each(function(){ // 해당 날짜에 예약가능한 시간만 선택할 수 있도록 설정
			$(this).val(<%= time %>);
						
			$.ajax({
				url: '<%= request.getContextPath() %>/search.rs',
				type: 'post',
				data: {hpId: '<%= hp.getHpId() %>', year: year, month: month, day: day},
				success: function(data){
					for(var i in data){
						if(data[i] == <%= time %>){
							continue;
						}
						$('select#rsTime').children("[value='" + data[i] + "']").prop('disabled', true);
					}
				}
			});
		});
		
		$('td#hmResult').each(function(){
			$.ajax({
				url: '<%= request.getContextPath()%>/searchfee.hp',
				type: 'post',
				data: {hpId: '<%= hp.getHpId() %>', cate: $('select#hmCate').val()},
				success: function(data){
					if(data != null){
						var min = data.hmMin.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						var max = data.hmMax.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						$('td#hmResult').text(min + "원 ~ " + max + "원");
					}
				}
			});
		});
		
		$('select#pet').each(function(){
			var userId = '<%= loginUser.getUsId() %>';
			$.ajax({
				url: '<%= request.getContextPath() %>/list.pet',
				type: 'post',
				data: {userId: userId},
				success: function(data){
					if(data.length != 0){
						var $select = $('select#pet');
						
						for(var i in data){
							var $option = $('<option>');
							$option.val(data[i].petNum);
							$option.text(data[i].petName);
							$select.append($option);
						}
						
						$('select#pet').val(<%= rs.getPetNum() %>);
						
					} else{
						alert('등록된 반려동물이 없습니다.');
					}
				}
			});
			$(this).val(<%= rs.getPetNum() %>);
		});
			
		$('select#hmCate').each(function(){
			$(this).val('<%= rs.getHmCate() %>');
			
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
	</script>
</body>
</html>