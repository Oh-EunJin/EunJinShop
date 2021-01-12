<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<%!
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		PreparedStatement pstmt2 = null;
		ResultSet rs;
	%>
	<%
		String opid = request.getParameter("opid");
		String id = (String)session.getAttribute("id");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ReviewIns </title>
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
		Timestamp rsigndate = new Timestamp(System.currentTimeMillis());
		String rcomment = request.getParameter("rcomment");
	%>
	<%
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3309/eunjin?serverTimezone=UTC";
			String dbId = "eunjinid";
			String dbPass = "eunjinpass";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			//out.println("DB 연결 성공");
			
			String sqle = "select * from O_order where opid = ?";
			
			pstmt2 = conn.prepareStatement(sqle);
			pstmt2.setString(1, opid);
			rs = pstmt2.executeQuery();
			
			while(rs.next()) {
				
				String rpimg = rs.getString("opimg");
			
				String sql = "insert into O_review (rmid, rpid, rpimg, rcomment, rsigndate) values (?, ?, ?, ?, ?)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, opid);
				pstmt.setString(3, rpimg);
				pstmt.setString(4, rcomment);
				pstmt.setTimestamp(5, rsigndate);
				pstmt.executeUpdate();
			
	%>
				
			<p>
			<div class = "h"> ♥리뷰 등록 완료♥ </div>
			<meta http-equiv = "refresh" content = "1; url= Review.jsp" target = "main">
	<%		
			//out.println("테이블에" + id + "회원정보 추가");
			conn.commit();
			}
			
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