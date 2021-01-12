<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<%!
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs;
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Notice </title>
	<style>
		body {
			font-size : 14pt;
			font-family : 휴먼편지체;
			background : #FFE6E8;
		}
		.n {
			margin-left : 1300px;
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
			
			String sql = "select * from O_notice order by nid desc";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//out.println(address);
			//conn.commit();	
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	<p>
	<div class = "h"> Notice </div>
	<div class = "m"> 공지사항 </div>
		<table align = "center">
 			<tr>
	   			<td align = "center" width = "10"> NO </td>
	   			<td align = "center" width = "1000"> SUBJECT </td>
	   			<td align = "center" width = "200"> DATE </td>
			</tr>
			<tr>
			<% while(rs.next()) { %>
				<td align = "center"> 
	   				<%= rs.getString("nid") %>
	         	</td>
	         	<td> 
	         		<a href = "Noticontext.jsp?nid=<%= rs.getString("nid")%>">
	   				<%= rs.getString("nsubject") %>
	         	</td>
	         	<td align = "center"> 
	   				<%= rs.getString("nsigndate") %>
	         	</td>
			</tr>
			<% } %>
		</table>
	</form>
</body>
</html>