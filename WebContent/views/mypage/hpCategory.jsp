<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 진료과 추가하기</title>
<%@ include file="../common/layout.jsp" %>
<%
	ArrayList<HpMedical> hmList = (ArrayList<HpMedical>)request.getAttribute("hmList");
%>
<style>
	h2 {font-weight: 700; font-size: 30px; color: #000; padding: 15px 0; text-align: center;}
	div.container {
		position: absolute; top:0; left:0; 
		padding-left:200px; width: 100%; height: 100%; 
		margin: 0 auto; box-sizing: border-box;
	}
	section.main {
		position:relative; height:100%; width:100%; 
		background-size: contain;
	}
	section.main > article.quickMenu {
		position: relative; width: 100%; height: 100%;
		text-align: center; min-width: 500px;
	}
	
	section.main > article.quickMenu > form > div.medi-sel{
		display: inline-block;
	}
	section.main > article.quickMenu > form > div.medi-sel select{
		width: 200px; height: 40px;
	}
	div.select-box{width: 200px;}
   	div.select-box.second{}
   	.medi-sel{ text-align: center;}
	.select-box > select{width: 200px; padding: 0;}
	
	section.main > article.quickMenu > form > div.input-box{
		display: inline-block;
		width: 20%; height: 30px;
	}
	section.main > article.quickMenu > form > div.input-submit{
		display: inline-block;
	}
	
	div.input-box > input {
		text-align: right; height: 40px;
	}
	input[type="button"] {min-width: 50px; height: 30px; cursor: pointer; background: #ffdfdf; color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; border-radius: 5px;}
	input[type="button"]:hover {background: #fb929e; color: #fff;}
	
	section.main > article.quickMenu > div.hmList{
		display: inline-block; width: calc(280px + 40%);
		text-align: center; align-content: center;
	}
	section.main > article.quickMenu > div.hmList > table.hmList{
		width: 100%; position: relative;
	}
	section.main > article.quickMenu > div.hmList > table.hmList tr{
		height: 35px; border-bottom: 1px solid #ffdfdf;
	}
	.thNumber{width: calc(100%-200px);}
	.hidden{display: none;}
		
</style>
</head>
<body>
	<div class="container">
    	<section class="main">
			<article class="quickMenu">
				<h2>진료 카테고리</h2>
				<form action="<%=request.getContextPath() %>/HpCategoryInsert.hp" method="post">
					<div class="medi-sel">
						<p class="input-label">Category</p>
						<div class="select-box">
							<select id="medical" name=hmCate>
								<option disabled>--진료과목--</option>
								<option value="HC1">내과</option>
								<option value="HC2">외과</option>
								<option value="HC3">안과</option>
								<option value="HC4">치과</option>
								<option value="HC5">피부과</option>
								<option disabled>--검사--</option>
								<option value="HI1">기초 혈액검사</option>
								<option value="HI2">심장사상충 검사</option>
								<option value="HI3">혈액형 검사</option>
								<option value="HI4">항체가 검사</option>
								<option value="HI5">내시경</option>
								<option value="HI6">초음파</option>
								<option disabled>--건강검진--</option>
								<option value="HS1">기초 종합검진</option>
								<option value="HS2">복합 종합검진</option>
								<option disabled>--예방접종--</option>
								<option value="HV1">코로나</option>
								<option value="HV2">켄넬로프</option>
								<option value="HV3">광견병</option>
								<option value="HV4">인플루엔자</option>
								<option value="HV5">반려견 종합백신</option>
								<option value="HV6">반려묘 종합백신</option>
								<option disabled>--중성화 수술--</option>
								<option value="HZ1">수컷</option>
								<option value="HZ2">암컷</option>
								<option value="HZ3">잠복고환</option>
							</select>
						</div>
					</div>
					
					<div class="input-box">
						<p class="input-label">최소 진료비</p><input type="text" name="hmMin" id="hmMin" onkeyup="inputNumberAutoComma(this);" required>
					</div>
					
					<div class="input-box">
						<p class="input-label">최대 진료비</p><input type="text" name="hmMax" id="hmMax" onkeyup="inputNumberAutoComma(this);" required>
					</div>
					
					<div class="input-submit"><input type="button" id="insertBtn" value="추가"></div>
					
					<br><br>
					
				</form>
				<div class=hmList>
					<table class=hmList>
						<thead>
						<tr>
							<th width="200px">Category</th>
							<th>최소 진료비</th>
							<th>최대 진료비</th>
							<th width="80px"></th>
						</tr>
						</thead>
						<tbody>
							<%if(hmList == null){ %>
							<tr>
								<td colspan="3">조회된 카테고리가 없음</td>
								<td></td>
							</tr>
							<%} else { %>
								<%for(int i = 0; i < hmList.size(); i++) {%>
								<tr>
									<td><%=hmList.get(i).getHmCate() %></td>
									<td><%=hmList.get(i).getHmMin() %></td>
									<td><%=hmList.get(i).getHmMax() %></td>
									<td><input type=button value='삭제' onclick=CategoryDelete(this);></td>
								</tr>
								<%} %>
							<%} %>
						</tbody>
					</table>
				</div>
				<script>
					$("#medical").change(function(){
						$("#hmMin").focus();
					});
					$("#hmMin").focus(function(){
						$(this).val("");
					});
					$("#hmMax").focus(function(){
						$(this).val("");
					});
				
				//------------------------------------------------------------
					
					function inputNumberAutoComma(obj) {
				       // 콤마( , )의 경우도 문자로 인식되기때문에 콤마를 따로 제거한다.
				       var deleteComma = obj.value.replace(/\,/g, "");
				       // 콤마( , )를 제외하고 문자가 입력되었는지를 확인한다.
				       if(isFinite(deleteComma) == false) {
				           alert("문자는 입력하실 수 없습니다.");
				            obj.value = "";
				            return false;
				        }
				        // 기존에 들어가있던 콤마( , )를 제거한 이 후의 입력값에 다시 콤마( , )를 삽입한다.
				        obj.value = inputNumberWithComma(inputNumberRemoveComma(obj.value));
				    }
				    // 천단위 이상의 숫자에 콤마( , )를 삽입하는 함수
				    function inputNumberWithComma(str) {
				        str = String(str);
				        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
				    }
				    // 콤마( , )가 들어간 값에 콤마를 제거하는 함수
				    function inputNumberRemoveComma(str) {
				        str = String(str);
				        return str.replace(/[^\d]+/g, "");
				    }
				//------------------------------------------------------------
					//홈페이지에 들어온 직후 hmList 고치기
					var select = $("#medical option");
					
					var trLength = $("table.hmList > tbody > tr").length;
					
					for(var i = 0; i < trLength; i++){
						var td1 = $("table.hmList > tbody > tr").eq(i).children()[0];
						var td2 = $("table.hmList > tbody > tr").eq(i).children()[1];
						var td3 = $("table.hmList > tbody > tr").eq(i).children()[2];
						for(var j = 0; j < select.length; j++){
							if(select[j].value == td1.innerText){
								td1.innerText = select[j].text;
							}
						}
						td2.innerText = inputNumberWithComma(td2.innerText)+"원";
						td3.innerText = inputNumberWithComma(td3.innerText)+"원";
						
					}
				//------------------------------------------------------------
					$("#insertBtn").click(function(){
						var hmCate = $("#medical").val();
						var hpId = "<%=loginHp.getHpId()%>";
						var hmMin = $("#hmMin").val().replace(/\,/g, "");
						var hmMax = $("#hmMax").val().replace(/\,/g, "");
						
						$.ajax({
							url: "<%=request.getContextPath()%>/HpCategoryInsert.hp",
							type: "post",
							data: {hmCate:hmCate, hpId:hpId, hmMin:hmMin, hmMax:hmMax},
							success: function(data){
								var tbody = $("table.hmList > tbody");
								tbody.html("");
								var select = $("#medical option");
								var resultStr;
								var hmCateList = new Array;
								for(var i in data){
									for(var j = 0; j < select.length; j++){
										if(select[j].value == data[i].hmCate){
											hmCateList[i] = select[j].text;
										}
									}
									resultStr +="<tr><td>"+hmCateList[i]+
												"</td><td>"+inputNumberWithComma(data[i].hmMin)+"원"+
												"</td><td>"+inputNumberWithComma(data[i].hmMax)+"원"+
												"</td><td><input type=button value='삭제' onclick=CategoryDelete(this);></td></tr>";
								}
								tbody.html(resultStr);
							}
						});
					});
				//------------------------------------------------------------
					function CategoryDelete(thid){
						var hmCateText = $(thid).parent().parent().children().eq(0)[0].innerText;
						var select = $("#medical option");
						
						for(var j = 0; j < select.length; j++){
							if(select[j].text == hmCateText){
								hmCateText = select[j].value;
							}
						}
						$.ajax({
							url: "<%=request.getContextPath()%>/HpCategoryDelete.hp",
							type: "post",
							data: {hpId:"<%=loginHp.getHpId()%>", hmCate:hmCateText},
							success: function(data){
								var tbody = $("table.hmList > tbody");
								tbody.html("");
								var select = $("#medical option");
								var resultStr;
								var hmCateList = new Array;
								for(var i in data){
									for(var j = 0; j < select.length; j++){
										if(select[j].value == data[i].hmCate){
											hmCateList[i] = select[j].text;
										}
									}
									resultStr +="<tr><td>"+hmCateList[i]+
												"</td><td>"+inputNumberWithComma(data[i].hmMin)+"원"+
												"</td><td>"+inputNumberWithComma(data[i].hmMax)+"원"+
												"</td><td><input type=button value='삭제' onclick=CategoryDelete(this);></td></tr>";
								}
								tbody.html(resultStr);
							}
						});
					}
				</script>
			</article>
		</section>
	</div>
</body>
</html>