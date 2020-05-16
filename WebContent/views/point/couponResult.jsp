<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
	import = "java.util.*, point.model.vo.PtUse"%>
<% 
	ArrayList<PtUse> ptu = (ArrayList<PtUse>)request.getAttribute("ptu");
%>	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 확인창</title>
<style>
	div{border: 3px dashed #ffdfdf; padding: 20px; }
</style>
</head>
<body>
<%@ include file="../common/layout.jsp" %> 
	<form action="<%= request.getContextPath() %>/mail.pt" method="post">
		<div style="text-align:center;">
	
			구매하신 "<%= ptu.get(0).getPtcName() %> 쿠폰" 시리얼 번호입니다.<br><br>
			<input type="hidden" name="cName" value="<%= ptu.get(0).getPtcName() %>">
			<font style="font-weight: 600;"><%= ptu.get(0).getPtcSerial() %></font><br><br>
			*사용시 해당 쿠폰을 제시해주세요.<br><br>
			<input type="hidden" name="coupon" value="<%= ptu.get(0).getPtcSerial() %>">
			쿠폰 번호를 이메일로 전송하기<br><br>
			<input type="submit" value="전송" style="width: 100px; font-size: 15px;">
			
			
		</div>
	</form>
</body>
</html>