<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%
	Pet pet = new Pet();
	int petNum = pet.getPetNum();
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 내 반려동물 목록</title>
<%@ include file="../common/layout.jsp" %>
<style>
div.contents {height: 600px; top: calc(50% - 300px);}

.petList{border:1px solid #5d5d5d; top:800px; margin:5% 25%; overflow-y:scroll; width:50%; max-height: 400px; border-radius: 5px;}
.petList::-webkit-scrollbar {display: none;}

h2 {font-weight: 700; font-size: 30px; color: #000; padding: 15px 0; text-align: center;}
table#listPet{width:100%; border-collapse: collapse; line-height:1.5;}
table#listPet thead th{width:20%;padding:10px;font-weight:bold; vertical-align:top; color:#000; border-bottom:1px solid #5d5d5d;}
table#listPet tbody tr:hover{background: #ffdfdf; cursor: pointer;}
table#listPet tbody th{width:20%;padding:15px; font-weight:bold; vertical-align:top;}
table#listPet tbody td{width:20%;padding:15px; vertical-align:top; text-align:center;}
table#listPet tbody td.lastTd{min-width:40%;}

input[type="button"]{width: 10%; min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
input[type="button"]:hover{background: #fb929e; color: #fff;}
</style>
</head>
<body>
	<div class="container">
		<div class="contents">
			<h2>반려동물 리스트</h2>
			<div class="petList">
				<table id="listPet">
					<thead>
						<tr>
							<th>반려동물이름</th>
							<th>생일</th>
							<th>종</th>
							<th>종류</th>
							<th>몸무게(kg)</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			<div class="input-submit">
				<input type="button" value="반려동물 등록" onclick="location.href='myPetInsert.jsp'">
			</div>
		</div>
	</div>
	<script>
		
		$(function(){
			var userId = '<%= loginUser.getUsId() %>';
			
			$.ajax({
				url: '<%= request.getContextPath() %>/list.pet',
				type: 'post',
				data: {userId: userId},
				success: function(data){
					$list = $('#listPet tbody');
					console.log(data);
					var resultStr="";
					for(var i in data){
						var href='"<%= request.getContextPath() %>/detail.pet?petNum=' + data[i].petNum + '"';
						
						resultStr += "<tr onmouseenter=address(this); onclick='location.href=" + href + "';>"
						    +"<td>"+data[i].petName + "</td>"
							+"<td>"+data[i].petBirth + "</td>"
							+"<td>"+data[i].petCate + "</td>"
							+"<td>"+data[i].petSpec + "</td>"
							+"<td>"+data[i].petWeight + "</td></tr>";
					}
					
					$("#listPet").children("tbody").html(resultStr);
				},
				error: function(data){
					console.log('error');
				},
				complete: function(data){
					console.log('co');
				}
			});
			
			$(window).click(function(){
				$('#listArea > thead').offset();
			});
			
		});
		
	</script>
</body>
</html>