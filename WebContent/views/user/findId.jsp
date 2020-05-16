<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	ArrayList<String> idList = (ArrayList<String>)request.getAttribute("idList");
	String findId = (String)request.getAttribute("findId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 아이디 찾기 완료</title>
<style>
	div.contents {width: 400px; height: 300px; top: calc(50% - 150px);}
	div.userInfo {margin: 10px 0; font-size: 18px; text-align: center;}
	div.userInfo:nth-of-type(1) {margin-top: 20px;}
	div.userInfo > span.data {font-weight: 600; border-bottom: 1px solid #000;}
	div.text-button {text-align: center;}
	div.text-button > a {color: #000; font-size: 14px;}
	div.text-button > a:hover {text-decoration: underline;}
	div.text-button.first {margin-top: 40px;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents">
			<h2>아이디 찾기 완료</h2>
			<% if(idList.size() == 1){ %>
			<div class="userInfo">회원님께서 가입한 아이디는 <span class="data"><%= idList.get(0) %></span>입니다.</div>
			<% } else{ %>
			<div class="userInfo">회원님께서 가입한 아이디 목록입니다.</div>
			<% for(int i = 0; i < idList.size(); i++) {%>
			<div class="userInfo"><span class="data"><%= idList.get(i) %></span></div>
			<% } %>
			<% } %>
			<div class="text-button first"><a href="<%= request.getContextPath() %>/views/user/login.jsp">로그인 하기</a></div>
			<div class="text-button"><a href="<%= request.getContextPath() %>/views/user/searchPwd.jsp">비밀번호 찾기</a></div>
		</div>
	</div>
</body>
</html>