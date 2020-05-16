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
 	}
 	else{
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

<style>
A:link {color: #1f3174; text-decoration: none}
A:active {color: #1f3174; text-decoration: none}
A:visited {color: #1f3174; text-decoration: none}
A:hover {color: #3366cc; text-decoration: underline}

.verdana_b { font-family:verdana, arial; font-size: 9px; font-weight: bold}
.cal_red { font-family:verdana, arial; font-size: 9px; color: #CC0000 }
.cal_blue { font-family:verdana, arial; font-size: 9px; color: #6666CC }
.cal_black { font-family:verdana, arial; font-size: 9px; color: #333333 }
</style>

</head>

<body bgcolor=#FFFFFF text=#000000 leftmargin=20 topmargin=20 marginwidth=20 marginheight=20>

	<table width=580 border=0 cellspacing=0 cellpadding=0>
 		<tr>
  			<td>
		 		<table width=580 border=0 cellspacing=0 cellpadding=0>
		    		<tr>
		     			<td align=center valign=middle height=25 background=http://img.cyworld.com/img/icon/popup_back_gray.gif>
		      				<a href=<%=prev%>><font color=#FFFFFF>◀</font></a>
		     				<font color=#FFFFFF><font face=Verdana, Arial, Helvetica, sans-serif><b>
		      				<%=year%>    <%=month%></b></font>  </font>
		      				<a href=<%=next%>><font color=#FFFFFF>▶</font></a>
		     			</td>
		    		</tr>
		   		</table>
 	 		</td>
 		</tr>
	</table>
<!-- 캘린더 HEAD -->

<!-- 달력 시작 -->
<table width=580 border=0 cellspacing=1 cellpadding=3 bgcolor=#999999>
 <tr bgcolor=#FCFCF3 align=center>
  <td width=82 class=verdana_b><font color=#CC0000>Sun</font></td>
  <td width=82 class=verdana_b><font color=#666666>Mon</font></td>
  <td width=82 class=verdana_b><font color=#666666>Tue</font></td>
  <td width=82 class=verdana_b><font color=#666666>Wed</font></td>
  <td width=82 class=verdana_b><font color=#666666>Thu</font></td>
  <td width=82 class=verdana_b><font color=#666666>Fri</font></td>
  <td width=82 class=verdana_b><font color=#6666CC>Sat</font></td>
 </tr>

<%
	cal.set(Integer.parseInt(year), Integer.parseInt(month) - 1 , 1);
	int indent = cal.get(Calendar.DAY_OF_WEEK);
	cal.add(Calendar.MONTH, 1);
 	cal.add(Calendar.DATE, -1);
 	int numberOfDays = cal.get(Calendar.DATE);

 	for (int i = 1; i < indent; i++){
  		if (i == 1){
   			out.println("<tr bgcolor='#FFFFFF' valign='top' height='85'>");
  		}
  		out.println("<td width='82'></td>");
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
   			out.println("<tr bgcolor='#FFFFFF' valign='top' height='85'>");
   			cssClass = "cal_red";
  		}
  		else if (((indent + i) - 1) % 7 == 0){
   			cssClass = "cal_blue";
  		}

  		if (df.format(today.getTime()).equals(year + month + day)){
   			out.println("<td width='82' bgcolor='#F2F112'>");
  		} else {
   			out.println("<td width='82'>");
  		}

  		out.println("<span class=" + cssClass + ">" + i + "</span>");
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

</body>

</html>