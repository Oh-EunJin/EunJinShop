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
		String mid = request.getParameter("id");
		String mpw = request.getParameter("pw");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Login_insert </title>
	<style>
		.h {
			font-size : 30pt;
			font-family : Comic Sans MS;
			font-weight : bold;
			color : #FF8BA0;
			align : center;	
		}
	</style>
</head>
<body bgcolor = "#FFE6E8">
	<%		
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3309/eunjin?serverTimezone=UTC";
			String dbId = "eunjinid";
			String dbPass = "eunjinpass";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			//out.println("DB 연결 성공");
			
			String sql = "select * from O_manager where mid = ? and mpw = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
			//out.println(mid);    out.println(mpw);
			rs = pstmt.executeQuery();
			
			Boolean isLogin = false;	// 로그인 확인 유무
			while(rs.next()) {
				isLogin = true;
			}
			
			if(isLogin) {	// DB에 id와 pw가 존재하면 session에 저장
				session.setAttribute("id", mid);
				session.setAttribute("pw", mpw);
	%>
				<meta http-equiv = "refresh" content = "0; url= Main2.jsp">
				<script>
					parent.logo.location.href = "Logo3.jsp";
					parent.menu.location.href = "Menu2.jsp";
				</script>
		 <% } else { %>
				<script>
					alert("아이디와 비밀번호를 다시 입력해주세요!");
					history.go(-1);
				</script>
		 <% }
			//conn.commit();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(rs != null) {
				try{ rs.close(); }catch(SQLException sqll){ }
			}
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