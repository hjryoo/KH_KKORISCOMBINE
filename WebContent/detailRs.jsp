<%@page import="java.text.SimpleDateFormat, java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reservation.model.vo.*, pet.model.vo.*" %>
<%
	//Reservation rs = (Reservation)request.getAttribute("reservation");
	//Hospital hp = (Hospital)request.getAttribute("hp");
	//Pet pet = (Pet)request.getAttribute("pet");
	//HashMap<String, String> cate = (HashMap<String, String>)request.getAttribute("cateMap");
	HashMap<String, Object> objMap = (HashMap<String, Object>)request.getAttribute("objMap");
	Reservation rs = (Reservation)objMap.get("rs");
	Hospital hp = (Hospital)objMap.get("hp");
	Pet pet = (Pet)objMap.get("pet");
	HashMap<String, String> cate = (HashMap<String, String>)objMap.get("cate");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 예약 상세 조회</title>
<style>
	div.contents {width: 70%; height: 700px; top: calc(50% - 350px); text-align: center;}
	h3.on {color: green;}
	h3.ok {color: #fb929e;}
	h3.no {color: #bfbfbf;}
	
	div.info {display: inline-block; font-size: 18px; margin-top: 20px;}
	table {width: 100%;}
	td {border: 1px solid #000; padding: 5px 20px; color: #000;}
	tr > td:nth-of-type(1) {width: 25%;}
	tr > td:nth-of-type(2) {text-align: left;}
	table.main tr > td:nth-of-type(1) {background: #ffdfdf;}
	p.title {text-align: left; font-weight: 600; margin-top: 20px;}
	
	.button-box {display: inline-block; text-align: center; margin: 30px;}
	.button-box > button {width: 100px; height: 30px; cursor: pointer; background: #aedefc; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
	.button-box > button:hover {color: #fff;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents">
			<h2>예약 상세 조회</h2>
			<form action="<%= request.getContextPath() %>/select.rs" method="post">
				<% if(rs.getRsDel().equals("Y")){ %>
				<h3 class="no"><i class="fas fa-times"></i> 예약취소</h3>
				<% } else{ %>
					<% if(rs.getRsVisit().equals("W")){ %>
					<h3 class="on"><i class="fas fa-circle"></i> 예약중</h3>
					<% } else if(rs.getRsVisit().equals("Y")){ %>
					<h3 class="ok"><i class="fas fa-circle"></i> 진료완료</h3>
					<% } else{ %>
					<h3 class="no"><i class="fas fa-times"></i> 미방문</h3>
					<% } %>
				<% } %>
				<div class="info">
					<p class="title">예약 정보</p>
					<table class="main">
						<tr>
							<td>동물병원</td>
							<td><%= hp.getHpName() %></td>
						</tr>
						<tr>
							<td>예약일시</td>
						<%
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
							String date = sdf.format(rs.getRsDate());
						%>
							<td><%= date %></td>
						</tr>
						<tr>
							<td>진료과목</td>
							<td><%= cate.get(rs.getHmCate()) %></td>
						</tr>
						<tr>
							<td>예상진료비</td>
							<td id="hmResult"></td>
						</tr>
						<tr>
							<td>반려동물</td>
							<td><%= pet.getPetName() %></td>
						</tr>
						<tr>
							<td>특이사항</td>
							<% if(rs.getRsMemo() != null){ %>
							<td><%= rs.getRsMemo() %></td>
							<% } else{ %>
							<td>없음</td>
							<% } %>
						</tr>
					</table>
					<p class="title">병원 정보</p>
					<table class="hp">
						<tr>
							<td>위치</td>
							<% if(hp.getHpLoc2() == null){ %>
							<td>[<%= hp.getHpZip() %>] <%= hp.getHpLoc1() %></td>
							<% } else{ %>
							<td>[<%= hp.getHpZip() %>] <%= hp.getHpLoc1() %> <%= hp.getHpLoc2() %></td>
							<% } %>
						</tr>
						<tr>
							<td>연락처</td>
							<td><%= hp.getHpPhone() %></td>
						</tr>
						<%
							String start = hp.getHpStart() + ":00";
							String end = hp.getHpEnd() + ":00";
							String lunch = hp.getHpLunch() + ":00";
							
							if(hp.getHpStart() < 12 || hp.getHpStart() == 24){
								start = "AM " + start;
							} else{
								start = "PM " + start;
							}
							
							if(hp.getHpEnd() < 12 || hp.getHpEnd() == 24){
								end = "AM " + end;
							} else{
								end = "PM " + end;
							}
							
							if(hp.getHpLunch() < 12 || hp.getHpLunch() == 24){
								lunch = "AM " + lunch;
							} else{
								lunch = "PM " + lunch;
							}
						%>
						<tr>
							<td>진료시간</td>
							<td><%= start %> ~ <%= end %></td>
						</tr>
						<tr>
							<td>점심시간</td>
							<td><%= lunch %></td>
						</tr>
					</table>
					<% if(rs.getRsVisit().equals("W")){ %>
					<div class="button-box"><button id="cancelBtn">예약 취소</button></div>
					<input type="hidden" name="rsNum" value="<%= rs.getRsNum() %>">
					<input type="hidden" name="update" value="update">
					<div class="button-box"><button id="updateBtn">예약 변경</button></div>
					<!-- <div class="input-submit"><input type="submit" value="예약 변경"></div> -->
					<% } else if(rs.getRsVisit().equals("Y")) {%>
					<input type="hidden" name="hpName" value="<%= hp.getHpName() %>">
					<input type="hidden" name="rsDate" value="<%= rs.getRsDate() %>">	
					<div class="button-box"><button id="writeBtn" onclick="href.location='<%= request.getContextPath() %>/views/rvBoard/rvBoardWrite.jsp?hpName=<%= hp.getHpName() %>&rsDate=<%= rs.getRsDate() %>'">후기 작성</button></div>											
					<% } else { %>
					<div class="button-box"><button id="listBtn">목록으로</button></div>					
					<% } %>
				</div>
			</form>
		</div>
	</div>
	<script>
		$('td#hmResult').each(function(){
			$.ajax({
				url: '<%= request.getContextPath()%>/searchfee.hp',
				type: 'post',
				data: {hpId: '<%= hp.getHpId() %>', cate: '<%= rs.getHmCate() %>'},
				success: function(data){
					if(data != null){
						var min = data.hmMin.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						var max = data.hmMax.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						$('td#hmResult').text(min + "원 ~ " + max + "원");
					}
				}
			});
		});
		
		$('#cancelBtn').click(function(){
			var ok = confirm('정말 예약을 취소하시겠습니까?');
			if(ok){
				$.ajax({
					url: '<%= request.getContextPath()%>/cancel.rs',
					type: 'post',
					data: {rsNum: <%= rs.getRsNum() %>},
					success: function(data){
						if(data == 'success'){
							alert('예약이 취소되었습니다.');
							location.href="<%= request.getContextPath() %>/list.rs";
						} else{
							alert('예약 취소에 실패했습니다.');
						}
					},
					error: function(data){
						console.log('error');
					}
				});
			} else{
				$('form').submit(false);
			}
		});
		
		$('#listBtn').click(function(){
			$('form').submit(false);
			location.href='<%= request.getContextPath() %>/list.rs';
		});
	</script>
</body>
</html>