<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<%!
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs;
		
		Connection conn2 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs2;
	%>
	<%
		String qid = request.getParameter("qid");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ManaQAcontext </title>
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
			margin-left : 1060px;
		}
		.l {
			margin-top : 10px;
			margin-left : 370px;
		}
		table {
	      	margin-top : 50px;
	      	border : 3px solid #FFB6B9;
	      	width : 800px;
		}
		tr, td {
	     	border-bottom : 1px solid #FFB6B9;
	      	padding: 10px;
		}
		.t {
			margin-top : 10px;
			border : 3px solid #FFB6B9;
	      	width : 800px;
		}
	</style>
	<script>
		function back() {
			location.href = "ManaQ&A.jsp";
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
			conn2 = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			//out.println("DB 연결 성공");
			
			String sql = "select * from O_question where qid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qid);
			rs = pstmt.executeQuery();
			
			String sqle = "select * from O_answer where aqid = ?";
			
			pstmt2 = conn2.prepareStatement(sqle);
			pstmt2.setString(1, qid);
			rs2 = pstmt2.executeQuery();
			
			//out.println(pid);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	<p>
	<div class = "h"> Q&A </div>
	<div class = "m"> 질문응답 </div>
	
		<table align = "center">
			<% while(rs.next()) { 
				String aqid = rs.getString("qid");
			%>
			<tr>
				<td align = "center" width = "50"> 제목 </td>
				<td> <%= rs.getString("qsubject") %> </td>
				<td align = "center" width = "70"> 작성자 </td>
				<td> <%= rs.getString("qwriter") %> </td>
				<td align = "center" width = "70"> 작성일 </td>
				<td> <%= rs.getString("qsigndate") %> </td>
			</tr>
			<tr>
				<td colspan = "6"> <%= rs.getString("qcomment") %> </td>
			</tr>
			
		</table>

		<% while(rs2.next()){ %>
		<table align = "center">
			<tr>
				<td align = "center"> 관리자님의 답변 </td>
			</tr>
			<tr>
				<td>
					<%= rs2.getString("answer") %>
				</td>
			</tr>
			<tr>
				<td align = "right">
					<%= rs2.getString("asigndate") %>
				</td>
			</tr>
		</table>
		<% } %>
		
	<form method = "post" name = "ManaQARegister" action = "ManaQAInsert.jsp">
	<input type = "image" src = "img/REGISTER.png" name = "submit" value = "submit" class = "r" align = "absmiddle" width = "100">
		<table align = "center" class = "t">
			<tr>
				<td> NO </td>
				<td> <input type = "text" name = "aqid" value = "<%= aqid %>" size = "1"> </td>
			<%} %>
			</tr>
			<tr>
				<td> 답변 내용 </td>
				<td> <textarea name = "answer" rows = "10" cols = "80"> </textarea> </td>
			</tr>
		</table>
	</form>
		<input type = "image" src = "img/LIST.png" onclick = "back()" class = "l" align = "absmiddle" width = "70">
</body>
</html>