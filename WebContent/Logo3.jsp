<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Logo2 </title>
	<style>
		td {
			font-family : 휴먼편지체;
			font-size : 10pt;
			color : #FF8BA0;
			font-weight : bold;	
		}
		.menu {
			font-family : 휴먼편지체;
			font-size : 10pt;
			color : #FF8BA0;
			font-weight : bold;
		}
		.id {
			font-family : 휴먼편지체;
			font-size : 15pt;
			color : #FF8BA0;
			font-weight : bold;
		}
	</style>
</head>
<body>
	<table>
		<tr>
			<td>
				<a href = "Main2.jsp" target = "main">
				<img src = "img/EUNJINSHOP2.jpg" width = "230" />
			</td>
			<td align = "right" width = "3000">
				<h class = "id"> <%= session.getAttribute("id") %>(관리자) 님 </h>
				&nbsp&nbsp&nbsp | &nbsp&nbsp&nbsp
				<a href = "LogoutForm.jsp" target = "main" class = "menu"> LOGOUT </a>
				&nbsp&nbsp&nbsp
			</td>
		</tr>
	</table>
</body>
</html>