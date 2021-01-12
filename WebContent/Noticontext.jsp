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
		String nid = request.getParameter("nid");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Noticontext </title>
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
		.l {
			margin-top : 10px;
			margin-left : 390px;
		}
		table {
	      	margin-top : 50px;
	      	border : 3px solid #FFB6B9;
	      	width : 750px;
		}
		tr, td {
	     	border-bottom : 1px solid #FFB6B9;
	      	padding: 10px;
		}
	</style>
	<script>
		function back() {
			location.href = "Notice.jsp";
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
			
			String sql = "select * from O_notice where nid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nid);
			rs = pstmt.executeQuery();
			
			//out.println(pid);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	<p>
	<div class = "h"> Notice </div>
	<div class = "m"> 공지사항 </div>
		<table align = "center">
			<% while(rs.next()) { %>
			<tr>
				<td align = "center" width = "50"> 제목 </td>
				<td width = "350"> <%= rs.getString("nsubject") %> </td>
				<td align = "center" width = "70"> 작성일 </td>
				<td> <%= rs.getString("nsigndate") %> </td>
			</tr>
			<tr>
				<td colspan = "4"> <%= rs.getString("ncontext") %> </td>
			</tr>
			<%} %>
		</table>
	<input type = "image" src = "img/LIST.png" onclick = "back()" class = "l" align = "absmiddle" width = "60">
</body>
</html>