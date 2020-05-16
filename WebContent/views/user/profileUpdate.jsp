<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="user.model.vo.User, java.sql.Date, java.util.ArrayList"%>
<%@ include file="../common/layout.jsp" %>
<%
	String userId = loginUser.getUsId();
	String usName = loginUser.getUsName();
	String usNick = loginUser.getUsNick();
	String usPhone = loginUser.getUsPhone();
	String usGender = loginUser.getUsGender();
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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 내 프로필 수정</title>
<style>
div.contents.profile{width: 50%; max-width: 650px; margin: 20px auto;}
div.contents.profile > form{width: 80%; margin: 0 auto;}
div.contents.profile > form > div.profile-icon {display: flex; justify-content: center; height: 100%; width: 100%; margin: 0 auto;}
.profile-icon > img{border-radius:75px; overflow:hidden; border:2px solid #000; cursor: pointer;}

div.contents.profile > form > div.profile-icon > a {display: inline-block; font-size: 5em; width: 150px; height: 150px; border: 2px solid #000; border-radius: 75px; margin: 50px;}
div.contents.profile > form > div.profile-icon > a > i {display: inline-block; width: 70px; margin-left: 40px; vertical-align: middle;}

input[type="button"]{width: 25%; min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
input[type="button"]:hover{background: #fb929e; color: #fff;}

textarea{width: 100%; padding: 10px; font-size: 16px; border: 1px solid #000; outline: none; resize: none;}
</style>
</head>
<body>
	<div class="container">
    	<div class="contents profile">
			<h2>프로필 수정</h2>
    		<form action="<%= request.getContextPath() %>/profile.up" method="post" id="userProfile" name="userProfile" enctype="multipart/form-data">
	    		<div class="profile-icon">
	    			<!-- <div> -->
						<img name="usPhoto" width=150px; height=150px; id="usPhoto" src="<%= request.getContextPath() %>/thumbnail_uploadFiles/<%= usPhoto %>">
					<!-- </div> -->
				</div>
				<div id="fileArea">
					<input type="file" name= "profileImage" id="profileImage" multiple="multiple" onchange="LoadImg(this)">
				</div>
				<script>
				$(function(){
					$("#fileArea").hide();

					$(".profile-icon").click(function(){
						$("#profileImage").click();
					});
				});
				//-------------------------------------------------------------
				// 각각의 영역에 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
					function LoadImg(value){
						if(value.files && value.files[0]){
							var reader = new FileReader();
							reader.onload = function(e){								
							$("#usPhoto").attr("src", e.target.result);
							}
							reader.readAsDataURL(value.files[0]);
						}
					}
				</script>
				<input type="hidden" name="usGender" value="<%= usGender %>">
				<div class="input-box">
					<p class="input-label">이름</p>
					<input type="text" name="userName" value="<%= usName %>" readonly>
				</div>
				<div class="input-box">
	    			<p class="input-label">닉네임</p>
	    			<input type="text" id="userNick" name="userNick" maxlength="6" autocomplete="off" required value="<%= usNick %>">
	    		</div>
	    		<div class="input-box">
	    			<p class="input-label">연락처</p>
	    			<input type="text" name="userPhone" value="<%= usPhone %>" maxlength="11" onkeyup="inputNumber(this);">
	    		</div>
				<div class="input-box">
	    			<p class="input-label">이메일</p>
	    			<input type="email" id="userEamil" name="userEmail" value="<%= email %>">
				</div>
				<div class="input-box">
	    			<p class="input-label">생년월일</p>
	    			<input type="text" name="usBirth" value="<%= usBirth %>" onkeyup="inputNumber(this);">
				</div>
				<div class="input-box">
	    			<p class="input-label">소개</p>
	    			<textarea name="usIntro"><%= usIntro %></textarea>
	    		</div>
	    		<div class="input-submit">
		    		<input id="updateBtn" type="submit" value="수정하기">
		    		<input type="button" onclick="location.href='javascript:history.back()'" value="취소하기">
		    		<input type="button" id="deleteBtn" onclick="deleteMember();" value="탈퇴하기">
		    	</div>
	    	</form>
    	</div>
	</div>
	
	<script>
		function inputNumber(e){
			$(e).val($(e).val().replace(/[^0-9-]/g,""));
		}
		
		function inputPhone(e){
			e.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '-');
		}
		
		$('#userNick').change(function(){
			var nickName = $(this);
			if($(this).val() == ''){
				$(this).addClass('border-red').focus();
				$p.text('닉네임을 입력해주세요.');
				$(this).parent().append($p);
				isNickName = false;
			} else{
				$.ajax({
					url: '<%= request.getContextPath() %>/nickCheck.us',
					type: 'post',
					data: {nickName: nickName.val()},
					success: function(data){
						if(data == 'success'){
							nickName.removeClass('border-red');
							nickName.next().remove();
							isNickName = true;
						} else{
							nickName.addClass('border-red');
							$p.text('이미 사용중인 닉네임입니다.');
							nickName.parent().append($p);
							nickName.focus();
							isNickName = false;
						}
					}
				});
			}
		});
		
		$('#userEmail').change(function(){
		     var emailReg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		     if($(this).val() == '' || !emailReg.test($(this).val())) {
		    	$(this).addClass('border-red').focus();
		   		$p.text('이메일 형식에 맞춰 입력해주세요.');
		   		$(this).parent().append($p);
		   		isEmail = false;
		     }
		     else {                       
		    	 $(this).removeClass('border-red');
		         $(this).next().next().remove();
		         isEmail = true;
		     }
		});
		
		
		function deleteMember(){
			var bool = confirm("정말로 탈퇴하시겠습니까?");
			if(bool){
				$('#userProfile').attr('action', '<%= request.getContextPath() %>/delete.us');
				$('#userProfile').submit();
			}
		}
	</script>
</body>
</html>