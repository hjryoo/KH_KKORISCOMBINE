<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 회원가입</title>
<style>
div.container {height: auto !important;}
/* 회원가입 - 일반유저 */
div.contents.join.user {width: 50%; max-width: 650px; margin: 20px auto;}
form#joinUser {width: 80%; margin: 0 auto;}
form#joinUser > div.input-box > input[name^=b] {width: 20%; text-align: right;}
form#joinUser > div.input-box > input[name^=b]:not(:nth-of-type(1)){margin-left: 6%;}
form#joinUser > div.input-box > input[name^=bYear] {width: 35%;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents join user">
			<h2>회원가입</h2>
			<form method="post" action="<%= request.getContextPath() %>/joinUser.us" id="joinUser" name="joinUser">
				<div class="input-box">
					<p class="input-label">아이디</p><input type="text" name="userId" id="userId" autocomplete="off" required>
					<p class="input-info">* 영문 소문자/숫자 1가지 이상 조합, 5자~15자</p>
				</div>
				<div class="input-box">
					<p class="input-label">비밀번호</p><input type="password" name="userPwd" id="userPwd" required>
					<p class="input-info">* 영문/숫자/특수문자 3가지 조합, 8자~16자</p>
				</div>
				<div class="input-box">
					<p class="input-label">비밀번호 확인</p><input type="password" name="userPwdChk" id="userPwdChk" required>
				</div>
				<div class="input-box">
					<p class="input-label">이름</p><input type="text" name="userName" id="userName" autocomplete="off" required>
				</div>
				<div class="input-box">
					<p class="input-label">연락처</p><input type="text" name="phone" id="phone" maxlength="11" autocomplete="off" onkeyup="inputNumber(this);" required>
					<p class="input-info">* 번호만 입력해주세요. (- 제외)</p>
				</div>
				<div class="input-box">
					<p class="input-label">닉네임</p><input type="text" name="nickName" id="nickName" maxlength="6" autocomplete="off" required>
				</div>
				<div class="input-box">
					<p class="input-label">이메일</p><input type="email" name="email" id="email" autocomplete="off" required>
					<p class="input-info">* 아이디/비밀번호를 찾을 때 사용되므로 정확한 이메일을 입력해주세요.</p>
				</div>
				<div class="input-box">
					<p class="input-label">생년월일</p>
					<input type="text" name="bYear" id="bYear" maxlength="4" autocomplete="off" onkeyup="inputNumber(this);"> 년
					<input type="text" name="bMonth" id="bMonth" maxlength="2" autocomplete="off" onkeyup="inputNumber(this);"> 월
					<input type="text" name="bDay" id="bDay" maxlength="2" autocomplete="off" onkeyup="inputNumber(this);"> 일
				</div>
				<div class="input-box">
					<p class="input-label">성별</p>
					<input type="radio" name="gender" value="M"><label class="radioLabel">남자</label>
					<input type="radio" name="gender" value="F"><label class="radioLabel">여자</label>
				</div>
				<div class="input-submit"><input type="submit" id="joinBtn" value="가입"></div>
			</form>
		</div>
	</div>
	<script src="<%= request.getContextPath() %>/js/common.js"></script>
	<script>
		function inputNumber(e){
			$(e).val($(e).val().replace(/[^0-9]/g,""));
		}
		
		$(function(){
			var isId, isPwd, isPwd2, isName, isPhone, isNickName, isEmail, isYear, isMonth, isDay = false;
			$p = $('<p>');
			$p.addClass('input-info').addClass('color-red');
			
			$('#userId').change(function(){
				var userId = $(this);
				var userIdVal = $(this).val();
				var userIdReg = /[a-z0-9]{5,15}/g;
				console.log(userIdVal);
				if(userIdVal == '' || !userIdReg.test(userIdVal)){
					$(this).addClass('border-red').focus();
					$(this).next().addClass('color-red');
					isId = false;
				} else{
					$.ajax({
						url: '<%= request.getContextPath() %>/idCheck.au',
						type: 'post',
						data: {userId: userId.val()},
						success: function(data){
							if(data == 'success'){
								userId.next().next().remove();
								userId.removeClass('border-red');
								userId.next().removeClass('color-red');
								isId = true;
							} else{
								userId.addClass('border-red').focus();
								$p.text('이미 사용중인 아이디입니다.');
								userId.parent().append($p);
								isId = false;
							}
						}
					});
				}
			});
			
			$('#userPwd').change(function(){
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
			
			$('#userPwdChk').change(function(){
				var userPwdVal = $('#userPwd').val().trim();
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
			
			$('#userName').change(function(){
				if($(this).val() == ''){
					$(this).addClass('border-red').focus();
					$p.text('정확한 이름을 입력해주세요.');
					$(this).parent().append($p);
					isName = false;
				} else{
					$(this).removeClass('border-red');
					$(this).next().remove();
					isName = true;
				}
			});
			
			$('#phone').change(function(){
				if($(this).val() == '' || $(this).val().length < 9){
					$(this).addClass('border-red').focus();
					$p.text('정확한 연락처를 입력해주세요.');
					$(this).parent().append($p);
					isPhone = false;
				} else{
					$(this).removeClass('border-red');
					$(this).next().next().remove();
					isPhone = true;
				}
			});
			
			$('#nickName').change(function(){
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
			
			$('#email').change(function(){
			     //var emailReg = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
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
			
			$('#bYear').change(function(){
				var yearVal = $(this).val();
				if(yearVal == '' || yearVal < 1920 || yearVal > 2010){
					alert('태어난 연도를 정확히 입력해주세요. (ex. 1991)');
					$(this).focus();
					isYear = false;
				} else{
					isYear = true;
				}
			});
			
			$('#bMonth').change(function(){
				var monthVal = $(this).val();
				if(monthVal == '' || monthVal < 0 || monthVal > 12){
					alert('태어난 월을 정확히 입력해주세요.');
					$(this).focus();
					isMonth = false;
				} else{
					isMonth = true;
				}
			});
			
			$('#bDay').change(function(){
				var dayVal = $(this).val();
				if(dayVal == '' || dayVal < 0 || dayVal > 31){
					alert('태어난 일을 정확히 입력해주세요.');
					$(this).focus();
					isDay = false;
				} else{
					isDay = true;
				}
				console.log($('input[name="gender"]').val());
			});
			
			
			$('form').submit(function(){
				var isSubmit = false;
				if(isId && isPwd && isPwd2 && isName && isPhone && isNickName && isEmail && isYear && isMonth && isDay){
					alert('회원가입이 완료되었습니다.');
					return true;
				} else{
					alert('회원가입 양식에 맞춰 입력해주세요.');
					if(!isId) $('#userId').focus();
					else if(!isPwd) $('#userPwd').focus();
					else if(!isPwd2) $('#userPwd2').focus();
					else if(!isName) $('#userName').focus();
					else if(!isPhone) $('#phone').focus();
					else if(!isNickName) $('#nickName').focus();
					else if(!isEmail) $('#email').focus();
					else if(!isYear) $('#bYear').focus();
					else if(!isMonth) $('#bMonth').focus();
					else if(!isDay) $('#bDay').focus();
					
					return false;
				}
			});
		});
	</script>
</body>
</html>