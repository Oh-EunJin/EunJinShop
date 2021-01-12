<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Noti_Update </title>
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
		String nid = request.getParameter("nid");
		String nsubject = request.getParameter("nsubject");
		String ncontext = request.getParameter("ncontext");
		Timestamp nsigndate = new Timestamp(System.currentTimeMillis());
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
			
			String sql = "update O_notice set nsubject = ?, nsigndate = ?, ncontext = ? where nid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nsubject);
			pstmt.setTimestamp(2, nsigndate);
			pstmt.setString(3, ncontext);
			pstmt.setString(4, nid);
			pstmt.executeUpdate();
			//out.println("수정 성공"); 
	%>
			<p>
			<div class = "h"> 공지사항이 수정 완료 </div>
			<meta http-equiv = "refresh" content = "1; url= ManaNotice.jsp" target = "main">
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