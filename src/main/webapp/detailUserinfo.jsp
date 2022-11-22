<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘-회원정보</title>
<style type="text/css">
	a{text-decoration:none;}
	#logo{
		position:absolute;
		left:50%;
		margin-left:-150px;
		width:300px;
	}
	header{
		position:fixed;
		left:0; top:0; right:0;
		height:130px;
		background:white;
		z-index:98;
		padding-top:10px;
	}
	.headerElements{
	}
	#logout{
		position:absolute;
		right:20px;
		padding:5px;
		border:3px solid black;
	}
	#myPage{
		position:absolute;
		top:50px;
		left:0; right:0;
		font-size:26px;
		padding:20px;
	}
	section{
		position:absolute;
		top:250px;
		width:300px;
		height:300px;
		left:50%;
		margin-left:-150px;
	}
	#userimg{
		border-radius:50px;
	}
	.updateWindow{
		width:400px;
		height:250px;
		margin-left:-200px;
		margin-top:-125px;
		display:none;
		background:white;
		z-index:100;
		position:absolute;
		top:50%;
		left:50%;
		border:1px solid gray;
		border-radius:10px;
		padding:25px 20px;
	}
	#updateImg{

	}
	#updateNickname{
	}
	#updatePwd{
		
	}
	#black{
		position:absolute;
		top:0; bottom:0; left:0; right:0;
		background-color:rgba(0,0,0,0.7);
		z-index:99;
		display:none;
	}
	.close{
		width:10px;
		position:absolute;
		right:20px;
		color:gray;
		cursor:pointer;
	}
	#checkPwd{
		color:red;
	}
	#updatePwd{
		
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
	//// 프로필 사진 ////
	//프로필사진 변경 창 띄우기
	$("#btn_img").click(function(){
		$("#updateImg").css({display:"initial"})
		$("#black").css({display:"initial"})
	})
	//프로필사진 변경 창 닫기
	$("#close_img").click(function(){
		$("#updateImg").css({display:"none"})
		$("#black").css({display:"none"})
	})
	
	//// 닉네임 ////
	//닉네임 변경 창 띄우기
	$("#btn_nickname").click(function(){
		$("#updateNickname").css({display:"initial"})
		$("#black").css({display:"initial"})
	})
	//닉네임 변경 창 닫기
	$("#close_nickname").click(function(){
		$("#updateNickname").css({display:"none"})
		$("#black").css({display:"none"})
	})
	//닉네임 중복확인
	$("#btn_checkNickname").click(function(){
		$.ajax({
			url:"checkNickname.jsp",
			data:{nickname:$("#newNickname").val()},
			success:function(re){
				if(re>=1){
					$("#checkResult").text("이미 사용중인 닉네임입니다. 다른 닉네임을 입력해주세요.").css({color:"red"})
				}else if(re==0){
					$("#checkResult").text("사용할 수 있는 닉네임입니다.").css({color:"blue"})
				}else{
					alert("알 수 없는 오류")
				}
			}
		})
	})
	//닉네임 변경 실행
	$("#btn_updateNicknameOK").click(function(){
		$.ajax({
			url:"updateNickname.jsp",
			data:{
				nickname:$("#newNickname").val()
			},
			success:function(re){
				if(re==1){
					alert("닉네임이 변경되었습니다");
					$("#updateNickname").css({display:"none"})
					$("#black").css({display:"none"})
					$("#newNickname_changed").html($("#newNickname").val())
				}else{
					alert("닉네임 변경에 실패했습니다")
				}
			}
		})
	})
	
	//// 비밀번호 ////
	//비밀번호 변경 창 띄우기
	$("#btn_pwd").click(function(){
		$("#updatePwd").css({display:"initial"})
		$("#black").css({display:"initial"})
	})
	//비밀번호 변경 창 닫기
	$("#close_pwd").click(function(){
		$("#updatePwd").css({display:"none"})
		$("#black").css({display:"none"})
	})
	//비밀번호 일치 확인
	$("#newPwdRe").keyup(function(){
		if($("#newPwd").val()!=$("#newPwdRe").val()){
			$("#checkPwd").html("비밀번호가 일치하지 않습니다.")
		}
		if($("#newPwd").val()==$("#newPwdRe").val()){
			$("#checkPwd").html("")
		}
		$("#newPwd").keyup(function(){
			if($("#newPwd").val()!=$("#newPwdRe").val()){
				$("#checkPwd").html("비밀번호가 일치하지 않습니다.")
			}
			if($("#newPwd").val()==$("#newPwdRe").val()){
				$("#checkPwd").html("")
			}
		})
	})
	$("#btn_updatePwdOK").click(function(){
		$.ajax({
			url:"checkPwd.jsp",
			data:{pwd_input:$("#currentPwd").val()},
			success:function(re){
				if(re==1){
					if($("#newPwd").val()!=$("#newPwdRe").val()){
						alert("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.")
					}else{
						$.ajax({
							url:"updatePwd.jsp",
							data:{pwd:$("#newPwd").val()},
							success:function(re){
								if(re==1){
									alert("비밀번호를 변경했습니다.")
								}else{
									alert("비밀번호 변경에 실패했습니다.")
								}
								$("#updatePwd").css({display:"none"})
								$("#black").css({display:"none"})
							}
						})
					}
				}else{
					alert("입력하신 현재 비밀번호는 부정확합니다. 비밀번호를 다시 확인해주세요.")
				}
			}
		})
	})
})
</script>
</head>
<body>
	<div id="black"></div>
	<header>
		<!-- 로고 -->
		<div id="logo" class="headerElements">
			<a href="mainPage.do"><img src="./images/logo.png" width=300px;></a>
		</div>
		
		<div id="logout">
			<a href="logout.do">로그아웃</a>
		</div>
		
		<div id="myPage">
			<div class="headerElements"><b>회원정보</b></div>
			<hr class="headerElements">
		</div>
	</header>
	
	<section>
		<article>
			<!-- 프로필사진 -->
			<div>
				<img id="userimg" src="./images/userimg/${userinfovo.userimg }" width="100" height="100">
				<button id="btn_img">변경</button>
			</div>
			<br>
			<br>
			
			<table cellpadding="10">
				<tr>
					<td>이름</td>
					<td>${userinfovo.username }</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>${userinfovo.email }</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td id="newNickname_changed">${userinfovo.nickname }</td>
					<td><button id="btn_nickname">변경</button></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><button id="btn_pwd">변경</button></td>
					<td>&nbsp;</td>
				</tr>				
			</table>
		</article>
		
		<article>
			<div id="updateImg" class="updateWindow">
				<div id="close_img" class="close">X</div>
				<div>프로필 사진 변경</div>
				<hr>
				<form id="imgForm" action="updateUserimg.do" method="post" enctype="multipart/form-data">
					<input type="file" id="imgInput" name="imgInput" required="required"><br>
					<input type="submit" value="확인">
				</form>
			</div>
		</article>
		
		<article>
			<div id="updateNickname" class="updateWindow">
				<div id="close_nickname" class="close">X</div>
				<div>닉네임 변경</div>
				<hr>
				<input id="newNickname" required="required" value="${userinfovo.nickname }">
				<button id="btn_checkNickname">중복확인</button>
				<br>
				<div id="checkResult"></div>
				<br>
				<button id="btn_updateNicknameOK">확인</button>
			</div>
		</article>
		
		<article>
			<div id="updatePwd" class="updateWindow">
				<div id="close_pwd" class="close">X</div>
				<div>&nbsp;</div>
				<div>비밀번호 변경</div>
				<hr>
				<table>
					<tr>
						<td>현재 비밀번호</td>
						<td><input id="currentPwd" type="password" required="required"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>새 비밀번호</td>
						<td><input id="newPwd" type="password" required="required"></td>
					</tr>
					<tr>
						<td>새 비밀번호 확인</td>
						<td><input id="newPwdRe" type="password" required="required"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td id="checkPwd"></td>
					</tr>
				</table>				
				<br>
				<button id="btn_updatePwdOK">확인</button>
			</div>
		</article>
	</section>
</body>
</html>