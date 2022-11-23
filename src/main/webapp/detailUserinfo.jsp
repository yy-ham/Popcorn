<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘-회원정보</title>
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
							<a href="#">
								<button class="menu_icon" id="join_icon">회원가입</button>
							</a>
						</c:if>
					</li>
					<!-- 로그인 / 로그아웃 아이콘 -->
					<li class="navigation_menu">
						<input type="hidden" value="${userno }" id="userno">
						<c:if test="${userno != null }">
							<a href="#">
								<button class="menu_icon" id="logout_icon">로그아웃</button>
							</a>
						</c:if>
						<c:if test="${userno == null }">
							<a href="#">
								<button class="menu_icon" id="login_icon">로그인</button>
							</a>
						</c:if>
					</li>
				</ul> <!-- end #menu_list -->
			</nav>
		</header>
	</div> <!-- end #header_container -->
	
	<section>
		<article>
			<!-- 프로필사진 -->
			<div>
				<img id="userimg" src="./images/userimg/${userinfovo.userimg }" width="100" height="100">
				<button id="btn_img">변경</button>
			</div>
			<br>
			<br>
			
			<table cellpadding="20">
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