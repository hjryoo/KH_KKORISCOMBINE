<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="pet.model.vo.Pet, java.sql.Date, java.util.ArrayList"%>
<%
	Pet pet = (Pet)request.getAttribute("pet");
	int petNum = pet.getPetNum();
	Date petBirth = pet.getPetBirth();
	String petName = pet.getPetName();
	String petGender = pet.getPetGender().equals("M")? "수컷":"암컷";
	String petCate = pet.getPetCate();
	String petSpec = pet.getPetSpec();
	Double petWeight = pet.getPetWeight();
	String petVacc = pet.getPetVacc();
	if(petVacc.equals("Y")){
		petVacc = "접종";
	} else if(petVacc.equals("N")){
		petVacc = "접종 안 함";
	} else {
		petVacc = "모름";
	}
	String petNeut = pet.getPetNeut();
	if(petNeut.equals("Y")){
		petNeut = "중성화 함";
	} else if(petNeut.equals("N")){
		petNeut = "중성화 안 함";
	} else {
		petNeut = "모름";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 반려동물 정보 조회</title>
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

p.input-label{color:#5A5A5A; margin-bottom:3%;}
div.input-box{padding: 1%; border-bottom: 1px solid #5A5A5A;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	
	<div class="container">
		<div class="contents insertPet">
		<h2>반려동물 상세보기</h2>
			<form id="detailPet" name="detailPet" method="post" action="<%= request.getContextPath() %>/views/user/myPetUpdate.jsp">
				<input type="hidden" name="petNum" value="<%=petNum %>">
				<div class="input-box">
					<p class="input-label">반려동물 이름</p>
					<input type="hidden" name="petName" value="<%= petName %>"><%= petName %>
				</div>
				<div class="input-box">
					<p class="input-label">생년월일</p>
					<input type="hidden" name="petBirth" value="<%= petBirth %>"><%= petBirth %>
					</div>
				<div class="input-box">
					<p class="input-label">성별</p>
					<input type="hidden" name="petGender" value="<%= petGender %>"><%= petGender %>
					</div>
				<div class="input-box">
					<p class="input-label">종</p>
					<input type="hidden" name="petCate" value="<%= petCate %>"><%= petCate %>
				</div>
				<div class="input-box">
					<p class="input-label">품종</p>
					<input type="hidden" name="petSpec" value="<%= petSpec %>"><%= petSpec %>
				</div>
				<div class="input-box">
					<p class="input-label">체중(kg)</p>
					<input type="hidden" name="petWeight" value="<%= petWeight %>"><%= petWeight %>
				</div>
				<div class="input-box">
					<p class="input-label">기초 예방 접종 여부</p>
					<input type="hidden" name="petVacc" value="<%= petVacc %>"><%= petVacc %>
				</div>
				<div class="input-box">
					<p class="input-label">중성화 여부</p>
					<input type="hidden" name="petNeut" value="<%= petNeut %>"><%= petNeut %>
				</div>
				<div class="input-submit">
					<input type="submit" id="insertBtn" value="수정하기">
					<input type="button" onclick="deletePet();" value="삭제하기">
				</div>
			</form>		
		</div>
	</div>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/common.js"></script>
	<script>
		function deletePet(){
			var bool = confirm("정말로 삭제하시겠습니까?");
			if(bool){
				$('#detailPet').attr('action', '<%= request.getContextPath() %>/delete.pet');
				$('#detailPet').submit();
			}
		}
	</script>

</body>
</html>