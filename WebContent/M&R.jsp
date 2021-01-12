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
		String pid = request.getParameter("pid");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> M&R </title>
	<style>
		body {
			font-size : 15pt;
			font-family : 휴먼편지체;
			background : #FFE6E8;
		}
		.m {
			text-align : center;
			font-size : 20pt;
			font-family : 휴먼편지체;
			color : #FF8BA0;
		}
		.h {
			text-align : center;
			font-size : 40pt;
			font-family : Comic Sans MS;
			font-weight : bold;
			color : #FF8BA0;	
		}
		table {
	      	margin-top : 50px;
	      	border : 3px solid #FFB6B9;
	      	width : 420px;
		}
		tr, td {
	     	border-bottom : 1px solid #FFB6B9;
	      	padding: 10px;
		}
	</style>
	<script>
		function chk() {
			if(!document.Register.pname.value) {
				alert("상품명을 입력하세요!");
				document.Register.pname.focus();
				return false;
			}
			
			if(!document.Register.price.value) {
				alert("상품가격을 입력하세요!");
				document.Register.price.focus();
				return false;
			}
		}
		
		function remove() {
			document.MR.action = "Rem.jsp?pid=<%= pid %>";
			document.MR.submit();
		}
		
		function back() {
			location.href = "Main2.jsp";
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
			
			String sql = "select * from O_product where pid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			
			//out.println(pid);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	<p>
	<div class = "h"> Product Modify & Remove </div>
	<div class = "m"> 상품수정 & 삭제 </div>

	<form method = "post" name = "MR" action = "Pro_Update.jsp?pid=<%= pid %>" onsubmit = "return chk()">
		<table align = "center">
			<% while(rs.next()) { %>
			<tr>
				<td align = "center"> 상품코드 </td>
				<td> <%= rs.getString("pid") %> </td>
			</tr>
			<tr>
				<td align = "center"> 상품명 </td>
				<td> <input type = "text" name = "pname" value = "<%= rs.getString("pname") %>"> </td>
			</tr>
			<tr>
				<td align = "center"> 상품분류 </td>
				<td> <select name = "poption">
				<% 
					if(rs.getString("poption").equals("OUTER")) { 
				%>
					   <option value = "OUTER" selected> OUTER </option>
					   <option value = "TOP"> TOP </option>
					   <option value = "BLOUSE"> BLOUSE </option>
					   <option value = "PANTS"> PANTS </option>
					   <option value = "SKIRT"> SKIRT </option>
					   <option value = "SHOE"> SHOE&BAG </option>
					   <option value = "ACC"> ACC </option>
				<%
				   		} else if(rs.getString("poption").equals("TOP")) {
				%>
					   <option value = "OUTER"> OUTER </option>
					   <option value = "TOP" selected> TOP </option>
					   <option value = "BLOUSE"> BLOUSE </option>
					   <option value = "PANTS"> PANTS </option>
					   <option value = "SKIRT"> SKIRT </option>
					   <option value = "SHOE"> SHOE&BAG </option>
					   <option value = "ACC"> ACC </option>
				<%
				   		} else if(rs.getString("poption").equals("BLOUSE")) {
				%>
					   <option value = "OUTER"> OUTER </option>
					   <option value = "TOP"> TOP </option>
					   <option value = "BLOUSE" selected> BLOUSE </option>
					   <option value = "PANTS"> PANTS </option>
					   <option value = "SKIRT"> SKIRT </option>
					   <option value = "SHOE"> SHOE&BAG </option>
					   <option value = "ACC"> ACC </option>
				<%
				   		} else if(rs.getString("poption").equals("PANTS")) {
				%>
					   <option value = "OUTER"> OUTER </option>
					   <option value = "TOP"> TOP </option>
					   <option value = "BLOUSE"> BLOUSE </option>
					   <option value = "PANTS" selected> PANTS </option>
					   <option value = "SKIRT"> SKIRT </option>
					   <option value = "SHOE"> SHOE&BAG </option>
					   <option value = "ACC"> ACC </option>
				<%
				   		} else if(rs.getString("poption").equals("SKIRT")) {
				%>
					   <option value = "OUTER"> OUTER </option>
					   <option value = "TOP"> TOP </option>
					   <option value = "BLOUSE"> BLOUSE </option>
					   <option value = "PANTS"> PANTS </option>
					   <option value = "SKIRT" selected> SKIRT </option>
					   <option value = "SHOE"> SHOE&BAG </option>
					   <option value = "ACC"> ACC </option>
				<%
				   		} else if(rs.getString("poption").equals("SHOE")) {
				%>
					   <option value = "OUTER"> OUTER </option>
					   <option value = "TOP"> TOP </option>
					   <option value = "BLOUSE"> BLOUSE </option>
					   <option value = "PANTS"> PANTS </option>
					   <option value = "SKIRT"> SKIRT </option>
					   <option value = "SHOE" selected> SHOE&BAG </option>
					   <option value = "ACC"> ACC </option>
				<%
				   		} else if(rs.getString("poption").equals("ACC")) {
				%>
					   <option value = "OUTER"> OUTER </option>
					   <option value = "TOP"> TOP </option>
					   <option value = "BLOUSE"> BLOUSE </option>
					   <option value = "PANTS"> PANTS </option>
					   <option value = "SKIRT"> SKIRT </option>
					   <option value = "SHOE"> SHOE&BAG </option>
					   <option value = "ACC" selected> ACC </option>
				<%
				   		}
				%>
					</select>
				</td>
			</tr>
			<tr>
				<td align = "center"> 가격 </td>
				<td> <input type = "text" name = "price" size = "10" value = "<%= rs.getString("price") %>"> </td>
			</tr>
			<tr>
				<td align = "center"> 상품설명 </td>
				<%
	    			String pExplain = rs.getString("pexplain");
	    		%>
				<td> <textarea name = "pexplain" rows = "5" cols = "30"> <%= pExplain %> </textarea>
				</td>
			</tr>
			<tr>
				<td align = "center"> 상품 이미지 </td>
				<td> <img src = "<%= rs.getString("pimg") %>" width = "100"> </img> </td>
			</tr>
			<% } %>
		</table>
		<p align = "center"> 
			<input type = "image" src = "img/REMOVE.png" onclick = "remove()" align = "absmiddle" width = "100">
        	<input type = "image" src = "img/MODIFY.png" name = "submit" value = "submit" align = "absmiddle" width = "100">
        	<input type = "image" src = "img/RESET.png" onclick = "back()" align = "absmiddle" width = "100">
        </p>
	</form>
</body>
</html>