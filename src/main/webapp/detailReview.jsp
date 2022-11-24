<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="bootstrap2.css">
<link rel="stylesheet" type="text/css" href="detailReview.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(function () {
		$("#btnUpdateReview").click(function () {
			var review_update = $("#review_form").serializeArray();
			console.log(review_update);
			$.ajax({
				url: "updateReview.jsp",
				data: review_update,
				success: function (re) {
					location.reload();
					console.log(re);
				}
			});			
		});
		
		
		$("#btnReviewDelete").click(function () {
			if(confirm("리뷰를 삭제하시겠습니까?")){
				var reviewno = $("#reviewno_delete").val();
				console.log("reviewno:"+reviewno);
				
				var movieno = $("#movieno").val();
				console.log("movieno:"+movieno);
				
				$.ajax({
					url: "deleteReview.jsp",
					data: {reviewno: reviewno},
					success: function (result) {
						location.href = "detailMovie.do?movieno="+movieno;
					}
				});
				
			}
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
				<div id="review_container">
					<input type="hidden" value="${reviewrating.reviewno }" id="reviewno_delete" name="review_delete">
					<div id="userinfo">
						<img alt="" src="images/userimg/${reviewrating.userimg }" id="userimg" width="50" name="userimg">
						<p id="nickname" name="nickname">${reviewrating.nickname }</p>
					</div>
					<div id="ratinginfo">
						<c:if test="${reviewrating.ratingcontent != null }">
							<img alt="" src="images/icon/${reviewrating.ratingcontent }_click.png" id="rating" width="50" name="ratingcontent">
						</c:if>
					</div>
					<div id="movietitle_container">
						<a href="detailMovie.do?movieno=${movie.movieno }">
							<b><p id="movietitle" name="movietitle">${movie.movietitle }</p></b>
						</a>
					</div>
					<hr>
					<div id="review_content">
						<p name="reviewcontent">${reviewrating.reviewcontent }</p>
					</div>
					<div id="movieinfo">
						<input type="hidden" value="${movie.movieno }" id="movieno">
						<a href="detailMovie.do?movieno=${movie.movieno }">
							<img alt="" src="./images/poster/${movie.poster }" id="poster" width="150" name="poster">
						</a>
						
					</div>
				</div> <!-- end #review_container -->
				<div id="button_container">
					<c:if test="${userno == reviewrating.userno}">
						<!-- Button to Open the Modal -->
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="btnWriteReview">
							수정
						</button>
						<button id="btnReviewDelete" class="btn">삭제</button>				
					</c:if>
				</div>	
			
			
			
		<!-- 리뷰쓰기 버튼 눌렀을 때 나오는 창 -->
		<!-- The Modal -->
		<div class="modal" id="myModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">리뷰수정</h4>
		        <button id="btnClose" class="close" data-dismiss="modal">x</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	<form id="review_form" method="post">
			      	<input type="hidden" value="${reviewrating.reviewno }" id="reviewno" name="reviewno">
			      	<input type="hidden" value="${userno}" id="userno" name="userno">
			      	<input type="hidden" value="${reviewrating.movieno }" id="movieno" name="movieno">
			        <textarea rows="10" cols="60" id="reviewcontent" name="reviewcontent" color="black">${reviewrating.reviewcontent }</textarea><br>
		      	</form>
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-dismiss="modal" id="btnUpdateReview">수정</button>
		      </div>
		      
			</section>
		</div> <!-- end #content -->
		
	</div> <!-- end #page_wrapper -->
</body>
</html>