<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.StringTokenizer" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	if(session.getAttribute("id") == null) {
%>
	<script>
		alert("로그인을 해주시기 바랍니다.");
	</script>
	<meta http-equiv = "refresh" content = "0; url= LoginForm.jsp" target = "main">
<%
	}
%>
	<%!
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs;		// 결과 받아오는 변수
	%>
	<%
		String id = (String)session.getAttribute("id");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Mine </title>
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
		.withdraw {
			margin-right : 450px;
		}
	</style>
	<script src = "http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
		function check2() {
			if(document.MineForm.pw.value.length < 8 || document.MineForm.pw.value.length > 16) {
				alert("비밀번호는 8~15자 이내로 입력하세요!");
				document.MineForm.pw.focus();
				return false;
			}
			
			if(document.MineForm.pw.value != document.MineForm.pw2.value) {
				alert("비밀번호를 동일하게 입력하세요!");
				document.MineForm.pw2.focus();
				return false;
			}
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
		
		function withdraw() {
			document.MineForm.action = "Withdraw.jsp";
			document.MineForm.submit();
		}
		
		function Re() {
			location.href = "Main.jsp";
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
			
			String sql = "select * from O_member where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//out.println(address);
			//conn.commit();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	%>

	<p>
	<div class = "h"> MY PAGE </div>
	<div class = "m"> 회원정보 수정 </div>
	
	<form method = "post" action = "Update.jsp" name = "MineForm" onsubmit = "return check2()">
    	<div class = "list"> * : 필수 작성 항목 </div> <p>
    	<div class = "normal"> 기본정보 </div> <p>
    	<table align = "center">
    		<% while(rs.next()) { %>
 			<tr>
	   			<td align = "center">* 아이디 </td>
	   			<td> 
	   				<%= rs.getString("id") %>
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
	   			<td> <%= rs.getString("name") %> </td>
			</tr>
			<tr>
				<%
					String ad[] = new String[4];
					String adrr[] = new String[4];
					String add = rs.getString("address_A");
					StringTokenizer addr = new StringTokenizer(add, "/");
					while(addr.hasMoreTokens()) {
						for(int i = 0; i < 4; i++) {
							ad[i] = addr.nextToken();
						}
						adrr[0] = ad[0];  adrr[1] = ad[1];
						adrr[2] = ad[2];  adrr[3] = ad[3];
					}
				%>
	   			<td align = "center">* 주소 </td>
	   			<td> <input type = "text" size = "5" name = "postcode" id = "postcode" 
	   					value = "<%= adrr[0] %>"> &nbsp&nbsp
			         <input type = "button" value = "우편번호 찾기" onclick = "postCode()"> <br>
			         <input type = "text" size = "30" name = "address" id = "address"
			         	value = "<%= adrr[1] %>" placeholder = "도로명주소"> <br>
			         <input type = "text" size = "30" name = "address2" id = "address2" 
			         	value = "<%= adrr[2] %>" placeholder = "지번주소"> <br>
			         <input type = "text" size = "30" name = "address3" 
			         	value = "<%= adrr[3] %>" placeholder = "상세주소">
			         <span id="guide" style="color:#999"></span>
	   			</td>
			</tr>
			<tr>
			   	<td align = "center">* 성별 </td>
			   	<td> 
			   	<%
					String sex = rs.getString("sex");
					if(sex.equals("female")) {
				%>
			   		 	여자
			    <%
					} else{
			    %>
				    	남자
			    <%
					}
			    %>
			    </td>
			</tr>
			<tr>
			   	<td align = "center">* 핸드폰번호 </td>
			   	<td>
			   	<%
			   		String cel[] = new String[3];
					String cell[] = new String[3];
					String ph = rs.getString("phone_A");
			   		StringTokenizer tel = new StringTokenizer(ph, "-");
			   		while(tel.hasMoreTokens()) {
						for(int i = 0; i < 3; i++) {
							cel[i] = tel.nextToken();
						}
						cell[0] = cel[0];  cell[1] = cel[1];
						cell[2] = cel[2];
					}
				%> 
			   		<select name = "phone">
			   	<%
			   		if(cell[0].equals("010")) {
			   	%>
					   <option value = "010" selected> 010 </option>
					   <option value = "011"> 011 </option>
					   <option value = "016"> 016 </option>
					   <option value = "017"> 017 </option>
					   <option value = "018"> 018 </option>
					   <option value = "019"> 019 </option>
				<%
			   		} else if(cell[0].equals("011")) {
				%>
					   <option value = "010"> 010 </option>
					   <option value = "011" selected> 011 </option>
					   <option value = "016"> 016 </option>
					   <option value = "017"> 017 </option>
					   <option value = "018"> 018 </option>
					   <option value = "019"> 019 </option>
				<%
			   		} else if(cell[0].equals("016")) {
				%>
					   <option value = "010"> 010 </option>
					   <option value = "011"> 011 </option>
					   <option value = "016" selected> 016 </option>
					   <option value = "017"> 017 </option>
					   <option value = "018"> 018 </option>
					   <option value = "019"> 019 </option>
				<%
			   		} else if(cell[0].equals("017")) {
				%>
					   <option value = "010"> 010 </option>
					   <option value = "011"> 011 </option>
					   <option value = "016"> 016 </option>
					   <option value = "017" selected> 017 </option>
					   <option value = "018"> 018 </option>
					   <option value = "019"> 019 </option>
				<%
			   		} else if(cell[0].equals("018")) {
				%>
					   <option value = "010"> 010 </option>
					   <option value = "011"> 011 </option>
					   <option value = "016"> 016 </option>
					   <option value = "017"> 017 </option>
					   <option value = "018" selected> 018 </option>
					   <option value = "019"> 019 </option>
				<%
			   		} else if(cell[0].equals("019")) {
				%>
					   <option value = "010"> 010 </option>
					   <option value = "011"> 011 </option>
					   <option value = "016"> 016 </option>
					   <option value = "017"> 017 </option>
					   <option value = "018"> 018 </option>
					   <option value = "019" selected> 019 </option>
				<%
			   		}
				%>
					</select>
					- <input type = "number" size = "5" name = "phone2" value = "<%= cell[1] %>">
					- <input type = "number" size = "5" name = "phone3" value = "<%= cell[2] %>">
	   			</td>
			</tr>
			<tr>
				<td align = "center">* SMS 수신여부 </td>
				<td> 
				<%
					String smsRe = rs.getString("sms");
					if(smsRe.equals("ok")) {
				%>
					 <input type = "radio" name = "sms" value = "ok" checked> 수신함 
			         <input type = "radio" name = "sms" value = "no"> 수신안함
			    <%
					} else {
			    %>
			    	 <input type = "radio" name = "sms" value = "ok"> 수신함 
			         <input type = "radio" name = "sms" value = "no" checked> 수신안함
			    <%
					}
			    %>
				</td>
			</tr>
			<tr>
	   			<td align = "center">* 이메일 </td>
	   			<td> 
	   			<%
			   		String E[] = new String[2];
					String Em[] = new String[2];
					String e = rs.getString("email_A");
			   		StringTokenizer emi = new StringTokenizer(e, "@");
			   		while(emi.hasMoreTokens()) {
						for(int i = 0; i < 2; i++) {
							E[i] = emi.nextToken();
						}
						Em[0] = E[0];  Em[1] = E[1];
					}
				%> 
	   				<input type = "text" size = "13" name = "email" 
	   					value = "<%= Em[0] %>" maxlength = "30"> @
	          		<select name = "email2">
	          	<%
	          		if(Em[1].equals("1")) {
	          	%>
					   <option value = "1" selected> naver.com </option>
					   <option value = "2"> nate.com </option>
					   <option value = "3"> daum.net </option>
					   <option value = "4"> gmail.com </option>
					   <option value = "5"> hanmail.com </option>
				<%
	          		} else if(Em[1].equals("2")) {
	          	%>
					   <option value = "1"> naver.com </option>
					   <option value = "2" selected> nate.com </option>
					   <option value = "3"> daum.net </option>
					   <option value = "4"> gmail.com </option>
					   <option value = "5"> hanmail.com </option>
				<%
	          		} else if(Em[1].equals("3")) {
	          	%>
					   <option value = "1"> naver.com </option>
					   <option value = "2"> nate.com </option>
					   <option value = "3" selected> daum.net </option>
					   <option value = "4"> gmail.com </option>
					   <option value = "5"> hanmail.com </option>
				<%
	          		} else if(Em[1].equals("4")) {
	          	%>
					   <option value = "1"> naver.com </option>
					   <option value = "2"> nate.com </option>
					   <option value = "3"> daum.net </option>
					   <option value = "4" selected> gmail.com </option>
					   <option value = "5"> hanmail.com </option>
				<%
	          		} else if(Em[1].equals("5")) {
	          	%>
					   <option value = "1"> naver.com </option>
					   <option value = "2"> nate.com </option>
					   <option value = "3"> daum.net </option>
					   <option value = "4"> gmail.com </option>
					   <option value = "5" selected> hanmail.com </option>
				<%
	          		}
				%>
					</select>
	   			</td>
			</tr>
			<tr>
				<td align = "center">* 이메일 수신여부 </td>
				<td> 
				<%
					String emRe = rs.getString("e_mail");
					if(emRe.equals("ok")) {
				%>
					 <input type = "radio" name = "e_mail" value = "ok" checked> 수신함 
			         <input type = "radio" name = "e_mail" value = "no"> 수신안함
			    <%
					} else {
			    %>
			    	 <input type = "radio" name = "e_mail" value = "ok"> 수신함 
			         <input type = "radio" name = "e_mail" value = "no" checked> 수신안함
			    <%
					}
			    %>
				</td>
			</tr>
			<tr>
	   			<td align = "center">* 생년월일 </td>
	   			<td>
	   			<%
			   		String B[] = new String[3];
					String Bo[] = new String[3];
					String b = rs.getString("born");
			   		StringTokenizer bor = new StringTokenizer(b, "-");
			   		while(bor.hasMoreTokens()) {
						for(int i = 0; i < 3; i++) {
							B[i] = bor.nextToken();
						}
						Bo[0] = B[0];  Bo[1] = B[1];  Bo[2] = B[2];
					}
				%> 
	   				<%= Bo[0] %> 년
	   				<%= Bo[1] %> 월
	   				<%= Bo[2] %> 일  &nbsp
	   			<%
		   			String bir = rs.getString("birth");
					if(bir.equals("plus")) {
	   			%>
	   					(양력)
	   			<%
					} else {
	   			%>
	   					(음력)
	   			<%
					}
	   			%>
	   			</td>
			</tr>
        </table>
        
        <div class = "add"> 추가정보 </div>
        <table align = "center">
        	<tr>
	   			<td align = "center"> 직업 </td>
	   			<td> 
	   			<%
		   			String job = rs.getString("job");
					if(job.equals("teacher")) {
	   			%>
	   				 <input type = "radio" name = "job" value = "teacher" checked> 교사 &nbsp&nbsp
			         <input type = "radio" name = "job" value = "student"> 학생 <br>
			         <input type = "radio" name = "job" value = "soldier"> 군인 &nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "company"> 회사원 <br>
			         <input type = "radio" name = "job" value = "housewife"> 주부 &nbsp&nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "etc"> 기타 <br>
		 	    <%
					} else if(job.equals("student")) {
		 	    %>
		 	    	 <input type = "radio" name = "job" value = "teacher"> 교사 &nbsp&nbsp
			         <input type = "radio" name = "job" value = "student" checked> 학생 <br>
			         <input type = "radio" name = "job" value = "soldier"> 군인 &nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "company"> 회사원 <br>
			         <input type = "radio" name = "job" value = "housewife"> 주부 &nbsp&nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "etc"> 기타 <br>
		 	    <%
					} else if(job.equals("soldier")) {
		 	    %>
		 	    	 <input type = "radio" name = "job" value = "teacher"> 교사 &nbsp&nbsp
			         <input type = "radio" name = "job" value = "student"> 학생 <br>
			         <input type = "radio" name = "job" value = "soldier" checked> 군인 &nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "company"> 회사원 <br>
			         <input type = "radio" name = "job" value = "housewife"> 주부 &nbsp&nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "etc"> 기타 <br>
		 	    <%
					} else if(job.equals("company")) {
		 	    %>
		 	    	 <input type = "radio" name = "job" value = "teacher"> 교사 &nbsp&nbsp
			         <input type = "radio" name = "job" value = "student"> 학생 <br>
			         <input type = "radio" name = "job" value = "soldier"> 군인 &nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "company" checked> 회사원 <br>
			         <input type = "radio" name = "job" value = "housewife"> 주부 &nbsp&nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "etc"> 기타 <br>
		 	    <%
					} else if(job.equals("housewife")) {
		 	    %>
		 	    	 <input type = "radio" name = "job" value = "teacher"> 교사 &nbsp&nbsp
			         <input type = "radio" name = "job" value = "student"> 학생 <br>
			         <input type = "radio" name = "job" value = "soldier"> 군인 &nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "company"> 회사원 <br>
			         <input type = "radio" name = "job" value = "housewife" checked> 주부 &nbsp&nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "etc"> 기타 <br>
		 	    <%
					} else if(job.equals("etc")) {
		 	    %>
		 	    	 <input type = "radio" name = "job" value = "teacher"> 교사 &nbsp&nbsp
			         <input type = "radio" name = "job" value = "student"> 학생 <br>
			         <input type = "radio" name = "job" value = "soldier"> 군인 &nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "company"> 회사원 <br>
			         <input type = "radio" name = "job" value = "housewife"> 주부 &nbsp&nbsp&nbsp
		 	         <input type = "radio" name = "job" value = "etc" checked> 기타 <br>
		 	    <%
					}
		 	    %>
	   			</td>
			</tr>
			<tr>
			   	<td align = "center"> 회원구분 </td>
			   	<td>
			   	<%
		   			String mem = rs.getString("member_s");
					if(mem.equals("member_n")) {
	   			%>
			   		 <input type = "radio" name = "member_s" value = "member_n" checked> 일반회원 (탈퇴 가능) <br>
			         <input type = "radio" name = "member_s" value = "member_f"> 평생회원 (탈퇴 불가능)<br>
			   	<%
					} else {
			   	%>
			   		 <input type = "radio" name = "member_s" value = "member_n"> 일반회원 (탈퇴 가능) <br>
			         <input type = "radio" name = "member_s" value = "member_f" checked> 평생회원 (탈퇴 불가능)<br>
			   	<%
					}
			   	%>
			   	</td>
			</tr>
			<br>
			<tr>
	   			<td align = "center"> 자기소개 </td>
	    		<td>
	    		<%
	    			String Self = rs.getString("self");
	    		%>
	    			<textarea name = "self" rows = "5" cols = "30"> <%= Self %> </textarea>
	   			</td>
			</tr>
			<% } %>
        </table>
        <br>
        <input type = "image" src = "img/WITHDRAW.png" onclick = "withdraw()" class = "withdraw" align = "right" width = "100">
        <br>
        <p align = "center"> 
        	<input type = "image" src = "img/MODIFY.png" name = "submit" value = "submit" align = "absmiddle" width = "100">
        	<input type = "image" src = "img/RESET.png" onclick = "Re()" align = "absmiddle" width = "100">
        </p>
     </form>
</body>
</html>