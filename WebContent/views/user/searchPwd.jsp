<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스 컴바인 : 비밀번호 찾기</title>
<style>
div.contents.search {width: 50%; max-width: 400px; height: 400px; top: calc(50% - 200px);}
#searchBtn {width: 30%; margin-top: 20px; margin-left: 35%;}
</style>
</head>
<body>
	<%@ include file="../common/layout.jsp" %>
	<div class="container search">
		<div class="contents search">
			<h2>비밀번호 찾기</h2>
					<div class="input-container"><label class="input-label">아이디</label><input type="text" name="userId" id="userId"></div>
					<div class="input-container"><label class="input-label">이름</label><input type="text" name="userName" id="userName"></div>
					<div class="input-container">
						<label class="input-label">이메일</label><input type="email" name="email" id="email">
						<p class="input-info">* 가입시 입력했던 이메일을 정확히 입력해주세요.</p>
						<p class="input-info">* 해당 이메일로 임시 비밀번호가 발급됩니다.</p>
					</div>
					<input type="submit" id="searchBtn" class="center" value="찾기">
		</div>
	</div>
	<script src="<%= request.getContextPath() %>/js/common.js"></script>
	<script>
		$('#searchBtn').click(function(){
			var charArr = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
			var temPwd = "";
			for(var i = 0; i < 6; i++) {
				var idx = parseInt(charArr.length * Math.random());
				temPwd += charArr[idx];
			}
			
			$.ajax({
				url: '<%= request.getContextPath() %>/searchPwd.au',
				type: 'post',
				data: {userId: $('#userId').val(),
						userName: $('#userName').val(),
						email: $('#email').val(),
						temPwd: temPwd,
						newPwd: temPwd},
				success: function(data){
					if(data == 'success'){
						alert('임시 비밀번호가 발급 되었습니다.');
						location.href="login.jsp";
					} else{
						alert('임시 비밀번호 발급에 실패하였습니다.');
					}
				},
				error: function(data){
					alert('정보가 일치하지 않습니다.');
				}
			});
		});
	</script>
</body>
</html>