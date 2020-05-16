<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 회원가입</title>
<style>
div.container {height: auto !important;}
/* 회원가입 - 병원 */
div.contents.join.user {width: 50%; max-width: 650px; margin: 20px auto;}
form#joinHospital > div.location > input:nth-of-type(1) {width: 60%;}
form#joinHospital > div.location > input {margin: 5px 0;}
form#joinHospital > div.location > .postcodify_searchBtn {width: 39%; border: 1px solid #000; font-size: 13px; padding: 12px; cursor: pointer;}
form#joinHospital > div.location > .postcodify_searchBtn:hover {border-color: #aedefc; background: #aedefc; color: #fff;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents join user">
			<h2>회원가입</h2>
			<form method="post" action="<%= request.getContextPath() %>/joinHp.hp" id="joinHospital" name="joinHospital">
				<div class="input-box">
					<p class="input-label">아이디</p><input type="text" name="userId" id="userId" required>
					<p class="input-info">* 영문 소문자/숫자 1가지 이상 조합, 5자~15자</p>
				</div>
				<div class="input-box">
					<p class="input-label">비밀번호</p><input type="password" name="userPwd" id="userPwd" required>
					<p class="input-info">* 영문 대소문자/숫자/특수문자 중 3가지 이상 조합, 8자~16자</p>
				</div>
				<div class="input-box">
					<p class="input-label">비밀번호 확인</p><input type="password" name="userPwdChk" id="userPwdChk" required>
				</div>
				<div class="input-box">
					<p class="input-label">병원명</p><input type="text" name="hpName" required>
				</div>
				<div class="input-box">
					<p class="input-label">병원장명</p><input type="text" name="hpDName" required>
				</div>
				<div class="input-box">
					<p class="input-label">연락처</p><input type="text" name="phone" id="phone" onkeyup="inputNumber(this);" required>
				</div>
				<div class="input-box">
					<p class="input-label">이메일</p><input type="email" name="email" id="email" required>
					<p class="input-info">* 아이디/비밀번호를 찾을 때 사용되므로 정확한 이메일을 입력해주세요.</p>
				</div>
				<div class="input-box location">
					<p class="input-label">위치</p>
					<input type="text" name="zipcode" class="postcodify_postcode5" placeholder="우편번호" readonly required>
					<input type="button" id="postcodify_searchBtn" class="postcodify_searchBtn" value="주소검색">
					<input type="text" name="location1" class="postcodify_address" placeholder="기본주소" readonly required>
					<input type="text" name="location2" class="postcodify_details" placeholder="상세주소">
				</div>
				<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
				<script type="text/javascript">
					$(function(){
						$("#postcodify_searchBtn").postcodifyPopUp();
					});
				</script>
				<div class="input-box">
					<p class="input-label">진료 시간</p>
					<div class="select-box">
						<select name="startTime" id="startTime">
							<option value="100">진료 시작</option>
							<option value="00">00:00</option>
							<option value="01">01:00</option>
							<option value="02">02:00</option>
							<option value="03">03:00</option>
							<option value="04">04:00</option>
							<option value="05">05:00</option>
							<option value="06">06:00</option>
							<option value="07">07:00</option>
							<option value="08">08:00</option>
							<option value="09">09:00</option>
							<option value="10">10:00</option>
							<option value="11">11:00</option>
							<option value="12">12:00</option>
							<option value="13">13:00</option>
							<option value="14">14:00</option>
							<option value="15">15:00</option>
							<option value="16">16:00</option>
							<option value="17">17:00</option>
							<option value="18">18:00</option>
							<option value="19">19:00</option>
							<option value="20">20:00</option>
							<option value="21">21:00</option>
							<option value="22">22:00</option>
							<option value="23">23:00</option>
							<option value="24">24:00</option>
						</select>
					</div>
					&nbsp;-&nbsp;
					<div class="select-box">
						<select name="endTime" id="endTime">
							<option value="100">진료 종료</option>
							<option value="00">00:00</option>
							<option value="01">01:00</option>
							<option value="02">02:00</option>
							<option value="03">03:00</option>
							<option value="04">04:00</option>
							<option value="05">05:00</option>
							<option value="06">06:00</option>
							<option value="07">07:00</option>
							<option value="08">08:00</option>
							<option value="09">09:00</option>
							<option value="10">10:00</option>
							<option value="11">11:00</option>
							<option value="12">12:00</option>
							<option value="13">13:00</option>
							<option value="14">14:00</option>
							<option value="15">15:00</option>
							<option value="16">16:00</option>
							<option value="17">17:00</option>
							<option value="18">18:00</option>
							<option value="19">19:00</option>
							<option value="20">20:00</option>
							<option value="21">21:00</option>
							<option value="22">22:00</option>
							<option value="23">23:00</option>
							<option value="24">24:00</option>
						</select>
					</div>
					&nbsp;/&nbsp;
					<div class="select-box">
						<select name="breakTime" id="breakTime">
							<option value="100">점심 시간</option>
							<option value="404">선택 안함</option>
						</select>
					</div>
					<p class="input-info">* 점심시간 기준은 선택한 시간부터 1시간입니다. (점심시간이 13:00-14:00일 경우, 13:00 선택)</p>
				</div>
				<div class="input-submit"><input type="submit" id="joinBtn" value="가입"></div>
			</form>
		</div>
	</div>
	<script>
		function inputNumber(e){
			$(e).val($(e).val().replace(/[^0-9]/g,""));
		}
		
		$(function(){
			var isId, isPwd, isPwd2, isEmail = false;
			$p = $('<p>');
			$p.addClass('input-info').addClass('color-red');
			
			$('input').each(function(){
				$(this).prop('autocomplete', 'off');
			});
			
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
			
			$('#email').change(function(){
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
			
			var startTime, endTime = null;
			
			$('#startTime').click(function(){
				startTime = (Number)($(this).val());
				$('#endTime').val('100');
			});
			
			$('#endTime').click(function(){
				endTime = (Number)($(this).val());
				
				if(isNaN(startTime)){
					alert('진료 시작 시간을 먼저 선택해주세요.');
				} else if(startTime == endTime){
					alert('24시 진료일 경우, 00:00-24:00로 선택해주세요.');
					$(this).val('100');
				}
				
				// 선택된 진료 시간에 따라 점심시간 옵션목록 제어
				if(!isNaN(startTime) && !isNaN(endTime)){
					var startNum = startTime;
					var endNum = endTime;
					
					if(startTime > endTime){
						endNum = 24;
					}
					
					$('#breakTime').find('option').eq(1).nextAll().remove(); // 초기하
					
					for(var i = startNum; i <= endNum; i++){
						var $option = $('<option>');
						
						$option.val(i);
						
						if(i < 10){
							$option.text('0' + i + ':00');
						} else{
							$option.text(i + ':00');
						}
						
						$('#breakTime').append($option);
					}
				}
			});
			
			$('form').submit(function(){
				var isSubmit = false;
				if(isId && isPwd && isPwd2 && isEmail){
					alert('회원가입이 완료되었습니다.');
					return true;
				} else{
					alert('회원가입 양식에 맞춰 입력해주세요.');
					if(!isId) $('#userId').focus();
					else if(!isPwd) $('#userPwd').focus();
					else if(!isPwd2) $('#userPwd2').focus();
					else if(!isEmail) $('#email').focus();
					
					return false;
				}
			});
		});
	</script>
</body>
</html>