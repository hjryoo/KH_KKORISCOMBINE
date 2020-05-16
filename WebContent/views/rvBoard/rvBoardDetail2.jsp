<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="rvBoard.model.vo.*, java.util.ArrayList, java.sql.Date, photo.model.vo.*"  %>
<%
	RvBoard rv = (RvBoard)request.getAttribute("board");
	String id = rv.getUsId();
	String swriter = id.substring(0, 2);
	for(int i = 0; i < id.length(); i++) {
		swriter += "*";
	}
	ArrayList<Photo> pList = (ArrayList<Photo>)request.getAttribute("pList");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 후기 게시판 글보기</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.raty.js"></script>

<style>
	div.contents{width: 60%; min-width: 600px;}
	#blogo{width: 100%; margin-top: 50px; text-align: center;}
	.writeArea{width: 100%; height: 750px; margin: auto; padding: 20px;}
	table{margin-top: 3px;}
	table, th, td{word-spacing: 3px; padding: 3px;}
	table > tfoot > th, td{padding-top: 5px;}
	.input{font-family: inherit; width: 90%; border: 0; border-bottom: 1px solid #575756; outline: 0; background: transparent; transition: border-color 0.2s;}	
	table > tr> title{cursor: text;}
	.aleft{font-weight: 800;}
	#writeTd{width: 300px;}
	#writeBorder{border: 1px solid #AEDEFC; width: 800px; height: 550px; }
	#rvt{font-size: 25px; font-weight: 900; text-align: center;}
	#rvcon{align: auto; width: 850px; max-height: 680px; margin-left: 10px; margin-top: 10px; margin-right: 10px; margin-botton: 10px; overflow: auto;}
	#rvcon > img {width:200px; height:200px;}
	#deleteBtn{font-size: 15px; text-align: center; border: 1px solid #575756; border-radius: 5px; width: 80px; height: 35px; background-color: #AEDEFC;}
	#deleteBtn:hover{cursor: pointer; background-color: white;}
	#listBtn{font-size: 15px; text-align: center; border: 1px solid #575756; border-radius: 5px; width: 80px; height: 35px; background-color: #AEDEFC;}
	#listBtn:hover{cursor: pointer; background-color: white;}	
	div#photo{position: absolute; left: 224pt;}
	#likeView{font-weight: 600; margin-right: 20px; }
	#titleImgArea {width:180px; height:180px; border:1px dashed #AEDEFC; text-align:center; display:table-cell; vertical-align:middle; }
	#titleImgArea:hover, #contentImgArea1:hover, #contentImgArea2:hover, #contentImgArea3:hover {cursor:pointer;}
	#contentImgArea1, #contentImgArea2, #contentImgArea3 {width:180px; height:180px; border:1px dashed #AEDEFC; text-align:center; display:table-cell; vertical-align:middle;}
	figcaption {color: #5d5d5d; background: rgba(255, 223, 223, 0.2); padding: 1em; line-height: 1; position: absolute; left: 0; right: 0; bottom: 0;}
	figure {margin: 0; line-height: 0; position: relative;}
</style>
</head>
<body>
<%@ include file="../common/layout.jsp" %>
<form id=detailForm>
	<div class="container">
		<div class="contents">
			<div id="blogo"><img src="<%= request.getContextPath() %>/images/rvb.png"></div>
		<div class="writeArea">	
			<table>
				<tr>
					<td class="aleft" colspan="2">제목
						<input type="hidden" value="<%= rv.getRvNum() %>" name="no">
						<span id="rvt"><%=rv.getRvTitle() %></span>
					</td>			
					<td class="aleft">글쓴이
						<%= swriter %></td>
				</tr>
				<tr>
					<td class="aleft" style="max-width:300px;">병원명
						<%= rv.getHpId() %>
					</td>
					<td class="aleft">날짜
						<%= rv.getRvDate() %>
					</td>
					<td>
						 <div id="star"></div> <!-- 별점 -->
					</td>							
				</tr>
				<tr>
					<td class="aleft">내용</td>					
				</tr>
				<tr>
					<td colspan="3">
					<div id = "writeBorder">
						<div id = "rvcon">
							<%= rv.getRvCon() %>
							<br><br>
							<% if(pList != null) { %>
								<% for(int i = 0; i < pList.size(); i++){ %>
									<img id="detailImg" class="detailImg" src="<%= request.getContextPath() %>/thumbnail_uploadFiles/<%= pList.get(i).getPhChng() %>">
									<input type="hidden" value="<%= pList.get(i).getPhNum() %>" name="detailImg<%= i %>">
								<% } %>
							<% }  %>
						</div>
					</div>	
					</td>
				</tr>
				<tfoot>
				<tr>
					<td colspan=3 style="text-align: center;">
					<% if(loginAu != null && loginUser.getUsId().equals(rv.getUsId())) {%>
						<input type="button" onclick="deleteRv();" id="deleteBtn" value="삭제">
						<input type="button" onclick="location.href='javascript:history.back();'" id="listBtn" value="목록으로">						
					<% } else if(loginAu != null && loginAu.getAuKind().equals("ADMIN")){ %>
						<input type="button" onclick="deleteRv();" id="deleteBtn" value="삭제">
						<input type="button" onclick="location.href='javascript:history.back();'" id="listBtn" value="목록으로">					
					<% } else { %>
						<button id="likeBtn" style="border: 0"><img src="images/like.png" width=50px; height=50px;></button>						
						<span id="likeView"><%= rv.getRvLike() %></span>
						<input type="button" onclick="location.href='javascript:history.back();'" id="listBtn" value="목록으로">
					<%	} %>
					</td>			
					
				</tr>
				</tfoot>
			</table>								
			</div>
		</div>
	</div>
</form>
	<script>
		// 별점 부분
		var i = jQuery.noConflict();
		i(document).ready(function() {
            $('div#star').raty({
                path : "<%= request.getContextPath() %>/images",
                score : <%= rv.getRvStar() %>,
                width : 200,
                half: false,
                halfShow: true,
                readOnly: true
            });
        });
		
    	// 삭제
	      function deleteRv(){
	         var bool = confirm('정말로 삭제하시겠습니까?');
	         if(bool){
		        $('#detailForm').attr('action', '<%= request.getContextPath() %>/delete.rv');
	            $('#detailForm').submit();
	         }
	      }   
    	
    	// 좋아요 버튼	    	
   			$('#likeBtn').on("click", function(e){	
	    		var exId = '<%= loginUser.getUsId() %>';
	    		var writer = '<%= id %>';
				var no = <%= rv.getRvNum() %>;
	    		var like = $('#likeView').text();
				
	    		if(exId == writer){
	    			$(this).attr('disabled', true);
	    		}else{	
					$.ajax({
						url: '<%= request.getContextPath() %>/insertlike.rv',	 
						type: 'post',
						data: {writer: writer, no: no, like: like},
						success: function(data){
							$('#likeView').html(data);
						}		
    				});		
	    		}
   			});
	</script>
</body>
</html>