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
		String id = request.getParameter("id");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> IdCheck </title>
	<style>
		body {
			font-size : 15pt;
			font-family : 휴먼편지체;
			background : #FFE6E8;
		}
		.idCheck {
			text-align : center;
			font-size : 20pt;
			font-family : 휴먼편지체;
			color : #FF8BA0;
		}
	</style>
	<script>
		function check() {
			opener.document.JoinForm.idHidden.value = "idCheck";
			self.close();
		}
	</script>
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
			
			String sql = "select * from O_member where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//out.println(id);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>

	<form method = "post" action = "idCheck.jsp" name = "idCheckForm">
		<% try{
				if (rs.next() || (id == null)) { %>		
					<div class = "idCheck"> 현재 <font color = "red"> <%= id %> </font> 는 이미 다른 사람이 사용중입니다.<br> 사용 불가능 <p> 
					<input type = "button" value = "확인" onclick = "check()"> </div>
			 <% } else { %>
					<div class = "idCheck"> 현재 <font color = "red"> <%= id %> </font> 는 사용가능 합니다. <p>
					<input type = "button" value = "확인" onclick = "check()"> </div>			
			 <% }
			}catch(SQLException e){
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
	</form>
</body>
</html>