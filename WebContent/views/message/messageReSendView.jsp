<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Date, message.model.vo.Message, knBoard.model.vo.KnBoard"%>
<%-- <% 
	Message m = ((Message)request.getAttribute("message"));
	String mNum = request.getParameter("mNum");
	String ssgId = m.getSsgId();
	String rsgId = m.getRsgId();
	String mTitle = m.getMsgTitle();
	String mCon = m.getMsgCon();
	Date mDate = m.getMsgDate();
%>  --%>  
<%
	String rsgId = request.getParameter("id");
	System.out.println("rsgId11 + " + rsgId);
	String rnick = request.getParameter("sNick");
	System.out.println("받는이 msg닉뭐임 + " + rnick);
	String ssgId = ((AllUser)session.getAttribute("loginAu")).getAuId();
	
	
/* 	String rsgId = request.getParameter("id");
	System.out.println("rsgId11 + " + rsgId);
	String rnick = (String)request.getSession().getAttribute("nickname");
	System.out.println("받는이 msg닉뭐임 + " + rnick);

	String ssgId = ((AllUser)session.getAttribute("loginAu")).getAuId();
	 */
	/* Message m = ((Message)request.getAttribute("message"));
	 
	 System.out.println("답장확인 + " + m.getMsgTitle() + m.getMsgCon() + m.getSNick() + m.getSsgId());
 */
 
 
 
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
	margin-left: 870px;

}

input#sendMsgButton {
	text-align: left;
	margin-right: 200px;
	margin-bottom: 20px;
	margin-left: 30px;
	
}

textarea.con{
	margin-top:20px;
}

div.input-button {display: block; padding: 20px;}
input[type="button"]{min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
input[type="button"]:hover {background: #fb929e; color: #fff;}

input#searchButton {
	margin-bottom: 20px;
	width: 20px;
	

}

input.text{
	margin-bottom: 20px;

}


span.messageControll{
	align-content: center;
	text-align: center;
}	


input#insertBtn {
	width: 90px; 
	height: 36px; 
	background: #ffdfdf;
	color: #5d5d5d;
	font-size: 14px;
	font-weight: 600;
	border: none;
	border-radius: 5px;
}

input#insertBtn:hover {
	background: #fb929e;
	color: #fff;
}

input#menuBtn {
	width: 90px; 
	height: 36px; 
	display: inline-block;
	margin-left: 10px;
	background: #aedefc;
	font-size: 14px;
	font-weight: 600;
	color: #5d5d5d;
	border:none;
	border-radius: 5px;

}

input#menuBtn:hover {
	background: #0774b7;
	color: white;
}


div.pagingArea{margin-left: 70px;}
div.pagingArea button {
	min-width: 60px; 
	height: 30px; 
	cursor: pointer; 
	background: #ffdfdf; color: #5d5d5d; 
	font-size: 14px; 
	font-weight: 600; 
	border: none; 
	border-radius: 5px;
}
div.pagingArea button:hover {background: #fb929e; color: #fff;}



div.menu{
	margin-top:600px;
	
}

table#msgArea {	
	border-spacing: 5px;
	text-align: left;
	margin-left:10px;
	padding-bottom: 20px;
	height: 600px;
}
div.title{
	border-spacing: 5px;
	padding-bottom: 20px;
	margin-top:100px;
}


#msgArea tr:nth-child(1){border-bottom: 1px solid #5d5d5d; background-color: #fcc6c9; font-weight: bold;}
#msgArea th{padding:5px;} 
#msgArea textArea{border: 1px solid #fcc6c9;}


</style>

<meta charset="UTF-8">
<title>꼬리스컴바인 : 쪽지 보내기</title>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	
	
	<div class="outer">
		<div class="messageOuter">
			<div class="inContentTitle"><img src="<%= request.getContextPath() %>/images/sendM.png" width="190px" height="200px"></div>
			<form action="" id="sendForm" method="post"> 
			<div class="tableTitle">
				<table id="msgArea">
					<tr>
					
						<th>수신자 : <input type="hidden" name="rsgId" value="<%= request.getParameter("ssgId") %>"><input type="hidden" name="rNick" value="<%= request.getParameter("sNick") %>"><%= request.getParameter("sNick") %> </th>
					</tr>
					<tr class="title">
						<th>제목 : <input type="text" size="120" name="title" value="Re: <%= request.getParameter("mTitle") %>"></th>
					</tr>
					<tr>
						<td>
							<textarea class="con" name="con" cols="130" rows="25" style="resize:none;" > 
  
	   ------ 원문 -------------------------------------------------------------------------- 
		
							
	   <%= request.getParameter("mCon") %>
		
		
	   --------------------------------------------------------------------------------------
							
							</textarea>
						</td>
					</tr>
					
				</table>
					<span class="messageControll">
						<input type="button" id="insertBtn" value="보내기">
						<input type="button" onclick="javascript:history.back();" id="menuBtn" value="취소">
					</span>
			</div>
			</form>
		</div>
	</div>
		<script>
		$("#insertBtn").click(function(){
			var bool = confirm("쪽지를 보내시겠습니까?");
			
			if(bool) {
				$('#sendForm').attr('action', '<%= request.getContextPath() %>/insert.ms');
				$('#sendForm').submit();
				
			} else {

				return false;
			}
		});
		
	</script>

	
	
	


</body>
</html>