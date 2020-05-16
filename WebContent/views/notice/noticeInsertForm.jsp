<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 공지사항 글쓰기</title>
<%@ include file="../common/layout.jsp" %>
<style>
	label{font-weight: bold;}
	div.container {
		position: absolute; top:0; left:0; 
		padding-left:200px; width: 100%; height: 100%; 
		margin: 0 auto; box-sizing: border-box;
	}
	section.Nmain {
		position:relative; height:100%; width:100%; 
		background-size: contain;
	}
	section.Nmain > article.NquickMenu {
		position: relative; width: 100%; height: 100%; 
	}
	
	section.Nmain > article.NquickMenu > h1{
		position: relative;
		margin: 0 auto;
		font-size: 40px;
		width: 220px;
		text-align: center;
		vertical-align: middle;
	}
	
	section.Nmain > article.NquickMenu > form.noticeInsertC{
		position: relative;
		margin: 0 auto;
		width: 80%;
		height: 70%;
		min-width: 500px;
		padding: 10px;
	}
	article.NquickMenu > form.noticeInsertC > div.title{
		position: relative;
		margin: 0 auto;
		width: 65%; height: 25px;
		vertical-align: middle;
	}
	article.NquickMenu > form.noticeInsertC > div.title > label{
		margin: 0 auto;
		width: 65%; height: 25px;
	}
	article.NquickMenu > form.noticeInsertC > div.title > input.title{
		position: relative;
		margin: 0 auto; width: calc(100% - 34px);
		border: 0px solid #000; border-bottom: 1px solid #fb929e;
		vertical-align: middle; padding-left: 10px;
		height: 24px; margin-bottom: 3px;
	}
	
	
	article.NquickMenu > form.noticeInsertC > div.writerdate{
		position: relative;
		width: 80%;
		margin: 5px auto 0 auto;
		text-align: center;
		
	}
	article.NquickMenu > form.noticeInsertC > div.writerdate > label{
		display: inline-block;
		position: relative;
		margin: 0 auto;
		width: 100px;
		text-align: center;
	}
	article.NquickMenu > form.noticeInsertC > div.writerdate > label.data{
		display: inline-block;
		position: relative;
		width: 15%;
		text-align: center;
		border-bottom: 1px solid #fb929e;
	}
	
	article.NquickMenu > form.noticeInsertC > div.content{
		position: relative;
		margin: 0 auto;
		width: 80%;
		height: 75%;
	}
	article.NquickMenu > form.noticeInsertC > div.content > textarea.content{
		position:relative;
		margin: 0 auto;
		width: 100%;
		height: calc(100% - 24px);
		border: 1px solid #fb929e;
		resize: none; padding: 10px;
	}
	
	article.NquickMenu > form.noticeInsertC > div.insertNotice-submit {
		position:relative;
		margin: 0 auto;
		text-align: center;
	}
	article.NquickMenu > form.noticeInsertC > div.insertNotice-submit > input.noticeInsertBtn {
		width: 70px; height: 30px; cursor: pointer; background: #ffdfdf;
		color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; 
		border-radius: 5px;
	}
	article.NquickMenu > form.noticeInsertC > div.insertNotice-submit > input.noticeInsertBtn:hover {
		background: #fb929e; color: #fff;
	}
	article.NquickMenu > form.noticeInsertC > div.insertNotice-submit > input.cancelBtn {
		min-width: 70px; height: 30px; cursor: pointer; background: #ffdfdf; 
		color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; 
		border-radius: 5px;
	}
	article.NquickMenu > form.noticeInsertC > div.insertNotice-submit > input.cancelBtn:hover {
		background: #fb929e; color: #fff;
	}
</style>
</head>
<body>
	<div class="container">
    	<section class="Nmain">
			<article class="NquickMenu">
				
				<br><br>
				
				<h1><img src="../../images/noticeTitle.png"></h1>
				
				<br><br><br>
				
				<form action="<%=request.getContextPath() %>/noticeInsert.bo" class=noticeInsertC>
					<br>
					<div class=title>
						<label>제목 </label><input type=text name=title class=title>
					</div>
					
					<br>
					
					<div class=content>
						<label style="display: inline-block;margin: 5px 0px 5px 0px;">내용</label> <br>
						<textarea name=content class=content></textarea>
					</div>
					
					<br>
					
					<div class=insertNotice-submit>
						<input type=submit class=noticeInsertBtn value=글쓰기>&nbsp;&nbsp;
						<input type=button class=cancelBtn value=취소 onclick="location.href='<%=request.getContextPath()%>/noticeList.bo'">
					</div>
				</form>
			</article>
		</section>
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>