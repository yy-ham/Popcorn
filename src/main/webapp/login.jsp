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
	
	#logo{
		cursor:pointer;
		
	}
	
</style>	
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		
		
		
		$("#logo").click(function(){
			$(location).attr("href","mainPage.do");
		})

		var login= function(){
			if($("#email").val()!=""&& $("#password").val()!=""){
					$.ajax({
						url:"LoginCheck",
						method:"POST",
						data:$("#myform").serializeArray(),
						success:function(userno){
							if(userno>0){
									alert("로그인 성공!");
									console.log("re : "+userno);
									$(location).attr("href","mainPage.do");
							}else{
								alert("아이디 또는 비밀번호가 일치하지 않습니다.");
							}
						}
					});
				}else{
					alert("아이디 또는 비밀번호를 입력하세요");
				}
			}
		
			$("#login_btn").click(function(){
				login();
			});
			
		
		$(document).keydown(function(e){
			if(e.keyCode==13){
				login();
			};
		});
		
		
		var rewrite=$("form").find("button")[0];
		$(rewrite).click(function(){
			$("#email").val("");
			$("#password").val("");
		});
		
		$("#btn_searchPwd").click(function(){
			$(location).attr("href","searchPwd.jsp");
		})
		
		$("#btn_join").click(function(){
			$(location).attr("href","insertUserinfo.jsp");
		})
	});
	
</script>

</head>
<body>
	<div id="entire">
		<img src="images/logo.png" width="300px" height="125px" id="logo">
		<h2>로그인</h2>
		<form id="myform">
			<input type="email" placeholder="이메일" name="email" id="email"><br>
			<input type="password" placeholder="비밀번호" name="password" id="password"><br>
		</form>
			<div>
				<button id="login_btn">로그인</button>
			</div>
			<button>다시 입력</button>
			<button id="btn_searchPwd">비밀번호 찾기</button>
			<button id="btn_join">회원가입</button>
	</div>
</body>
</html>