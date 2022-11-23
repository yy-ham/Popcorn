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
		<img src="./images/mainlogo.png" width="200px">
		<h2>비밀번호 수정</h2>
		<form action="searchPwdOK.do" method="post">
			<input type="hidden" value="${userinfovo.userno }" id="userno" name="userno">
			<input type="password" placeholder="비밀번호" id="pwd" name="pwd"><br>
			<input type="password" placeholder="비밀번호 재확인" id="pwdRe" name="pwdRe"><br>
			<input type="submit" value="비밀번호 바꾸기" id="resetPwd">
			<input type="reset" value="취소">
		</form>
	</div>
</body>
</html>