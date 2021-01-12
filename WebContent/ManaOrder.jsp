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
<title> ManaOrder </title>
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
			
			String sql = "select * from O_order order by oid desc";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//out.println(address);
			//conn.commit();	
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	<p>
	<div class = "h"> ORDER </div>
	<div class = "m"> 주문관리 </div>
		<table align = "center">
 			<tr>
	   			<td align = "center" width = "10"> NO </td>
	   			<td align = "center" width = "100"> 회원 ID </td>
	   			<td align = "center" width = "200"> 상품 </td>
	   			<td align = "center" width = "200"> 상품명 </td>
	   			<td align = "center" width = "30"> 수량 </td>
	   			<td align = "center"> 관리 </td>
			</tr>
			<tr>
			<% while(rs.next()) { %>
				<td align = "center">
	   				<%= rs.getString("oid") %>
	         	</td>
	         	<td align = "center"> 
	   				<%= rs.getString("omid") %>
	         	</td>
	         	<td align = "center"> 
	   				<img src = "<%= rs.getString("opimg") %>" width = "70"> </img>
	         	</td>
	         	<td align = "center"> 
	   				<%= rs.getString("opname") %>
	         	</td>
	         	<td align = "center"> 
	   				<%= rs.getString("ocamount") + "개" %>
	         	</td>
	         	<td>
	         		<a href = "Mana_OrderDel.jsp?oid=<%= rs.getString("oid")%>">
      				<input type = "image" src = "img/CANCEL.png" width = "70"> </a>
	         	</td>
			</tr>
			<% } %>
		</table>
	</form>
</body>
</html>