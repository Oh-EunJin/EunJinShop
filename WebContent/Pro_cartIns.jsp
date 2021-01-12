<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	if(session.getAttribute("id") == null) {
%>
	<script>
		alert("로그인을 해주시기 바랍니다.");
	</script>
	<meta http-equiv = "refresh" content = "0; url= LoginForm.jsp" target = "main">
<%
	}
%>
	<%!
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		PreparedStatement pstmt2 = null;
		ResultSet rs;
	%>
	<%
		String pid = request.getParameter("pid");
		String id = (String)session.getAttribute("id");
		String camount = request.getParameter("camount");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Pro_cart </title>
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
			
			String sqle = "select * from O_product where pid = ?";
			
			pstmt2 = conn.prepareStatement(sqle);
			pstmt2.setString(1, pid);
			rs = pstmt2.executeQuery();
			
			while(rs.next()) {
				
				String cpimg = rs.getString("pimg");
				String cpname = rs.getString("pname");
				String cprice = rs.getString("price");
			
				String sql = "insert into O_cart (cmid, cpid, cpimg, cpname, cprice, camount) values (?, ?, ?, ?, ?, ?)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pid);
				pstmt.setString(3, cpimg);
				pstmt.setString(4, cpname);
				pstmt.setString(5, cprice);
				pstmt.setString(6, camount);
				pstmt.executeUpdate();
			
	%>
				
			<p>
			<div class = "h"> ♥장바구니 등록 완료♥ <br>
			장바구니로 이동합니다!
			</div>
			<meta http-equiv = "refresh" content = "1; url= Cart.jsp" target = "main">
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