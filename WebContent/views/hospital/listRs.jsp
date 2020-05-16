<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.text.SimpleDateFormat"%>
<%@ page import="reservation.model.vo.*" %>
<%
	ArrayList<ReservationInfo> list = (ArrayList<ReservationInfo>)request.getAttribute("riList");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 예약 조회</title>
<style>
	div.contents {width: 50%; text-align: center; padding: 20px 0;}
	div.list {width: 80%; margin: auto; margin-top: 30px; padding: 10px; background: rgba(191, 191, 191, 0.5); border-radius: 15px; cursor: pointer;}
	div.list.on {background: rgba(174, 222, 252, 0.5);}
	div.list > p:nth-of-type(1) {font-size: 18px;font-weight: 600;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents">
			<h2>예약 내역</h2>
		<% if(list.isEmpty()){ %>
			<p>예약 내역이 없습니다.</p>
		<% } else{ %>
		<% for(int i = 0; i < list.size(); i++){ %>
			<form action="<%= request.getContextPath() %>/select.rs" method="post">
			<input type=hidden name="rsNum" value="<%= list.get(i).getRsNum() %>">
			<% if(list.get(i).getRsVisit().equals("W")){ %>
			<div class="list on">
			<% } else{ %>
			<div class="list">
			<% } %>
				<p><%= list.get(i).getHpName() %></p>
				<p><i class="far fa-clock"></i> <%= sdf.format(list.get(i).getRsDate()) %></p>
				<p><i class="fas fa-stethoscope"></i> <%= list.get(i).getHmCate() %></p>
				<p><i class="fas fa-paw"></i> <%= list.get(i).getPetName() %></p>
			</div></form>
		<%
			}
		}
		%>
		</div>
	</div>
	<script>
		$('div.list').click(function(){
			<%-- var rsNum = $(this).attr('id');
			$.ajax({
				url: '<%= request.getContextPath() %>/select.rs',
				type: 'post',
				data: {rsNum: rsNum},
				success: function(data){
					
				},
				complete: function(data){
					console.log('com');
				}
			}); --%>
			$(this).parent('form').submit();
		});
	</script>
</body>
</html>