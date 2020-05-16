<%@page import="notice.model.vo.Notice"%>
<%@page import="notice.model.vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 공지사항</title>
<%@ include file="../common/layout.jsp" %>
<%
	ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("list");
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
		pagingAddress = "/noticeList.bo?currentPage=";
	} else {
		pagingAddress = "/noticeSearchList.bo?searchCategory="+searchCategory+"&searchTag="+searchTag+"&currentPage=";
	}
%>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/index.css"/>
<style>
	section.Nmain {
		position:relative; 
		height:100%; width:100%; 
		background-size: contain;
	}
	
	section.Nmain > article.NquickMenu {
		position: relative; width: 100%; height: 100%; background: white;
	}
	
	section.Nmain > article.NquickMenu > h1{
		position: relative;
		margin: 0 auto;
		font-size: 40px;
		width: 220px;
		text-align: center;
		vertical-align: middle;
	}
	
	table.noticeList{
		text-align: center;
		position: relative;
		margin: 0 auto;
	}
	table.noticeList th{text-align: center; background: rgba(255, 167, 163, 0.63);}
	table.noticeList tr{height: 35px; border-bottom: 1px solid lightgray;}
	table.noticeList tr:hover{
		cursor: pointer; background: #ffdfdf;
	}
	table.noticeList td{padding: 7px;}
	
	section.Nmain > article.NquickMenu > input.addnotice{
		position: relative;
		min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; 
		color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; 
		border-radius: 5px;
	}
	section.Nmain > article.NquickMenu > input.addnotice:hover {
		background: #fb929e; color: #fff;
	}
	
	article.NquickMenu > div.pagingArea{
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
	
	
	article.NquickMenu > div.pagingArea > button{
		text-align: center;
		border: 0px;
		min-width: 20px;
		height: 24px; background: none;
	}
	
	article.NquickMenu > form > div.search{
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
    	<section class="Nmain">
			<article class="NquickMenu">
				<br><br>
				<h1><img src="<%=request.getContextPath() %>/images/noticeTitle.png"></h1><br>
				<table class="noticeList" id=noticeList style="width: 80%;">
					<thead>
						<tr>
							<th style="min-width: 60px;">No</th>
							<th style="min-width: 370px; text-align: left;">제목</th>
							<th style="min-width: 80px;">작성자</th>
							<th style="min-width: 110px;">작성일</th>
						</tr>
					</thead>
					<tbody>
					<%if(list.isEmpty()) {%>
						<tr>
							<td colspan=4>조회된 리스트가 없습니다.</td>
						</tr>
					<%} else {%>
						<%for(Notice n : list){ %>
						<tr>
							<td style="display: none;"><%=n.getNoNum() %></td>
							<td><%=n.getrNum() %></td>
							<td style="text-align: left;"><%=n.getNoTitle() %></td>
							<td><%=n.getAuId() %></td>
							<td><%=n.getNoDate() %></td>
						</tr>
						
						<%} %>
					<%} %>
					</tbody>
				</table>
				<%if(loginAu != null && loginAu.getAuKind().equals("ADMIN")) {%>
				<input type=button class=addnotice id=addnotice value=글쓰기
				onclick="location.href='<%=request.getContextPath()%>/views/notice/noticeInsertForm.jsp'">
				<%} %>
				<script>
					var addnoticeCss = 
						(Number)($("#noticeList").css("margin-left").replace(/[^-\d\.]/g, ''))
						+ $("#noticeList")[0].offsetWidth - 50;
					$('#addnotice').css("margin-left",addnoticeCss);
					
					$(window).resize(function(){
						var addnoticeCss2 = 
							(Number)($("#noticeList").css("margin-left").replace(/[^-\d\.]/g, ''))
							+ $("#noticeList")[0].offsetWidth - 50;
						
						$('#addnotice').css("margin-left",addnoticeCss2);
					});
				</script>
				
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
				<form action="<%=request.getContextPath()%>/noticeSearchList.bo">
					<div class="search">
						<select name=searchCategory>
							<option>제목</option>
							<option>내용</option>
							<option>제목+내용</option>
						</select>
						<input name=searchTag type=text class=search_input placeholder="Search">
						<input type="submit" value="검색">
					</div>
				</form>
			</article>
		</section>
	</div>
	<script>
		$("td").click(function(){
			var noNum = $(this).parent().children().eq(0).text();
			console.log(noNum);
			location.href="<%=request.getContextPath()%>/noticeDetailView.bo?noNum="+noNum;
		});
	</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>