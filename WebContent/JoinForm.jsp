<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> JoinForm </title>
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
		.list {
			font-family : 휴먼편지체;
	      	text-align : center;
			margin-left : 300px;
		}
		.normal {
			font-family : 휴먼편지체;
			text-align : center;
			margin-right : 400px;
		}
		.add {
			font-family : 휴먼편지체;
			text-align : center;
			margin-right : 400px;
			padding-top : 80px;
		}
		table {
	      	border : 3px solid #FFB6B9;
	      	width : 450px;
		}
		tr, td {
	     	border-bottom : 1px solid #FFB6B9;
	      	padding: 10px;
		}
	</style>
	<script src = "http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
		function check() {
			if(!document.JoinForm.id.value) {
				alert("입력된 아이디가 없습니다!");
				document.JoinForm.id.focus();
				return false;
			}
			
			if(document.JoinForm.idHidden.value != "idCheck") {
				alert("아이디 중복체크를 해주세요!!");
				document.JoinForm.id.focus();
				return false;
			}
			
			if(document.JoinForm.pw.value.length < 8 || document.JoinForm.pw.value.length > 16) {
				alert("비밀번호는 8~15자 이내로 입력하세요!");
				document.JoinForm.pw.focus();
				return false;
			}
			
			if(document.JoinForm.pw.value != document.JoinForm.pw2.value) {
				alert("비밀번호를 동일하게 입력하세요!");
				document.JoinForm.pw2.focus();
				return false;
			}
			
			if(!document.JoinForm.name.value) {
				alert("이름을 입력해주세요!");
				document.JoinForm.name.focus();
				return false;
			}
			
			if(!document.JoinForm.address.value) {
				alert("주소를 입력해주세요!");
				document.JoinForm.address.focus();
				return false;
			}
			
			if(!document.JoinForm.phone2.value || !document.JoinForm.phone3.value) {
				alert("핸드폰번호를 입력해주세요!");
				document.JoinForm.phone2.focus();
				return false;
			}
			
			if(!document.JoinForm.email.value) {
				alert("이메일을 입력해주세요!");
				document.JoinForm.email.focus();
				return false;
			}
			
			if(!document.JoinForm.year.value || !document.JoinForm.month.value || !document.JoinForm.day.value) {
				alert("생년월일을 입력해주세요!");
				document.JoinForm.day.focus();
				return false;
			}
		}
		
		function idCheck() {
			window.open("idCheck.jsp?id=" + document.JoinForm.id.value, "idCheck", "width = 500, height = 300");
		}
		
		function inputIdChk() {
			document.JoinForm.idHidden.value = "idUncheck";
		}
	
		function postCode() {
			new daum.Postcode({
				oncomplete: function(data) {
					
					var fullRoadAddr = data.roadAddress;
					var extraRoadAddr = '';
					
					if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
					
					if(data.buildingName !== '' && data.apartment === 'Y'){
		                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		            }
					
					if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
					
					if(fullRoadAddr !== ''){
	                    fullRoadAddr += extraRoadAddr;
	                }
					
					document.getElementById('postcode').value = data.zonecode;
	                document.getElementById('address').value = fullRoadAddr;
	                document.getElementById('address2').value = data.jibunAddress;
					
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

	                } else {
	                    document.getElementById('guide').innerHTML = '';
	                }
	                
				}
			}).open();
		}
		
		function goForm() {
			location.href = "Main.jsp";
		}
	</script>
</head>
<body>
	<p>
	<div class = "h"> JOIN US </div>
	<div class = "m"> 회원가입 </div>
	
	<form method = "post" action = "Join_insert.jsp" name = "JoinForm" onsubmit = "return check()">
    	<div class = "list"> * : 필수 작성 항목 </div> <p>
    	<div class = "normal"> 기본정보 </div> <p>
    	<table align = "center">
 			<tr>
	   			<td align = "center">* 아이디 </td>
	   			<td> 
	   				<input type = "text" size = "20" name = "id" onkeydown = "inputIdChk()"> 
	         		<input type = "button" onclick = "idCheck()" value = "중복확인">
	         		<input type = "hidden" name = "idHidden" value = "idUncheck">
	         	</td>
			</tr>
			<tr>
	   			<td align = "center">* 비밀번호 </td>
	   			<td> 
	   				<input type = "password" size = "21" name = "pw"
	          			minlength = "8" maxlength = "15" placeholder = "8~15자 내로 입력하세요"> 
	          	</td>
			</tr>
			<tr>
	   			<td align = "center">* 비밀번호 재확인 </td>
	   			<td> <input type = "password" size = "21" name = "pw2"
	          			maxlength = "15" placeholder = "8~15자 내로 입력하세요"> 
	          	</td>
			</tr>
			<tr>
	   			<td align = "center">* 이름 </td>
	   			<td> <input type = "text" size = "20" name = "name"> </td>
			</tr>
			<tr>
	   			<td align = "center">* 주소 </td>
	   			<td> <input type = "text" size = "5" name = "postcode" id = "postcode"> &nbsp&nbsp
			         <input type = "button" value = "우편번호 찾기" onclick = "postCode()"> <br>
			         <input type = "text" size = "30" name = "address" id = "address" placeholder = "도로명주소"> <br>
			         <input type = "text" size = "30" name = "address2" id = "address2" placeholder = "지번주소"> <br>
			         <input type = "text" size = "30" name = "address3" placeholder = "상세주소">
	   				 <span id="guide" style="color:#999"></span>
	   			</td>
			</tr>
			<tr>
			   	<td align = "center">* 성별 </td>
			   	<td> <input type = "radio" name = "sex" value = "female" checked> 여자 
			         <input type = "radio" name = "sex" value = "male"> 남자 
			    </td>
			</tr>
			<tr>
			   	<td align = "center">* 핸드폰번호 </td>
			   	<td> <select name = "phone">
					   <option value = "010"> 010 </option>
					   <option value = "011"> 011 </option>
					   <option value = "016"> 016 </option>
					   <option value = "017"> 017 </option>
					   <option value = "018"> 018 </option>
					   <option value = "019"> 019 </option>
					</select>
					- <input type = "number" size = "5" name = "phone2">
					- <input type = "number" size = "5" name = "phone3">
	   			</td>
			</tr>
			<tr>
				<td align = "center">* SMS 수신여부 </td>
				<td> <input type = "radio" name = "sms" value = "ok" checked> 수신함 
			         <input type = "radio" name = "sms" value = "no"> 수신안함
				</td>
			</tr>
			<tr>
	   			<td align = "center">* 이메일 </td>
	   			<td> <input type = "text" size = "13" name = "email" maxlength = "30"> @
	          		<select name = "email2">
					   <option value = "1"> naver.com </option>
					   <option value = "2"> nate.com </option>
					   <option value = "3"> daum.net </option>
					   <option value = "4"> gmail.com </option>
					   <option value = "5"> hanmail.com </option>
					</select>
	   			</td>
			</tr>
			<tr>
				<td align = "center">* 이메일 수신여부 </td>
				<td> <input type = "radio" name = "e_mail" value = "ok" checked> 수신함 
			         <input type = "radio" name = "e_mail" value = "no"> 수신안함
				</td>
			</tr>
			<tr>
	   			<td align = "center">* 생년월일 </td>
	   			<td> 
	   				<input type = "text" size = "3" name = "year"> 년
	   				<input type = "text" size = "1" name = "month"> 월
	   				<input type = "text" size = "1" name = "day"> 일  <br>
	   				<input type = "radio" name = "birth" value = "plus" checked> 양력 &nbsp&nbsp
	   				<input type = "radio" name = "birth" value = "minus"> 음력
	   			</td>
			</tr>
        </table>
        
        <div class = "add"> 추가정보 </div>
        <table align = "center">
        	<tr>
	   			<td align = "center"> 직업 </td>
	   			<td> <input type = "radio" name = "job" value = "teacher"> 교사 &nbsp&nbsp
			         <input type = "radio" name = "job" value = "student"> 학생 <br>
			         <input type = "radio" name = "job" value = "soldier"> 군인 &nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "company"> 회사원 <br>
			         <input type = "radio" name = "job" value = "housewife"> 주부 &nbsp&nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "etc"> 기타 <br>
	   			</td>
			</tr>
			<tr>
			   	<td align = "center"> 회원구분 </td>
			   	<td> <input type = "radio" name = "member_s" value = "member_n" checked> 일반회원 (탈퇴 가능) <br>
			         <input type = "radio" name = "member_s" value = "member_f"> 평생회원 (탈퇴 불가능)<br>
			   	</td>
			</tr>
			<br>
			<tr>
	   			<td align = "center"> 자기소개 </td>
	    		<td> 
	    			<textarea name = "self" rows = "5" cols = "30"> 자기소개해주세요 </textarea>
	   			</td>
			</tr>
        </table>
        <p align = "center"> 
        	<input type = "image" src = "img/JOIN2.png" name = "submit" value = "submit" align = "absmiddle" width = "100">
        	<input type = "image" src = "img/RESET.png" onclick = "goForm()" align = "absmiddle" width = "100">
        	<!-- <input type = "submit" value = "JOIN"> 
		    <input type = "reset" value = "취	소"> 위와 같은 역할 수행  -->
        </p>
     </form>
</body>
</html>