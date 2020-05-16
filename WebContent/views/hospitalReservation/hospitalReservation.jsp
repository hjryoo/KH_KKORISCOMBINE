<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/layout.jsp" %>
<%
	ArrayList<RVInfo> list = (ArrayList<RVInfo>)request.getAttribute("list");
	ArrayList<RVInfo> TDRVList = (ArrayList<RVInfo>)request.getAttribute("TDRVList");
 	String year = (String)request.getAttribute("year");
 	String month = (String)request.getAttribute("month");
 	String day = "01";
 	String Ryear = (String)request.getAttribute("Ryear");
 	String Rmonth = (String)request.getAttribute("Rmonth");
 	String Rday = (String)request.getAttribute("Rday");
 	String dayOfTheWeek = (String)request.getAttribute("dayOfTheWeek");
 	
 	
 	System.out.println(loginHp);
 	System.out.println("ssss hpId = "+loginHp.getHpId());
 	

 	Calendar cal = Calendar.getInstance();
 	Date todayDate = cal.getTime();
	java.text.DateFormat df = null;
 	/* 
 	
	if ((year = request.getParameter("year")) == null){
		df = new SimpleDateFormat("yyyy");
 		year = df.format(cal.getTime());
	}
	if((Ryear = request.getParameter("Ryear")) == null){
		Ryear = df.format(cal.getTime());
	}
	
	if ((month = request.getParameter("month")) == null && (Rmonth = request.getParameter("Rmonth")) == null){
		df = new SimpleDateFormat("MM");
 		month = df.format(cal.getTime());
 		Rmonth = df.format(cal.getTime());
	} 
	if((Rmonth = request.getParameter("Rmonth")) == null){
		Rmonth = df.format(cal.getTime());
	}
	df = new SimpleDateFormat("dd");
	if((Rday = request.getParameter("Rday")) == null){
		Rday = df.format(cal.getTime());
	}
	df = new SimpleDateFormat("yyyyMM");
	if (df.format(cal.getTime()).equals(year + month)){
		df = new SimpleDateFormat("dd");
 		day = df.format(cal.getTime());
	} */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section.HRmain {
		position:relative; height:100%; width:100%; 
		background-size: contain;
	}
	section.HRmain > article.HRquickMenu {
		position: relative; width: 100%; height: 100%;
		margin: 0 auto; text-align: center; min-width: 1100px;
	}
	section.HRmain > article.HRquickMenu > h1{
		position: relative;
		margin: 0 auto;
		font-size: 40px;
		width: 270px;
		text-align: center;
		vertical-align: middle;
	}
	
	section.HRmain > article.HRquickMenu > table.calendarBody{
		display: inline-block;
		border:0; cellspacing:1; cellpadding:3;
	}
	section.HRmain > article.HRquickMenu > table.calendarBody th.yearMonth{
		background: #ffdfdf; border: 1px solid #ffdfdf; vertical-align: middle;
		height: 25px;
	}
	section.HRmain > article.HRquickMenu > table.calendarBody th.yearMonth > label:hover{
		cursor: pointer;
	}
	section.HRmain > article.HRquickMenu > table.calendarBody td.verdana_b{
		background: #FCFCF3; font-family:verdana, arial; font-size: 9px; font-weight: bold; height: 16px;
	}
	section.HRmain > article.HRquickMenu > table.calendarBody td{
		border: 1px solid #ffdfdf; text-align: left;
		width: 110px; height: 110px; max-height:110px; vertical-align: top;
	}
	A:link {color: #1f3174; text-decoration: none}
	A:active {color: #1f3174; text-decoration: none}
	A:visited {color: #1f3174; text-decoration: none}
	A:hover {color: #3366cc; text-decoration: underline}
	
	.cal_red { font-family:verdana, arial; font-size: 10px; color: #CC0000 }
	.cal_blue { font-family:verdana, arial; font-size: 10px; color: #6666CC }
	.cal_black { font-family:verdana, arial; font-size: 10px; color: #333333 }
	
	
	
	section.HRmain > article.HRquickMenu > div.todayReservation{
		display: inline-block;
		position: relative;
		min-width: 250px;
		width: 15%;
		vertical-align: top;
		text-align: center;
		margin: 0 0 0 2%;
		height: 592px;
		overflow: auto;
		border: 1px solid #ffdfdf;
		padding: 5px;
	}
	div.todayReservation > label.todayDate{
		border-bottom: 1px solid #5d5d5d;
	}
	div.todayReservation > div.rvInfo  ul{
		display: none; border-top: 1px solid lightgray;
		border-bottom: 1px solid black; margin
	}
	div.rvInfo > div.rvInfoOne{
		margin: 3px;
	}
	div.todayReservation > div.rvInfo label.reservationTime{cursor:pointer;}
	div.todayReservation > div.rvInfo label > i{vertical-align: top; padding-top: 2px;}
	div.todayReservation > div.rvInfo textarea{
		width: 100px; resize: none;
	}
	
	div.todayReservation > div.rvInfo > table{
		width: 90%;
		position: relative; margin: 3px auto 0 auto;
		display: none; border-top: 1px solid lightgray;
		border-bottom: 1px solid black;
	}
	div.rvInfo > table tr{
		border-bottom: 1px solid lightgray;
	}
	div.rvInfo > table tr:last-child{
		border-bottom: 1px solid black;
	}
	div.rvInfo > table td{
		padding: 5px;
	}
	
	
	
	.pointer{cursor: pointer;}
	button.WaitBtn{
		width: 50px; height: 25px; background: #ffdfdf; 
		color: #5d5d5d; font-size: 12px; font-weight: 600; border: none; 
		border-radius: 5px; vertical-align: middle;
		text-align: center;
	}
	button.WaitBtn:hover{
		background: #fb929e; color: #fff; cursor: pointer;
	}
	button.CouponBtn{
		width: 70px; height: 30px; background: #ffdfdf; 
		color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; 
		border-radius: 5px;
	}
	button.CouponBtn:hover{
		background: #fb929e; color: #fff; cursor: pointer;
	}
	button.RVBtn{
		width: 90px; height: 30px; background: #ffdfdf; 
		color: #5d5d5d; font-size: 14px; font-weight: 600; border: none; 
		border-radius: 5px;
	}
	button.RVBtn:hover{
		background: #fb929e; color: #fff; cursor: pointer;
	}
	
</style>
</head>
<body>
<form id=HRform action="<%=request.getContextPath() %>/HpRvCheck.hp" method="post">
	<input type=hidden name=hpId id=hpId value=<%=loginHp.getHpId() %>>

	<input type=hidden name=year id=year value=<%=year %>>
	<input type=hidden name=month id=month value=<%=month %>>
	<input type=hidden name=Ryear id=Ryear value=<%=Ryear %>>
	<input type=hidden name=Rmonth id=Rmonth value=<%=Rmonth %>>
	<input type=hidden name=Rday id=Rday value=<%=Rday %>>
	
	<input type=hidden name=rsNum id=rsNum>
	<input type=hidden name=rsVisit id=rsVisit>
	
	<div class="container">
    	<section class="HRmain">
			<article class="HRquickMenu">
			
				<br><br>
				
				<h1>예약 관리</h1>
				
				<br> <br><br>
				
				<table class=calendarBody>
					<tr>
						<th colspan="7" class=yearMonth>
							<label id="prev"><font color=#FFFFFF>◀</font></label>&nbsp;&nbsp;
					     	<%=year%>    <%=month%>&nbsp;&nbsp;
					      	<label id=next><font color=#FFFFFF>▶</font></label>
					    </th>
					    <script>
						    $("#prev").click(function(){
								var year = <%=year%>;
								var month = <%=month%>;
								
								if(month == "1"){
									year = ""+(Number(year) - 1);
							  		month = "12";
								} else {
									var prevMonth = "0"+String(Number(month)-1);
									if (prevMonth.length == 3){
								  		prevMonth = prevMonth.substring(1);
							  		}
									month = prevMonth;
								}
								$("#year").val(year);
								$("#month").val(month);
								
								$("#HRform").submit();
							});
							
							$("#next").click(function(){
								var year = <%=year%>;
								var month = <%=month%>;
								
								if(month == "12"){
									year = ""+(Number(year) + 1);
							  		month = "01";
								} else {
									var prevMonth = "0"+String(Number(month)+1);
									if (prevMonth.length == 3){
								  		prevMonth = prevMonth.substring(1);
							  		}
									month = prevMonth;
								}
								$("#year").val(year);
								$("#month").val(month);
								
								$("#HRform").submit();
							});
					    </script>
					</tr>
			 		<tr class=dayOfTheWeek>
				  		<td class=verdana_b><font color=#CC0000>Sun</font></td>
				  		<td class=verdana_b><font color=#666666>Mon</font></td>
				  		<td class=verdana_b><font color=#666666>Tue</font></td>
				  		<td class=verdana_b><font color=#666666>Wed</font></td>
						<td class=verdana_b><font color=#666666>Thu</font></td>
						<td class=verdana_b><font color=#666666>Fri</font></td>
						<td class=verdana_b><font color=#6666CC>Sat</font></td>
			 		</tr>
			 	
					<%
						cal.set(Integer.parseInt(year), Integer.parseInt(month) - 1 , 1);
						int indent = cal.get(Calendar.DAY_OF_WEEK);
						cal.add(Calendar.MONTH, 1);
					 	cal.add(Calendar.DATE, -1);
					 	int numberOfDays = cal.get(Calendar.DATE);
					
					 	for (int i = 1; i < indent; i++){
					  		if (i == 1){
					   			out.println("<tr>");
					  		}
					  		out.println("<td></td>");
					 	}	
					
					 	Calendar today = Calendar.getInstance();
					 	df = new SimpleDateFormat("yyyyMMdd");
					 
					 	for (int i = 1; i <= numberOfDays; i++){
					  		String cssClass = "cal_black";
					  		String dayDescript = "";
					 		day = "0" + i;
					
					  		if (day.length() == 3){
					   			day = day.substring(1);
					  		}
					
					  		if (((indent + i) - 1) % 7 == 1){  // 일요일
					   			out.println("<tr>");
					   			cssClass = "cal_red";
					  		}
					  		else if (((indent + i) - 1) % 7 == 0){
					   			cssClass = "cal_blue";
					  		}
					
					  		if (df.format(today.getTime()).equals(year + month + day)){
					   			out.println("<td onclick=reservation(this); class=pointer bgcolor='#ffdfdf'>");
					  		} else {
					   			out.println("<td onclick=reservation(this); class=pointer>");
					  		}
					
					  		out.println("<span class=" + cssClass + ">" + day + "</span>");
					  		out.println(dayDescript);
					  		out.print("<div style='overflow:auto; height:80px;'>");
					  		
					  		for(int jj = 0; jj < list.size(); jj++){
					  			if(list.get(jj).getRsDate().substring(0, 10).equals(year+"/"+month+"/"+day)){
					  				String rsdate = list.get(jj).getRsDate();
					  				out.print(rsdate.substring(11, rsdate.length())+":00<br>");
					  			}
					  		}
					  		out.println("</div>");
					  		out.println("</td>");
					  
					  		if (((indent + i) - 1) % 7 == 0){
					   			out.println("</tr>"); //토요일
					  		}
					 	}
					
					
					 	if(((indent == 6) && (numberOfDays > 30) ) || ( (indent == 7) && (numberOfDays > 29) ) ){
					  		if (41-numberOfDays-indent > 0){
					   			for (int i = 43 - numberOfDays - indent; i > 0; i--){
					    			out.println("<td> </td>");
					   			}
					  		}
					  		out.println("</tr>");
					 	} else if ( (numberOfDays != 28) || (indent > 1) ){
					  		if (36-numberOfDays-indent > 0){
					   			for (int i = 36 - numberOfDays - indent; i > 0; i--){
					    			out.println("<td> </td>");
					   			}
					  		}
					  		out.println("</tr>");
					 	}
					%>
				</table>
				
				<div class=todayReservation>
					<label class=todayDate><%=Ryear %>/<%=Rmonth %>/<%=Rday %>(<%=dayOfTheWeek %>)</label><br>
					<div class=rvInfo>
					<%if(TDRVList.size() > 0) {%>
						<%for(int i = 0; i < TDRVList.size(); i++) {%>
						<div class=rvInfoOne>
						<label onclick=toggleInfo(this); class=reservationTime>시간: <%=TDRVList.get(i).getRsDate().substring(11, TDRVList.get(i).getRsDate().length()) %>:00&nbsp;<i class='fas fa-sort-down'></i></label>
						<%
							SimpleDateFormat sm = new SimpleDateFormat("yyyy/MM/dd HH");
							Date rvDate = sm.parse(TDRVList.get(i).getRsDate());
						%>
						<%if(!TDRVList.get(i).getPetName().equals("null")) {%>
							<%if(rvDate.compareTo(todayDate) < 0) {%>
								<%if(TDRVList.get(i).getRsVisit().equals("Wait")) {%>
								<button type=button class=WaitBtn onclick="Wait(<%=TDRVList.get(i).getRsNum() %>);">Wait</button>
								<%} else if(TDRVList.get(i).getRsVisit().equals("Visit")){%>
								<button type=button class=WaitBtn onclick="Wait(<%=TDRVList.get(i).getRsNum() %>);">Visit</button>
								<%} else if(TDRVList.get(i).getRsVisit().equals("Cancle")){%>
								<button type=button class=WaitBtn onclick="Wait(<%=TDRVList.get(i).getRsNum() %>);">Cancle</button>
								<%} %>
							<%} else {%>
								<p style="display: inline;"></p>
							<%} %>
						<%} else {%>
							<button type=button class=WaitBtn onclick="DeleteBtn(<%=TDRVList.get(i).getRsNum() %>);">Delete</button>
						<%} %>
						</div>
						<table>
						 	<tr>
						 		<td>예약상태  </td> 
						 		<td>
						 			<%if(TDRVList.get(i).getRsVisit().equals("Wait")) {%>방문대기
						 			<%} else if(TDRVList.get(i).getRsVisit().equals("Visit")) {%>방문확인
						 			<%} else if(TDRVList.get(i).getRsVisit().equals("Cancle")) {%>미방문<%} %>
						 		</td>
						 	</tr>
						 	<tr>
						 		<td>이름  </td>
						 		<td><%=TDRVList.get(i).getPetName() %></td>
						 	</tr>
						 	<tr>
						 		<td>품종  </td>
						 		<td><%=TDRVList.get(i).getPetSpec() %></td>
						 	</tr>
						 	<tr>
						 		<td>성별  </td>
						 		<td><%=TDRVList.get(i).getPetGen() %></td>
						 	</tr>
						 	<tr>
						 		<td>생일  </td>
						 		<td><%=TDRVList.get(i).getPetBirth() %></td>
						 	</tr>
						 	<tr>
						 		<td>체중  </td>
						 		<td><%=TDRVList.get(i).getPetWeight() %>kg</td>
						 	</tr>
						 	<tr>
						 		<td>기초예방<br>접종여부</td>
						 		<td><%=TDRVList.get(i).getPetVacc() %></td>
						 	</tr>
						 	<tr>
						 		<td>진료과  </td>
						 		<td><%=TDRVList.get(i).getHmCate() %></td>
						 	</tr>
						 	<tr>
						 		<td colspan=2>특이사항</td>
						 	</tr>
						 	<tr>
						 		<td colspan="2"><%=TDRVList.get(i).getRsMemo() %></td>
						 	</tr>
						 </table>
						<%} %>
					<%} else {%>
						<p>예약자 없음</p>
					<%} %>
					</div>
				</div>
				<br>
				<br>
				<a href="<%=request.getContextPath() %>/views/hospitalReservation/couponValidate.jsp" onclick="return openCoupon(this);"><button type=button class=CouponBtn>쿠폰사용</button></a>
				<a href="<%=request.getContextPath() %>/views/hospitalReservation/HpReservationInsert.jsp" onclick="return openRV(this)";><button type=button class=RVBtn>예약추가하기</button></a>
			</article>
		</section>
	</div>
	</form>
	
	<script>
		function Wait(rsNum){
			var rsVisit;
			var isTrue = confirm("방문확인 : 손님이 예약한시간에 오셧나요?");
			if(isTrue){
				rsVisit = 'Y';
			} else {
				rsVisit = 'N';
			}
			$("#rsNum").val(rsNum);
			$("#rsVisit").val(rsVisit);
			
			$("form").submit();
		}
		
		function DeleteBtn(rsNum){
			var isTrue = confirm("예약을 삭제하시겠습니까?");
			if(isTrue){
				$("#rsNum").val(rsNum);
				$("form").submit();
			}
		}
	
		function toggleInfo(ti){
			console.log($(ti).parent().next().children().children().eq(1).children()[1].innerText);
			var isTrue = $(ti).parent().next().children().children().eq(1).children()[1].innerText == "null";
			if(isTrue){
				alert("병원에서 추가한 예약이기 때문에 동물정보가 없습니다.");
			} else {
				$(ti).parent().next().toggle();
			}
		}
		
		function reservation(ti){
			var Ryear = <%=year%>;
			var Rmonth = '<%=month%>';
			var Rday = $(ti).children()[0].innerText;
			$("#Ryear").val(Ryear);
			$("#Rmonth").val(Rmonth);
			$("#Rday").val(Rday);
			$("form").submit();	
		}
		
		function openCoupon(ti){
			var popupX = (document.body.offsetWidth / 2) - (600 / 2);
			var popupY = (document.body.offsetHeight / 2) - (300 / 2);
			window.open(ti.href, '_blank','width=600px, height=300px, left='+popupX+', top='+popupY+', location=no, toolbars=no, scrollbars=no');
			return false;
		}
		function openRV(ti){
			var popupX = (document.body.offsetWidth / 2) - (320 / 2);
			var popupY = (document.body.offsetHeight / 2) - (150 / 2);
			window.open(ti.href, '_blank','width=320px, height=150px, left='+popupX+', top='+popupY+', location=no, toolbars=no, scrollbars=no');
			return false;
		}
	</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>