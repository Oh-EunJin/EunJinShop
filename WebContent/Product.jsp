<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Product </title>
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
		String pstock = request.getParameter("pstock");
		String pexplain = request.getParameter("pexplain");
		String pimg = request.getParameter("pimg");
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
			
			String sql = "insert into O_product values (?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pid);
			pstmt.setString(2, pname);
			pstmt.setString(3, poption);
			pstmt.setString(4, price);
			pstmt.setString(5, pexplain);
			pstmt.setString(6, pimg);	
			pstmt.executeUpdate();
	%>
			<p>
			<div class = "h"> ♥상품등록 완료♥ <br>
			Main화면으로 넘어갑니다!
			</div>
			<meta http-equiv = "refresh" content = "1; url= Main2.jsp" target = "main">
	<%		
			//out.println("테이블에" + id + "회원정보 추가");
			conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(pstmt != null)
				try{ pstmt.close(); }catch(SQLException sqle){ }
			if(conn != null)
				try{ conn.close(); }catch(SQLException sqll){ }
		}	
		//String fileName = pimg.substring(pimg.lastIndexOf("\\")+1, pimg.length() );
		//String fileNameWithoutExtn = fileName.substring(0, fileName.lastIndexOf('.'));
	%>
</body>
</html>