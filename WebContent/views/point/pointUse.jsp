<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int curPt = Integer.parseInt(request.getParameter("curPt"));
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 포인트 사용</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/index.css"/>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<style>
	#blogo{margin-top: 50px;}
	#pointView{border-color: #AEDEFC; cursor: default;}
	#pointBtn{margin-left: 850px; margin-top: 20px; min-width: 300px;}
	.outer{width: 800px; height: 650px; background: rgba(255, 255, 255, 0.4); margin-left: 300px; margin-right: auto; margin-top: auto;}
	.writeArea{width: 800px; height: 600px; margin-top: 10px; margin-left: 180px; margin-right: auto; padding: 10px; border: 1px solid #AEDEFC;}
	table{margin-left: 100px; margin-top: 3px; max-width:600px;}
	table, th, td{word-spacing: 3px; padding: 3px;}
	tr > th{padding-bottom: 10px; padding-top: 30px; font-size: 20pt;}
	tbody > tr > td{padding-left : 90px; padding-bottom : 10px; padding-top: 120px;}
	td > div{width: 35%; height:35%;}
	td > div > img{width: 100%; height:100%; align: center;}
	td > div > input[type="button"]{margin-left: 300px; font-size: 20px; text-align: center; color: #575756; border: 1px solid #575756; border-radius: 5px; width: 140px; height: 35px; cursor: pointer;}
	.pt{text-align: right;}
	#page{margin-left: 270px;}
	#pHistory{font-size: 18px; text-align: center; background-color: #575756; color:#FFF6F6; border: 1px solid #575756; border-radius: 5px; width: 120px; height: 40px; font-weight: 600; }
	#pHistory:hover {background: #ffe3e4; color: #575756; cursor: pointer;}
	#cPurchase{font-size: 13px; text-align: center; background-color: #ffe3e4; color:#575756; border: 1px solid #575756; border-radius: 5px; width: 100px; height: 30px; font-weight: 600; }
	#cPurchase:hover {background: white; color: #575756; cursor: pointer;}	
	#hList{display:none;}
	.modal-content > input[type="button"]{border: none; background-color: white; cursor: pointer; -webkit-appearance: none; -moz-appearance: none; appearance: none; outline:none;}
	#coupon{background: white;}
	#coupon:hover{background: #ffe3e4; color: #575756; cursor: pointer;}
    .modal {display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0,0,0); background-color: rgba(0,0,0,0.4);}
    .modal-content {background-color: #fefefe; margin: 20% auto; padding: 20px; border: 1px solid #888; width: 50%; height: 50%;}
    .close {color: #aaa; float: right; font-size: 28px; font-weight: bold;}
    .close:hover, .close:focus {color: black; text-decoration: none; cursor: pointer;}
</style>
</head>
<body>
<%@ include file="../common/layout.jsp" %> 
		<div class="outer">
			<img src="../../images/point.png" id="blogo" style="margin-left: 500px; margin-top: 50px;">
			<br>
			<input type="text" id="pointView" style="margin-left: 450px; margin-top: 50px; width: 220px; height: 30px;"  value="<%= curPt %>pt"  placeholder="보유 포인트" disabled>
		<br>
		<div id="pointBtn">
			<input type="button" id="pHistory" value="포인트 기록" onclick="location.href='javascript:history.back();'">
		</div>
		<div class="writeArea">
				<table>
					<tbody>
					<tr>
						<th>
							쿠폰 구매
						</th>
					</tr>
					<tr>
						<td>
							<div>
								<img src="../../images/coupon.png">
								<input type="button" value="쿠폰 구매" id="coupon">
							</div>				
						</td>
					</tr>
					</tbody>																																								
				</table>
			</div>
		</div>
	 
	    <!-- The Modal -->
	    <div id="cmodal" class="modal">	 
	      <!-- Modal content -->
	      <form action="<%= request.getContextPath() %>/coupon.pt" id="cForm" method="post">
		      <div class="modal-content" style="text-align:center">
		        <span class="close">&times;</span>                                                               
		        <p><font style="font-size:25px; font-weight:500;">쿠폰 구매</font></p>
		        <br><br>
		        <p>구매할 쿠폰 종류를 선택해주세요</p>
				<select name="couponcate">
					<option>--------</option>
					<option value="진료비">진료비 3000원 10000pt</option>
					<option value="미용비">미용비 3000원 10000pt</option>
					<option value="물품 구매비">물품 구매비 3000원 10000pt</option>
				</select>	
				<input type="button" value="구매" id="cPurchase">
				<br><br>
					<span>본 사이트에서 예약 가능한 모든 병원에서 사용 가능합니다.</span><br>   
		      </div>
	      </form>	 
	    </div>
	    

	<script type="text/javascript">	  
		var modal = document.getElementById('cmodal');
		var btn = document.getElementById("coupon");
		var span = document.getElementsByClassName("close")[0];                                          
		btn.onclick = function() {
		    modal.style.display = "block";
		}
		span.onclick = function() {
		    modal.style.display = "none";
		}
		window.onclick = function(event) {
		    if (event.target == modal) {
		        modal.style.display = "none";
		    }
		}
		
		$('#cPurchase').click(function(){
			var pt = <%=curPt%>;
			if(pt < 10000){
				alert('포인트가 부족합니다.');
			}else{
	            $('#cForm').attr('action', '<%= request.getContextPath() %>/coupon.pt');
	            $('#cForm').submit();
			}
			
			
		});
		
		
	</script>
</body>
</html>