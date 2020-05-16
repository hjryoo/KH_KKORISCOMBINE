<%@page import="java.util.logging.SimpleFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page
	import="java.util.ArrayList, message.model.vo.*, java.text.SimpleDateFormat"%>
<%
	ArrayList<Message> mList = (ArrayList<Message>) request.getAttribute("mList");

	PageInfo pi = (PageInfo) request.getAttribute("pi");
	//SimpleDateFormat sf = new SimpleDateFormat("yyyy년 'MM월 dd일 HH:mm");
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
%>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
<style>
.header {
	top: 0px;
}

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

div#msgArea{
	border-top: 1px solid #444444;
    border-collapse: collapse;
}

div.messageOuter {
	margin-top: 0px;
}

/* 로고 */
div.inContentTitle {
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

input#sendMsgButton {
	text-align: center;
	margin-bottom:  	0px;
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
	cursor: pointer;
	background: #fb929e;
	color: #fff;
}



.messageControll > #deleteButton {
	cursor: pointer;
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



input#searchButton {
	margin-bottom: 20px;
	width: 20px;
}

input.textMsg {
	margin-bottom: 20px;
}


/* div.pagingArea {
	display: inline-block; 
	margin-left: 70px;
}

div.pagingArea button {
	min-width: 60px;
	height: 30px;
	cursor: pointer;
	background: #ffdfdf;
	color: #5d5d5d;
	font-size: 14px;
	font-weight: 600;
	border: none;
	border-radius: 5px;
}

div.pagingArea button:hover {
	background: #fb929e;
	color: #fff;
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
}  */
</style>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 메세지 보관함</title>
</head>
<body>
	<!-- 공유css -->
	<%@ include file="../common/layout.jsp"%>

	<!-- 검색, 목록 -->

	<div class="outer">
		<div class="messageOuter">
			<div class="inContentTitle">
				<img src="<%= request.getContextPath() %>/images/readMsg.png" width="190px" height="200px">
			</div>
			<form method="get">

				<!-- <input type="text" class="textMsg" size="20">
			   	<input type="submit" id="searchButton" class="button" value="검색"> -->
				<div class="messageControll">
					<input type="button" onclick="location.href='<%=request.getContextPath()%>/listSend.ms'" value=" 보낸쪽지함 " id="sendMsgButton" class="sendMsgButton"
						role="button" aria-disabled="false">
					<input type="button" id="deleteButton" class="deleteButton" role="button" aria-disabled="false" value="선택쪽지 삭제">
				</div>

				<div class="tableTitle">
					<table id="msgArea">
						<tr>
							<th><div class="tableCol checkBox">
									<input type="checkbox" name="check" id="aCheck" onclick="allCheck(this);">
								</div></th>
							<th><div class="tableCol receiver">발신자</div></th>
							<th><div class="tableCol subject">제목</div></th>
							<th><div class="tableCol sendDate">발신일</div></th>
						</tr>

						<!-- 이따가 조회 리스트 추가 -->
						<%
							if (mList.isEmpty()) {
						%>

						<tr>
							<td colspan="4">조회된 리스트가 없습니다.</td>
						</tr>
						<%
							} else {
								for (Message m : mList) {
						%>
						<tr>
							<td><input type="checkbox" name="check" class="check" data-mNum="<%=m.getMsgNum()%>"></td>
							<td class="rId"><input type="hidden" class="mNum"
								name="mNum" value='<%=m.getMsgNum()%>'><%=m.getSNick()%><input
								type="hidden" value='<%=m.getSNick()%>'></td>
							<td class="mTitle"><%=m.getMsgTitle()%><input
								type="hidden" value='<%=m.getMsgTitle()%>'></td>
							<td><%=m.getMsgDate()%><input type="hidden"
								value='<%=m.getMsgDate()%>'></td>
						</tr>

						<%
							}

							}
						%>
						
					</table>
						
							<!-- 하단에 페이징 번호 -->
					<div class="pagingArea" align="center">
						<%
							if (!mList.isEmpty()) {
						%>
						<button type="button" onclick="location.href='<%=request.getContextPath()%>/list.ms?currentPage=1'">&lt;&lt;</button>
	
	
						<!-- 이전 페이지 -->
						<button type="button" onclick="location.href='<%=request.getContextPath()%>/list.ms?currentPage=<%=currentPage - 1%>'" id="beforeBtn">&lt;</button>
						<!-- 이전 페이지 갈 작동 함수 필요 -->
						<script>
						if(<%=currentPage%> <= 1){
							var before = $('#beforeBtn');
							before.attr('disabled', 'true'); // 첫번째 페이지면 클릭이 안되게 한다. 
						}
					
					</script>
	
						<!-- 10개의 페이지 목록 -->
						<%
							for (int p = startPage; p <= endPage; p++) {
						%>
						<%
							if (p == currentPage) {
						%>
						<button id="choosen" type="button" disabled><%=p%></button>
						<%
							} else {
						%>
						<button id="numBtn" type="button" onclick="location.href='<%=request.getContextPath()%>/list.ms?currentPage=<%=p%>'"><%=p%></button>
						<%
							}
						%>
						<%
							}
						%>
						<!-- 다음 페이지 -->
						<button type="button" onclick="location.href='<%=request.getContextPath()%>/list.ms?currentPage=<%=currentPage + 1%>'"
							id="afterBtn">&gt;</button>
						<script>
						if(<%=currentPage%> >= <%=maxPage%>){
							var after = $("#afterBtn");
							after.attr('disabled', 'true');
						}
					</script>
	
						<!-- 맨 끝으로 -->
						<button type="button" onclick="location.href='<%=request.getContextPath()%>/list.ms?currentPage=<%=maxPage%>'">&gt;&gt;</button>
						<%
							}
						%>
					</div>
				</div>
				
			</form>
		</div>



	</div>




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

			<%if (loginUser != null) {%>
				location.href='<%=request.getContextPath()%>/detail.ms?mNum=' + mNum;
			<%} else {%>
			 alert("로그인 후에 이용해주세요.");
			 
			 location.href='<%=request.getContextPath()%>/index.jsp';
	<%}%>
		});

		$('.deleteButton').click(function() {
			var checkArr = new Array();
			
			var checkBox = $("input:checkbox[name='check']").is(":checked");
			console.log(checkBox);
			
			
			if(checkBox){
				var confirm1 = confirm("정말 삭제하시겠습니까?");
				

				if (confirm1) {
					$('input[class="check"]:checked').each(function() {
						checkArr.push($(this).attr("data-mNum")); //체크한 쪽지 배열로 저장
						console.log(checkArr);
					});
				}

				jQuery.ajaxSettings.traditional = true;

				//ajax실행해서 배열로 값넘긴 후에 deleteM실행한 후에 다시 돌아온다. 
				$.ajax({
					url : 'deleteM.ms',
					type : 'post',
					data : {
						checkArr : checkArr
					}, //쉼표로 구분
					success : function(data) {
						alert(data);
						window.location.href = 'list.ms';

					}

				});
			} else {
				confirm1 = alert("삭제할 쪽지를 선택하세요.");
			}
		});
	</script>	



</body>
</html>