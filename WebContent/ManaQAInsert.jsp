<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ManaQAInsert </title>
	<style>
		body {
			text-align : center;
			background : #FFE6E8;
		}
		.h {
			font-size : 30pt;
			font-family : Comic Sans MS;
			font-weight : bold;
			color : #FF8BA0;	
		}
	</style>
</head>
<body>
	<%	
		String aqid = request.getParameter("aqid");
		String answer = request.getParameter("answer");
		Timestamp asigndate = new Timestamp(System.currentTimeMillis());
	%>
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		String str = "";
		
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3309/eunjin?serverTimezone=UTC";
			String dbId = "eunjinid";
			String dbPass = "eunjinpass";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			//out.println("DB 연결 성공");
			
			String sql = "insert into O_answer (aqid, answer, asigndate) values (?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aqid);
			pstmt.setString(2, answer);
			pstmt.setTimestamp(3, asigndate);
			pstmt.executeUpdate();
	%>
			<p>
			<div class = "h"> ♥답변 등록 완료♥ </div>
			<meta http-equiv = "refresh" content = "1; url= ManaQ&A.jsp" target = "main">
	<%		
			//out.println("테이블에" + id + "회원정보 추가");
			conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(pstmt != null) {
				try{ pstmt.close(); }catch(SQLException sqle){ }
			}
			if(conn != null) {
				try{ conn.close(); }catch(SQLException sqll){ }
			}
		}	
	%>
</body>
</html>