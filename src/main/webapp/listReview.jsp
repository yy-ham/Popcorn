<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="listReview.css">
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
				<div id="insertReview">
					<h4>리뷰쓰기</h4>
					<form action="InsertReview.do" id="InsertReview_form">
						<textarea rows="5" cols="100"></textarea><br>
						<input type="submit" value="리뷰등록">
					</form>
				</div>
				
				<hr>
				
				<div id="review_list">
					<c:forEach var="review" items="${review_list }">
						<div id="review_container">
							<div id="userinfo">
								<img alt="" src="./images/userimg/${review.userimg }" width="50">
								<p>${review.nickname }</p>
							</div>
							
							<div id="ratinginfo">
								<img alt="" src="./images/icon/${review.ratingcontent }_click.png" id="rating_content" width="50">
							</div>
											
							<a href="detailReview.do?reviewno=${review.reviewno }">
								<div id="review_content">
									${review.reviewcontent }
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
				
				
				
				
			</section>
		</div> <!-- end #content -->
			
			
	</div> <!-- end #page_wrapper -->
</body>
</html>