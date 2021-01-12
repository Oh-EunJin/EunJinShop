<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Update </title>
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
		String id = (String)session.getAttribute("id");
		String pw = request.getParameter("pw");
		String pw2 = request.getParameter("pw2");
		String postcode = request.getParameter("postcode");
		String address = request.getParameter("address");
		String address2 = request.getParameter("address2");
		String address3 = request.getParameter("address3");
		String phone = request.getParameter("phone");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String sms = request.getParameter("sms");
		String email = request.getParameter("email");
		String email2 = request.getParameter("email2");
		String e_mail = request.getParameter("e_mail");
		String job = request.getParameter("job");
		String member_s = request.getParameter("member_s");
		String self = request.getParameter("self");
		
		String address_A = postcode + "/" + address + "/" + address2 + "/" + address3;
		String phone_A = phone + "-" + phone2 + "-" + phone3;
		String email_A = email + "@" + email2;
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
			
			String sql = "update O_member set pw = ?, pw2 = ?, address_A = ?, " + 
							" phone_A = ?, sms = ?, email_A = ?, e_mail = ?, " + 
			 				" job = ?, member_s = ?, self = ? where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, pw2);
			pstmt.setString(3, address_A);
			pstmt.setString(4, phone_A);
			pstmt.setString(5, sms);
			pstmt.setString(6, email_A);
			pstmt.setString(7, e_mail);
			pstmt.setString(8, job);
			pstmt.setString(9, member_s);
			pstmt.setString(10, self);
			pstmt.setString(11, id);
			pstmt.executeUpdate();
			
			//out.println("수정 성공"); 
	%>
				
			<p>
			<div class = "h"> <%= id %> 님 회원정보 수정이 완료되었습니당♥ <br>
				3초후 Main화면으로 넘어갑니다!
			</div>
			<meta http-equiv = "refresh" content = "3; url= Main.jsp" target = "main">
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