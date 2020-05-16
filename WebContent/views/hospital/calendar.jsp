<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="java.util.*, java.text.*" %>
<%
 	String year = null;
 	String month = null;
 	String day = "01";

 	Calendar cal = Calendar.getInstance();
 	java.text.DateFormat df = null;

	 if ((year = request.getParameter("year")) == null){
		 df = new SimpleDateFormat("yyyy");
 		 year = df.format(cal.getTime());
	 }

	 if ((month = request.getParameter("month")) == null){
  		df = new SimpleDateFormat("MM");
 		 month = df.format(cal.getTime());
	 }

 	df = new SimpleDateFormat("yyyyMM");
 
	if (df.format(cal.getTime()).equals(year + month)){
 		df = new SimpleDateFormat("dd");
 		day = df.format(cal.getTime());
	}
	
	String prev = null;
	String next = null;
	
 	if (Integer.parseInt(month) == 1){
  		prev = "calendar.jsp?year=" + (Integer.parseInt(year) - 1) + "&month=12";
 	} else{
  		String prevMonth = "0" + (Integer.parseInt(month) - 1);
  
		if (prevMonth.length() == 3){
 			prevMonth = prevMonth.substring(1);
		}
  		prev = "calendar.jsp?year=" + year + "&month=" + prevMonth;
 	}

 	if (Integer.parseInt(month) == 12){
  		next = "calendar.jsp?year=" + (Integer.parseInt(year) + 1) + "&month=01";
 	} else {
  		String nextMonth = "0" + (Integer.parseInt(month) + 1);
  		if (nextMonth.length() == 3){
   			nextMonth = nextMonth.substring(1);
  		}
  		next = "calendar.jsp?year=" + year + "&month=" + nextMonth;
 	}
%>
<html>
<head>
<title>Calendar</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
<style>
A:link {color: #1f3174; text-decoration: none}
A:active {color: #1f3174; text-decoration: none}
A:visited {color: #1f3174; text-decoration: none}
A:hover {color: #3366cc; text-decoration: underline}

table {border: 0; color: #000;}
table.cal {width: 50%;}
table.inner {width: 100%;}
table.inner td {font-size: 20; font-weight: 600;}
td {vertical-align: middle;}
table.date td > p {text-align: center; font-size: 16px; font-weight: 600; margin: 0;}
.day {font-weight: 600;}
.red {color: #ff4848}
.blue {color: #0042ed}
.black {color: #000}
.onclick {background: #aedefc}
</style>

</head>

<body leftmargin=20 topmargin=20 marginwidth=20 marginheight=20>
	<%-- <%@ include file="../common/layout.jsp" %> --%>
	<table class="cal header">
 		<tr>
  			<td>
		 		<table class="inner">
		    		<tr>
		     			<td align=center valign=middle height=25>
		      				<a href=<%=prev%>><b class="prev">&lt;</b></a>
		     				<b><%=year%> <%=month%></b>
		      				<a href=<%=next%>><b class="next">&gt;</b></a>
		     			</td>
		    		</tr>
		   		</table>
 	 		</td>
 		</tr>
	</table>
<!-- 캘린더 HEAD -->

<!-- 달력 시작 -->
<!-- <table class="cal date" cellspacing=1 cellpadding=3 bgcolor=#999999> -->
<table class="cal date">
 <tr align=center>
  <td width=40 class="day red">Sun</td>
  <td width=40 class="day">Mon</td>
  <td width=40 class="day">Tue</td>
  <td width=40 class="day">Wed</td>
  <td width=40 class="day">Thu</td>
  <td width=40 class="day">Fri</td>
  <td width=40 class="day blue">Sat</td>
 </tr>

<%
	cal.set(Integer.parseInt(year), Integer.parseInt(month) - 1 , 1);
	int indent = cal.get(Calendar.DAY_OF_WEEK);
	cal.add(Calendar.MONTH, 1);
 	cal.add(Calendar.DATE, -1);
 	int numberOfDays = cal.get(Calendar.DATE);

 	for (int i = 1; i < indent; i++){
  		if (i == 1){
   			out.println("<tr valign='top' height='30'>");
  		}
  		out.println("<td width='30'></td>");
 	}	

 	Calendar today = Calendar.getInstance();
 	df = new SimpleDateFormat("yyyyMMdd");
 
 	for (int i = 1; i <= numberOfDays; i++){
  		String cssClass = "black";
  		String dayDescript = "";
 		day = "0" + i;

  		if (day.length() == 3){
   			day = day.substring(1);
  		}

  		if (((indent + i) - 1) % 7 == 1){  // 일요일
   			out.println("<tr valign='top' height='30'>");
   			cssClass = "red";
  		}
  		else if (((indent + i) - 1) % 7 == 0){
   			cssClass = "blue";
  		}

  		if (df.format(today.getTime()).equals(year + month + day)){
   			out.println("<td width='30' class='onclick'>");
  		} else {
   			out.println("<td width='30'>");
  		}

  		out.println("<p class=" + cssClass + ">" + i + "</p>");
  		out.println(dayDescript);
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

<script>
	$(function(){
		$('td').click(function(){
			var year = <%= year %>;
			var month = <%= month %>;
			var day = $(this).children().text();
			$('table.date td').removeClass('onclick');
			$(this).addClass('onclick');
		});
		
		<%-- $('b.prev').click(function(){
			var href = $(location).attr('href');
			$.ajax({
				url: href,
				type: 'post',
				data: {year: <%= year %>, month: <%= month %>},
				success: function(data){
					
				}
			});
		}); --%>
	});
</script>
</body>

</html>