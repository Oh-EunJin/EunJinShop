<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> LogoutForm </title>
</head>
<body>
	<%
		session.invalidate();
		//response.sendRedirect("Main.jsp");
	%>
		<meta http-equiv = "refresh" content = "0; url= Main.jsp">
		<script>
			parent.logo.location.href = "Logo.jsp";
			parent.menu.location.href = "Menu.jsp";
		</script>
</body>
</html>