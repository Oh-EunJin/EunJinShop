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
		String cid = request.getParameter("cid");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Pro_cartDel </title>
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
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3309/eunjin?serverTimezone=UTC";
			String dbId = "eunjinid";
			String dbPass = "eunjinpass";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			//out.println("DB 연결 성공");
			
			String sql = "delete from O_cart where cid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cid);
			pstmt.executeUpdate();
			
	%>	
			<p>
			<div class = "h"> 선택하신 상품이 성공적으로 삭제되었습니다! </div>
			<meta http-equiv = "refresh" content = "1; url= Cart.jsp" target = "main">
	<%		
			//out.println("수정 성공");

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