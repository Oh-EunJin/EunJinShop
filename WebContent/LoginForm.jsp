<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> LoginForm </title>
	<style>
		body {
			text-align : center;
			font-size : 20pt;
			font-family : 휴먼편지체;
			color : #FF8BA0;
			background : #FFE6E8;
		}
		.h {
			font-size : 40pt;
			font-family : Comic Sans MS;
			font-weight : bold;
			color : #FF8BA0;	
		}
	</style>
	<script language = "javascript">
        function loginClose() {          
			window.close();   
        }
    </script>
</head>
<body>
	<p>
	<div class = "h"> LOGIN </div>
	EUNJINSHOP에 오신 것을 환영합니다! <p>
	
	<form method = "post" action = "Login_insert.jsp">
		<table align = "center">
			<tr>
				<td>
					ID <input type = "text" name = "id"> &nbsp
				</td>
				<td rowspan = "2">
					<input type = "image" src = "img/LOGIN.png" name = "submit" value = "submit" align = "absmiddle" width = "80">
				</td>
			</tr>
			<tr>
				<td>
					PW <input type = "password" name = "pw" minlength = 8 maxlength = 15> &nbsp
				</td>
			</tr>
			<tr>
				<td colspan = "2">
					<a href = "JoinForm.jsp"> 
					<img src = "img/JOIN.png" width = "200" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>



