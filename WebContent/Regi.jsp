<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Regi </title>
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
			if(!document.Register.pid.value) {
				alert("상품코드를 입력하세요!");
				document.Register.pid.focus();
				return false;
			}
			
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
			
			if(!document.Register.pexplain.value) {
				alert("상품설명을 입력하세요!");
				document.Register.pexplain.focus();
				return false;
			}
		}
		
		function pidCheck() {
			window.open("pidCheck.jsp?pid=" + document.Register.pid.value, "pidCheck", "width = 500, height = 300");
		}
		
		function inputPidChk() {
			document.Register.pidHidden.value = "pidUncheck";
		}
	
		function back() {
			parent.main.location.href = "Main2.jsp";
		}
	</script>
</head>
<body>
	<p>
	<div class = "h"> Product Register </div>
	<div class = "m"> 상품등록 </div>

	<form method = "post" name = "Register" action = "Product.jsp" onsubmit = "return chk()">
		<table align = "center">
			<tr>
				<td align = "center"> 상품코드 </td>
				<td> <input type = "text" name = "pid" size = "10" onkeydown = "inputIdChk()">
					 <input type = "button" onclick = "pidCheck()" value = "중복확인">
	         		 <input type = "hidden" name = "pidHidden" value = "pidUncheck">
				</td>
			</tr>
			<tr>
				<td align = "center"> 상품명 </td>
				<td> <input type = "text" name = "pname"> </td>
			</tr>
			<tr>
				<td align = "center"> 상품분류 </td>
				<td> <select name = "poption">
					   <option value = "OUTER"> OUTER </option>
					   <option value = "TOP"> TOP </option>
					   <option value = "BLOUSE"> BLOUSE </option>
					   <option value = "PANTS"> PANTS </option>
					   <option value = "SKIRT"> SKIRT </option>
					   <option value = "SHOE"> SHOE&BAG </option>
					   <option value = "ACC"> ACC </option>
					</select>
				</td>
			</tr>
			<tr>
				<td align = "center"> 가격 </td>
				<td> <input type = "text" name = "price" size = "10"> </td>
			</tr>
			<tr>
				<td align = "center"> 상품설명 </td>
				<td> <textarea name = "pexplain" rows = "5" cols = "30"> </textarea>
				</td>
			</tr>
			<tr>
				<td align = "center"> 상품 이미지 </td>
				<td> <input type = "file" name = "pimg"> </td>
			</tr>
		</table>
		<p align = "center"> 
        	<input type = "image" src = "img/REGISTER.png" name = "submit" value = "submit" align = "absmiddle" width = "100">
        	<input type = "image" src = "img/RESET.png" onclick = "back()" align = "absmiddle" width = "100">
        </p>
	</form>
</body>
</html>