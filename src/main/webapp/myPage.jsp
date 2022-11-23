<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘-마이페이지</title>
<style type="text/css">
	a{text-decoration:none;}
	
	/* header */
	#logo{
		position:absolute;
		left:50%;
		margin-left:-150px;
		width:300px;
		border:1px solid red;
	}
	#img{
		border:1px solid black;
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
	}
	
	/* section 공통 */
	#section{
		position:absolute;
		top:150px;
		right:5%;
		left:5%;
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
		border:1px solid blue;
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
	#userinfo{
		text-align:center;
		margin-top:100%;
	}
	
	/* rating */
	#rating{
		border: 1px solid yellow;
	}
	#myrating{
		overflow:hidden;
		height:310px;
		border:1px solid red;
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
		border: solid 1px blue;
		height:490px;
	}
	#reviewContainer{
		overflow:hidden;
	}
	.eachReview{
		border:3px solid black;
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
		overflow:hidden;
		border:1px solid red;
		height:418px;
	}
	#ul{
		list-style:none;
	}
	.eachBoard{
		margin:10px;
		padding:20px;
		width:700px;
		height:100px;
		border:1px solid orange;
		overflow:hidden;
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

	<header>
		<!-- 로고 -->
		<a id="logo" href="mainPage.do">
			<img id="img" src="./images/logo.png" width="300">
		</a>
		
		<div id="logout">
			<a href="logout.do">로그아웃</a>
		</div>
		
		<div id="title">
			<div><b>마이페이지</b></div>
			<hr>
		</div>
	</header>
	
	<section id="section">
	
		<article id="profile">
			<!-- 프로필사진 -->
			<div id="userimg" class="profileElements">
				<img src="./images/userimg/${userinfovo.userimg }" width="100" height="100">
			</div>
			<!-- 닉네임 -->
			<div id="nickname" class="profileElements">${userinfovo.nickname }</div>
			<div id="userinfo" class="profileElements">
				<a href="detailUserinfo.do">회원정보</a>
			</div>
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
</body>
</html>