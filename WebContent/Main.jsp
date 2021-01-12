<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%!
	ResultSet rs;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Main </title>
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
		table {
	      	margin-top : 50px;
	      	margin-left : 100px;
	      	width : 1300px;
		}
		tr, td {
			font-size : 20pt;
			align : middle;
		}
	</style>
</head>
<body>
	<%		
		Connection conn = null;
		PreparedStatement pstmt = null;
	// jdbc:mysql://localhost:3309/eunjin?serverTimezone=UTC?serverTimezone=UTC
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3309/eunjin?serverTimezone=UTC";
			String dbId = "eunjinid";
			String dbPass = "eunjinpass";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			//out.println("DB 연결 성공");
			
			String sql = "select * from O_product";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		String pid1 = "";
		String pid2 = "";
		String pid3 = "";
		String img1 = "";
		String img2 = "";
		String img3 = "";
		String pname1 = "";
		String pname2 = "";
		String pname3 = "";
		String price1 = "";
		String price2 = "";
		String price3 = "";
		boolean f1 = false;
		boolean f2 = false;
		boolean f3 = false;
				
	%>
			
		<div class = "h"> Product List </div>
		<div class = "m"> 상품목록 </div>
		<% while(rs.next()) { 
			pid1 = rs.getString("pid");
			img1 = rs.getString("pimg");
			pname1 = rs.getString("pname");
			price1 = rs.getString("price");
			f1 = true;
			if(rs.next()) {
				pid2 = rs.getString("pid");
				img2 = rs.getString("pimg");
				pname2 = rs.getString("pname");
				price2 = rs.getString("price");
				f2 = true;
			}
			else {
				pid2 = "";
				img2 = "";
				pname2 = "";
				price2 = "";
				f2 = false;
			}
			if(rs.next()) {
				pid3 = rs.getString("pid");
				img3 = rs.getString("pimg");
				pname3 = rs.getString("pname");
				price3 = rs.getString("price");
				f3 = true;
			}
			else {
				pid3 = "";
				img3 = "";
				pname3 = "";
				price3 = "";
				f3 = false;
			}
		%>
			<table>
				<tr>
				<% if(f1) { %>
					<td align = "center"> <img src = "<%= img1 %>" width = "300"> </img></td> 
					<% } if(f2) {%>
					<td align = "center"> <img src = "<%= img2 %>" width = "300"> </img></td>
					<% } if(f3) {%>
					<td align = "center"> <img src = "<%= img3 %>" width = "300"> </img></td>
				<% } %>
				</tr> 
				<tr>
				<% if(f1) { %>
					<td align = "center"> <a href = "ProDetail.jsp?pid=<%= pid1 %>" target = "main"><%= pname1 %> </td> 
					<% } if(f2) {%>
					<td align = "center"> <a href = "ProDetail.jsp?pid=<%= pid2 %>" target = "main"><%= pname2 %></td>
					<% } if(f3) {%>
					<td align = "center"> <a href = "ProDetail.jsp?pid=<%= pid3 %>" target = "main"><%= pname3 %></td>
				<% } %>
				</tr> 
				<tr>
				<% if(f1) { %>
					<td align = "center"> <%= price1 + "원" %> </td> 
					<% } if(f2) {%>
					<td align = "center"> <%= price2 + "원" %></td>
					<% } if(f3) {%>
					<td align = "center"> <%= price3 + "원" %></td>
				<% } %>
				</tr> 
			</table>
		<% } %>
</body>
</html>