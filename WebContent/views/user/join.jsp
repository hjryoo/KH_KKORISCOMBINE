<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 회원가입</title>
<style>
/* 회원가입 메인 */
div.contents.join {width: 70%; height: 50%; top: calc(50% - 25%);}
div.contents.join > div.join-icon {display: flex; justify-content: center; height: 100%; width: 100%; margin: 0 auto;}
div.contents.join > div.join-icon > a {display: inline-block; font-size: 5em; width: 150px; height: 150px; border: 2px solid #000; border-radius: 75px; margin: 50px;}
div.contents.join > div.join-icon > a > i {display: inline-block; width: 70px; margin-left: 40px; vertical-align: middle;}
div.contents.join > div.join-icon > a:hover {border: 2px solid #fb929e; background: #fb929e; color: #fff; transition: all 0.3s ease-in-out;}
div.contents.join > div.join-icon > a:hover i.fa-user {width: 108px; height: 27px; margin-left: 21px;}
div.contents.join > div.join-icon > a:hover i.fa-hospital {width: 54px; height: 27px; margin-left: 48px;}
div.contents.join > div.join-icon > a:hover i::before {font-size: 27px; font-weight: 600; position: absolute;}
div.contents.join > div.join-icon > a:first-child:hover i::before {content:"일반회원";}
div.contents.join > div.join-icon > a:last-child:hover i::before {content: "병원";}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents join">
			<h2>회원가입</h2>
			<div class="join-icon">
				<a href="joinUser.jsp"><i class="far fa-user"></i></a>
				<a href="joinHospital.jsp"><i class="far fa-hospital"></i></a>
			</div>
		</div>
	</div>
</body>
</html>