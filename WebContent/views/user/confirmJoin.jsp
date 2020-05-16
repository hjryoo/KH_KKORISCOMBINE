<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User)request.getAttribute("user");
	Hospital hp = (Hospital)request.getAttribute("hp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 회원가입 완료</title>
<style>
	div.contents {width: 400px; height: 300px; top: calc(50% - 150px);}
	div.userInfo {margin: 10px 0; font-size: 18px; text-align: center;}
	div.userInfo > span.data {font-weight: 600; border-bottom: 1px solid #000;}
	div.loginBtn {width: 100px; line-height: 30px; text-align: center; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px; margin: 30px 150px;}
	div.loginBtn:hover {background: #fb929e;}
	div.loginBtn:hover a {color: #fff;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	
	<div class="container">
		<div class="contents">
			<h2>회원가입 완료</h2>
			<% if(user != null){ %>
			<div class="userInfo"><span>아이디: </span><span class="data"><%= user.getUsId() %></span></div>
			<div class="userInfo"><span>이름: </span><span class="data"><%= user.getUsName() %></span></div>
			<div class="userInfo"><span>이메일: </span><span class="data"><%= user.getUsEmail() %></span></div>
			<% } else{ %>
			<div class="userInfo"><span>아이디: </span><span class="data"><%= hp.getHpId() %></span></div>
			<div class="userInfo"><span>이름: </span><span class="data"><%= hp.getHpName() %></span></div>
			<div class="userInfo"><span>이메일: </span><span class="data"><%= hp.getHpEmail() %></span></div>
			<% } %>
			<div class="loginBtn"><a href="<%= request.getContextPath() %>/views/user/login.jsp">로그인하기</a></div>
		</div>
	</div>
</body>
</html>