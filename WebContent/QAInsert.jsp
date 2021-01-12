<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> QAInsert </title>
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
		String qsubject = request.getParameter("qsubject");
		String qwriter = request.getParameter("qwriter");
		String qcomment = request.getParameter("qcomment");
		Timestamp qsigndate = new Timestamp(System.currentTimeMillis());
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
			
			String sql = "insert into O_question (qsubject, qwriter, qcomment, qsigndate) values (?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qsubject);
			pstmt.setString(2, qwriter);
			pstmt.setString(3, qcomment);
			pstmt.setTimestamp(4, qsigndate);
			pstmt.executeUpdate();
	%>
			<p>
			<div class = "h"> ♥질문 등록 완료♥ </div>
			<meta http-equiv = "refresh" content = "1; url= Q&A.jsp" target = "main">
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