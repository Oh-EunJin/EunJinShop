<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<%!
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		PreparedStatement pstmt2 = null;
		ResultSet rs;
		
		PreparedStatement pstmt3 = null;
	%>
   	<%
   		String id = (String)session.getAttribute("id");
		String cid = request.getParameter("cid");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Pro_Order </title>
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
			
			String sqle = "select * from O_cart where cid = ?";
			
			pstmt2 = conn.prepareStatement(sqle);
			pstmt2.setString(1, cid);
			rs = pstmt2.executeQuery();
			
			while(rs.next()) {
				
				String opid = rs.getString("cpid");
				String opimg = rs.getString("cpimg");
				String opname = rs.getString("cpname");
				String oprice = rs.getString("cprice");
				String ocamount = rs.getString("camount");
			
				String sql = "insert into O_order (ocid, omid, opid, opimg, opname, oprice, ocamount) values (?, ?, ?, ?, ?, ?, ?)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cid);
				pstmt.setString(2, id);
				pstmt.setString(3, opid);
				pstmt.setString(4, opimg);
				pstmt.setString(5, opname);
				pstmt.setString(6, oprice);
				pstmt.setString(7, ocamount);
				pstmt.executeUpdate();
				
				
				String sqld = "delete from O_cart where cid = ?";
				
				pstmt3 = conn.prepareStatement(sqld);
				pstmt3.setString(1, cid);
				pstmt3.executeUpdate();
				
	%>
				
			<p>
			<div class = "h"> ♥주문 완료♥ </div>
			<meta http-equiv = "refresh" content = "1; url= Order.jsp" target = "main">
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