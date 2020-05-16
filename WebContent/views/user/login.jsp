<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 로그인</title>
<style>
/* 로그인 */
div.contents.login {width: 50%; max-width: 400px; height: 400px; top: calc(50% - 200px);}
form#login > #loginBtn {width: 30%; margin-top: 20px; margin-left: 35%;}
div.contents.login > div.text-button {text-align: center;}
div.contents.login > div.text-button:nth-of-type(1) {margin-top: 30px;}
div.contents.login > div.text-button > a {color: #000; font-size: 14px;}
div.contents.login > div.text-button > a:hover {text-decoration: underline;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents login">
			<h2>로그인</h2>
			<form action="<%= request.getContextPath() %>/login.au" method="post" id="login" name="userLogin">
					<div class="input-container"><label class="input-label">아이디</label><input type="text" name="userId" id="userId"></div>
					<div class="input-container"><label class="input-label">비밀번호</label><input type="password" name="userPwd" id="userPwd"></div>
					<input type="submit" id="loginBtn" value="접속">
			</form>
			<div class="text-button"><a href="searchId.jsp">아이디 찾기</a></div>
			<div class="text-button"><a href="searchPwd.jsp">비밀번호 찾기</a></div>
		</div>
	</div>
	<script src="<%= request.getContextPath() %>/js/common.js"></script>
</body>
</html>