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
<title> Cart </title>
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
	      	margin-top : 30px;
	      	border : 3px solid #FFB6B9;
	      	width : 800px;
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
			
			String sql = "select * from O_cart where cmid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//out.println(poption);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	
		<div class = "h"> Cart List </div>
		<div class = "m"> 장바구니 목록  </div>
		
			<table align = "center">
				<tr>
					<td> 상품 </td>
					<td> 상품명 </td>
					<td width = "70"> 가격 </td>
					<td> 수량 </td>
					<td align = "center"> 선택 </td>
				</tr>
				<tr>
				<% while(rs.next()) { %>
					<td> 
						<img src = "<%= rs.getString("cpimg") %>" width = "90"> </img>
					</td>
					<td> 
						<a href = "ProDetail.jsp?pid=<%= rs.getString("cpid")%>"> 
						<%= rs.getString("cpname") %>
					</td>
					<td> <%= rs.getString("cprice") + "원" %> </td>
					<td> <%= rs.getString("camount") + "개" %> </td>
					<td align = "center"> <p>
						 <a href = "Pro_OrderIns.jsp?cid=<%= rs.getString("cid")%>">
						 <input type = "image" src = "img/ORDER.png" width = "70"> </a> <p>
						 <a href = "Pro_cartDel.jsp?cid=<%= rs.getString("cid")%>">
        				 <input type = "image" src = "img/CANCEL.png" width = "70"> </a>
					</td>
				</tr>
				<%  }  %>
			</table>
</body>
</html>