<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="allUser.model.vo.*, user.model.vo.*, hospital.model.vo.*" %>
<%
	AllUser loginAu = (AllUser)session.getAttribute("loginAu");
	User loginUser = (User)session.getAttribute("loginUser");
	Hospital loginHp = (Hospital)session.getAttribute("loginHp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 KKORISCOMBINE</title>
<script src="https://kit.fontawesome.com/a65bb113b4.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<%-- <link rel="stylesheet" type="text/html" href="<%= request.getContextPath() %>/css/layout.css"/> --%>
<style>
* {margin: 0; padding: 0; font-family: 'Noto Sans KR', sans-serif;}
*, *:before, *:after {box-sizing: border-box;}
html, body {width: 100%; height: 100%;}
table{border-collapse: collapse;}
img,fieldset{border: none;}
ol,ul{list-style: none;}
q:after,q:before{content: "";}
abbr,acronym{border:none;} /* 축약어 */
img,input,select{vertical-align: middle;}
hr{display: none;}
a {text-decoration: none; color: #000;}
header {position: fixed; width: 200px; height: 100%; background: #ffdfdf; z-index: 30;}
input, button {outline: none; background: none;}
button {cursor: pointer;}
input::placeholder {font-size: 14px; color: #5d5d5d; background: none;}
.blind{position: absolute;left: 0;top: 0;width: 0;height: 0;font-size: 0;line-height: 0;text-indent: -9999px;overflow: hidden;visibility: hidden;}
.displaynone{display: none;}

/* input타입 1 (커서유입에 따른 스타일 변화)
	<div class="input-container"><label class="input-label">아이디</label><input type=""></div>
*/
div.input-container {position: relative; display: block; margin: 20px 0;}
div.input-container > input {width: 100%; height: 40px; line-height: 40px; font-size: 16px; border: none; border-bottom: 1px solid #5d5d5d;}
div.input-container.focus > input:focus {border-bottom: 1px solid #fb929e;}
label.input-label {position: absolute; font-size: 16px; transform: translateY(10px); color: #5d5d5d; transition: transform 0.2s ease; z-index: -1;}
div.input-container.focus > label.input-label {font-size: 12px; transform: translateY(-5px); text-transform: uppercase;}
div.input-container.focus.on > label.input-label {color: #fb929e;}

/* input타입 2 (박스형)
	<div class="input-box"><p class="input-label">라벨명</p><input type=""></div>
*/
div.input-box {position: relative; display: block; margin: 20px 0;}
div.input-box > input {width: 100%; padding: 10px; font-size: 16px; border: 1px solid #000;}
p.input-label {font-size: 16px; color: #000;}
p.input-info {font-size: 14px; color: #5d5d5d;}

/* input radio
	<input type="radio" name="test"><label class="radioLabel">라벨명1</label>
	<input type="radio" name="test"><label class="radioLabel">라벨명2</label>
*/
input[type=radio] {display: none;}
label.radioLabel {display: inline-block; position: relative; padding: 0 30px; cursor: pointer; line-height: 18px;}
label.radioLabel:before, label.radioLabel:after {position: absolute; border-radius: 50%; content: '';}
label.radioLabel:before {left: 0; top: 0; width: 18px; height: 18px; border: 2px solid #000;}
label.radioLabel:after {top: 5px; left: 5px; width: 8px; height: 8px; background: #fb929e; transform: scale(0);}
input[type="radio"]:checked + label.radioLabel:before {border-color: #fb929e; }
input[type="radio"]:checked + label.radioLabel:after {transform: scale(1);}

/* input submit 
	<form>에서 submit되는 버튼을 위한 css (단, 검색 등의 다른 버튼은 blue베이스 스타일로 사용)
*/
div.input-submit {display: block; text-align: center; padding: 15px;}
input[type="submit"] {width: 30%; min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
input[type="submit"]:hover {background: #fb929e; color: #fff;}

/* select-box */
div.select-box {position: relative; width: 30%; max-width: 200px; display: inline-block;}
div.select-box::before, div.select-box::after {content: ''; display: block; width: 7px; height: 1px; background: #5d5d5d; position: absolute; top: 50%; right: 15px; -webkit-transform: rotate(45deg); transform: rotate(45deg); -webkit-transition: transform .3s ease-out; transition: transform .3s ease-out;}
div.select-box::after {right: 10px; -webkit-transform: rotate(-45deg); transform: rotate(-45deg);}
div.select-box > select {width: 100%; padding: .7em .5em; font-size: 14px; background: none; outline: none; -webkit-appearance: none; -moz-appearance: none; appearance: none; cursor: pointer; border:1px solid #5d5d5d;}

/* input 검색 (class="search_input") */
div > span > input.search_input{width: 250px;  padding: 12px 24px; font-size: 14px; line-height: 18px; color: #575756; background-size: 18px 18px; border-radius: 50px; border: 1px solid #5d5d5d; backface-visibility: hidden; right:20px; outline:none;}


input[type=submit].center {margin: 0 35%;}
.border-red {border-color: #f00 !important;}
.color-red {color: #f00 !important;}


/* 영역
	<div class="container">		// 아래css 외에 특정 스타일을 주어야할 때, 클래스를 추가로 부여하여 사용했음 (ex. class="container login")
		<div class="contents">
			구현 영역
		</div>
	</div>
*/
div.container {position: absolute; top:0; left:0; padding-left: 200px; width: 100%; height: 100%; margin: 0 auto; box-sizing: border-box;}
div.contents {position:relative; margin: 0 auto;}
div.contents > h2 {font-weight: 700; font-size: 30px; color: #000; padding: 15px 0; text-align: center;}


/** 헤더 **/
h1.logo {
	text-indent: -9999px; overflow: hidden; width: 180px; height: 180px;
	margin: 10px auto; /* auto는 중앙에 놓음 */ 
	background: url(<%= request.getContextPath() %>/images/logo.png) no-repeat; background-size: contain; /*contain = h1 사이즈에 맞춤*/
}
 
nav > div.login {display: flex; justify-content:space-around; font-size: 15px;}
				/*블락요소로 가로 정렬 함*/
nav > div.login > div {width: 75px; height: 30px;} /* 위 아래 마진, 좌 우 마진*/
nav > div.login > div > a {display: block; width: 100%; height: 100%; line-height: 30px; text-align: center; border: 1px solid #5d5d5d; border-radius: 5px;}
nav > div.login > div > a:hover {color: #fb929e; border: none; background: #fff6f6; font-weight: 600}

nav > div.loginOk {text-align: center;}
nav > div.loginOk > div.loginName {color: #000; font-size: 18px; font-weight: 600; margin: 5px 0;}
nav > div.loginOk > div.logoutBtn {margin: 0 30%;}
nav > div.loginOk > div > a {display: block; width: 100%; height: 100%; line-height: 25px; text-align: center; font-size: 14px; border: 1px solid #5d5d5d; border-radius: 5px;}
nav > div.loginOk > div > a:hover {font-size: 14px; color: #fb929e; border: none; background: #fff6f6; font-weight: 600; border: 1px solid #fff6f6;}


/* 메뉴 */
nav {margin-top: 20px;}
nav * {color: #5d5d5d;}
nav > ul {margin-top: 30px; text-align: center;}
nav > ul > li {width: 100%;}
nav > ul > li:hover {background: #fff6f6;}
nav > ul > li span {display:block; width: 100%; height: 100%; line-height: 50px; font-size: 18px; font-weight: 600; border-radius: 10px; cursor: pointer;}
nav > ul > li span:hover {color: #fb929e;}

nav > ul > li > ul[class^=nav2] {display: none;}
nav > ul > li > ul[class^=nav2] > li > a {display: block; line-height: 40px; font-size: 16px;}
nav > ul > li > ul[class^=nav2] > li > a:hover {color: #fb929e; font-weight: 600;}

nav > ul > li:hover > ul[class^=nav2] {display: block;}

/* sns */
nav > dl {position:absolute; bottom:50px; width:100%; height:50px; display:flex; justify-content:space-around;}
nav > dl > dd {width:50px; text-align:center;}
nav > dl > dd > a {display: block; width: 100%; height:100%; font-size:20px; line-height:50px; transition:all 0.2s ease 0s;}
nav > dl > dd > a:hover {font-size:25px;}

footer {position: fixed; bottom: 10px;}
</style>
</head>
<body>
	<header><!-- 헤더 -->
		<h1 class="logo"></h1>
		<nav>
			<% if(loginAu == null){ %>
      		<div class="login">
	        	<div><a href="<%= request.getContextPath() %>/views/user/login.jsp">로그인</a></div>
	        	<div><a href="<%= request.getContextPath() %>/views/user/join.jsp">회원가입</a></div>
	      	</div>
	      	<% } else{ %>
	      	<div class="loginOk">
	      		<% if(loginUser != null){ %>
	      		<div class="loginName"><%= loginUser.getUsNick() %> 님</div>
	      		<% 		} else if(loginHp != null){ %>
	      		<div class="loginName"><%= loginHp.getHpName() %> 님</div>
	      		<% 		} else{ %>
	      		<div class="loginName"><%= loginAu.getAuId() %> 님</div>
	      		<% 		} %>
	      		<div class="logoutBtn"><a href="<%= request.getContextPath() %>/logout.au">로그아웃</a></div>
	      	</div>
	      	<% } %>
	      	<ul id="navigator">
	        	<li id="nav-home">
	         		<a href="<%= request.getContextPath() %>/index.jsp"><span>홈</span></a>
	         	</li>
	         	<li id="nav-hospital">
	         		<a href="<%= request.getContextPath()%>/views/hospital/searchHp.jsp"><span>병원 검색</span></a>
	         	</li>
	         	<li id="nav-community">
	         		<span>커뮤니티</span>
         			<ul class="nav2-community" id="nav2-community">
	         			<li><a href="<%=request.getContextPath() %>/noticeList.bo">공지사항</a></li>
	         			<li><a href="<%= request.getContextPath()%>/list.rv">후기 모아보기</a></li>
	         			<li><a href="<%= request.getContextPath()%>/list.kn">지식 공유</a></li>
         			</ul>
	         	</li>
	         	<% if(loginAu != null){ %>
	         	<li id="nav-mypage">
	         		<span>마이페이지</span>
	         		<ul class="nav2-mypage" id="nav2-mypage">
	         			<%if(loginAu != null && loginAu.getAuKind().equals("HP")) {%>
		         		<li><a href="<%=request.getContextPath()%>/views/mypage/hpModify.jsp">내 정보</a></li>
		         		<li><a href="<%=request.getContextPath()%>/hpCateList.hp">진료 카테고리</a></li>
		         		<li><a href="<%=request.getContextPath()%>/HpRvCheck.hp">예약 조회</a></li>
		         		<%} else if(loginAu != null && loginAu.getAuKind().equals("USER")){%>
		         		<li><a href="<%= request.getContextPath() %>/views/user/profile.jsp">내 정보</a></li>
		         		<li><a href="<%= request.getContextPath() %>/views/user/myPetList.jsp">내 반려동물 관리</a></li>
		         		<li><a href="<%= request.getContextPath() %>/list.rs">예약 내역</a></li>
		         		<li><a href="<%= request.getContextPath()%>/list.pt">포인트</a></li>
		         		<li><a href="<%= request.getContextPath() %>/list.ms">내 쪽지함</a></li>
		         		<%} else if(loginAu != null && loginAu.getAuKind().equals("ADMIN")){%>
		         		<li><a href="<%=request.getContextPath() %>/UserList.ad">회원관리</a></li>
		         		<li><a href="<%=request.getContextPath() %>/HPList.ad">병원목록</a></li>
		         		<%} %>
	         		</ul>
	         	</li>
	         	<% } %>
	      	</ul>
			<dl>
		    	<dt class="blind">sns</dt>
		        <dd><a href="#"><i class="fab fa-facebook-f"></i></a></dd>
		        <dd><a href="#"><i class="fab fa-twitter"></i></a></dd>
		        <dd><a href="#"><i class="fab fa-youtube"></i></a></dd>
			</dl>
		</nav>
	</header>
	<!-- <footer></footer> -->
</body>
</html>