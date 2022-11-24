<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘-내가 쓴 리뷰</title>
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
	
	#title{
		font-size:22px;
		margin-left:115px;
	}
	section{
		margin-top:180px;
	}
	
	#myReview{
		overflow:hidden;
		border:1px solid #D9CDBF;
		margin-top:20px;
		margin-left:110px;
		margin-right:110px;
		border-radius:5px;
	}
	#ul{
		list-style:none;
	}
	.eachReview{
		border:1px solid #D93223;
		height:130px;
		margin:10px;
		padding:10px;
		position:relative;
		border-radius:5px;
	}
	.reviewElements{
		float:left;
		margin:8px;
	}
	.reviewElementsLower{
		margin:8px;
	}
	.ellipsis{
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}
	#titleEditContents{
		width:600px;
	}
	#textarea{
		display:none;
	}
	#confirm{
		display:none;
	}
	.reviewno{
		display:none;
	}
	
	
	
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".edit").click(function(){
		$("#textarea").css({display:"block"});
		$("#confirm").css({display:"block"});
	})
	$("#confirm").click(function(){
		$.ajax({
			url:"updateReviewAtMyPage.jsp",
			data:{
				reviewcontent:$("#textarea").val(),
				reviewno:$(".reviewno").text()
			},
			success:function(re){
				if(re==1){
					alert("리뷰를 수정했습니다.");
					$.ajax({
						url:"getUpdatedReview.jsp",
						data:{reviewno:$(".reviewno").text()},
						success:function(reviewcontent){
							$("#reviewcontent").text(reviewcontent);
						}
					})
				}else{
					alert("오류");
				}
			}
		})
	})
	$(".del").click(function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			$.ajax({
				url:"deleteReviewAtMyPage.jsp",
				data:{reviewno:$(".reviewno").text()},
				success:function(re){
					if(re==1){
						alert("리뷰를 삭제했습니다.");
						location.reload();
					}else{
						alert("오류 발생");
					}
				}
			})
		}
	})
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
	
	<section>
		<div id="title"><b>내가 쓴 리뷰</b></div>
		<article id="myReview">
			<ul id="ul">
				<c:forEach var="re" items="${list_review }">
					<li class="eachReview">
						<div class="reviewElements">
							<a href="detailMovie.do?movieno=${re.movieno }">
								<img src="./images/poster/${re.poster }" width="80" height='114.5'/>
							</a>
						</div>
						<div class="reviewElements" id="titleEditContents">
							<div class="reviewElementsLower" id="titleAndEdit">
								<a href="detailMovie.do?movieno=${re.movieno }">${re.movietitle }</a>
							</div>
							<div class="reviewElementsLower">
								<c:if test="${re.ratingcontent =='good'}">
									<img src="./images/icon/good_click.png" width="30">
								</c:if>
								<c:if test="${re.ratingcontent =='fair'}">
									<img src="./images/icon/fair_click.png" width="30">
								</c:if>
								<c:if test="${re.ratingcontent =='bad'}">
									<img src="./images/icon/bad_click.png" width="30">
								</c:if>
							</div>
							<a href="detailReview.do?reviewno=${re.reviewno }&movieno=${re.movieno }" class="reviewElementsLower" id="reviewcontent">${re.reviewcontent }</a>
						</div>
						<div class="reviewno">${re.reviewno }</div>
					</li>
					<textarea cols="80" rows="5" id="textarea">${re.reviewcontent }</textarea>
					<a href="#" id="confirm">확인</a>
				</c:forEach>
			</ul>
		</article>
	</section>
</body>
</html>