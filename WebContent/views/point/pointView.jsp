<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*, common.model.vo.Paging, point.model.vo.Point" %>
<%
	ArrayList<Point> list = (ArrayList<Point>)request.getAttribute("list");
	
	int curPt = 0;
	int point = 0;
	String ptHis = null;
	
	if(list.isEmpty()){
		curPt = 0;
	}else{
		for(int i = 0; i < list.size(); i++){
			if(list.get(i).getPtAdd() != 0){
				curPt += list.get(i).getPtAdd();
			}else {
				curPt -= list.get(i).getPtUse();
			}
			
			switch(list.get(i).getPtCate()){
			case 1 : ptHis = "리뷰 작성"; break;
			case 2 : ptHis = "댓글 포인트"; break;
			case 3 : ptHis = "좋아요 포인트"; break;
			case 4 : ptHis = "쿠폰 구매"; break;
			}
			list.get(i).setPtHis(ptHis);		
		}
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꼬리스컴바인 : 포인트</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/index.css"/>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<style>
<style>
	#blogo{margin-top: 50px;}
	#pointView{border-color: #AEDEFC; cursor: default;}
	#pointBtn{margin-left: 850px; margin-top: 20px; min-width: 300px;}
	.outer{width: 100px; height: 800px; background: rgba(255, 255, 255, 0.4); margin-left: 300px; margin-right: auto; margin-top: auto;}
	.writeArea{width: 800px; height: 600px; margin-top: 10px; margin-left: 180px; margin-right: auto; padding: 10px; border: 1px solid #FB929E;}	
	.pt{text-align: right;}
	.input{font-family: inherit; width: 100%; border: 0; outline: 0; background: transparent; transition: border-color 0.2s;}	
	#page{margin-left: 270px;}
	#pUsing{font-size: 18px; text-align: center; background-color: #575756; color:#FFF6F6; border: 1px solid #575756; border-radius: 5px; width: 120px; height: 40px; }
	#pUsing:hover {background: #ffe3e4; color: #575756; cursor: pointer;}
	#ptHis::-webkit-scrollbar {width: 6px; background-color: #F5F5F5;} 
	#ptHis::-webkit-scrollbar-thumb {background-color: #FB929E;}

</style>
</head>
<body>
<%@ include file="../common/layout.jsp" %> 
		<!-- 포인트 -->	
		<div class="outer">
			<img src="<%= request.getContextPath() %>/images/point.png" id="blogo" style="margin-left: 500px; margin-top: 50px;">
			<br>
			<form action="views/point/pointUse.jsp" method="post">
				<input type="text" id="pointView" style="margin-left: 500px; margin-top: 50px; width: 150px; height: 30px; text-align: right;" value="<%= curPt %>pt" disabled>
				<input type="hidden" name="curPt" value="<%= curPt%>">
		<br>
		<div id="pointBtn">
			<input type="submit" id="pUsing" value="포인트 사용">
		</div>
			</form>
		<div class="writeArea">		

			<div style="text-align:center; font-size: 20pt; font-weight: 700;">포인트 기록<br><br></div>
			<div id = "ptHis" style="text-align:center; overflow-y:scroll; width: 600px; height: 500px; margin-left: 100px;">
					<% if(list.isEmpty()) { %>
					<div>아직 포인트 기록이 없습니다.</div>
					<% } else {
							for(Point pt : list) {	
					%>			
							<span style="width: 120px;"><%= pt.getPtDate() %><input type="hidden" name ="date" value='<%= pt.getPtDate() %>'></span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
							
							<span style="width: 120px;"><%= pt.getPtHis() %><input type="hidden" name ="ptHis" value='<%= pt.getPtHis() %>'></span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
							
							<span style="width: 120px;"><% if(pt.getPtAdd() != 0){ %>
								<span style="color: blue; width: 120px;" >+<%= pt.getPtAdd() %><input type="hidden" name ="ptHis" value='<%= pt.getPtAdd() %>'></span>pt					
								<% } else { %>
								<span style="color: red; width: 120px;">-<%= pt.getPtUse() %><input type="hidden" name ="ptHis" value='<%= pt.getPtUse() %>'></span>pt					
								<% } %></span><br><br>
	           	    <%       }				               
                    } %>
                    </div>	
			</div>
		</div>						
		<script>
/* 			$(function(){
				$('tbody td').mouseenter(function(){
					$(this).parent().css({'background':'#ffe3e4', 'cursor':'pointer'});
				}).mouseout(function(){
					$(this).parent().css("background", "none");
				});			
			}); */
		</script>
</body>
</html>