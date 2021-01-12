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
<title> NotiM&R </title>
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
	      	width : 600px;
		}
		tr, td {
	     	border-bottom : 1px solid #FFB6B9;
	      	padding: 10px;
		}
	</style>
	<script>
		function chk() {
			if(!document.NotiMR.nsubject.value) {
				alert("제목을 입력하세요!");
				document.NotiMR.nsubject.focus();
				return false;
			}
			
			if(!document.NotiMR.ncontext.value) {
				alert("내용을 입력하세요!");
				document.NotiMR.ncontext.focus();
				return false;
			}
		}
		function remove() {
			document.NotiMR.action = "NotiRem.jsp?nid=<%= nid %>";
			document.NotiMR.submit();
		}
		
		function back() {
			location.href = "ManaNotice.jsp";
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
	<form method = "post" name = "NotiMR" action = "Noti_Update.jsp?nid=<%= nid %>" onsubmit = "return chk()">
		<table align = "center">
			<% while(rs.next()) { %>
			<tr>
				<td align = "center" width = "50"> 제목 </td>
				<td width = "300"> <input type = "text" name = "nsubject" value = "<%= rs.getString("nsubject") %>" size = "80"> </td>
			</tr>
			<tr>
				<td align = "center" width = "50"> 작성일 </td>
				<td> <%= rs.getString("nsigndate") %> </td>
			</tr>
			<tr>
				<td align = "center" width = "50"> 내용 </td>
			<%
    			String ncontext = rs.getString("ncontext");
    		%>
				<td colspan = "3"> <textarea name = "ncontext" rows = "10" cols = "60"> <%= ncontext %> </textarea> </td>
			</tr>
			<%} %>
		</table>
		<p align = "center"> 
			<input type = "image" src = "img/REMOVE.png" onclick = "remove()" align = "absmiddle" width = "100">
        	<input type = "image" src = "img/MODIFY.png" name = "submit" value = "submit" align = "absmiddle" width = "100">
        	<input type = "image" src = "img/RESET.png" onclick = "back()" align = "absmiddle" width = "100">
        </p>
	</form>
</body>
</html>