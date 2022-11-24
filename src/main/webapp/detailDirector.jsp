<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="detailDirector.css">
</head>
<body>
	<div id="page_wrapper">
		
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
			<section>
				<div id="director_container">
					<img alt="" src="./images/directorimg/${directorvo.directorimg }">
				</div>
				<div id="director_info">
					<h1>${directorvo.directorname }</h1>
					<p><b>감독</b></p>
				</div>
				<hr>
				<div id="movie_list">
					<ul id="list_head">
						<li class="list_title">포스터</li>
						<li class="list_title">제목</li>
						<li class="list_title">개봉일</li>
						<li class="list_title">장르</li>
						<li class="list_title">역할</li>
					</ul>
				</div> <!-- end #movie_list -->
					
					<div id="list_body">
						<c:forEach var="director_movie" items="${director_movie }">
							<a href="detailMovie.do?movieno=${director_movie.movieno }">
								<div class="movie_container">
									<ul>
										<li class="list_content">
											<img alt="" src="./images/poster/${director_movie.poster }" id="poster">
										</li>
										<li class="list_content text">${director_movie.movietitle }</li>
										<li class="list_content text">${director_movie.releasedate }</li>
										<li class="list_content text">${director_movie.genre }</li>
										<li class="list_content text">${director_movie.position }</li>
									</ul>
								</div>
							</a>
						
						</c:forEach>
					
					</div> <!-- end #list_body -->
				
					
				
			</section>
		</div> <!-- end #content -->
			
	</div> <!-- end #page_wrapper -->
</body>
</html>