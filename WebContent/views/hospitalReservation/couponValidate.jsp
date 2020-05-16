<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 사용 페이지</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/common.js"></script>
<style>
	#border{border: 3px dashed #ffdfdf; padding: 20px; }
	#valBtn{font-size: 12px; font-weight: 600; text-align: center; border: 1px solid #575756; border-radius: 5px; width: 50px; height: 30px; background: #ffdfdf; color: #5d5d5d;}
	#valBtn:hover{cursor: pointer; background: #fb929e; color: #fff;}		
</style>
</head>
<body>
		<div id="border" style="text-align:center;">
			쿠폰 번호를 입력해주세요<br>
			<input type="text" id="coupon">	<button id="valBtn">확인</button>
			<br><br>
			<div id="result" ></div>
		</div>
	<script>
		$('#valBtn').click(function(){
			var coupon = $('#coupon').val();
			
			$.ajax({
				url: '<%= request.getContextPath() %>/coupon.hp',
				type: 'get',
				data: {coupon:coupon},
				success: function(data){
					console.log(data);
				
					var result = "";
					if(data > 0){
						alert("쿠폰이 정상적으로 사용되었습니다.");
						self.close();
					} else{
						result= "사용 불가능한 쿠폰입니다.";
					}
					$('#result').text(result);
				}
			});
			
		});

	</script>	
</body>
</html>