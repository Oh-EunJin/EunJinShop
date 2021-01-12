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
		String opid = request.getParameter("opid");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ReviewRegi </title>
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
	      	border : 3px solid #FFB6B9;
	      	width : 420px;
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
			
			String sql = "select * from O_order where opid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, opid);
			rs = pstmt.executeQuery();
			
			//out.println(poption);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>

	<p>
	<div class = "h"> REVIEW Register </div>
	<div class = "m"> 리뷰 등록 </div>

	<form method = "post" name = "ReviewRegi" action = "ReviewIns.jsp?opid=<%= opid %>">
		<table align = "center">
			<tr>
				<td align = "center"> 상품 </td>
				<td align = "center"> 내용 </td>
			</tr>
			<tr>
				<% while(rs.next()) { %>
				<td>
					<img src = "<%= rs.getString("opimg") %>" width = "120"> </img>
				</td>
				<% } %>
				<td> 
					<textarea name = "rcomment" rows = "10" cols = "40"> </textarea>
				</td>
			</tr>
		</table>
		<p align = "center">
	       	<input type = "image" src = "img/REGISTER.png" name = "submit" value = "submit" width = "100">
        </p>
	</form>
</body>
</html>