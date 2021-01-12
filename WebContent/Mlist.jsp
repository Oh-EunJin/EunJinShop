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
<title> Mlist </title>
	<style>
		body {
			font-size : 14pt;
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
	      	width : 1500px;
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
			
			String sql = "select * from O_member";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//out.println(address);
			//conn.commit();	
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>				
	<p>
	<div class = "h"> Member List </div>
	<div class = "m"> 회원목록 </div>
		<table align = "center">
 			<tr>
	   			<td> 아이디 </td>
	   			<td> 비밀번호 </td>
	   			<td> 이름 </td>
	   			<td> 주소 </td>
	   			<td> 전화번호 </td>
	   			<td> 생년월일 </td>
	   			<td> 회원구분 </td>
			</tr>
			<tr>
			<% while(rs.next()) { %>
				<td> 
	   				<%= rs.getString("id") %>
	         	</td>
	         	<td> 
	   				<%= rs.getString("pw") %>
	         	</td>
	         	<td> 
	   				<%= rs.getString("name") %>
	         	</td>
	         	<td> 
	   				<%= rs.getString("address_A") %>
	         	</td>
	         	<td> 
	   				<%= rs.getString("phone_A") %>
	         	</td>
	         	<td> 
	   				<%= rs.getString("born") %>
	         	</td>
	         	<td>
	         	<%
		         	String mem = rs.getString("member_s");
					if(mem.equals("member_n")) {
	         	%>
	   				일반회원
	   			<%
	         		} else {
	   			%>
	   				평생회원
	   			<%
	         		}
	   			%>
	         	</td>
			</tr>
			<% } %>
		</table>
</body>
</html>