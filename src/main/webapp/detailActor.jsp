<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="detailActor.css">
</head>
<body>
	<div id="page_wrapper">
		
		<header>
				<div id="main_header">
					<nav id="main_navigation">
						<ul>
							<li class="navigation_menu">
								<a href="mainPage.do">
									<img src="./images/mainlogo.png" width="300" id="mainlogo">
								</a>
							</li>
							
							<li class="navigation_menu">
								<a href="#">
									<button class="menu_icon">자유게시판</button>
								</a>
							</li>
							<li class="navigation_menu">
							<a href="#">
								<c:if test="${userno != null }">
									<button class="menu_icon" id="mypage_icon">마이페이지</button>
								</c:if>
								<c:if test="${userno == null }">
									<button class="menu_icon" id="join_icon">회원가입</button>
								</c:if>
							</a>
						</li>
						<li class="navigation_menu">
							<a href="#">
								<input type="hidden" value="${userno }" id="userno">
								<c:if test="${userno != null }">
									<button class="menu_icon" id="logout_icon">로그아웃</button>
								</c:if>
								<c:if test="${userno == null }">
									<button class="menu_icon" id="login_icon">로그인</button>
								</c:if>
							</a>
						</li>
						</ul>
					</nav>
				</div>
			</header>
			
			
		<div id="content">
			<section>
				<div id="actor_container">
					<img alt="" src="./images/atorimg/${actorvo.actorimg }">
				</div>
				<div id="actor_info">
					<h1>${actorvo.actorname }</h1>
					<p><b>배우</b></p>
				</div>
				<hr>
				<div id="movie_list">
					<div id="list_head">
						<div class="list_title">포스터</div>
						<div class="list_title">제목</div>
						<div class="list_title">개봉연도</div>
						<div class="list_title">장르</div>
						<div class="list_title">역할</div>
					</div>
					
					<div id="list_body">
						<c:forEach var="actor_movie" items="${actor_movie }">
							<a href="detailMovie.do?movieno=${actor_movie.movieno }">
								<div class="movie_container">
									<div>
										<img alt="" src="./images/poster/${actor_movie.poster }" id="poster">
									</div>
									<div>${actor_movie.movietitle }</div>
									<div>${actor_movie.releasedate }</div>
									<div>${actor_movie.genre }</div>
									<div>${actor_movie.position } | ${actor_movie.role }</div>
								</div>
							</a>
						</c:forEach>
					</div> <!-- end #list_body -->
				
					
				</div> <!-- end #ㅡmovie_list -->
				
			</section>
		</div> <!-- end #content -->
			
	</div> <!-- end #page_wrapper -->
</body>
</html>