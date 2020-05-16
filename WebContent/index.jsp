<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="views/common/layout.jsp" %>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 KKORISCOMBINE</title>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/index.css"/>
<style>
	@charset "UTF-8";
	/* 참고	section:nth-of-type(1) {section 중 첫번째 section에 접근} */
	section.main {position:relative; height:100%; width:100%; background: url(<%=request.getContextPath()%>/images/main-bg.jpg) no-repeat center center; background-size: contain;}
	section.main > article.quickMenu {position: relative; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.2);}
	section.main > article.quickMenu > ul {position: absolute; top:calc(50% - 50px); left:calc(50% - 25%); width: 50%; height: 100px; display: flex;}
	section.main > article.quickMenu > ul > li {width: 33%; height:100px;}
	section.main > article.quickMenu > ul > li > a {color: #5d5d5d; display:block; font-size: 5em; text-align:center;}
	section.main > article.quickMenu > ul > li > a > span {display: block; font-size: 15px;}
	section.main > article.quickMenu > ul > li > a:hover {color: #fb929e;}

	
	<% if(loginAu != null && loginAu.getAuKind().equals("ADMIN")){%>
	section.main > article.quickMenu > ul.userMenu{position: absolute; top:calc(40% - 55px); left:calc(50% - 25%); width: 50%; height: 100px; display: flex;}
	section.main > article.quickMenu > ul.insertMenu{position: absolute; top:calc(40% + 55px); left:calc(50% - 25%); width: 50%; height: 100px; display: flex;}
	<%}%>
	
	
	
	
</style>
</head>
<body>
	
	
	<div class="container">
    	<section class="main">
      		<article class="quickMenu">
	         	<ul class=userMenu>
	            	<li><a href="<%= request.getContextPath()%>/views/hospital/searchHp.jsp"><i class="fas fa-map-marker-alt"></i><span>검색</span></a></li>
	            	<%if(loginAu != null && loginAu.getAuKind().equals("HP")){ %>
	            	<li><a href="<%=request.getContextPath()%>/HpRvCheck.hp"><i class="far fa-check-circle"></i><span>예약</span></a></li>
	            	<%} else {%>
	            	<li><a href="<%= request.getContextPath()%>/views/hospital/searchHp.jsp"><i class="far fa-check-circle"></i><span>예약</span></a></li>
	            	<%} %>
	                <li><a href="<%= request.getContextPath()%>/list.kn"><i class="far fa-comments"></i><span>커뮤니티</span></a></li>
	            </ul>
	            <%if(loginAu != null && loginAu.getAuKind().equals("ADMIN")) {%>
	            <ul class=insertMenu>
					<li><a href="<%=request.getContextPath() %>/UserList.ad"><i class="fas fa-user-friends"></i><span>회원관리</span></a></li>
					<li><a href="<%=request.getContextPath() %>/noticeList.bo"><i class="fas fa-volume-up"></i><span>공지사항</span></a></li>
					<li><a href="<%=request.getContextPath() %>/HPList.ad"><i class="far fa-list-alt"></i><span>병원목록</span></a></li>
				</ul>
				<%} %>
         	</article>	
      	</section>
	</div>
</body>
</html>