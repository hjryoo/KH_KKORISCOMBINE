<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 지식 공유 글쓰기</title>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<style>
	div.contents{width: 60%; min-width: 600px;}
	#blogo{width: 100%; margin-top: 50px; text-align: center;}
	.writeArea{width: 100%; margin: auto; padding: 20px;}
	table{width: 100%; margin-top: 3px;}
	table > tfoot > th, td{padding-top: 5px;}
	.input{font-family: inherit; width: 100%; border: 0; border-bottom: 1px solid #575756; outline: 0; background: transparent; transition: border-color 0.2s; padding: 2px 5px;}	
	table > tr> title{cursor: text;}
	title{cursor: text;}
	content{font-family: inherit; cursor: text; }
	.aleft{font-weight: 800;}
	.knb_photo {padding-top: 15px;}
	#writeBtn{font-size: 15px; text-align: center; border: 1px solid #575756; border-radius: 5px; width: 80px; height: 35px;}
	#cancleBtn{font-size: 15px; text-align: center; border: 1px solid #575756; border-radius: 5px; width: 80px; height: 35px;}
	div#photo{position: absolute; width: 100%; padding: 0 20px;}
	#titleImgArea:hover, #contentImgArea1:hover, #contentImgArea2:hover, #contentImgArea3:hover {cursor:pointer;}
	#titleImgArea, #contentImgArea1, #contentImgArea2, #contentImgArea3 {width:24.6%; height: 120px; border:1px dashed #fcc6c9; text-align:center; display:inline-block; vertical-align:middle;}
	figcaption {color: #5d5d5d; background: rgba(255, 223, 223, 0.2); padding: 1em; line-height: 1; position: absolute; left: 0; right: 0; bottom: 0;}
	figure {margin: 0; line-height: 0; position: relative;}
	textarea.knContent {width: 100%; padding: 5px; border: 1px solid #bfbfbf; resize:none; outline: none;}
</style>
</head>
<body>
<%@ include file="../common/layout.jsp" %>   
	<div class="container">
		<div class="contents">
			<div id="blogo"><img src="../../images/knb.png"></div>
		<br>
		<!-- <h1>지식 공유게시판 글쓰기</h1> -->
		<form action="<%= request.getContextPath() %>/write.kn" method="post" encType="multipart/form-data">
			<div class="writeArea">			
				<table>
					<tr>
						<td class="aleft" rownum="2">제목
						</td>				
					</tr>
					<tr>
						<td><input type="text" size="50" name="title" class="input"></td>
					</tr>					
					<tr>
						<td class="aleft">내용</td>
					</tr>
					<tr>
						<td colspan="4">
							<textarea name="content" class="knContent" rows="15"></textarea>
						</td>
					</tr>
					<tr>
						<th colspan="4" class="knb_photo">
							<input type="submit" id="writeBtn" value="글쓰기">
							<input type="button" id="cancleBtn" value="취소" onclick="location.href='<%= request.getContextPath() %>/list.kn'">
						</th>
					</tr>
				</table>				
				<br><br><br>			
			</div>	
			<input type="hidden" name="bNum" value="1">
			<div id = "photo">
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