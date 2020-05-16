<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="knBoard.model.vo.*, java.util.ArrayList, java.sql.Date, photo.model.vo.*"%>
<%
	KnBoard kn = (KnBoard)request.getAttribute("board");
	ArrayList<KnReply> list = (ArrayList<KnReply>)request.getAttribute("list");
	ArrayList<Photo> pList = (ArrayList<Photo>)request.getAttribute("pList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 지식 공유 글보기</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.contextMenu.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.ui.position.js"></script>
<link href="<%= request.getContextPath() %>/css/index.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
<style>
	div.contents{width: 60%; min-width: 600px;}
	#blogo{width: 100%; margin-top: 50px; text-align: center;}
	.writeArea{width: 100%; height: 750px; margin: auto; padding: 20px;}
	#tableD{width: 100%;}
	#tableD.th, td{word-spacing: 3px; padding: 4px;}
	#tableD.tfoot > th, td{padding-top: 5px;}
	#knt{font-size: 20px; font-weight: 900; text-align: center;}
	content{font-family: inherit;}
	.aleft{font-weight: 600; min-width:300px;}
	tr > td > #title{font-weight: 800; color: gray;}
	#writeBorder{border: 1px solid #fcc6c9; width: 100%; height: 550px; margin: 10px 0;}
	#kncon{width: 100%; height: 100%; padding: 10px; overflow: auto;}
	#imgArea {margin: 10px;}
	#kncon > #imgArea > img {width:45%; height:auto; align-content: center;}
	#writeTd{min-width: 250px;}
	#updateBtn{text-align: center; border: none; border-radius: 5px; width: 80px; height: 35px;}
	#deleteBtn{font-size: 14px; font-weight: 600; text-align: center; border: none; border-radius: 5px; width: 80px; height: 35px; background: #ffdfdf; color: #5d5d5d;}
	#deleteBtn:hover{cursor: pointer; background: #fb929e; color: #fff;}	
	#listBtn{font-size: 14px; font-weight: 600; text-align: center; border: none; border-radius: 5px; width: 80px; height: 35px; background: #ffdfdf; color: #5d5d5d;}
	#listBtn:hover{cursor: pointer; background: #fb929e; color: #fff;}		
	table#knb_reply{width: 100%; margin: 0 20px;}
	tr#knr_area{max-height: 80px;}
	#knb_replyTable {width: 100%; margin: 0 20px; padding-top: 0px; padding-bottom: 0px;}
	#knb_replyTable > tr {max-height: 100px;}
	textarea#rCon {width: 100%; padding: 5px; resize: none; border: 1px solid #bfbfbf; outline: none;}
	#RreplyBtn{min-width: 100px; height: 30px; cursor: pointer; background: #aedefc; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
	#RreplyBtn:hover {color: #fff;}
	#reSendBtn{width: 60px; height: 60px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 16px; font-weight: 600; border: none; border-radius: 5px;}
	
	#knb_replyTable td {height: 40px;}
	
	textarea {
      width: 100%;
      resize: none;
      overflow-y: hidden; /* prevents scroll bar flash */
      padding: 1.1em; /* prevents text jump on Enter keypress */
      padding-bottom: 0.2em;
      line-height: 1.6;
    }
	
	
	
</style>
</head>
<body>
<%@ include file="../common/layout.jsp" %>   
	<div class="container">
		<div class="contents">
			<div id="blogo"><img src="<%= request.getContextPath() %>/images/knb.png"></div>
			<form action="views/knBoard/knBoardUpdate.jsp" id="detailForm" method="post">
				<div class="writeArea">			
					<table id="tableD">
						<tr>
							<td colspan=2 class="aleft"><!-- 제목 &nbsp;&nbsp; -->
								<span id="knt"><%= kn.getknTitle() %></span>
							</td>				
						</tr>
						<tr>
							<td class="aleft" width="50%">글쓴이&nbsp;&nbsp;
								<span id=id-menu style="font-size:15px; font-weight: 300"><input type="hidden" name="usId" value="<%= kn.getUsId()%>"><%= kn.getUsNick() %></span>
							</td>
							<td class="aleft">날짜&nbsp;&nbsp;
								<span style="font-size:15px; font-weight: 300"><%= kn.getKnDate() %></span>
							</td>
						</tr>
						<!-- <tr>
							<td colspan=2 class="aleft">내용</td>
						</tr> -->
						<tr>
							<td colspan="2">
								<div id = "writeBorder" style="overflow: auto;">
									<div id="kncon">
										<textarea style="overflow: visible; border: 0px; resize: none;" readonly><%= kn.getKnCon() %></textarea>
										<script>
										$("textarea").css('height', 'auto' );
								        $("textarea").height($("textarea")[0].scrollHeight);	
			 							</script>
										<div id = "imgArea">
										<% if(pList != null) { %>
										<% for(int i = 0; i < pList.size(); i++){ %>
											<img style="height: 150px; width: auto;" id="detailImg" class="detailImg" src="<%= request.getContextPath() %>/thumbnail_uploadFiles/<%= pList.get(i).getPhChng() %>">
											<input type="hidden" value="<%= pList.get(i).getPhChng() %>" name="detailImg<%= i %>">
											<input type="hidden" value="<%= pList.get(i).getPhNum() %>" name="detailImgId<%= i %>">
										<% } %>
										<% } %>
										</div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan=2 style="text-align: center;">
						<% if(loginUser != null) {%>
						<% if(loginAu != null && loginUser.getUsNick().equals(kn.getUsNick())) {%>
							<input type="submit" id="updateBtn" value="수정">
							<input type="button" onclick="deleteKn();" id="deleteBtn" value="삭제">
							<input type="button" onclick="location.href='<%= request.getContextPath() %>/list.kn'" id="listBtn" value="목록으로">
						<% } else {%>
							<input type="button" onclick="location.href='<%= request.getContextPath() %>/list.kn'"  id="listBtn" value="목록으로" style= "">
						<% } %>
						<% } else if(loginAu != null && loginAu.getAuKind().equals("ADMIN")){ %>
							<input type="submit" id="updateBtn" value="수정">
							<input type="button" onclick="location.href='<%= request.getContextPath() %>/list.kn'" value="목록으로" style= "">
						<% }else{ %>
							<input type="button" onclick="location.href='<%= request.getContextPath() %>/list.kn'"  id="listBtn" value="목록으로" style= "">
						<% } %>
							</td>
						</tr>
					</table>
					<!--  넘길 값 -->				
					<input type="hidden" value="<%= kn.getKnNum() %>" name="no">
					<input type="hidden" value="<%= kn.getknTitle() %>" name="title">		
					<input type="hidden" value="<%= kn.getKnCon() %>" name="content">	
					<input type="hidden" value="<%= kn.getUsNick() %>" name="knNick">										
				</div>		
			</form>	
			<% if(loginAu != null ){%>						
			<table id="knb_reply">
				<tr id="knr_area">
					<td width="60%">
						<textarea rows="3" id="rCon" placeholder="댓글을 입력해주세요."></textarea>	
					</td>
					<td width="10%"><button id="RreplyBtn">댓글 등록</button></td>
				</tr>
			</table>
			<% } %>
			<% if(loginAu != null ){%>				
			<div id="knb_replyArea">						
				<table id="knb_replyTable">
					<% if(list.isEmpty()){ %>
						<tr><td colspan="3"></td></tr>
					<% } else { %>
						<% for(int i = 0; i < list.size(); i++){ %>
							<tr id="knrWriter">
								<td width="100px" height="50px;"><%= list.get(i).getUsId() %></td>							
								<td width="400px" height="50px;"><%= list.get(i).getKnrCon() %></td>
								<td width="200px" height="50px;"><%= list.get(i).getKnrDate() %></td>
							</tr>						
						<% } %>						
					<% } %>						
				</table>
			</div>
			<script>
			    // 댓글 관련 유저일 경우 ajax싫행 병원, 관리자는 alert(유저만 등록가능);		
	    		$('#RreplyBtn').click(function(){
	    			<%if(loginUser != null){%>
		    		var id = '<%= loginUser.getUsId() %>';
					var no = <%= kn.getKnNum() %>;
					var content = $('#rCon').val();
				
					$.ajax({
						url: '<%= request.getContextPath() %>/insertReply.kn',
						type: 'post',
						data: {id: id, content: content, no: no},
						success: function(data){
							$knb_replyTable = $('#knb_replyTable');
							$knb_replyTable.html("");
							for(var i in data){
								var $tr = $('<tr>');
								var $writerTd = $('<td width="15%">').text(data[i].usId);							
								var $contentTd = $('<td width="70%">').text(data[i].knrCon);
								var $dateTd = $('<td width="15%">').text(data[i].knrDate);

								$tr.append($writerTd);
								$tr.append($contentTd);
								$tr.append($dateTd);
								$knb_replyTable.append($tr);
							}
							
							$('#rCon').val('');
						}	
					});
					<%} else {%>
					alert("댓글은 유저만 등록가능합니다.");
					<%}%>
				});			
			</script>
			<% } %>
		</div>
	</div>
	<script>
    	// 삭제
	      function deleteKn(){
	         var bool = confirm('정말로 삭제하시겠습니까?');
	         if(bool){
	            $('#detailForm').attr('action', '<%= request.getContextPath() %>/delete.kn');
	            $('#detailForm').submit();
	         }
	      }    	

			// context
			var i = jQuery.noConflict();
			i(document).ready(function() {
		        $.contextMenu({
		            selector: '#id-menu', 
		            callback: function(key, options) {
		                var usId = $('[name=usId]').val();
		                console.log(usId);
						location.href='<%= request.getContextPath() %>/views/message/messageSendView.jsp?id=' + usId+'&nickname=<%= kn.getUsNick() %>';
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