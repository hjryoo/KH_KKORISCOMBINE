<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reservation.model.vo.*" %>
<%
	ReservationInfo ri = (ReservationInfo)request.getAttribute("ri");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시");
	String date = sdf.format(ri.getRsDate());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 예약 완료</title>
<style>
	div.contents {width: 400px; height: 230px; top: calc(50% - 115px);}
	div.rsInfo {margin: 10px 0; font-size: 18px; text-align: center;}
	div.rsInfo > span.data {font-weight: 600; border-bottom: 1px solid #000;}
	div.detailBtn {width: 100px; line-height: 30px; text-align: center; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px; margin: 30px 150px;}
	div.detailBtn:hover {background: #fb929e;}
	div.detailBtn:hover a {color: #fff;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	
	<div class="container">
		<div class="contents">
			<h2>예약 완료</h2>
			<form action="<%= request.getContextPath() %>/select.rs" method="post">
				<input type="hidden" name="rsNum" value=<%= ri.getRsNum() %>>
				<div class="rsInfo"><span class="data"><%= ri.getHpName() %></span></div>
				<div class="rsInfo"><span class="data"><%= date %></span></div>
				<div class="input-submit"><input type="submit" value="예약 상세 조회"></div>
			</form>
		</div>
	</div>
</body>
</html>