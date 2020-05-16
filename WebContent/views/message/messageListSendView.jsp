<%@ page language="java" contentType="text/html; charset=UTF-8"	
    pageEncoding="UTF-8"%>

<%@ page import = "java.util.ArrayList, message.model.vo.*" %>    
<%
	ArrayList<Message> mListS = (ArrayList<Message>)request.getAttribute("mLists");
	PageInfo piS = (PageInfo)request.getAttribute("pi"); 

	int listCounts = piS.getListCount();
	int currentPages = piS.getCurrentPage();
	int maxPages = piS.getMaxPage();
	int startPages = piS.getStartPage();
	int endPages = piS.getEndPage();
%>
<!DOCTYPE html>
<html>
<head>
<script src="<%= request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
<style>
.header{
	top:0px;}	
div.tableTitle {
	text-align: center;
	align-content: center;
	width:999px;
	margin-top: 20px;
	margin-left: 500px;
	margin-right: 50px;
	border-top: solid 0px;
	border-bottom: solid 0px;
	height: 35px;
	clear: both;
}

div.messageOuter{
	margin-top: 0px;

}

div.inContentTitle{
	margin-left: 920px;
}


div.tableCol.checkBox {
 	width: 20px; 
 	height: 20px;
	margin-left: 40px;
	margin-right: 40px;
}

input#aCheck{
 	width: 20px; 
 	height: 20px;
}

div.tableCol.receiver {
	width: 45px;
	margin-left: 40px;
	margin-right: 40px;
}

div.tableCol.subject {
	width: 45px;
	margin-left: 250px;
	margin-right: 250px;
}

div.tableCol.sendDate {
	width: 45px;
	margin-left: 70px;
	margin-right: 70px;
}

input#receiveMsgButton {
	text-align: center;
	
}

input[type="button"] {
	cursor: pointer;
	width: 90px; 
	height: 36px; 
	background: #ffdfdf;
	color: #5d5d5d;
	font-size: 14px;
	font-weight: 600;
	border: none;
	border-radius: 5px;
}

input[type="button"]:hover {
	background: #fb929e;
	color: #fff;
}
input#searchButton {
	margin-bottom: 20px;
	width: 20px;
	

}

input.textMsg{
	margin-bottom: 20px;

}

.messageControll > #deleteButton {
	display: inline-block;
	margin-left: 10px;
	background: #aedefc;
	font-size: 14px;
	font-weight: 600;
	color: #5d5d5d;
	width: 100px; 
	height: 36px; 
	border:none;
	border-radius: 5px;

}

input#deleteButton:hover {
	background: #0774b7;
	color: white;
}

.messageControll {
	display: inline;
	margin-left: 500px;
	width: 90px; 
	height: 36px; 

}



/* div.tableRow {
    border-bottom:solid 1px #eaeaea ;
    width:100% ;
    clear:both ;
    height:30px ;
}

div.tableCol {
    padding:8px 3px 0 3px ;
    overflow-x:hidden;
    overflow-y:hidden ;
    height:20px ;
} */
	


input.check{width:20px; height: 20px;}

#msgArea th{border-bottom: 1px solid #5d5d5d; background-color: #fcc6c9; font-weight: bold;}
#msgArea th{padding:5px;} 
#msgArea td{padding:5px; border-bottom: 1px solid #5d5d5d; } 



.pagingArea {margin-top: 10px;}
.pagingArea{display: inline-block; margin-left: 30px; margin-top: 20px;}
.pagingArea button{color: black; float: left; padding: 6px 14px; text-decoration: none; transition: background-color .3s; border: 1px solid #ddd; margin: 0 4px; font-size: 15px; font-weight: 700;}	
.pagingArea button:hover{background-color: white; border: 1px solid #fb929e;}
.pagingArea button.disabled{color:gray;}

</style>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 메세지 보관함</title>
</head>
<body>
	<!-- 공유css -->	
	<%@ include file="../common/layout.jsp" %>
	
	<!-- 검색, 목록 -->
	
	<div class="outer">
	<div class="messageOuter">
		<div class="inContentTitle"><img src="<%= request.getContextPath() %>/images/sendMsg.png" width="190px" height="200px"></div>
		<form method="get"> 
			<div class="messageControll">
			   	<!-- <input type="text" class="textMsg" size="20">
			   	<input type="submit" id="searchButton" class="button" value="검색"> -->
			   	<input type="button" value=" 받은쪽지함 " id="sendMsgButton" class="sendMsgButton" onclick="location.href='<%= request.getContextPath() %>/list.ms'"> 
				<input type="button" id="deleteButton" class="deleteButton" role="button" aria-disabled="false" value="선택쪽지 삭제">
			</div>
			
		<div class="tableTitle">
			<table id="msgArea">
				<tr>
				   	<th><div class="tableCol checkBox"><input type="checkbox" name="check" id="aCheck" onclick="allCheck(this);"></div></th>
				  	<th><div class="tableCol receiver" >수신자</div></th>
				  	<th><div class="tableCol subject">제목</div></th>
				  	<th><div class="tableCol sendDate" >발신일</div></th>
				</tr>
				
				<!-- 이따가 조회 리스트 추가 -->
				<% if(mListS.isEmpty()){%>
				
				<tr>
					<td colspan="4">조회된 리스트가 없습니다.</td>
				</tr>
				<% } else { 
						for(Message m : mListS) {
				%>
				<tr>
					<td><input type="checkbox" name="check" class="check"  data-mNum='<%= m.getMsgNum() %>'></td>
					<td class="rId"><input type="hidden" class="mNum" name="mNum" value='<%= m.getMsgNum() %>'><%= m.getRNick() %><input type="hidden" value='<%= m.getRNick() %>'> </td>
					<td class="mTitle"><%= m.getMsgTitle() %><input type="hidden"  value='<%= m.getMsgTitle() %>'></td>
					<td><%= m.getMsgDate() %><input type="hidden" value='<%= m.getMsgDate() %>'></td>
				</tr>	
				
				<% 		}
					
					}%>
			</table>
			
						<!-- 하단에 페이징 번호 -->
		<div class="pagingArea" align="center">
			<% if(!mListS.isEmpty()){ %>	
			<button onclick ="location.href='<%=request.getContextPath() %>/listSend.ms?currentPages=1'">&lt;&lt;</button>
		
		
			<!-- 이전 페이지 -->
		<button onclick="location.href='<%=request.getContextPath() %>/listSend.ms?currentPages=<%= currentPages -1 %>'" id="beforeBtn">&lt;</button>
		<!-- 이전 페이지 갈 작동 함수 필요 -->
				<script>
					if(<%= currentPages %> <= 1){
						var before = $('#beforeBtn');
						before.attr('disabled', 'true'); // 첫번째 페이지면 클릭이 안되게 한다. 
					}
				
				</script>
				
				<!-- 10개의 페이지 목록 -->
				<% for(int p = startPages; p <= endPages; p++){ %>
					<% if(p == currentPages) { %>
						<button id="choosen" disabled><%= p %></button>
					<% } else {%>
						<button id="numBtn" onclick="location.href='<%= request.getContextPath() %>/listSend.ms?currentPages=<%= p %>'"><%= p %></button>
					<% } %>
				<% } %>
				<!-- 다음 페이지 -->
				<button onclick="location.href='<%= request.getContextPath() %>/listSend.ms?currentPages=<%= currentPages +1 %>'" id="afterBtn">&gt;</button>
				<script>
					if(<%= currentPages %> >= <%= maxPages %>){
						var after = $("#afterBtn");
						after.attr('disabled', 'true');
					}
				</script>			
				
				<!-- 맨 끝으로 -->
				<button onclick="location.href='<%= request.getContextPath() %>/listSend.ms?currentPages=<%= maxPages %>'">&gt;&gt;</button>			
				<% } %>
		</div>	
		</div>
		</form>
			</div>
		


	</div>

	<form name="frm" action="location.href='<%= request.getContextPath() %>/delete.ms" method="post"> <!-- 메세지 삭제 누르면 실행 -->
		<input type="hidden" name="action" value="ssgId">
		<input type="hidden" name="type" value="many">

	<!-- 쪽지 리스트 출력 부분-->
	</form>
	
	<!-- 버튼 위치 -->
	<div style="text-align:right"> </div>
    <!-- 페이징 쪽 번호 생기는 곳 -->
    

    
	
	
	<script>
	$(function(){
		$('tbody td').mouseenter(function(){
			$(this).parent().css({'background':'#ffe3e4', 'cursor':'pointer'});
		}).mouseout(function(){
			$(this).parent().css("background", "none");
		});			
		});
	
	
/* 		$('button').mouseenter(function(){
			$('button').css({'background':'#ffe3e4', 'cursor':'pointer'});
		}).mouseout(function(){
			$('button').parent().css("background", "none");
		}); */
		
		
		 function allCheck() {

			 var check = document.getElementsByName("check");
			 
		 	for(var i=0; i < check.length; i++) {
			 	 if(check[0].checked == true) {
			 		check[i].checked = true;
				 } else {
					 check[i].checked = false;
				   } 
				 
			 }
			 
		 }
		
		
		$(".check").click(function(){
			$('#aCheck').prop("checked", false);
		});
		
		
		/* 쪽지 가져오기 */
		$("td.mTitle").click(function(){
			var mNum = $(this).parent().children().children('.mNum').val();

			<% if(loginUser != null) { %>
				location.href='<%= request.getContextPath() %>/detailSend.ms?mNum=' + mNum;
			<% } else { %>
			 alert("로그인 후에 이용해주세요.");
			 
			 location.href='<%= request.getContextPath() %>/index.jsp';
			<% } %>
			
		});
		

 		$('.deleteButton').click(function(){
			var checkArr = new Array();
			
			var checkBox = $("input:checkbox[name='check']").is(":checked");

			
			if(checkBox){
			
			var confirm1 = confirm("정말 삭제하시겠습니까?");
			
			if(confirm1){
				$('input[class="check"]:checked').each(function(){
					checkArr.push($(this).attr("data-mNum")); //체크한 쪽지 배열로 저장
					console.log(checkArr);
				});
			};
			
			
			jQuery.ajaxSettings.traditional = true;
			

			//ajax실행해서 배열로 값넘긴 후에 deleteM실행한 후에 다시 돌아온다. 
			$.ajax({
                url:'deleteSM.ms',
                type: 'post',
				data:{checkArr:checkArr}, //쉼표로 구분
				success: function(data){
					alert(data); 
					window.location.href='listSend.ms';
					
				}
				
			});
		} else {
			confimr1 = alert("삭제할 쪽지를 선택하세요.");
		}
		}); 
		
		
	</script>

	
	
</body>
</html>