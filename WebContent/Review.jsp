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
<title> Review </title>
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
		.r {
			margin-top : 30px;
			margin-left : 1230px;
		}
		table {
	      	margin-top : 20px;
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
			
			String sql = "select * from O_review order by rid desc";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//out.println(poption);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	
		<div class = "h"> Review </div>
		<div class = "m"> 리뷰  </div>
		
			<table align = "center">
				<tr>
					<td width = "10"> NO </td>
					<td width = "100" align = "center"> 상품 </td>
					<td width = "600"> 내용 </td>
					<td width = "100" align = "center"> 회원 ID </td>
					<td align = "center" width = "200"> DATE </td>
				</tr>
				<tr>
				<% while(rs.next()) { %>
					<td> <%= rs.getString("rid") %> </td>
					<td> 
						<img src = "<%= rs.getString("rpimg") %>" width = "90"> </img>
					</td>
					<td> <%= rs.getString("rcomment") %> </td>
					<td align = "center"> 
						<%= rs.getString("rmid") %>
					</td>
					<td> <%= rs.getString("rsigndate") %> </td>
				</tr>
				<%  }  %>
			</table>
		</form>
</body>
</html>