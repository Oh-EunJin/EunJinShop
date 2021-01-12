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
		String pid = request.getParameter("pid");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ProDetail </title>
	<style>
		body {
			font-size : 20pt;
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
	      	margin-top : 20px;
		}
		tr, td {
	      	padding: 20px;
		}
	</style>
	<script>
		function chk() {
			if(!document.ProDetail.camount.value) {
				alert("구매하고자 하는 수량을 입력하세요!");
				document.ProDetail.camount.focus();
				return false;
			}
		}
	</script>
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
			
			String sql = "select * from O_product where pid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			
			//out.println(pid);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	<p>
	<div class = "h"> Product Detail </div>
	<div class = "m"> 상품 상세보기 </div>

	<form method = "post" name = "ProDetail" action = "Pro_cartIns.jsp?pid=<%= pid %>" onsubmit = "return chk()">
		<table align = "center">
			<% while(rs.next()) { %>
			<tr>
				<td> <img src = "<%= rs.getString("pimg") %>" width = "300"> </img> </td>
				<td>
				<table>
					<tr>
						<td> <%= rs.getString("pname") %> </td>
					</tr>
					<tr>
						<td> <%= rs.getString("price") + "원" %> </td>
					</tr>
					<tr>
						<td width = "300"> <%= rs.getString("pexplain") %> </td>
					</tr>
					<tr>
						<td> 수량  : &nbsp <input type = "text" name = "camount" size = "1"> 개 </td>
					</tr>
					<tr>
						<td>
							<input type = "image" src = "img/CART.png" name = "submit" value = "submit" width = "100">
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<% } %>
		</table>
	</form>
</body>
</html>