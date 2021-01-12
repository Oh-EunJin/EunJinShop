<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<%!
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs;
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ManaQ&A </title>
	<style>
		body {
			font-size : 14pt;
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
		.mb {
			font-size : 15pt;
			font-family : 휴먼편지체;
			color : #f74d6c;
			margin-left : 20px;
		}
		table {
			margin-top : 10px;
	      	border : 3px solid #FFB6B9;
		}
		tr, td {
	     	border-bottom : 1px solid #FFB6B9;
	      	padding: 10px;
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
			
			String sql = "select * from O_question order by qid desc";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//out.println(address);
			//conn.commit();	
	%>
	<p>
	<div class = "h"> Q&A </div>
	<div class = "m"> 질문응답 </div>
	<h class = "mb"> * 질문 제목을 클릭하면 답변이 가능합니다 </h> 
		<table align = "center">
 			<tr>
	   			<td align = "center" width = "10"> NO </td>
	   			<td align = "center" width = "700"> SUBJECT </td>
	   			<td align = "center" width = "100"> WRITER </td>
	   			<td align = "center" width = "200"> DATE </td>
	   			<td align = "center" width = "100"> REPLY </td>
			</tr>
			<tr>
			<%
				String sqle = "select * from O_answer where aqid = ?";
				pstmt2 = conn.prepareStatement(sqle);
				
				while(rs.next()) { 
			%>
				<td align = "center">
	   				<%= rs.getString("qid") %>
	         	</td>
	         	<td> 
	         		<a href = "ManaQAcontext.jsp?qid=<%= rs.getString("qid")%>">
	   				<%= rs.getString("qsubject") %>
	         	</td>
	         	<td align = "center"> 
	   				<%= rs.getString("qwriter") %>
	         	</td>
	         	<td align = "center"> 
	   				<%= rs.getString("qsigndate") %>
	         	</td>
				<%
					try{
						String reply = null;
						pstmt2.setString(1, rs.getString("qid"));
						rs2 = pstmt2.executeQuery();
						while(rs2.next()){
							reply = rs2.getString("aqid");
						}
							
						if (reply != null) {
				%>
				         	<td align = "center"> 
				         		답변 완료
				         	</td>
				       <% } else { %>
				         	<td align = "center"> 
				         		답변 준비중
				         	</td>
	         			<% } 
					}catch(Exception e){
						e.printStackTrace();
					}finally{
						if(rs2 != null){
							try{ rs2.close();  }catch(SQLException ee){ }
						}
					}
				%>
			</tr>
			<% }
			}catch(Exception e){
					e.printStackTrace();
			}finally{
				if(pstmt2 != null) {
					try{ pstmt2.close(); }catch(SQLException sqll){ }
				}
				if(rs != null){
					try{ rs.close(); }catch(SQLException sqle){ }
				}
				if(pstmt != null) {
					try{ pstmt.close(); }catch(SQLException sqll){ }
				}
				if(conn != null){
					try{ conn.close(); }catch(SQLException sqll){ }
				}
			} 
			%>
		</table>
	</form>
</body>
</html>