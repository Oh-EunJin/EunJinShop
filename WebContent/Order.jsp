<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<%!
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs;
	%>
	<%
		String id = (String)session.getAttribute("id");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Order </title>
	<style>
		body {
			font-size : 15pt;
			font-family : 휴먼편지체;
			background : #FFE6E8;
		}
		.m {
			text-align : center;
			font-size : 20pt;
			font-family : 휴먼편지체;
			color : #FF8BA0;
		}
		.h {
			text-align : center;
			font-size : 40pt;
			font-family : Comic Sans MS;
			font-weight : bold;
			color : #FF8BA0;	
		}
		.mb {
			font-size : 15pt;
			font-family : 휴먼편지체;
			color : #f74d6c;
			margin-left : 250px;
		}
		table {
	      	margin-top : 40px;
	      	border : 3px solid #FFB6B9;
	      	width : 900px;
		}
		tr, td {
	     	border-bottom : 1px solid #FFB6B9;
	      	padding: 10px;
		}
	</style>
</head>
<body>
	<%		
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3309/eunjin?serverTimezone=UTC";
			String dbId = "eunjinid";
			String dbPass = "eunjinpass";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			//out.println("DB 연결 성공");
			
			String sql = "select * from O_order where omid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//out.println(poption);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
		<div class = "h"> Order List </div>
		<div class = "m"> 주문 목록  </div>
		
			<table align = "center">
				<tr>
					<td> 상품 </td>
					<td> 상품명 </td>
					<td width = "70"> 가격 </td>
					<td> 수량 </td>
					<td align = "center"> 상태 </td>
					<td align = "center"> 리뷰 </td>
				</tr>
				<tr>
				<% while(rs.next()) { %>
					<td> 
						<img src = "<%= rs.getString("opimg") %>" width = "90"> </img>
					</td>
					<td> 
						<a href = "ProDetail.jsp?pid=<%= rs.getString("opid")%>"> 
						<%= rs.getString("opname") %>
					</td>
					<td> <%= rs.getString("oprice") + "원" %> </td>
					<td> <%= rs.getString("ocamount") + "개" %> </td>
					<td align = "center"> <p>
						 배송 준비중
					</td>
					<td align = "center"> <p>
						 <a href = "ReviewRegi.jsp?opid=<%= rs.getString("opid")%>">
						 <input type = "image" src = "img/RE.png" width = "80"> </a> <p>
					</td>
				</tr>
				<%  }  %>
			</table> <p>
			<h class = "mb"> * 주문취소를 원하실경우 관리자에게 문의하시길 바랍니다 </h> 
</body>
</html>