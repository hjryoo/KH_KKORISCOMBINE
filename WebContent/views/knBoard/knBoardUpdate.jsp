<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, java.sql.Date, photo.model.vo.*"%>
<%
	String title = request.getParameter("title");
	String con = request.getParameter("content");
	String nick = request.getParameter("knNick");
	
	ArrayList<String> images = new ArrayList<String>();
	for(int i = 0; i < 5; i++){
		images.add(request.getParameter("detailImg" + i) == null ? "" : "src=" + request.getContextPath() + "/thumbnail_uploadFiles/" + request.getParameter("detailImg" + i));
	}
	
	ArrayList<String> fIds = new ArrayList<String>();
	for(int i = 0; i < 5; i++){
		fIds.add(request.getParameter("detailImgId" + i) == null ? "" : request.getParameter("detailImgId" + i));
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 지식 공유 글수정</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/index.css"/>
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
	tr > td > #title{font-weight: 800;}
	#writeBorder{border: 1px solid #fcc6c9; width: 800px; height: 550px;}
	#kncon{align: auto; width: 850px; max-height: 680px; margin-left: 10px; margin-top: 10px; margin-right: 10px; margin-botton: 10px; overflow: auto;}
	#kncon > img {width:200px; height:200px;}
	#writeTd{min-width: 250px;}
	.knb_photo {padding-top: 15px;}
	#updateBtn{font-size: 15px; text-align: center; border: 1px solid #575756; border-radius: 5px; width: 80px; height: 35px;}
	#cancleBtn{font-size: 15px; text-align: center; border: 1px solid #575756; border-radius: 5px; width: 80px; height: 35px; cursor: pointer;}
	div#photo{position: absolute; width: 100%; padding: 0 20px;}
	#contentImgArea4:hover, #contentImgArea5:hover, #contentImgArea6:hover, #contentImgArea7:hover {cursor:pointer;}
	#contentImgArea4, #contentImgArea5, #contentImgArea6, #contentImgArea7{width: 24.6%; height: 120px; border:1px dashed #fcc6c9; text-align:center; display:inline-block; vertical-align:middle;}
	figcaption {color: #5d5d5d; background: rgba(255, 223, 223, 0.2); padding: 1em; line-height: 1; position: absolute; left: 0; right: 0; bottom: 0;}
	figure {margin: 0; line-height: 0; position: relative;}
	textarea.knContent {width: 100%; padding: 5px; border: 1px solid #bfbfbf; resize:none; outline: none;}
</style>
</head>
<body>
<%@ include file="../common/layout.jsp" %>   
	<div class="container">
		<div class="contents">
			<div id="blogo"><img src="<%= request.getContextPath() %>/images/knb.png"></div>
		<!-- 지식 공유게시판 글수정 -->
			<form action="<%= request.getContextPath() %>/update.kn" method="post" encType="multipart/form-data">
				<div class="writeArea">			
					<table>
						<tr>
							<td class="aleft">제목
							</td>				
						</tr>
						<tr>
							<td><input type="text" size="50" name="title" id="title" class="input" value="<%= title %>"></td>
						</tr>					
	
						<tr>
							<td class="aleft">내용</td>
						</tr>
						<tr>
							<td colspan="4">
								<textarea name="con" rows="15" class="knContent"><%= con %></textarea>
								<div>
									<% for(int i = 0; i < 4; i++){ %>				
										<img id="contentImg<%=i%>" width="24.6%" height="120" <%= images.get(i) %>> 				
										<input type="hidden" id="detailImgId<%=i%>" name="detailImgId<%=i%>" value="<%= fIds.get(i) %>"> 
										<input type="hidden" id="cContent<%= i %>" name="cContent<%= i %>">					
									<% } %>	
								</div>
							</td>
						</tr>
						<tr>
							<th colspan="4" class="knb_photo">
								<input type="submit" id="updateBtn" value="수정">
								<input type="button" onclick="location.href='<%= request.getContextPath() %>/list.kn'" id="cancleBtn" value="취소">
							</th>
						</tr>
					</table>				
					<br><br><br>			
				</div>	
				<input type="hidden" name="bNum" value="1">
				<div id = "photo">
					<div id="contentImgArea4">
						<figure>
							<img id="contentImg4" width="100%" height="120" style= "border:0">
							<figcaption>사진 첨부</figcaption>
						</figure>
					</div>
					<div id="contentImgArea5">
						<figure>
							<img id="contentImg5" width="100%" height="120" style= "border:0"> 
							<figcaption>사진 첨부</figcaption>
						</figure>
					</div>
					<div id="contentImgArea6">
						<figure>
							<img id="contentImg6" width="100%" height="120" style= "border:0"> 
							<figcaption>사진 첨부</figcaption>
						</figure>
					</div>
					<div id="contentImgArea7">
						<figure>
							<img id="contentImg7" width="100%" height="120" style= "border:0"> 
							<figcaption>사진 첨부</figcaption>
						</figure>
					</div>
					<div id="fileArea">
						<input type="file" id="thumbnailImg1" multiple="multiple" name="thumbnailImg1" onchange="LoadImg(this,1)">
						<input type="file" id="thumbnailImg2" multiple="multiple" name="thumbnailImg2" onchange="LoadImg(this,2)">
						<input type="file" id="thumbnailImg3" multiple="multiple" name="thumbnailImg3" onchange="LoadImg(this,3)">
						<input type="file" id="thumbnailImg4" multiple="multiple" name="thumbnailImg4" onchange="LoadImg(this,4)">
					</div>
				</div>
					<!-- 보낼 값 -->
					<input type="hidden" name="no" value="<%= request.getParameter("no") %>">
			</form>			
		</div>
	</div>
	<script>

		// 내용 작성 부분의 공간을 클릭할 때 파일 첨부 창이 뜨도록 설정하는 함수
		$(function(){
			$("#fileArea").hide();
			
			$("#contentImgArea4").click(function(){
				$("#thumbnailImg1").click();
			});
			$("#contentImgArea5").click(function(){
				$("#thumbnailImg2").click();
			});
			$("#contentImgArea6").click(function(){
				$("#thumbnailImg3").click();
			});
			$("#contentImgArea7").click(function(){
				$("#thumbnailImg4").click();
			});
		});
		
		// 각각의 영역에 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
		function LoadImg(value, num){
			if(value.files && value.files[0]){
				var reader = new FileReader();
				
				reader.onload = function(e){								
					switch(num){
					case 1: 
						$("#contentImg4").attr("src", e.target.result);
						break;
					case 2:
						$("#contentImg5").attr("src", e.target.result);
						break;
					case 3: 
						$("#contentImg6").attr("src", e.target.result);
						break;
					case 4:
						$("#contentImg7").attr("src", e.target.result);
						break;
					}
				}
				
				reader.readAsDataURL(value.files[0]);
			}
		} 	
		
		$('#updateBtn').click(function(){
			var c0 = $("#contentImg4").attr('src');
			var c1 = $("#contentImg5").attr('src');
			var c2 = $("#contentImg6").attr('src');
			var c3 = $("#contentImg7").attr('src');
			
			if(typeof(c0) != 'undefined'){
				$("#cContent0").val($("#contentImg4").attr('src').substring(0, 4));
			}
			if(typeof(c1) != 'undefined'){
				$("#cContent1").val($("#contentImg5").attr('src').substring(0, 4));
			}
			if(typeof(c2) != 'undefined'){
				$("#cContent2").val($("#contentImg6").attr('src').substring(0, 4));
			}
			if(typeof(c3) != 'undefined'){
				$("#cContent3").val($("#contentImg7").attr('src').substring(0, 4));
			}
			
			$('.insertArea').parent().submit();
		});		
		

	</script>
</body>
</html>