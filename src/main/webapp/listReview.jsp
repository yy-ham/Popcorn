<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="listReview.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function () {
		$("#btn_insertReview").click(function () {
			console.log("OK");
			var review_data = $("#InsertReview_form").serializeArray();
			$.ajax({
				url: "insertReview.jsp",
				data: review_data,
				success: function (result) {
					location.reload();
				}
			});
		});
	});
</script>
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
								<a href="insertUserinfo.jsp">
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
			
			
		<div id="content">
			<section>
				<div id="insertReview">
					<h4>리뷰쓰기</h4>
					<form id="InsertReview_form">
						<input type="hidden" value="${movieno }" id="movieno" name="movieno">
						<input type="hidden" value="${userno }" id="userno" name="userno">
						<textarea rows="5" cols="100" id="reviewcontent" name="reviewcontent"></textarea><br>
					</form>
					<input type="submit" value="리뷰등록" id="btn_insertReview">
				</div>
				
				<hr>
				
				<div id="review_list">
						<c:forEach var="review" items="${review_list }">
							<div id="review">
								<input type="hidden" value="${review.reviewno }" id="reviewno">
								<input type="hidden" value="${review.movieno }" id="movieno">
								<div id="userinfo">
									<img alt="" src="images/userimg/${review.userimg }" id="userimg" width="50">
									<p id="nickname"><b>${review.nickname }</b></p>
								</div>
								
								<div id="review_content">
									<a href="detailReview.do?reviewno=${review.reviewno }&movieno=${review.movieno}">
										<p>${review.reviewcontent }</p>
									</a>
								</div>
								
								<div id="ratinginfo">
									<c:if test="${review.ratingcontent != null }">
										<img alt="" src="images/icon/${review.ratingcontent }_click.png" id="rating_content" width="30">
									</c:if>
								</div>
							</div> <!-- end #review -->
						</c:forEach>
					</div> <!-- end #review_list -->
				
				
				
			</section>
		</div> <!-- end #content -->
			
			
	</div> <!-- end #page_wrapper -->
</body>
</html>