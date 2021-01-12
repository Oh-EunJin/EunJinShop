<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<%!
		ResultSet rs;
	%>
	<%
		String pid = request.getParameter("pid");
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
		.mb {
			font-size : 15pt;
			font-family : 휴먼편지체;
			color : #f74d6c;
			margin-left : 20px;
		}
		.h {
			text-align : center;
			font-size : 40pt;
			font-family : Comic Sans MS;
			font-weight : bold;
			color : #FF8BA0;	
		}
		table {
	      	margin-top : 30px;
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
		String poption = request.getParameter("poption");
		String pimg = request.getParameter("pimg");
	%>
	<%		
		Connection conn = null;
		PreparedStatement pstmt = null;
	
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3309/eunjin?serverTimezone=UTC";
			String dbId = "eunjinid";
			String dbPass = "eunjinpass";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			//out.println("DB 연결 성공");
			
			String sql = "select * from O_product order by poption";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
		
		<div class = "h"> Product List </div>
		<div class = "m"> 상품목록  </div>
		<h class = "mb"> * 상품명을 클릭하면 수정&삭제가 가능합니다 </h> 
		
			<table align = "center">
				<tr>
					<td> 상품 </td>
					<td> 상품명 </td>
					<td> 상품분류 </td>
					<td width = "70"> 가격 </td>
					<td> 상품설명 </td>
				</tr>
				<tr>
				<% while(rs.next()) { %>
					<td> 
						<img src = "<%= rs.getString("pimg") %>" width = "70"> </img> 
					</td>
					<td> 
						<a href = "M&R.jsp?pid=<%= rs.getString("pid")%>"> 
						<%= rs.getString("pname") %>
					</td>
					<td> <%= rs.getString("poption") %> </td>
					<td> <%= rs.getString("price") + "원" %> </td>
					<td> <%= rs.getString("pexplain") %> </td>
				</tr>
				<% } %>
			</table>
</body>
</html>


