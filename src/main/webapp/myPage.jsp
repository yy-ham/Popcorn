<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘-마이페이지</title>
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

	
	
	/*
	#logo{
		position:absolute;
		left:50%;
		margin-left:-150px;
		width:300px;
		border:1px solid red;
	}

	
	header{
		position:fixed;
		left:0; top:0; right:0;
		height:130px;
		background:white;
		z-index:99;
		padding-top:10px;
	}
	
	#logout{
		position:absolute;
		right:20px;
		padding:5px;
		border:3px solid black;
	}
	#title{
		position:absolute;
		left:0; right:0;
		top:50px;
		font-size:26px;
		padding:20px;
	}*/
	
	
	#title{
		font-size:26px;
	}
	
	/* section 공통 */
	
	#section{
		position:absolute;
		top:150px;
		right:5%;
		left:5%;
		width: 1000px;
		margin: 0 auto;
	}
	.smallTitle{
		font-size:22px;
		margin-top:20px;
	}
	.more{
		text-align:right;
	}
	
	/*profile*/
	#profile{
		height:200px;
		width:150px;
		position:relative;
		left:44%;
	}
	.profileElements{
		position:absolute;
		width:100px;
		left:50%;
		margin-left:-50px;
	}
	#userimg{
		height:100px;
		border-radius:50px;
		overflow:hidden;
	}
	#nickname{
		text-align:center;
		margin-top:80%;
	}
	/*
	#userinfo{
		text-align:center;
		margin-top:100%;
		
	}
	#userinfo_text{
		background-color:#D9CDBF;
		border-radius:3px;
		color:#0D0D0D;
		padding:3px;
	}*/
	
	
	#userinfoBtn{
		position:absolute;
		left:150px;
		top:120px;
	}
	
	
	/* rating */
	#rating{
		border: 1px solid #D9CDBF;
		border-radius:10px;
		padding:20px;
	}
	#myrating{
		overflow:hidden;
		height:310px;
	}
	.movie{
		float:left;
		margin:10px;
		padding:10px;
	}
	.ratingcontent{
		padding-top:7px;
	}
	
	/* review */
	#myReview{
		border: 1px solid #D9CDBF;
		border-radius:10px;
		padding:20px;
		height:490px;
		margin:50px 0px;
	}
	#reviewContainer{
		overflow:hidden;
	}
	.eachReview{
		border:1px solid #D93223;
		border-radius:10px;
		height:130px;
		margin:10px;
		padding:10px;
		position:relative;
		overflow:hidden;
	}
	.reviewElements{
		float:left;
		margin:8px;
	}
	.reviewElementsLower{
		margin:8px;
	}
	
	/* board */
	#myBoard{
		/*overflow:hidden;*/
		border: 1px solid #D9CDBF;
		border-radius:10px;
		padding:20px;
		height:418px;
		margin-top:50px;
		margin-bottom:100px;
	}
	#ul{
		list-style:none;
	}
	.eachBoard{
		margin:10px;
		padding:20px;
		width:700px;
		height:100px;
		border:1px solid #D93223;
		border-radius:10px;
		/*overflow:hidden;*/
	}
	.boardElements{
		margin:8px;
	}
	.ellipsis{
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}


</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
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
	
		<section id="section">
	
			<div id="title"><b>마이페이지</b></div>
			
			<article id="profile">
				<!-- 프로필사진 -->
				<div id="userimg" class="profileElements">
					<img src="./images/userimg/${userinfovo.userimg }" width="100" height="100">
				</div>
				<div>
					<!-- 닉네임 -->
					<span id="nickname" class="profileElements nickAndImg">${userinfovo.nickname }</span>
					<a id="userinfoBtn" class="profileElements nickAndImg" href="detailUserinfo.do">
						<img src="images/icon/pencil.png" width="20">
					</a>
				</div>
				<!-- 
				<div id="userinfo" class="profileElements">
					<a id="userinfo_text" href="detailUserinfo.do">회원정보</a>
				</div>
				 -->
				 
				<br>
			</article>
			
			<article id="rating">
				<div class="smallTitle"><b>내가 평가한 영화</b></div><br>
				<div class="more"><a href="listMyRating.do">더보기</a></div>
				<div id="myrating">
					<c:forEach var="ra" items="${list_rating }" begin="0" end="6">
						<div class="movie">
							<div>
								<a href="detailMovie.do?movieno=${ra.movieno }">
									<img src="./images/poster/${ra.poster }" width="150" height="215.9">
								</a>
							</div>
							<div>
								<a href="detailMovie.do?movieno=${ra.movieno }">${ra.movietitle }</a>
							</div>
							<div class="ratingcontent">
								<c:if test="${ra.ratingcontent =='good'}">
									<img src="./images/rating/good.png" width="30">
								</c:if>
								<c:if test="${ra.ratingcontent =='fair'}">
									<img src="./images/rating/fair.png" width="30">
								</c:if>
								<c:if test="${ra.ratingcontent =='bad'}">
									<img src="./images/rating/bad.png" width="30">
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
				<br>
			</article>
			
			<article id="myReview">
				<div class="smallTitle"><b>내가 쓴 리뷰</b></div><br>
				<div class="more"><a href="listMyReview.do">더보기</a></div>
				<div id="reviewContainer">
					<c:forEach var="re" items="${list_review }" begin="0" end="1">
						<div class="eachReview">
							<div class="reviewElements">
								<a href="detailMovie.do?movieno=${re.movieno }">
									<img src="./images/poster/${re.poster }" width="80" height='114.5'/>
								</a>
							</div>
							<div class="reviewElements">
								<div class="reviewElementsLower">
									<a href="detailMovie.do?movieno=${re.movieno }">${re.movietitle }</a>
								</div>
								<div class="reviewElementsLower">
									<c:if test="${re.ratingcontent =='good'}">
										<img src="./images/rating/good.png" width="30">
									</c:if>
									<c:if test="${re.ratingcontent =='fair'}">
										<img src="./images/rating/fair.png" width="30">
									</c:if>
									<c:if test="${re.ratingcontent =='bad'}">
										<img src="./images/rating/bad.png" width="30">
									</c:if>
								</div>
								<div class="reviewElementsLower ellipsis">${re.reviewcontent }</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<br>
			</article>
			
			<article id="myBoard">
				<div class="smallTitle"><b>내가 쓴 게시글</b></div><br>
				<div class="more"><a href="listMyBoard.do">더보기</a></div>
				<ul id="ul">
					<c:forEach var="b" items="${list_board }" begin="0" end="1">
						<li class="eachBoard">
							<div class="boardElements ellipsis">
								<a href="detailBoard.do?boardno=${b.boardno }">${b.boardtitle }</a>
							</div>
							<div class="boardElements">${b.boarddate }</div>
							<div class="boardElements ellipsis">${b.boardcontent }</div>
						</li>
					</c:forEach>
				</ul>
			</article>
		
		</section>
		
		<footer></footer>
	
</body>
</html>