<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 병원정보 업데이트</title>
<%@ include file="../common/layout.jsp" %>
<%
	String hpPhoto = loginHp.getHpPhoto();
	if(hpPhoto == null){
		hpPhoto = "";
	} else {
		hpPhoto = request.getContextPath()+"/thumbnail_uploadFiles/"+loginHp.getHpPhoto();
	}
%>
<style>
	div.container {height: auto !important;}
	/* 회원가입 - 병원 */
	div.contents.join.user {width: 50%; max-width: 650px; margin: 20px auto;}
	form#joinHospital{
		text-align: center;
	}
	form#joinHospital > div.location > input:nth-of-type(1) {width: 60%;}
	form#joinHospital > div.location > input {margin: 5px 0;}
	form#joinHospital > div.location > .postcodify_searchBtn {width: 39%; border: 1px solid #000; font-size: 13px; padding: 12px; cursor: pointer;}
	form#joinHospital > div.location > .postcodify_searchBtn:hover {border-color: #aedefc; background: #aedefc; color: #fff;}
	
	form#joinHospital > .titleImgArea {display:block; position: relative;  width:1%; max-width:100%; height:200px; text-align:center; display:table-cell; vertical-align:middle;}
	form#joinHospital > .titleImgArea > #titleImg{border: 1px solid black; position: relative; width:auto; height: 200px; min-height: 200px; min-width: 200px;}
	
	#titleImgArea:hover, #contentImgArea1:hover, #contentImgArea2:hover, #contentImgArea3:hover {cursor:pointer;}
	
	
	form#joinHospital > .input-box > .hpIntro{position: relative; width: 100%; height: 400px; padding: 10px; resize: none;}
	
	input.Btn {width:25%;min-width: 85px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
	input.Btn:hover {background: #fb929e; color: #fff;}
	
</style>
</head>
<body>
	<div class="container">
		<div class="contents join user">
			<h2>회원가입</h2>
			<form method="post" action="<%= request.getContextPath() %>/UpdateHp.hp" id="joinHospital" name="joinHospital" enctype="multipart/form-data">
				<div class="titleImgArea" id=titleImgArea style="">
					<p class="input-label">대표 이미지</p>
					<input type=hidden name="savedPhoto" id="savedPhoto" value="<%=loginHp.getHpPhoto()%>">
					<img id="titleImg" style="max-height: 300px;"><br>
				</div>
				<input type=button class=Btn onclick="deleteImg();" style="margin-top:5px; min-width: 110px;" value="대표 이미지 삭제">
				<div id="fileArea">
					<input type="file" id="thumbnailImg1" multiple="multiple" name="thumbnailImg1" onchange="LoadImg(this)">
				</div>
				<script>
					$(function(){
						$("#fileArea").hide();
						
						$("#titleImgArea").click(function(){
							$("#thumbnailImg1").click();
						});
						
						if("<%=hpPhoto%>" != ""){
							$("#titleImg").attr("src", "<%=hpPhoto %>");
						}
					});
					
					function LoadImg(value){
						console.log(value.files[0]);
						if(value.files && value.files[0]){
							var reader = new FileReader();
							reader.onload = function(e){								
								$("#titleImg").attr("src", e.target.result);
								console.log(e);
							}
							reader.readAsDataURL(value.files[0]);
						}
					}
					
					function deleteImg(){
						$("#titleImg").removeAttr("src");
						$("#savedPhoto").removeAttr("value");
					}
				</script>
				<div class="input-box">
					<p class="input-label">아이디</p><input type="text" name="userId" id="userId" value="<%=loginAu.getAuId() %>" readonly required>
				</div>
				<div class="input-box">
					<p class="input-label">병원명</p><input type="text" name="hpName" value="<%=loginHp.getHpName()%>" required>
				</div>
				<div class="input-box">
					<p class="input-label">병원장명</p><input type="text" name="hpDName"  value="<%=loginHp.getHpDName() %>" required>
				</div>
				<div class="input-box">
					<p class="input-label">연락처</p><input type="text" name="phone" id="phone" value="<%=loginHp.getHpPhone() %>" required>
				</div>
				<div class="input-box">
					<p class="input-label">이메일</p><input type="email" name="email" id="email" value="<%=loginHp.getHpEmail() %>" required>
					<p class="input-info">* 아이디/비밀번호를 찾을 때 사용되므로 정확한 이메일을 입력해주세요.</p>
				</div>
				<div class="input-box location">
					<p class="input-label">위치</p>
					<input type="text" name="zipcode" class="postcodify_postcode5" placeholder="우편번호" value="<%=loginHp.getHpZip() %>" readonly required>
					<input type="button" id="postcodify_searchBtn" class="postcodify_searchBtn" value="주소검색">
					<input type="text" name="location1" class="postcodify_address" placeholder="기본주소" value="<%=loginHp.getHpLoc1() %>" readonly required>
					<input type="text" name="location2" class="postcodify_details" placeholder="상세주소" value="<%=loginHp.getHpLoc2() %>">
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
							<option value="not">진료 시작</option>
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
							<option value="not">진료 종료</option>
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
							<option value="not">점심 시간</option>
							<option value="noTime">선택 안함</option>
						</select>
					</div>
					<p class="input-info">* 점심시간 기준은 선택한 시간부터 1시간입니다. (점심시간이 13:00-14:00일 경우, 13:00 선택)</p>
				</div>
				<div class=input-box>
					<p class="input-label">병원 소개</p>
					<textarea class="hpIntro" name="hpIntro"><%=loginHp.getHpIntro() %></textarea>
				</div>
				
				
				
				<div class="input-submit">
					<input type="submit" id="joinBtn" class=Btn value="수정하기">
					<input type=button class=Btn onclick="location.href='javascript:history.back()'" value="취소하기">
					<input type=button class=Btn onclick=secession(); value=탈퇴하기>
				</div>
			</form>
		</div>
	</div>
	<script>
		//탈퇴하기 function()
		function secession(){
			var isTrue = confirm("정말로 탈퇴하시겠습니까?");
			var isTrue2 = confirm("탈퇴완료시 메인화면으로 이동됩니다");
			if(isTrue && isTrue2){
				location.href="<%=request.getContextPath()%>/HpSecession.hp?auId=<%=loginAu.getAuId()%>";
			}
		}
		$(function(){
			//처음 정보화면 진료시작시간 script
			var STI = <%=loginHp.getHpStart() %>;
			var ETI = <%=loginHp.getHpEnd() %>;
			var LTI = <%=loginHp.getHpLunch() %>;
			
			for(var i = 0; i < $("#startTime")[0].length; i++){
				if(STI == $("#startTime option")[i].value){
					$("#startTime option")[i].selected = true;
				} else {
					$("#startTime option")[i].selected = false;
				}
			}
			
			for(var i = 0; i < $("#endTime")[0].length; i++){
				if(ETI == $("#endTime option")[i].value){
					$("#endTime option")[i].selected = true;
				} else {
					$("#endTime option")[i].selected = false;
				}
			}
			
			var isEmail = true;
			
			$p = $('<p>');
			$p.addClass('input-info').addClass('color-red');
			
			$('input').each(function(){
				$(this).prop('autocomplete', 'off');
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
			
			var startTime = (Number)($("#startTime").val());
			var	endTime = (Number)($("#endTime").val());
			
			$('#startTime').click(function(){
				startTime = (Number)($(this).val());
				$('#endTime').val('not');
			});
			
			$('#endTime').click(function(){
				endTime = (Number)($(this).val());
				
				if(isNaN(startTime)){
					alert('진료 시작 시간을 먼저 선택해주세요.');
				} else if(startTime == endTime){
					alert('24시 진료일 경우, 00:00-24:00로 선택해주세요.');
					$(this).val('not');
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
			
			
			//점심시간 데이터 가져오기
			for(var i = 0; i < $("#breakTime")[0].length; i++){
				if(LTI == $("#breakTime option")[i].value){
					$("#breakTime option")[i].selected = true;
				} else {
					$("#breakTime option")[i].selected = false;
				}
			}
			
			$('form').submit(function(){
				var isSubmit = false;
				if(isPwd && isPwd2 && isEmail){
					alert('수정이 완료되었습니다.');
					return true;
				} else{
					alert('해당 양식에 맞춰 다시 입력해주세요.');
					if(!isPwd) $('#userPwd').focus();
					else if(!isPwd2) $('#userPwd2').focus();
					else if(!isEmail) $('#email').focus();
					
					return false;
				}
			});
		});
	</script>
</body>
</html>