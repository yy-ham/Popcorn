<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	img{
		margin:10px;
	}
	h2{
		margin:15px;
	}
	input{
		margin:10px;
	}
	button{
		margin:10px;
	}
	#entire{
		text-align:center;
	}
</style>	
</head>
<body>
	<div id="entire">
		<img src="img/brandlogo.png" width="125px" height="125px">
		<h2>비밀번호 찾기</h2>
		<h5>팝콘 계정을 가입하셨을 당시의 이메일과 성명, 그리고 주민등록번호를 입력해주십시오</h5>
		<input type="text" placeholder="성명"><br>
		<input type="email" placeholder="이메일"><br>
		<input type="password" placeholder="주민등록번호"><br>
		<input type="submit" value="계속">
		<button>취소</button>
	</div>
</body>
</html>