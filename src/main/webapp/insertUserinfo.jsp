<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘-회원가입</title>
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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#checkEmail").click(function(e){
		e.preventDefault();
		$.ajax({
			url:"checkEmail.jsp",
			data:{email:$("#email_input").val()},
			success:function(re){
				if(re==0){
					$("#checkEmailResult").text("입력하신 이메일은 사용 가능합니다.").css("color","blue");
				}else if(re>=1){
					$("#checkEmailResult").text("사용 중인 이메일입니다.").css("color","red");
				}else{
					alert("알 수 없는 오류");
				}
			}
		})
	})
	
	$("#pwdRe").keyup(function(){
		if($("#pwd").val()!=$("#pwdRe").val()){
			$("#checkPwd").html("비밀번호가 일치하지 않습니다.").css("color","red");
		}
		if($("#pwd").val()==$("#pwdRe").val()){
			$("#checkPwd").html("비밀번호가 일치합니다.").css("color","blue");
		}
		$("#pwd").keyup(function(){
			if($("#pwd").val()!=$("#pwdRe").val()){
				$("#checkPwd").html("비밀번호가 일치하지 않습니다.").css("color","red");
			}
			if($("#pwd").val()==$("#pwdRe").val()){
				$("#checkPwd").html("비밀번호가 일치합니다.").css("color","blue");
			}
		})
	})
	
	$("#joinForm").submit(function(e){
		if($("#checkEmailResult").text()!="입력하신 이메일은 사용 가능합니다."){
			e.preventDefault();
			alert("중복되지 않는 이메일을 입력해주세요.")
		}
		if($("#checkPwd").text()!="비밀번호가 일치합니다."){
			e.preventDefault();
			alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.")
		}
	})
	
	$("#checkNickname").click(function(e){
		e.preventDefault();
		$.ajax({
			url:"checkNickname.jsp",
			data:{nickname:$("#nickname").val()},
			success:function(re){
				if(re>=1){
					$("#checkNicknameResult").text("이미 사용중인 닉네임입니다. 다른 닉네임을 입력해주세요.").css({color:"red"})
				}else if(re==0){
					$("#checkNicknameResult").text("사용할 수 있는 닉네임입니다.").css({color:"blue"})
				}else{
					alert("알 수 없는 오류")
				}
			}
		})
	})
})
</script>
</head>
<body>

	<div id="entire">
		<img src="images/mainlogo.png" width="300px" height="100px">
		<h2>회원가입</h2>
		<form id="joinForm" action="insertUserinfoOK.do" method="post">
			<input type="text" name="username" placeholder="이름을 입력하세요"><br>
			<div id="email">
				<input type="email" placeholder="이메일을 입력하세요" id="email_input" name="email">
				<button id="checkEmail">중복 확인</button>
			</div>		
			<div id="checkEmailResult">&nbsp;</div>
			<div>
				<input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력하세요"><br>
				<button id="checkNickname">중복 확인</button>
			</div>
			<div id="checkNicknameResult">&nbsp;</div>
			<input type="password" name="pwd" id="pwd" placeholder="비밀번호 입력"><br>
			<input type="password" id="pwdRe" placeholder="비밀번호 확인"><br>
			<div id="checkPwd"></div>
			<input type="submit" value="가입하기">
		</form>	
	</div>
	
</body>
</html>