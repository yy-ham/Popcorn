<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" type="text/css" href="bootstrap2.css">
<link rel="stylesheet" type="text/css" href="detailMovie.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(function () {
		var userno = $("#userno").val();
		var movieno = $("#movieno").val();
		console.log("movieno:"+movieno);
		console.log("userno:"+userno);
		
		//로그인 정보 없을 경우 리뷰쓰기, 평가등록 기능 제한
		if(userno == ""){
			console.log("로그인해야함");
			$("#btnWriteReview").click(function () {
				alert("로그인이 필요한 기능입니다.");
			});
			
			$("input[type=checkbox]").click(function () {
				alert("로그인이 필요한 기능입니.");
			});
		}else{
			//리뷰 등록
			$("#btnInsertReview").click(function () {
				var review_data = $("#review_form").serializeArray();
				$.ajax({
					url: "insertReview.jsp",
					data: review_data,
					success: function (result) {
						location.reload();
					}
				});
			});
			
			//평가 있으면 가져오기
			var getRating = function () {
				$.ajax({
					url: "listRating.jsp",
					data: {
						userno: userno,
						movieno: movieno
					},
					success: function (ratingcontent) {
						$("#"+ratingcontent).attr("src", "./images/icon/"+ratingcontent+"_click.png");
						$("#btn_"+ratingcontent).prop("checked", true);
					}
				});
			}
			getRating();
			
			//평가 등록하기, 삭제하기
			$("input[type=checkbox]").click(function () {
				var selected = $(this).val();
				console.log("selected:"+selected);
				
				if($(this).prop("checked")) {
					console.log($(this).val() + "선택");
					$("input[type=checkbox]").prop("checked", false); //전체 false
					$(this).prop("checked", true); //선택한 것만 다시 true
					$("#good").attr("src", "./images/icon/good_default.png");
					$("#fair").attr("src", "./images/icon/fair_default.png");
					$("#bad").attr("src", "./images/icon/bad_default.png");
					$("#"+selected).attr("src", "./images/icon/"+selected+"_click.png");
					
					//평가 등록하기
					$.ajax({
						url: "insertRating.jsp",
						data: {
							userno: userno,
							movieno: movieno,
							ratingcontent: selected
						},
						success: function (result) {
							console.log("결과:"+result);
							getRating();
						}
					});
					
				}else{
					console.log($(this).val() + "취소");
					$("input[type=checkbox]").prop("checked", false);
					$("#"+selected).attr("src", "./images/icon/"+selected+"_default.png");
					
					//평가 삭제하기
					$.ajax({
						url: "deleteRating.jsp",
						data: {
							userno: userno,
							movieno: movieno,
						},
						success: function (result) {
							console.log("result:"+result);
							getRating();
						}
					});
				}
			});
		}
		
	});
</script>
</head>
<body>
	<%
		//임시 로그인
		int userno; 
		if(session.getAttribute("userno") != null){
			userno = (Integer)(session.getAttribute("userno"));
			System.out.println("detailMovie_userno:" + userno);
		}
	%>

	<!-- 상단바 -->
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
		
		<!-- content -->
		<div id="content">
			<section>
				<div id="top_container">
					<!-- 포스터 -->
					<div id="poster_container">
						<img src="./images/poster/${movievo.poster }" height="250" id="poster">
					</div>
					<!-- 포스터 옆에 나오는 정보, 평가 버튼 -->
					<div id="info_container">
						<input type="hidden" value="${movievo.movieno }" id="movieno">
						<p id="movietitle">${movievo.movietitle }</p>
						<p id="info">${movievo.releasedate } | ${movievo.country } | ${movievo.genre } | ${movievo.runningtime }분 | ${movievo.agelimit }</p>
						<div id="rating_container">
							<p><b>평가하기</b></p>
							<div id="r">
								<input type="checkbox" id="btn_good" value="good" class="btnRating"/>
						      	<label for="btn_good">
						        	<img src="./images/icon/good_default.png" style="width:50px;" id="good"/>
						      	</label>
						      	&nbsp;&nbsp;
						      	<input type="checkbox" id="btn_fair" value="fair" class="btnRating"/>
						      	<label for="btn_fair">
						        	<img src="images/icon/fair_default.png" style="width:50px;" id="fair" />
						      	</label>
								&nbsp;&nbsp;
						      	<input type="checkbox" id="btn_bad" value="bad" class="btnRating"/>
						      	<label for="btn_bad">
						        	<img src="images/icon/bad_default.png" style="width:50px;" id="bad"/>
						      	</label>
							</div>
						</div> <!-- end #rating -->
					</div> <!-- end #info_container -->
				</div> <!-- end #top_container -->
				<div id="detail_container">
					<div id="story_info">
						<h2>기본정보</h2>
						<p><b>${movievo.releasedate } | ${movievo.country } | ${movievo.genre } | ${movievo.runningtime }분 | ${movievo.agelimit }</b></p>
						<p>${movievo.story }</p>
					</div>
					<hr>
					<div id="director_list">
						<h2>제작</h2>
						<div class="director">
							<a href="detailDirector.do?directorno=${directorcastvo.directorno }">
								<input type="hidden" value="${directorcastvo.directorno }" id="directorno">
								<div id="directorimg_container">
									<img alt="" src="./images/directorimg/${directorcastvo.directorimg }" id="directorimg" width="80">
								</div>
								<div id="directorname">
									<p><b>${directorcastvo.directorname }</b></p>
									<p>${directorcastvo.position }</p>
								</div>
							</a>
						</div>
					</div><!-- end #director_list -->
					<hr>
					<div id="actor_list">
						<h2>출연</h2>
						<c:forEach var="actor" items="${actor_list }">
							<div class="actor">
								<a href="detailActor.do?actorno=${actor.actorno }">
									<input type="hidden" value="${actor.movieno }" id="movieno">
									<div id="actorimg_container">
										<img alt="" src="./images/actorimg/${actor.actorimg }" id="actorimg" width="80">
									</div>
									<div id="actorname">
										<p><b>${actor.actorname }</b></p>
										<p>${actor.position} | ${actor.role }</p>
									</div>
								</a>
							</div>
						</c:forEach>
					</div> <!-- end #actor_list -->
				</div> <!-- end #detail_container -->
				<div id="review_container">
					<h2>리뷰</h2>
					<!-- 리뷰 등록, Button to Open the Modal -->
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="btnWriteReview">
					  <img alt="" src="./images/icon/insertReview_icon.png" width="40">
					</button>
					<div id="review_list">
						<c:forEach var="review" items="${review_list }">
							<div id="review">
								<input type="hidden" value="${review.reviewno } id="reviewno">
								<div id="userinfo">
									<img alt="" src="images/userimg/${review.userimg }" id="userimg" width="50">
									<p><b>${review.nickname }</b></p>
								</div>
								
								<div id="review_content">
									<a href="detailReview.do?reviewno=${review.reviewno }&movieno=${movievo.movieno}">
										<p>${review.reviewcontent }</p>
									</a>
								</div>
								
								<div id="ratinginfo">
									<c:if test="${review.ratingcontent != null }">
										<img alt="" src="images/icon/${review.ratingcontent }_click.png" id="rating_content" width="50">
									</c:if>
								</div>
							</div> <!-- end #review_container -->
						</c:forEach>
						<br><br>
						<p>
							<a href="listReview.do?movieno=${movievo.movieno }">
								<b id="review_more">더보기</b>
							</a>
						</p>
					</div> <!-- end #review_list -->
				</div> <!-- end #review_container -->
				
			</section>
		</div> <!-- end #content -->
		
		
		
		<c:if test="${userno != null}">
			<!-- 리뷰쓰기 버튼 눌렀을 때 나오는 창 -->
			<!-- The Modal -->
			
			<div class="modal" id="myModal">
			  <div class="modal-dialog">
			    <div class="modal-content">
			
			      <!-- Modal Header -->
			      <div class="modal-header">
			        <h4 class="modal-title">리뷰쓰기</h4>
			        <button id="btnClose" class="close" data-dismiss="modal">x</button>
			      </div>
			
			      <!-- Modal body -->
			      <div class="modal-body">
			      	<form id="review_form" method="post">
				      	<input type="hidden" value="${nextReviewno }" id="nextReviewno" name="reviewno">
				      	<input type="hidden" value="${userno}" id="userno" name="userno">
				      	<input type="hidden" value="${movievo.movieno }" id="movieno" name="movieno">
				        <textarea rows="10" cols="60" placeholder="이 작품에 대한 생각을 자유롭게 표현해주세요." id="reviewcontent" name="reviewcontent"></textarea><br>
			      	</form>
			      </div>
			
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="button" class="btn btn-danger" data-dismiss="modal" id="btnInsertReview">등록</button>
			      </div>
			
			    </div>
			  </div>
			</div>
		</c:if>
			
		

	</div> <!-- end #page_wrapper -->
</body>
</html>