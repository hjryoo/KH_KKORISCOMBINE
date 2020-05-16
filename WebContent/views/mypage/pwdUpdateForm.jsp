<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 비밀번호 수정</title>
<style>
/* 로그인 */
div.contents.login {width: 50%; max-width: 400px; height: 400px; top: calc(50% - 200px);}
form#login > #loginBtn {width: 30%; margin-top: 20px; margin-left: 35%;}
div.contents.login > div.text-button {text-align: center;}
div.contents.login > div.text-button:nth-of-type(1) {margin-top: 30px;}
div.contents.login > div.text-button > a {color: #000; font-size: 14px;}
div.contents.login > div.text-button > a:hover {text-decoration: underline;}

input.Btn {width:25%;min-width: 85px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
input.Btn:hover {background: #fb929e; color: #fff;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents login">
			<h2>비밀번호 수정</h2>
			<form action="<%= request.getContextPath() %>/pwdUpdate.au" method="post" id="login" name="userLogin">
				<input type="hidden" name="userId" id="userId" value="<%=loginAu.getAuId()%>">
				<div class="input-box">
					<p class="input-label">현재 비밀번호</p><input type="password" name="userPwd" id="userPwd" required>
				</div>
				<div class="input-box">
					<p class="input-label">새 비밀번호</p><input type="password" name="newPwd" id="newPwd" required>
					<p class="input-info">* 영문 대소문자/숫자/특수문자 중 3가지 이상 조합, 8자~16자</p>
				</div>
				<div class="input-box">
					<p class="input-label">새 비밀번호 확인</p><input type="password" name="newPwdChk" id="newPwdChk" required>
				</div>
				<div class="input-submit">
					<input type="submit" class=Btn id="loginBtn" value="비밀번호 수정">
					<input type=button class=Btn onclick="location.href='javascript:history.back()'" value="취소하기">
				</div>
			</form>
		</div>
	</div>
	<script src="<%= request.getContextPath() %>/js/common.js"></script>
	<script>
	$(function(){
		var isPwd, isPwd2 = false;
		$p = $('<p>');
		$p.addClass('input-info').addClass('color-red');
		
		$('input').each(function(){
			$(this).prop('autocomplete', 'off');
		});
		
		$('#newPwd').change(function(){
			var userPwdVal = $(this).val().trim();
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
		
		$('#newPwdChk').change(function(){
			var userPwdVal = $('#newPwd').val().trim();
			var userPwdChkVal = $(this).val().trim();
			if(userPwdVal != userPwdChkVal){
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
				$.ajax({
					async : false,
					url: "<%=request.getContextPath()%>/PwdCheckNow.au",
					type: "post",
					data: {userId:$("#userId").val(), userPwd:$("#userPwd").val()},
					success: function(data){
						console.log(data);
						if(!data){
							alert("현재 비밀번호가 일지하지 않습니다.");
							isSubmit = false;
						} else {
							alert('비밀번호 수정이 완료되었습니다.');
							isSubmit = true;
						}
					}
				});
				console.log("isSubmit = "+isSubmit);
				return isSubmit;
			} else{
				alert('비밀번호 양식에 맞춰 입력해주세요.');
				if(!isPwd) $('#newPwd').focus();
				else if(!isPwd2) $('#newPwdChk').focus();
				return false;
			}
		});
	});
	</script>
</body>
</html>