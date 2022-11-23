<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	img{
		margin:15px;
	}
	h2{
		margin:15px;
	}
	input{
		margin:15px;
	}
	#entire{
		text-align:center;
	}
	
</style>
</head>
<body>

	<div id="entire">
		<img src="img/pagelogo.png" width="300px" height="100px">
		<h2>회원가입</h2>
		<form action="#" method="post">
			<input type="text" placeholder="이름을 입력하세요"><br>
			<div id="email">
				<input type="email" placeholder="이메일을 입력하세요">
				<button>이메일 확인</button>
			</div>		
			<br>
			<input type="text" placeholder="닉네임을 입력하세요"><br>
			<input type="password" placeholder="비밀번호 입력"><br>
			<input type="password" placeholder="비밀번호 확인"><br>
			<input type="submit" value="가입하기">
		</form>	
	</div>
	
</body>
</html>