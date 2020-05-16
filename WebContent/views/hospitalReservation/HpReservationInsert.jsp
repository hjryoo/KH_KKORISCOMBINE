<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약추가하기</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/common.js"></script>
<style>
	div.container {
		position: absolute; top:0; left:0; 
		width: 100%; height: 100%; 
		margin: 0 auto; box-sizing: border-box;
	}
	section.main {
		position:relative; height:100%; width:100%; 
		background-size: contain;
	}
	section.main > article.quickMenu {
		position: relative; width: 100%; height: 100%;
		text-align: center; vertical-align: middle;
	}
	
	div.body{
		position: relative;
		top: calc(50% - 60px);
		margin: auto;
		width: 300px; height: 120px;
		border: 3px dashed #ffdfdf; vertical-align: middle;
	}
	div.body > form{
		position: relative;
		top: calc(50% - 50px);
		margin: auto;
		width: 200px; height: 100px;
	}
	
	div.select-date {width: 150px; height:35px; display: inline-block;}
	div.select-date > input {position:relative; height:33px; width: 147px; font-size: 14px; background: none; outline: none; -webkit-appearance: none; -moz-appearance: none; appearance: none; cursor: pointer; border:1px solid #5d5d5d;}
	
	div.select-box {width: 150px; height:35px; display: inline-block;}
	div.select-box > select {position:relative; height:100%; width: 100%; font-size: 14px; background: none; outline: none; -webkit-appearance: none; -moz-appearance: none; appearance: none; cursor: pointer; border:1px solid #5d5d5d;}
	
	button.submitBtn{
		width: 90px; height: 30px; background: #ffdfdf; 
		color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; 
		border-radius: 5px;
	}
	button.submitBtn:hover{
		background: #fb929e; color: #fff; cursor: pointer;
	}
	
</style>
</head>
<body>
	<div class="container">
    	<section class="main">
			<article class="quickMenu">
				<div class=body>
					<form action="<%=request.getContextPath()%>/HpRVInsertNoPet.hp" method="post">
						<input type=hidden name=hpId id=hpId value="123">
						<div class=select-date>
							<input type=date name=date id=date class=date>
						</div>
						<br>
						<div class=select-box>
							<select name="time" id="time">
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
						<br>
						<button class=submitBtn type=button onclick="RVInsert();">예약 추가</button>
					</form>
				</div>
			</article>
		</section>
	</div>
	<script>
		$("#hpId").val(opener.$("#hpId").val());
		$("#date").val(new Date().toISOString().substring(0, 10));
		
		function RVInsert(){
			var hpId = $("#hpId").val();
			var date = $("#date").val();
			var time = $("#time").val();
			$.ajax({
				url: "<%=request.getContextPath() %>/HpRVInsertNoPet.hp",
				type: "post",
				data: {hpId:hpId, date:date, time:time},
				success: function(data){
					console.log(data);
					if(data == -1){
						alert("해당 날짜에 예약이 있어 추가되지 않았습니다.");
					} else if(data == 0){
						alert("예약 추가에 실패했습니다.");
					} else if(data == 1){
						opener.location.reload();
						self.close();
					}
					
				}
			});
			
			//opener.location.reload();
		}
	</script>
</body>
</html>