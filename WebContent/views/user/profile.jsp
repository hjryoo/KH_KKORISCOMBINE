<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="user.model.vo.User, java.sql.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 내 프로필</title>
<%@ include file="../common/layout.jsp" %>
<%
	String userId = loginUser.getUsId();
	String usName = loginUser.getUsName();
	String usNick = loginUser.getUsNick();
	String usGender = loginUser.getUsGender().equals("M")? "남자":"여자";
	String usPhone = loginUser.getUsPhone();
	String email = loginUser.getUsEmail();
	Date usBirth = loginUser.getUsBirth();
	
	String usPhoto = loginUser.getUsPhoto();
	if(usPhoto == null){
		usPhoto = "";
	} else {
		usPhoto = loginUser.getUsPhoto();
	}
	String usIntro = loginUser.getUsIntro() != null? loginUser.getUsIntro() : "";
%>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/index.css"/>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css"/>
<style>
div.contents.profile{width: 50%; max-width: 650px; margin: 20px auto;}
div.contents.profile > form{width: 80%; margin: 0 auto;}
div.contents.profile > form > div.profile-icon {display: flex; justify-content: center; height: 100%; width: 100%; margin: 0 auto;}
.profile-icon > img{border-radius:75px; overflow:hidden; border:2px solid #000;}

input[type="button"]{width: 30%; min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
input[type="button"]:hover{background: #fb929e; color: #fff;}
p.input-label{color:#5A5A5A; margin-bottom:3%;}
div.input-box{padding: 1%; border-bottom: 1px solid #5A5A5A;}

</style>
</head>
<body>
	<div class="container">
    	<div class="contents profile">
			<h2>프로필 관리</h2>
    		<form action="<%= request.getContextPath() %>/views/user/profileUpdate.jsp" id="userProfile" method="post" id="userProfile" name="userProfile">
	    		<div class="profile-icon">
	    			<input type="hidden" name="savedPhoto" id="savedPhoto" value="<%= loginUser.getUsPhoto() %>">
					<img name="usPhoto" width=150px; height=150px; id="usPhoto" src="<%= request.getContextPath() %>/thumbnail_uploadFiles/<%= usPhoto %>">
				</div>
				<div class="input-box">
					<p class="input-label">이름</p>
					<input type="hidden" name="userName" value="<%= usName %>"><%= usName %>
				</div>
				<div class="input-box">
	    			<p class="input-label">닉네임</p>
	    			<input type="hidden" name="userNick" value="<%= usNick %>"><%= usNick %>
	    		</div>
	    		<div class="input-box">
	    			<p class="input-label">성별</p>
	    			<input type="hidden" name="userGender" value="<%= usGender %>"><%= usGender %>
	    		</div>
	    		<div class="input-box">
	    			<p class="input-label">연락처</p>
	    			<input type="hidden" name="userPhone" value="<%= usPhone %>"><%= usPhone %>
	    		</div>
				<div class="input-box">
	    			<p class="input-label">이메일</p>
	    			<input type="hidden" name="userEmail" value="<%= email %>"><%= email %>
				</div>
				<div class="input-box">
	    			<p class="input-label">생년월일</p>
	    			<input type="hidden" name="usBirth" value="<%= usBirth %>"><%= usBirth %>
				</div>
				<div class="input-box">
	    			<p class="input-label">소개</p>
	    			<input type="hidden" name="usIntro" value="<%= usIntro %>"><%= usIntro %>
	    		</div>
	    		<div class="input-submit">
		    		<input type="submit" id="updateBtn" value="프로필 수정">
		    		<input type="button" onclick="location.href='<%= request.getContextPath() %>/views/user/pwdUpdate.jsp'" value="비밀번호 변경">
		    		<input type="button" onclick="location.href='<%= request.getContextPath() %>/views/user/myPetList.jsp'" value="내 반려동물 관리">
		    	</div>
	    	</form>
    	</div>
    	
	</div>
</body>
</html>