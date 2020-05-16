<%@page import="notice.model.vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/layout.jsp" %>
<%
	ArrayList<Hospital> list = (ArrayList<Hospital>)request.getAttribute("list");
	String searchCategory = (String)request.getAttribute("searchCategory");
	String searchTag = (String)request.getAttribute("searchTag");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	
	String pagingAddress = "";
	String isSearch = "";
	if(searchCategory == null && searchTag == null){
		isSearch = "notSearch";
		pagingAddress = "/HPList.ad?currentPage=";
	} else {
		isSearch = "search";
		pagingAddress = "/HPSearchList.ad?searchCategory="+searchCategory+"&searchTag="+searchTag+"&currentPage=";
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/index.css"/>
<style>
	section.HMmain {
		position:relative; 
		height:100%; width:100%; 
		background-size: contain;
	}
	
	section.HMmain > article.HMquickMenu {
		position: relative; width: 100%; height: 100%; background: white;
	}
	
	section.HMmain > article.HMquickMenu > h1{
		position: relative;
		margin: 0 auto;
		font-size: 40px;
		width: 300px;
		text-align: center;
		vertical-align: miidle;
	}
	
	table.hpTable{
		text-align: center;
		position: relative;
		margin: 0 auto;
		max-width: 80%;
	}
	table.hpTable th{text-align: center; background: rgba(255, 167, 163, 0.63);}
	table.hpTable tr{height: 35px; border-bottom: 1px solid lightgray;}
	table.hpTable td{
		padding: 7px; 
		text-overflow:ellipsis; overflow:hidden; white-space:nowrap;
	}
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
	
	article.HMquickMenu > div.pagingArea{
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
	
	
	
	
	article.HMquickMenu > div.pagingArea > button{
		text-align: center;
		border: 0px;
		min-width: 20px;
		height: 24px;
	}
	
	article.HMquickMenu > form > div.search{
		position: relative;
		margin: 0 auto;
		height: 100px;
		font-size: 18px;
		width: 440px;
		text-align: center;
		vertical-align: middle;
	}
	div.search > select{
		font-size: 10pt; width: 100px; 
		padding: .7em .5em; font-family: inherit; 
		background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%; 
		-webkit-appearance: none; 
		-moz-appearance: none; appearance: none; outline:none; border:1px solid #5d5d5d;
	}
	div.search > input.search_input{
		width: 250px;  padding: 12px 24px; 
		font-size: 14px; line-height: 18px; 
		color: #575756; background-size: 18px 18px; 
		border-radius: 50px; border: 1px solid #5d5d5d; 
		backface-visibility: hidden; right:20px; outline:none;
	}
	div.search > input[type="submit"] {width: 70px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
	div.search > input[type="submit"]:hover {background: #fb929e; color: #fff;}
	
</style>

</head>
<body>
	<div class="container">
    	<section class="HMmain">
			<article class="HMquickMenu">
				<br><br>
				<h1>병원 관리 페이지</h1>
				
				<br>
				
				<table class="hpTable" id=hpTable style="width: 80%;">
					<thead>
						<tr>
							<th style="min-width: 80px;">아이디</th>
							<th style="min-width: 130px;">병원이름</th>
							<th style="min-width: 80px;">원장이름</th>
							<th style="min-width: 150px;">연락처</th>
							<th style="min-width: 250px;">위치</th>
							<th style="min-width: 80px;"><p style="display: inline;">탈퇴여부</p>
								<i class="fas fa-sort-down"></i>
								<ul>
									<li onclick=goSearch(this);>가입중</li>
									<li onclick=goSearch(this);>탈퇴</li>
									<li onclick=goSearch(this);>승인대기</li>
								</ul>
							</th>
						</tr>
					</thead>
					<tbody>
					<%if(list == null) {%>
						<tr>
							<td colspan=6>조회된 목록이 없습니다.</td>
						</tr>
					<%} else { %>
						<%for(int i = 0; i < list.size(); i++){ %>
							<tr>
								<td><%=list.get(i).getHpId() %></td>
								<td><%=list.get(i).getHpName() %></td>
								<td><%=list.get(i).getHpDName() %></td>
								<td><%=list.get(i).getHpPhone() %></td>
								<td style="max-width: 250px;" title='<%=list.get(i).getHpLoc1()+" "+list.get(i).getHpLoc2()%>'><%=list.get(i).getHpLoc1()+" "+list.get(i).getHpLoc2() %></td>
								<td><%=list.get(i).getAuDel() %></td>
							</tr>
						<%} %>
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
				<form action="<%=request.getContextPath()%>/HPSearchList.ad">
					<div class=search>
						<select name=searchCategory>
							<option>아이디</option>
							<option>병원이름</option>
							<option>원장이름</option>
							<option>연락처</option>
							<option>위치</option>
						</select>
						<input name=searchTag type=text class=search_input placeholder="Search">
						<input type="submit" value="검색">
					</div>
				</form>
			</article>
		</section>
	</div>
	<script>
		$(function(){
			for(var i = 0; i < $("tbody > tr").length; i++){
				var auDel = $("tbody").children().eq(i).children().eq(5)[0].innerText;
				if(auDel == "W"){
					$("tbody").children().eq(i).children().eq(5).css("cursor","pointer").attr("onclick","updateToN(this);");
				}
			}
		});
		
		function updateToN(im){
			var isTrue = confirm("가입 대기자를 승인하시겠습니까?");
			if(isTrue){
				console.log($(im).parent().children().eq(0)[0].innerText);
				var hpId = $(im).parent().children().eq(0)[0].innerText;
				var isSearch="<%=isSearch%>";
				location.href = "<%=request.getContextPath()%>/HPdelToN.ad?hpId="+hpId+"&isSearch="+isSearch+"&currentPage="+<%=currentPage%>;
			}
		}
	
	
		$("th i").click(function(){
			$("th ul").toggle();
		});
		
		function goSearch(data){
			var searchCategory = $(data).parent().parent().children('p')[0].innerText;
			var searchTag = data.innerText;
			location.href = "<%=request.getContextPath()%>/HPSearchList.ad?searchCategory="+searchCategory+"&searchTag="+searchTag+"&currentPage=1";
		}
	</script>
</body>
</html>