<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	Hospital hp = (Hospital)request.getAttribute("hp");
	String date = (String)request.getAttribute("date");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 후기 게시판 글쓰기</title>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.raty.js"></script>
<style>
	div.contents{width: 60%; min-width: 600px;}
	#blogo{width: 100%; margin-top: 50px; text-align: center;}
	.writeArea{width: 100%; margin: auto; padding: 20px;}
	table{width: 100%; margin-top: 3px;}
	table, th, td{word-spacing: 3px; padding: 3px;}
	table > tfoot > th, td{padding-top: 5px;}
	.aleft{font-weight: 800;}
	.input{font-family: inherit; width: 93%; margin-left: 2%; border: 0; border-bottom: 1px solid #575756; outline: 0; background: transparent; transition: border-color 0.2s; padding: 2px 5px;}	
	table > tr> title{cursor: text;}
	#writeTd{width: 300px;}
	content{font-family: inherit; cursor: text; }
	#writeBtn{font-size: 15px; margin-left: 50px;  text-align: center; border: 1px solid #575756; border-radius: 5px; width: 80px; height: 35px;}
	#cancleBtn{font-size: 15px; text-align: center; border: 1px solid #575756; border-radius: 5px; width: 80px; height: 35px;}
	div#photo{position: absolute; width: 100%; padding: 0 20px;}
	#titleImgArea:hover, #contentImgArea1:hover, #contentImgArea2:hover, #contentImgArea3:hover {cursor:pointer;}
	#titleImgArea, #contentImgArea1, #contentImgArea2, #contentImgArea3 {width:24.6%; height: 120px; border:1px dashed #AEDEFC; text-align:center; display:inline-block; vertical-align:middle;}
	figcaption {color: #5d5d5d; background: rgba(255, 223, 223, 0.2); padding: 1em; line-height: 1; position: absolute; left: 0; right: 0; bottom: 0;}
	figure {margin: 0; line-height: 0; position: relative;}
	textarea.rvContent {width: 100%; padding: 5px; border: 1px solid #bfbfbf; resize:none; outline: none;}
</style>
</head>
<body>
<%@ include file="../common/layout.jsp" %> 
	<div class="container">
		<div class="contents">
			<div id="blogo"><img src="<%= request.getContextPath() %>/images/rvb.png"></div>
		<!-- <h1>후기 게시판 글쓰기</h1> -->
		<form action="<%= request.getContextPath() %>/write.rv" method="post" encType="multipart/form-data">
			<div class="writeArea">	
				<table>
					<tr>
						<td class="aleft" colspan="3">
							<span>제목</span><input type="text" size="50" name="title" class="input">
						</td>
					</tr>
					<tr>
						<td class="aleft">병원명 <span><%= hp.getHpName() %></span>
							<input type="hidden" name="hpId" value="<%= hp.getHpId() %>">
						</td>
						<td class="aleft">날짜 <%= date %>
							<input type="hidden" name="date" value="<%= date %>">
						</td>
						<td class="aleft"><!-- 별점 -->
							 <div id="star" ></div>
						</td>							
					</tr>
					<tr>
						<td class="aleft">내용</td>					
					</tr>
					<tr>
						<td colspan="3">
							<textarea name="content" class="rvContent" rows="15" style="resize:none;"></textarea>
						</td>
					</tr>
					<tfoot>
					<tr>
						<th colspan="3" class="knb_photo" style="padding-top:20px;">
							<input type="submit" id="writeBtn" value="글쓰기">
							<input type="button" id="cancleBtn" value="취소" onclick="location.href='<%= request.getContextPath() %>/list.rv'">
						</th>
					</tr>
					</tfoot>
				</table>				
			</div>
			<div id="photo">
					<div id="titleImgArea">
						<figure>
							<img id="titleImg" width="100%" height="120" style= "border:0">
							<figcaption>사진 첨부</figcaption>
						</figure>
					</div>
					<div id="contentImgArea1">
						<figure>
							<img id="contentImg1" width="100%" height="120" style= "border:0"> 
							<figcaption>사진 첨부</figcaption>
						</figure>
					</div>
					<div id="contentImgArea2">
						<figure>
							<img id="contentImg2" width="100%" height="120" style= "border:0"> 
							<figcaption>사진 첨부</figcaption>
						</figure>
					</div>
					<div id="contentImgArea3">
						<figure>
							<img id="contentImg3" width="100%" height="120" style= "border:0"> 
							<figcaption>사진 첨부</figcaption>
						</figure>
					</div>
					<div id="fileArea">
						<input type="file" id="thumb1" multiple="multiple" name="thumb1" onchange="LoadImg(this,1)">
						<input type="file" id="thumb2" multiple="multiple" name="thumb2" onchange="LoadImg(this,2)">
						<input type="file" id="thumb3" multiple="multiple" name="thumb3" onchange="LoadImg(this,3)">
						<input type="file" id="thumb4" multiple="multiple" name="thumb4" onchange="LoadImg(this,4)">
					</div>
				</div>
			</form>		
		</div>
	</div>
		<script>
			// 별점 부분
			var i = jQuery.noConflict();
			var star = null;
			i(document).ready(function() {
	            $('div#star').raty({
	                path : "<%= request.getContextPath() %>/images",
	                width : 200,
	                half: false,
	                halfShow: true,
	                click: function(score, evt) {
	                	console.log(score);
	                }              
	            });
	        });
		
			// 파일 첨부 창
			$(function(){
				$("#fileArea").hide();
				
				$("#titleImgArea").click(function(){
					$("#thumb1").click();
				});
				$("#contentImgArea1").click(function(){
					$("#thumb2").click();
				});
				$("#contentImgArea2").click(function(){
					$("#thumb3").click();
				});
				$("#contentImgArea3").click(function(){
					$("#thumb4").click();
				});
			});
			
			// 미리 보기
			function LoadImg(value, num){
				if(value.files && value.files[0]){
					var reader = new FileReader();
					
					reader.onload = function(e){								
						switch(num){
						case 1: 
							$("#titleImg").attr("src", e.target.result);
							break;
						case 2:
							$("#contentImg1").attr("src", e.target.result);
							break;
						case 3: 
							$("#contentImg2").attr("src", e.target.result);
							break;
						case 4:
							$("#contentImg3").attr("src", e.target.result);
							break;
						}
					}
					reader.readAsDataURL(value.files[0]);
				}
			}
		</script>
</body>
</html>