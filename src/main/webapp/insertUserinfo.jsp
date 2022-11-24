<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘-회원가입</title>
<style type="text/css">
	/*상단바*/
	* {
	margin: 0;
	padding: 0;
	}
	
	/*전체*/
	body{
		background: rgb(243, 243, 243);
	}
	
	/*태그 선택자 설정*/
	p{
		margin-bottom: 5px;
		margin-left: 10px;
	}
	
	li{
		list-style: none;
		float: left;
	}
	
	button{
		cursor: pointer;
	}
	
	a{
		text-decoration: none;
		color: black;
	}
	
	hr{
		margin: 20px 0;
	}
	
	
	/*상단바*/
	/*중앙 정렬*/
	header{
		/*margin: 0 auto;*/
		width: 1300px;
		background: rgb(243, 243, 243);
		z-index: 50;
	}
	.navigation_menu{
		margin: 20px 0;
	}
	
	/*상단 우측 아이콘 정렬*/
	#empty{
		margin-left: 570px;
	}
	
	/*메인로고*/
	#mainlogo_li{
		margin-left: 30px;
	}
	
	.menu_icon {
		margin: 32px 10px 0 10px; /*위 오 아 왼*/
		background: none;
		font-size: 20px;
		font-weight: bold;
		padding: 5px;
		cursor: pointer;
		font-family: '나눔스퀘어라운드';
		/*border: 2px solid #BF9B7A;*/
		/*border-radius: 5px;*/
		border: none;
		color: #0D0D0D;
	}
	
	#header_container{
		position: fixed;
		width: 1300px;
		margin: 0 auto;
		/*margin-left: 150px;*/
		/*border: 5px solid red;*/
		display: block;
		left: 0; top: 0; right: 0;
		background: rgb(243, 243, 243);
		z-index: 50;
		border-bottom:1px solid #D9CDBF;
	}
	
	
	section{
		margin-top:215px;
	}
	#title{
		font-size:22px;
		left:45%;
	}


	img{
		margin:15px;
	}
/*	h2{
		margin:15px;
	}*/
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
		if($("#email_input").val()!=null && $("#email_input").val()!=" "){
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
		}
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
		if($("#email_input").val()!=null && $("#email_input").val()!=" "){
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
		}
	})
})
</script>
</head>
<body>
	<!-- header -->
	<div id="header_container">
		<header>
			<nav>
				<ul id="menu_list">
					<!-- 메인 로고 -->
					<li class="navigation_menu" id="mainlogo_li">
						<a href="mainPage.do">
							<img src="./images/mainlogo.png" width="300" id="mainlogo">
						</a>
					</li>
					<li id="empty">&nbsp;</li>
					<!-- 자유게시판 아이콘 -->
					<li class="navigation_menu">
						<a href="listBoard.do">
							<button class="menu_icon" id="board_icon">자유게시판</button>
						</a>
					</li>
					<!-- 회원가입 / 마이페이지 아이콘 -->
					<li class="navigation_menu">
						<c:if test="${userno != null }">
							<a href="myPage.do">
								<button class="menu_icon" id="mypage_icon">마이페이지</button>
							</a>
						</c:if>
						<c:if test="${userno == null }">
							<a href="insertUserinfo.do">
								<button class="menu_icon" id="join_icon">회원가입</button>
							</a>
						</c:if>
					</li>
					<!-- 로그인 / 로그아웃 아이콘 -->
					<li class="navigation_menu">
						<input type="hidden" value="${userno }" id="userno">
						<c:if test="${userno != null }">
							<a href="logout.do">
								<button class="menu_icon" id="logout_icon">로그아웃</button>
							</a>
						</c:if>
						<c:if test="${userno == null }">
							<a href="login.jsp">
								<button class="menu_icon" id="login_icon">로그인</button>
							</a>
						</c:if>
					</li>
				</ul> <!-- end #menu_list -->
			</nav>
		</header>
	</div> <!-- end #header_container -->
	
	<section>
		<div id="entire">
			<br><br>
			<div id="title">회원가입</div><br><br>
			<form id="joinForm" action="insertUserinfoOK.do" method="post">
				<input type="text" name="username" placeholder="이름을 입력하세요" required="required"><br><br>
				<div id="email">
					<input type="email" placeholder="이메일을 입력하세요" id="email_input" name="email" required="required">
					<button id="checkEmail">중복 확인</button>
				</div>		
				<div id="checkEmailResult">&nbsp;</div>
				<div>
					<input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력하세요" required="required">
					<button id="checkNickname">중복 확인</button>
				</div>
				<div id="checkNicknameResult">&nbsp;</div>
				<input type="password" name="pwd" id="pwd" placeholder="비밀번호 입력" required="required"><br>
				<input type="password" id="pwdRe" placeholder="비밀번호 확인" required="required"><br><br>
				<div id="checkPwd"></div>
				<input type="submit" value="가입하기">
			</form>	
		</div>
	</section>
</body>
</html>