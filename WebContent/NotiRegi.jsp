<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> NotiRegi </title>
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
	      	width : 600px;
		}
		tr, td {
	     	border-bottom : 1px solid #FFB6B9;
	      	padding: 10px;
		}
	</style>
	<script>
		function chk() {
			if(!document.NotiRegister.nsubject.value) {
				alert("제목을 입력하세요!");
				document.NotiRegister.nsubject.focus();
				return false;
			}
			
		}
		function back() {
			parent.main.location.href = "Main2.jsp";
		}
	</script>
</head>
<body>
	<p>
	<div class = "h"> Notice Register </div>
	<div class = "m"> 공지사항 등록 </div>

	<form method = "post" name = "NotiRegister" action = "NotiInsert.jsp" onsubmit = "return chk()">
		<table align = "center">
			<tr>
				<td align = "center"> 제목 </td>
				<td> <input type = "text" name = "nsubject" size = "80">
				</td>
			</tr>
			<tr>
				<td align = "center"> 내용 </td>
				<td> <textarea name = "ncontext" rows = "10" cols = "60"> </textarea> </td>
			</tr>
		</table>
		<p align = "center"> 
        	<input type = "image" src = "img/REGISTER.png" name = "submit" value = "submit" align = "absmiddle" width = "100">
        	<input type = "image" src = "img/RESET.png" onclick = "back()" align = "absmiddle" width = "100">
        </p>
	</form>
</body>
</html>