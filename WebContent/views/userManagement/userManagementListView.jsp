<%@page import="notice.model.vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/layout.jsp" %>
<%
	ArrayList<User> list = (ArrayList<User>)request.getAttribute("list");
	String searchCategory = (String)request.getAttribute("searchCategory");
	String searchTag = (String)request.getAttribute("searchTag");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	
	String pagingAddress = "";
	if(searchCategory == null && searchTag == null){
		pagingAddress = "/UserList.ad?currentPage=";
	} else {
		pagingAddress = "/UserSearchList.ad?searchCategory="+searchCategory+"&searchTag="+searchTag+"&currentPage=";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section.UMmain {
		position:relative; 
		height:100%; width:100%; 
		background-size: contain;
	}
	
	section.UMmain > article.UMquickMenu {
		position: relative; width: 100%; height: 100%; background: white;
	}
	
	section.UMmain > article.UMquickMenu > h1{
		position: relative;
		margin: 0 auto;
		font-size: 40px;
		width: 300px;
		text-align: center;
		vertical-align: miidle;
	}
	
	section.UMmain > article.UMquickMenu > table.mbTable{
		text-align: center;
		position: relative;
		margin: 0 auto;
		width: 80%;
	}
	section.UMmain > article.UMquickMenu > table.mbTable th{text-align: center; background: rgba(255, 167, 163, 0.63);}
	section.UMmain > article.UMquickMenu > table.mbTable tr{height: 35px; border-bottom: 1px solid lightgray;}
	section.UMmain > article.UMquickMenu > table.mbTable td{padding: 7px;}
	i{vertical-align: top; padding-top: 1px; cursor: pointer;}
	th ul{
		display: none;
		position: absolute;
		width: 80px;
		background:white;
		cursor: pointer;
	}
	th ul > li{
		border: 1px solid lightgray;
	}
	
	section.UMmain > article.UMquickMenu > div.pagingArea{
		position: relative;
		margin: 0 auto;
		min-width:420px;
		text-align: center;
		vertical-align: middle;
	}
	.pagingArea > div {display: inline-block;}
	.pagingArea button{color: black; float: left; padding: 6px 14px; text-decoration: none; transition: background-color .3s; border: 1px solid #ddd; margin: 0 4px; font-size: 15px; font-weight: 700;}	
	.pagingArea button:hover{background-color: white; border: 1px solid #fb929e;}
	.pagingArea button.disabled{color:gray;}
	section.UMmain > article.UMquickMenu > div.pagingArea > button{
		text-align: center;
		border: 0px;
		min-width: 20px;
		height: 24px;
	}
	
	section.UMmain > article.UMquickMenu > div.search{
		position: relative;
		margin: 0 auto;
		height: 100px;
		font-size: 18px;
		width: 540px;
		text-align: center;
		vertical-align: middle;
		
	}
	section.UMmain > article.UMquickMenu > form > div.search > select{
		font-size: 10pt; width: 100px; 
		padding: .7em .5em; font-family: inherit; 
		background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%; 
		-webkit-appearance: none; 
		-moz-appearance: none; appearance: none; outline:none; border:1px solid #5d5d5d;
	}
	section.UMmain > article.UMquickMenu > form{
		text-align: center;
	}
	section.UMmain > article.UMquickMenu > form > div.search > input.search_input{
		width: 250px;  padding: 12px 24px; 
		font-size: 14px; line-height: 18px; 
		color: #575756; background-size: 18px 18px; 
		border-radius: 50px; border: 1px solid #5d5d5d; 
		backface-visibility: hidden; right:20px; outline:none;
	}
	section.UMmain > article.UMquickMenu > form > div.search > input[type="submit"] {width: 70px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
	section.UMmain > article.UMquickMenu > form > div.search > input[type="submit"]:hover {background: #fb929e; color: #fff;}
	
</style>
</head>
<body>
	<div class="container">
    	<section class="UMmain">
			<article class="UMquickMenu" style="background: white;">
			
				<br><br>
				
				<h1>회원 관리 페이지</h1>
				
				<br>
				
				<table class="mbTable" id=mbTable>
					<thead>
						<tr>
							<th style="min-width: 90px;">아이디</th>
							<th style="min-width: 90px;">이름</th>
							<th style="min-width: 90px;">닉네임</th>
							<th style="min-width: 70px;"><p style="display: inline;">성별</p>
								<i id=gender class="fas fa-sort-down"></i>
								<ul>
									<li onclick=goSearch(this);>남</li>
									<li onclick=goSearch(this);>여</li>
								</ul>
							</th>
							<th style="min-width: 170px;">연락처</th>
							<th style="min-width: 80px;"><p style="display: inline;">탈퇴여부</p>
								<i id=del class="fas fa-sort-down"></i>
								<ul>
									<li onclick=goSearch(this);>가입중</li>
									<li onclick=goSearch(this);>탈퇴</li>
								</ul>
							</th>
						</tr>
					</thead>
					<tbody>
					<%for(int i = 0; i < list.size(); i++){ %>
						<tr>
							<td><%=list.get(i).getUsId() %></td>
							<td><%=list.get(i).getUsName() %></td>
							<td><%=list.get(i).getUsNick() %></td>
							<td><%=list.get(i).getUsGender() %></td>
							<td><%=list.get(i).getUsPhone() %></td>
							<td><%=list.get(i).getAuDel() %></td>
						</tr>
					<%} %>
					</tbody>
				</table>
				
				<br>
				
				<div class="pagingArea" align="center">
					<div>
					<%if(!list.isEmpty()) {%>
					<!-- 맨 처음으로 버튼 -->
					<button onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %>1'">&lt;&lt;</button>
					<!-- 이전 페이지로 -->
					<button onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %><%=currentPage-1 %>'" id="beforeBtn">&lt;</button>
					<script>
						if(<%=currentPage %> <= 1){
							var before = $('#beforeBtn');
							before.attr('disabled', 'true');
						}
					</script>
					<!-- 10개의 페이지목록 -->
					<%for(int p = startPage; p <= endPage; p++){%>
						<%if(p == currentPage){ %>
							<button style="background: #ffdfdf;" id="numBtn" onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %><%=p %>'"><%=p %></button>
						<%} else {%>
							<button id=numBtn onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %><%=p %>'"><%=p %></button>
						<%} %>
					<%} %>
					<!-- 다음 페이지로 -->
					<button onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %><%=currentPage+1 %>'" id="afterBtn">&gt;</button>
					<script>
						if(<%=currentPage%> >= <%=maxPage%>){
							var after = $("#afterBtn");
							after.attr('disabled','true');
						}
					</script>
					<!-- 맨끝으로버튼 -->
					<button onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %><%=maxPage %>'">&gt;&gt;</button>
					<%} %>
					</div>
				</div>
				
				<br>
				<form action="<%=request.getContextPath()%>/UserSearchList.ad">
					<div class=search>
						<select name=searchCategory>
							<option>아이디</option>
							<option>이름</option>
							<option>닉네임</option>
							<option>연락처</option>
						</select>
						<input name=searchTag type=text class=search_input placeholder="Search">
						<input type="submit" value="검색">
					</div>
				</form>
			</article>
		</section>
	</div>
	<script>
		$("#gender").click(function(){
			$("#gender").parent().children('ul').toggle();
		});
		$("#del").click(function(){
			$("#del").parent().children('ul').toggle();
		});
		
		function goSearch(data){
			var searchCategory = $(data).parent().parent().children('p')[0].innerText;
			var searchTag = data.innerText;
			location.href = "<%=request.getContextPath()%>/UserSearchList.ad?searchCategory="+searchCategory+"&searchTag="+searchTag+"&currentPage=1";
		}
		
	</script>
</body>
</html>