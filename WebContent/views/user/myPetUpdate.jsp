<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="pet.model.vo.Pet, java.sql.Date"%>
<%
	int petNum = Integer.parseInt(request.getParameter("petNum"));
	String petName = request.getParameter("petName");
	String petBirth = request.getParameter("petBirth");
	String petGender = request.getParameter("petGender");
	String petCate = request.getParameter("petCate");
	String petSpec = request.getParameter("petSpec");
	Double petWeight = Double.parseDouble(request.getParameter("petWeight"));
	String petVacc = request.getParameter("petVacc");
	String petNeut = request.getParameter("petNeut");
	System.out.println(petNeut);
	String year = petBirth.split("-")[0];
	String month = petBirth.split("-")[1];
	String day = petBirth.split("-")[2];
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 반려동물 프로필 수정</title>
<style>
div.contents.updatePet{width: 50%; max-width: 650px; margin: 20px auto;}
div.contents.updatePet > form{width: 80%; margin: 0 auto;}
div.contents.updatePet > form > div.profile-icon {display: flex; justify-content: center; height: 100%; width: 100%; margin: 0 auto;}
.profile-icon > img{border-radius:75px; overflow:hidden; border:2px solid #000;}
div.contents.updatePet > form > button {width: 20%; }

form#updatePet > div.input-box > input[name^=b] {width: 20%; text-align: right;}
form#updatePet > div.input-box > input[name^=b]:not(:nth-of-type(1)){margin-left: 6%;}
form#updatePet > div.input-box > input[name^=bYear] {width: 33%;}

input[type="button"]{width: 30%; min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
input[type="button"]:hover{background: #fb929e; color: #fff;}
</style>

</head>
<body>
<%@ include file="../common/layout.jsp" %>
	<div class="container">
		<div class="contents updatePet">
		<h2>반려동물 수정하기</h2>
			<form id="updatePet" name="updatePet" method="post" action="<%= request.getContextPath() %>/update.pet">
				<input type="hidden" name="petNum" value="<%= petNum %>">
				<input type="hidden" name="petBirth" value="<%= petBirth %>">
				<div class="input-box">
					<p class="input-label">반려동물 이름</p>
					<input type="text" name="petName" autocomplete="off" required value="<%= petName %>">
				</div>
				<div class="input-box">
					<p class="input-label">생년월일</p>
					<input type="text" name="bYear" id="bYear" maxlength="4" autocomplete="off" onkeyup="inputNumber(this);" value="<%= year %>"> 년
					<input type="text" name="bMonth" id="bMonth" maxlength="2" autocomplete="off" onkeyup="inputNumber(this);" value="<%= month %>"> 월
					<input type="text" name="bDay" id="bDay" maxlength="2" autocomplete="off" onkeyup="inputNumber(this);" value="<%= day %>"> 일
				</div>
				<div class="input-box">
					<p class="input-label">성별</p>
					<input type="radio" name="petGender" id="petGender" value="M" <%if(petGender.equals("수컷")){ %> checked<% } %>><label class="radioLabel">수컷</label>
					<input type="radio" name="petGender" id="petGender" value="F" <%if(petGender.equals("암컷")){ %> checked<% } %>><label class="radioLabel">암컷</label>
				</div>
				<div class="input-box">
					<p class="input-label">종</p>
					<input type="radio" name="petCate" id="petCate" value="DOG" <%if(petCate.equals("DOG")){ %> checked<% } %>><label class="radioLabel">개</label>
					<input type="radio" name="petCate" id="petCate" value="CAT" <%if(petCate.equals("CAT")){ %> checked<% } %>><label class="radioLabel">고양이</label>
				</div>
				<div class="input-box">
					<p class="input-label">품종</p>
					<input type="text" name="petSpec" value="<%= petSpec %>" required>
				</div>
				<div class="input-box">
					<p class="input-label">체중(kg)</p>
					<input type="text" name="petWeight" value="<%= petWeight %>" required>
					<p class="input-info">* 숫자만 입력해주세요.</p>
				</div>
				<div class="input-box">
					<p class="input-label">기초 예방 접종 여부</p>
					<input type="radio" name="petVacc" id="petVacc" value="Y" <%if(petVacc.equals("접종")){ %> checked<% } %>><label class="radioLabel">접종</label>
					<input type="radio" name="petVacc" id="petVacc" value="N" <%if(petVacc.equals("접종 안 함")){ %> checked<% } %>><label class="radioLabel">접종 안 함</label>
					<input type="radio" name="petVacc" id="petVacc" value="W" <%if(petVacc.equals("모름")){ %> checked<% } %>><label class="radioLabel">모름</label>
				</div>
				<div class="input-box">
					<p class="input-label">중성화 여부</p>
					<input type="radio" name="petNeut" id="petNeut" value="Y" <%if(petNeut.equals("중성화 함")){ %> checked<% } %>><label class="radioLabel">중성화</label>
					<input type="radio" name="petNeut" id="petNeut" value="N" <%if(petNeut.equals("중성화 안 함")){ %> checked<% } %>><label class="radioLabel">중성화 안 함</label>
					<input type="radio" name="petNeut" id="petNeut" value="W" <%if(petNeut.equals("모름")){ %> checked<% } %>><label class="radioLabel">모름</label>
				</div>
				<div class="input-submit">
					<input type="submit" id="insertBtn" value="수정하기">
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
					$p.text('몸무게를 정확히 입력해주세요.');
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
				if(yearVal == '' || yearVal < 2000 || yearVal > 2020){
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

		});
	</script>
</body>
</html>