<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="pet.model.vo.Pet, java.sql.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 반려동물 프로필 등록</title>
<%@ include file="../common/layout.jsp" %>
<%
	Pet pet = new Pet();

	int petNum = pet.getPetNum();
	String petName = pet.getPetName();
	Date petBirth = pet.getPetBirth();
	String petGender = pet.getPetGender();
	String petCate = pet.getPetCate();
	String petSpec = pet.getPetSpec();
	Double petWeight = pet.getPetWeight();
	String petVacc = pet.getPetVacc();
	String petNeut = pet.getPetNeut();
	Date petUpdate = pet.getPetUpdate();
	String usId = loginUser.getUsId();
	String petDel = pet.getPetDel();
%>
<style>
div.contents.insertPet{width: 50%; max-width: 650px; margin: 20px auto;}
div.contents.insertPet > form{width: 80%; margin: 0 auto;}
div.contents.insertPet > form > div.profile-icon {display: flex; justify-content: center; height: 100%; width: 100%; margin: 0 auto;}
.profile-icon > img{border-radius:75px; overflow:hidden; border:2px solid #000;}
div.contents.insertPet > form > button {width: 20%; }

form#insertPet > div.input-box > input[name^=b] {width: 20%; text-align: right;}
form#insertPet > div.input-box > input[name^=b]:not(:nth-of-type(1)){margin-left: 6%;}
form#insertPet > div.input-box > input[name^=bYear] {width: 33%;}

input[type="button"]{width: 30%; min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
input[type="button"]:hover{background: #fb929e; color: #fff;}
</style>
</head>
<body>

	<div class="container">
		<div class="contents insertPet">
		<h2>내 반려동물 등록</h2>
			<form id="insertPet" name="insertPet" method="post" action="<%= request.getContextPath() %>/insertProfile.pe">
				<div class="profile-icon">
					<div>
						
					</div>
				</div>
				<div class="input-box">
					<p class="input-label">반려동물 이름</p>
					<input type="text" name="petName" id="petName" autocomplete="off" required>
				</div>
				<div class="input-box">
					<p class="input-label">생년월일</p>
					<input type="text" name="bYear" id="bYear" maxlength="4" autocomplete="off" onkeyup="inputNumber(this);" > 년
					<input type="text" name="bMonth" id="bMonth" maxlength="2" autocomplete="off" onkeyup="inputNumber(this);" > 월
					<input type="text" name="bDay" id="bDay" maxlength="2" autocomplete="off" onkeyup="inputNumber(this);" > 일
				</div>
				<div class="input-box">
					<p class="input-label">성별</p>
					<input type="radio" name="petGender" id="petGender" value="M"><label class="radioLabel">수컷</label>
					<input type="radio" name="petGender" id="petGender" value="F"><label class="radioLabel">암컷</label>
				</div>
				<div class="input-box">
					<p class="input-label">종</p>
					<input type="radio" name="petCate" id="petCate" value="DOG"><label class="radioLabel">개</label>
					<input type="radio" name="petCate" id="petCate"value="CAT"><label class="radioLabel">고양이</label>
				</div>
				<div class="input-box">
					<p class="input-label">품종</p>
					<input type="text" name="petSpec" id="petSpec" required>
				</div>
				<div class="input-box">
					<p class="input-label">체중(kg)</p>
					<input type="text" name="petWeight" id="petWeight">
					<p class="input-info">* 숫자만 입력해주세요.</p>
				</div>
				<div class="input-box">
					<p class="input-label">기초 예방 접종 여부</p>
					<input type="radio" name="petVacc" id="petVacc" value="Y"><label class="radioLabel">접종</label>
					<input type="radio" name="petVacc" id="petVacc" value="N"><label class="radioLabel">비접종</label>
					<input type="radio" name="petVacc" id="petVacc" value="W"><label class="radioLabel">모름</label>
				</div>
				<div class="input-box">
					<p class="input-label">중성화 여부</p>
					<input type="radio" name="petNeut" id="petNeut" value="Y"><label class="radioLabel">중성화</label>
					<input type="radio" name="petNeut" id="petNeut" value="N"><label class="radioLabel">하지 않음</label>
					<input type="radio" name="petNeut" id="petNeut" value="W"><label class="radioLabel">모름</label>
				</div>
				<div class="input-submit">
					<input type="submit" id="insertBtn" value="등록하기">
					<input type="button" onclick="location.href='javascript:history.back()'" value="취소하기">
				</div>
			</form>		
		</div>
	</div>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/common.js"></script>
	<script>
		function inputNumber(e){
			$(e).val($(e).val().replace(/[^0-9]/g,""));
		}
		
		$(function(){
			var isName, isSpec, isWeight, isYear, isMonth, isDay = false;
			$p = $('<p>');
			$p.addClass('input-info').addClass('color-red');
			
			
			$('#petName').change(function(){
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
			
			$('#petSpec').change(function(){
				if($(this).val() == ''){
					$(this).addClass('border-red').focus();
					$p.text('정확한 품종을 입력해주세요. 모르는 경우 모름 이라고 적어주세요.');
					$(this).parent().append($p);
					isSpec = false;
				} else{
					$(this).removeClass('border-red');
					$(this).next().remove();
					isSpec = true;
				}
			});
			
			$('#petWeight').change(function(){
				if($(this).val() == ''){
					$(this).addClass('border-red').focus();
					$p.text('정확한 품종을 입력해주세요. 모르는 경우 모름 이라고 적어주세요.');
					$(this).parent().append($p);
					isWeight = false;
				} else{
					$(this).removeClass('border-red');
					$(this).next().remove();
					isWeight = true;
				}
			});
			
			$('#bYear').change(function(){
				var yearVal = $(this).val();
				if(yearVal == '' || yearVal < 1920 || yearVal > 2020){
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
			});
			
			
			$('form').submit(function(){
				var isSubmit = false;
				if(isName && isSpec && isWeight && isYear && isMonth && isDay){
					alert('반려동물 등록이 완료되었습니다.');
					return true;
				} else{
					alert('반려동물 등록 양식에 맞춰 입력해주세요.');
					if(!isName) $('#petName').focus();
					else if(!isSpec) $('#petSpec').focus();
					else if(!isWeight) $('#petWeight').focus();
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