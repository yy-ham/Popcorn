<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<style type="text/css">
	/*중앙 정렬 레이아웃 초기화*/
* {
	margin: 0;
	padding: 0
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
}


/*body*/
#content{
	/*clear: both;*/
	margin: 0 auto;
	margin-top: 200px;
	width: 960px;
	border: 2px solid #BF9B7A;
	padding: 30px;
	border-radius: 5px;
	display: block;
}
	
	#type_moviename{
		border: 2px solid yellow;
	}
	
	#insert{
		text-align:center;
	}
	
	#input_moviename{
		width:500px;
		height:30px;
		font-size:1.2em;
	}
	
	
	#list{
		border: 1px solid orange;
		margin:0px auto;
		width:80%;
	}
	
	.item{
		margin:30px;
		margin-left:50px;
		width:200px;
		height:380px;
		background-color:white;
		border:2px solid black;
		border-radius:10px;
		float:left;
	}
	


	.movie_name{
		display:inline-block;
		margin:0px auto;
		border : 1px solid green;
		width:100%;
		text-align:center;
	}
	
	#poster{
		display:block;	
		border:1px solid black;
		margin:0px auto;
	}
	
	input::placeholder{
		text-align:center;
		font-size:0.8em;
	}
	
	

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.2.min.js"></script>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("#search_movie").click(function(){
			
			$.ajax({
				url:"SearchByMovietitle",
				data:{movietitle:$("#input_moviename").val()},
				success:function(list){
					$("#list").empty();
					$.each(list,function(){
							
							var div=$("<div></div>").addClass("item");
							var img=$("<img/>").attr({"src":"images/poster/"+this.poster,
														"width":"180px",		
														"height":"250px"});
							var br = $("<br>");
							var span = $("<span></span>").html(this.movietitle).addClass("movie_name");
							var span2 = $("<span></span>").html(this.agelimit).addClass("movie_name");
							var span3 = $("<span></span>").html(this.genre).addClass("movie_name");
							$(div).append(img,br,span,span2,span3);
							var a = $("<a></a>").append(div).attr("href", "detailMovie.do?movieno="+this.movieno);
							$("#list").append(a);
								
							})
							
					$("#list").masonry({
						itemSelector:".item",
						columnWidth:100
					});
				}
			})
			
		})
				
		
	});
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
	
	<div id="content">
		<div id="type_moviename">
			<div id="insert">
				<input type="text" placeholder="영화제목을 입력하세요" id="input_moviename">
				<button id="search_movie">검색</button>
			</div>
		</div>
		<hr>
		
		<div id="list">
			<div id="list_inner">
				<img src="images/poster/기생충.jpg" width="200px" height="250px" id="poster"><br>
				<span class="movie_name">기생충</span>
			</div>
		</div>
	</div>
</body>
</html>