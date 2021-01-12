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
		String id = (String)session.getAttribute("id");		
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Withdraw </title>
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
			
			String sqle = "select * from O_member where id = ?";
			
			pstmt = conn.prepareStatement(sqle);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getString("member_s").equals("member_n")) {	// 일반회원인 경우
					String sql = "delete from O_member where id = ?";
				
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
	%>
					<p>
					<div class = "h"> <%= id %> 님 탈퇴되었습니다...ㅠㅠ <br>
						3초후 Main화면으로 넘어갑니다ㅠ
					</div>
					<meta http-equiv = "refresh" content = "3; url= Main.jsp" target = "main">
					<script>
							parent.logo.location.href = "Logo.jsp";
					</script>
	<%		
					session.invalidate();
					//out.println("테이블에" + id + "회원정보 추가");
					conn.commit();
				}
				else if(rs.getString("member_s").equals("member_f")){	// 평생회원인 경우
	%>
				<script>
					alert("평생회원이셔서 탈퇴 불가능합니다.\n 탈퇴하고 싶으시다면 일반회원으로 전환해주세요~");
				</script>
				<meta http-equiv = "refresh" content = "0; url= Mine.jsp" target = "main">
	<%
				}
			}
			
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