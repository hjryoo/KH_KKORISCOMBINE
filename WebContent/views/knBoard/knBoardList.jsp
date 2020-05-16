<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import = "java.util.*, knBoard.model.vo.KnBoard, common.model.vo.Paging" %>
<%
	ArrayList<KnBoard> list = (ArrayList<KnBoard>)request.getAttribute("list");
	Paging pg = (Paging)request.getAttribute("pg");
	String searchCategory = (String)request.getAttribute("searchCategory");
	String searchTag = (String)request.getAttribute("searchTag");	
	
	int listCount = pg.getListCount();
	int currentPage = pg.getCurrentPage();
	int maxPage = pg.getMaxPage();
	int startPage = pg.getStartPage();
	int endPage = pg.getEndPage();

	String pagingAddress = "";
	if(searchCategory == null && searchTag == null){
		pagingAddress = "/list.kn?currentPage=";
	} else {
		pagingAddress = "/search.kn?searchCategory="+searchCategory+"&searchTag="+searchTag+"&currentPage=";
	}	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 지식 공유 커뮤니티</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.contextMenu.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.ui.position.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
<style>
	div.contents{width: 70%; height: 600px;}
	#blogo{width: 100%; margin-top: 50px; text-align: center;}
	.tableArea{width: 80%; height: 650px; margin: 0 auto; margin-top: 80px;}
	table {width: 100%;}
	table > class{margin-left: 100px; margin-top: 30px; width: 680px;}
	table, th, td{word-spacing: 5px; padding: 5px; height: 40px;}
	thead th{border-bottom: 1px solid  #5d5d5d;; background-color: #fcc6c9; height: 30px; font-weight: 600; text-align: center;}
	tbody th{font-weight: 600; border-bottom: 1px solid #5d5d5d; text-align: center;}
	tbody td{border-bottom: 1px solid #5d5d5d; font-family: inherit; text-align: center; font-size: 11pt;}
	#writeBtn{margin-left: 700px; font-size: 15px; border-radius: 5px; width: 80px; height: 35px; font-size: 14px; font-weight: 600; text-align: center; border: none; border-radius: 5px; background: #aedefc; color: #5d5d5d;}
	#writeBtn:hover{cursor: pointer; ; color: #fff;}
	.pagingArea{display: inline-block; width: 100%; margin-top: 20px;}
	.pagingArea > div {display: inline-block;}
	.pagingArea button{color: black; float: left; padding: 6px 14px; text-decoration: none; transition: background-color .3s; border: 1px solid #ddd; margin: 0 4px; font-size: 15px; font-weight: 700;}	
	.pagingArea button:hover{background-color: white; border: 1px solid #fb929e;}
	.pagingArea button.disabled{color:gray;}
	span > #searchBtn{line-height: 30px; text-align: center; background-color: #ffe3e4; border: none; border-radius: 5px; border-radius: 5px; width: 80px; height: 35px  position: fixed;}
	span > #searchBtn:hover{cursor: pointer; ; background: #fb929e; color: #fff;}
	.searchArea{margin-top : auto; text-align: center;}
	div.select-box {width: 10% !important; min-width: 70px;}
	span > input{width: 200px;}
	#searchForm {margin-top: 40px;}
	.search_input{width: 40%; padding: 12px 24px; margin: 0 10px; font-size: 14px; line-height: 18px; color: #575756; background-size: 18px 18px; border-radius: 50px; border: 1px solid #5d5d5d; backface-visibility: hidden; right:20px; outline:none;}

</style>
</head>
<body>
<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents">	
			<div id="blogo"><img src="<%= request.getContextPath() %>/images/knb.png"></div>
			<div class="tableArea">
				<table id="table">
					<thead> <!-- 게시판 라벨 부분 -->
					<tr>
						<th width="5%">No</th>
						<th width="55%" class="title">제목</th>
						<th width="15%">작성자</th>
						<th width="15%">작성일</th>
						<th width="10%">조회수</th>
					</tr>
					</thead>
					<tbody> <!-- 게시판 내용 부분-->
					<% if(list.isEmpty()) { %>
					<tr>
						<td colspan=5 class="not">게시글이 없습니다.</td>
					</tr>
					<% } else {
							for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<th><%= list.get(i).getKnNum() %><input type="hidden" name ="knNum" value='<%= list.get(i).getKnNum() %>'></th>
						<td class="title"><%= list.get(i).getknTitle() %><input type="hidden" name ="title" value='<%= list.get(i).getknTitle() %>'></td>
						<td class="id-menu"><%= list.get(i).getUsNick() %><input type="hidden" name ="nickname" value='<%= list.get(i).getUsNick() %>'><input type="hidden" name ="usId" value='<%= list.get(i).getUsId() %>'></td>
						<td><%= list.get(i).getKnDate() %><input type="hidden" name ="kndate" value='<%= list.get(i).getKnDate() %>'></td>
						<td><%= list.get(i).getKnView() %><input type="hidden" name ="knview" value='<%= list.get(i).getKnView() %>'></td>
					</tr>
	           	    <%       
							}
	                    } %>				
					</tbody>
				</table>
				<br>
			<%if(loginAu != null) {%>
				<input type=button id=writeBtn value=글쓰기 onclick="location.href='<%=request.getContextPath()%>/views/knBoard/knBoardWrite.jsp'">
			<%} %>				
	     	 <div class='pagingArea' align='center'>
	     	 	<div>
			         <% if(!list.isEmpty()){ %>      
					<button onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %>1'">&laquo;</button>
			
					<button onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %><%=currentPage-1 %>'" id="beforeBtn">&lsaquo;</button>
			         <script>
			            if(<%= currentPage %> <= 1){
			               var before = $('#beforeBtn');
			               before.attr('disabled', 'true');
			            }
			         
			         </script>
			
			         <% for(int p = startPage; p <= endPage; p++){ %>
			            <% if(p == currentPage) { %>
			               <button style="background: #ffdfdf;" id="choosen" disabled class="pBtn"><%= p %></button>
			            <% } else {%>
			               <button id="numBtn" onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %><%=p %>'"><%=p %></button>
			            <% } %>
			         <% } %>
			         
					<button onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %><%=currentPage+1 %>'" id="afterBtn">&rsaquo;</button>
			         <script>
			            if(<%= currentPage %> >= <%= maxPage %>){
			               var after = $("#afterBtn");
			               after.attr('disabled', 'true');
			            }
			         </script>         
			         
					<button onclick="location.href='<%=request.getContextPath() %><%=pagingAddress %><%=maxPage %>'">&raquo;</button>          
			         <% } %>
		         </div>        	
			</div>
			<form action="<%=request.getContextPath()%>/search.kn" id="searchForm">
			<div class="searchArea">
				<div class="select-box">
					<select name=searchCategory>
					<option value="작성자">작성자</option>
					<option value="제목">제목</option>
					<option value="내용">내용</option>
					</select>
				</div>
				<span class="search_container">
	        		<input name=searchTag class="search_input" type="text" placeholder="Search">
	        		<input id="searchBtn" type="submit" value="검색" onclick="location.href='<%=request.getContextPath() %>/search.kn'">		
	    		</span>           				
			</div>
		</form>
			</div>
			
		</div>
	</div>
		<script>
		// 버튼 관련
			$(function(){
				$('tbody td:not(.not)').mouseenter(function(){
					$(this).parent().css({'background':'#ffe3e4', 'cursor':'pointer'});
				}).mouseout(function(){
					$(this).parent().css("background", "none");
				}).click(function(){
					var no = $(this).parent().children().children('input').val();
					location.href='<%= request.getContextPath() %>/detail.kn?no=' + no;
				});
			});
   
			// context
			var i = jQuery.noConflict();
			i(document).ready(function() {
		        $.contextMenu({
		            selector: '.id-menu', 
		            callback: function(key, options) {
		                var usId = $(this).parent().children().children('input[name=usId]').val();
		                var nickname = $(this).parent().children().children('input[name=nickname]').val();
						location.href='<%= request.getContextPath() %>/views/message/messageSendView.jsp?id=' + usId+'&nickname=' + nickname;
		            },
		            items: {
		                "쪽지보내기": {name: "쪽지보내기"}
		            }
		        });

		        $('.context-menu').on('click', function(e){
		            console.log('clicked', this);
		        });   
			});

		</script>
</body>
</html>