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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function () {

	});
</script>
</head>
<body>
	<div id="entire">
		<img src="./images/mainlogo.png" width="200px">
		<h2>비밀번호 찾기</h2>
		<h5>팝콘 계정을 가입하셨을 당시의 이메일과 성명을 입력해주십시오</h5>
		<form action="searchPwd.do" method="post">
			<input type="text" placeholder="성명" id="username" name="username"><br>
			<input type="email" placeholder="이메일" id="email" name="email"><br>
			<input type="submit" value="비밀번호 찾기" id="searchPwd">
			<input type="reset" value="취소">
		</form>
	</div>
</body>
</html>