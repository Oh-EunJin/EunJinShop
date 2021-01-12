<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Pro_Update </title>
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
		String pid = request.getParameter("pid");
		String pname = request.getParameter("pname");
		String poption = request.getParameter("poption");
		String price = request.getParameter("price");
		String pexplain = request.getParameter("pexplain");
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
			
			String sql = "update O_product set pname = ?, poption = ?, price = ?, " + 
							" pexplain = ? where pid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
			pstmt.setString(2, poption);
			pstmt.setString(3, price);
			pstmt.setString(4, pexplain);
			pstmt.setString(5, pid);
			pstmt.executeUpdate();
			
			//out.println("수정 성공"); 
	%>
				
			<p>
			<div class = "h"> <%= pid %> 의 상품이 수정되었습니당♥ <br>
				 Main화면으로 넘어갑니다!
			</div>
			<meta http-equiv = "refresh" content = "1; url= Main2.jsp" target = "main">
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