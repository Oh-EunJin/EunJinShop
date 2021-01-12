<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Join_insert </title>
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
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String pw2 = request.getParameter("pw2");
		String name = request.getParameter("name");
		String postcode = request.getParameter("postcode");
		String address = request.getParameter("address");
		String address2 = request.getParameter("address2");
		String address3 = request.getParameter("address3");
		String sex = request.getParameter("sex");
		String phone = request.getParameter("phone");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String sms = request.getParameter("sms");
		String email = request.getParameter("email");
		String email2 = request.getParameter("email2");
		String e_mail = request.getParameter("e_mail");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String birth = request.getParameter("birth");
		String job = request.getParameter("job");
		String member_s = request.getParameter("member_s");
		String self = request.getParameter("self");
		
		String address_A = postcode + "/" + address + "/" + address2 + "/" + address3;
		String phone_A = phone + "-" + phone2 + "-" + phone3;
		String email_A = email + "@" + email2;
		String born = year + "-" + month + "-" + day;
		
	%>
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		String str = "";
		
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3309/eunjin";
			String dbId = "eunjinid";
			String dbPass = "eunjinpass";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			//out.println("DB 연결 성공");
			
			String sql = "insert into O_member values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, pw2);
			pstmt.setString(4, name);
			pstmt.setString(5, address_A);
			pstmt.setString(6, sex);
			pstmt.setString(7, phone_A);
			pstmt.setString(8, sms);
			pstmt.setString(9, email_A);
			pstmt.setString(10, e_mail);
			pstmt.setString(11, born);
			pstmt.setString(12, birth);
			pstmt.setString(13, job);
			pstmt.setString(14, member_s);
			pstmt.setString(15, self);
			pstmt.executeUpdate();
	%>
			<p>
			<div class = "h"> <%= id %> 님 저희 EUNJINSHOP의 MEMBER가 되신것을 환영합니당♥ <br>
				3초후 LOGIN화면으로 넘어갑니다!
			</div>
			<meta http-equiv = "refresh" content = "3; url= LoginForm.jsp" target = "main">
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


