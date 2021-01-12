<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<%!
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs;		// 결과 받아오는 변수
	%>
	<%
		String id = (String)session.getAttribute("id");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> QARegi </title>
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
		}
		tr, td {
	     	border-bottom : 1px solid #FFB6B9;
	      	padding: 10px;
		}
	</style>
	<script>
		function chk() {
			if(!document.QARegister.qsubject.value) {
				alert("제목을 입력하세요!");
				document.QARegister.qsubject.focus();
				return false;
			}
			
			if(!document.QARegister.qwriter.value) {
				alert("이름이나 닉네임을 입력하세요!");
				document.QARegister.qwriter.focus();
				return false;
			}
			
			if(!document.QARegister.qcomment.value) {
				alert("내용을 입력하세요!");
				document.QARegister.qcomment.focus();
				return false;
			}
		}
		
		function back() {
			parent.main.location.href = "Q&A.jsp";
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
			
			String sql = "select * from O_member where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//out.println(address);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>

	<p>
	<div class = "h"> Question </div>
	<div class = "m"> 질문 등록 </div>

	<form method = "post" name = "QARegister" action = "QAInsert.jsp"  onsubmit = "return chk()">
		<table align = "center">
			<tr>
				<td align = "center"> 제목 </td>
				<td> <input type = "text" name = "qsubject" size = "40"> </td>
				<%
					if(session.getAttribute("id") == null) {
				%>
				<td align = "center"> 작성자 </td>
				<td> <input type = "text" name = "qwriter" size = "10"> </td>
				<% 	}
					else {  
						while(rs.next()) { %>
				<td align = "center"> 작성자 </td>
				<td> <input type = "text" name = "qwriter" size = "10" value = "<%= rs.getString("id") %>"> </td>
				<% 		} 
				   	} %>
			</tr>
			<tr>
				<td align = "center"> 내용 </td>
				<td colspan = "3"> <textarea name = "qcomment" rows = "10" cols = "60"> </textarea> </td>
			</tr>
		</table>
		<p align = "center"> 
        	<input type = "image" src = "img/REGISTER.png" name = "submit" value = "submit" align = "absmiddle" width = "100">
        	<input type = "image" src = "img/RESET.png" onclick = "back()" align = "absmiddle" width = "100">
        </p>
	</form>
</body>
</html>