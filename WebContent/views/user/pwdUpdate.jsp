<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 비밀번호 변경</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/index.css"/>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css"/>
<style>
div.contents {width: 60%; max-width: 800px; height: 500px; top: calc(50% - 250px); margin: 20px auto;}
button {width: 15%; min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px; margin-left: 20px;}
button:hover {background: #fb929e; color: #fff;}
#updatePwdBtn{width: 15%}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents profile">
			<form action="<%= request.getContextPath() %>/updatePwd.us" method="post" id="updatePwdForm" name="updatePwdForm" onsubmit="return send();">
				<div class="contents join user">
					<h2>비밀번호 수정하기</h2>
					<div class="input-box">
						<p class="input-label">현재 비밀번호</p><input type="password" name="userPwd" id="userPwd" required>
					</div>
					<div class="input-box">
						<p class="input-label">변경 비밀번호</p><input type="password" name="newPwd" id="newPwd" required>
						<p class="input-info">* 영문/숫자/특수문자 3가지 조합, 8자~16자</p>
					</div>
					<div class="input-box">
						<p class="input-label">변경 비밀번호 확인</p><input type="password" name="newPwd2" id="newPwd2" required>
					</div>
					<div class="input-submit">
						<input id="updatePwdBtn" type="submit" value="변경하기">
						<button onclick="location.href='javascript:history.back()'">취소하기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script>

		$(function(){
			var isPwd, isPwd2 = false;
			$p = $('<p>');
			$p.addClass('input-info').addClass('color-red');
			
			$('#newPwd').change(function(){
				var userPwdVal = $(this).val();
				var userPwdReg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#\$%\^&*?]).{8,16}$/;
				if(userPwdVal == '' || !userPwdReg.test(userPwdVal)){
					$(this).addClass('border-red').focus();
					$(this).next().addClass('color-red');
					isPwd = false;
				} else{
					$(this).removeClass('border-red');
					$(this).next().removeClass('color-red');
					isPwd = true;
				}
			});
			
			$('#newPwd2').change(function(){
				var userPwdVal = $('#newPwd').val();
				var userPwdChkVal = $(this).val();
				if(userPwdVal != '' && (userPwdChkVal == '' || userPwdVal != userPwdChkVal)){
					$(this).addClass('border-red');
					$p.text('비밀번호가 일치하지 않습니다.');
					$(this).parent().append($p);
					isPwd2 = false;
				} else{
					$(this).removeClass('border-red');
					$(this).next().remove();
					isPwd2 = true;
				}
			});
			
			$('form').submit(function(){
				var isSubmit = false;
				if(isPwd && isPwd2){
					alert('비밀번호 수정이 완료되었습니다.');
					return true;
				} else{
					alert('비밀번호 양식에 맞춰 입력해주세요.');
					if(!isPwd) $('#newPwd').focus();
					else if(!isPwd2) $('#newPwd2').focus();
					
					return false;
				}
			});
		});
	</script>
</body>
</html>