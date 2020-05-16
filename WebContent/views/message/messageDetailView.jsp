<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Date, message.model.vo.Message"%>
<% 
	Message m = ((Message)request.getAttribute("message"));
	String mNum = request.getParameter("mNum");
	String rNick = m.getRNick();
	String sNick = m.getSNick();
	String rsgId = m.getRsgId();
	String ssgId = m.getSsgId();
	String mTitle = m.getMsgTitle();
	String mCon = m.getMsgCon();
	Date mDate = m.getMsgDate();
	
%>    
<!DOCTYPE html>
<html>
<head>
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

div.inContentTitle{
	margin-left: 880px;

}


span.messageControll {
	margin-left: 500px;

}


input#deleteNoBtn {
	margin-top :10px;
	margin-left :10px;
	min-width: 50px; 
	height: 30px; 
	cursor: pointer; 
	background: #aedefc; color: #5d5d5d; 
	font-size: 14px; 
	font-weight: 600; 
	border: none; 
	border-radius: 5px;
}

input#deleteNoBtn:hover{background: #0774b7; color:white; }


input#reSendBtn {
	margin-top :10px;
	margin-left: 50px;
	min-width: 50px; 
	height: 30px; 
	cursor: pointer; 
	background: #ffdfdf; color: #5d5d5d; 
	font-size: 14px; 
	font-weight: 600; 
	border: none; 
	border-radius: 5px;
}

input#receiveMsgButton{
	text-align: center;
}


input#reSendBtn:hover {background: #fb929e; color: #fff;}

input#sendMsgButton {
	text-align: center;
	margin-left:10px;
	margin-bottom:  0px;
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

#msgArea tr:nth-child(1){border-bottom: 1px solid #5d5d5d; background-color: #fcc6c9; font-weight: bold;}
#msgArea th{padding:5px;} 
#msgArea td{padding:5px; } 
#msgArea textArea{border: 1px solid #fcc6c9;}

</style>

<meta charset="UTF-8">
<title>꼬리스컴바인 : 쪽지 상세보기</title>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	
	
	<div class="outer">
	<div class="messageOuter">
		<div class="inContentTitle"><img src="<%= request.getContextPath() %>/images/readMsg.png" width="190px" height="200px"></div>
		<form action="<%= request.getContextPath() %>/views/message/messageReSendView.jsp" id="detailForm" method="post"> 
			<span class="messageControll">
			   	<!-- <input type="text" class="textMsg" size="20" name="msgNum" > -->
			   	<input type="button" value=" 받은쪽지함 " id="receiveMsgButton" class="receiveMsgButton" role="button" onclick="location.href='<%= request.getContextPath() %>/list.ms'">
			   	<input type="button" value=" 보낸쪽지함 " id="sendMsgButton" class="sendMsgButton" role="button" onclick="location.href='<%= request.getContextPath() %>/listSend.ms'">
			</span> 
		<div class="tableTitle">
			<table id="msgArea">
				<tr>
					<th colspan="6">
						<input type="hidden" name="rsgId" value="<%= rsgId %> ">
						<input type="hidden" name="ssgId" value="<%= ssgId %> ">
						<input type="hidden" name="mNum" value="<%= mNum %>">										
						<input type="hidden" size="50" name="title" value="<%= mTitle %>">
					  	<input type="hidden" name="mTitle" value="<%= mTitle %>"> <%= mTitle %>
					</th>				
				</tr>
				<tr>
					<th>발신자</th>
					<td><input type="hidden" name="sNick" value="<%= sNick %>"><%= sNick %></td>
					<th>수신자</th>
					<td><input type="hidden" name="rNick" value="<%= rNick %>"><%= rNick %></td>
					<th>발신일</th>
					<td><input type="hidden" name="date" value="<%= mDate %>"><%= mDate %></td>
				</tr>
				
				<tr>
					<td colspan="6">
						<textarea type="hidden" name="mCon" cols="130" rows="25" style="resize:none;" readonly>
						
		
		
		<%= mCon %></textarea>
					</td>
				</tr>
				
			</table>
				<input type="submit" id="reSendBtn" value="답장 보내기">	
				<input type="button" onclick="deleteNo();" id="deleteNoBtn" value="삭제">	
		</div>
		</form>
	</div>
	</div>

	<script>
		function deleteNo(){
			var bool = confirm('정말로 삭제하시겠습니까? \n ※ 삭제한 쪽지는 복구가 불가능 합니다.');
			if(bool){
				$('#detailForm').attr('action', '<%= request.getContextPath() %>/delete.ms');
				$('#detailForm').submit();
			}
		}	
		
		
		
	</script>
	
	


</body>
</html>