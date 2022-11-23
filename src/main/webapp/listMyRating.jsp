<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	
	/*상단바*/
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
	}
	
	header{
		position:fixed;
		left:0; top:0; right:0;
		height:130px;
		background:white;
		z-index:99;
		padding-top:10px;
		border: 1px solid blue;
	}
	#logout{
		position:absolute;
		right:20px;
		padding:5px;
		border:1px solid black;
	}
	#title{
		position:absolute;
		left:0; right:0;
		top:50px;
		font-size:26px;
		padding:20px;
	}
	*/
	
		
	a{text-decoration:none;}
	
	#myrating{
		overflow:hidden;
		border:1px solid #D9CDBF;
		margin-top:140px;
		margin-left:100px;
		margin-right:100px;
		border-radius:5px;
	}
	#ul{
		list-style:none;
		
	}
	.eachRating{
		float:left;
		margin:10px;
		padding:10px;
	}
	.ratingcontent{
		padding-top:7px;
	}
	
	
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<script type="text/javascript">
$(function(){
	var end=8;
	var totalRecord=-1;
	$.ajax({
		url:"getTotalRatingRecord.jsp",
		success:function(re){
			totalRecord=re;
		}
	})
	$(window).scroll(function(){
		
		if(end<=totalRecord+4){
			var scrollHeight=$(window).scrollTop()+$(window).height()
			var documentHeight=$(document).height()
			if((scrollHeight+1)>=documentHeight){
				$.ajax({
					url:"listRatingByScroll.jsp",
					data:{end:end},
					success:function(list){
						end=end+4;
						$.each(list,function(){
							var li=$("<li></li>");
							
							var img=$("<img/>").attr({src:"./images/poster/"+this.poster,width:"150",height:"215.9"});
							var a_img=$("<a></a>").attr("href","detailMovie.do?movieno="+this.movieno);
							a_img.append(img);
							var div=$("<div></div>").append(a_img);
	
							var a_movietitle=$("<a></a>").text(this.movietitle).attr("href","detailMovie.do?movieno="+this.movieno);
							
							var div_ratingcontent=$("<div></div>").addClass("ratingcontent");
							if(this.ratingcontent=='good'){
								div_ratingcontent.append($("<img/>").attr({
									src:"./images/rating/good.png",
									width:30
										}))
							}else if(this.ratingcontent=='fair'){
								div_ratingcontent.append($("<img/>").attr({
									src:"./images/rating/fair.png",
									width:30
										}))
							}else if(this.ratingcontent=='bad'){
								div_ratingcontent.append($("<img/>").attr({
									src:"./images/rating/bad.png",
									width:30
										}))
							}
							li.addClass("eachRating");
							li.append(div,a_movietitle,div_ratingcontent);
							$("#ul").append(li);
							
						})
						
					}
				})
			}
			
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
	
	<section>
		<article id="myrating">
			<ul id="ul">
				<c:forEach var="ra" items="${list_rating }">
					<li class="eachRating">
						<div>
							<a href="detailMovie.do?movieno=${ra.movieno }">
								<img src="./images/poster/${ra.poster }" width="150" height="215.9"/>
							</a>
						</div>
						<a href="detailMovie.do?movieno=${ra.movieno }">${ra.movietitle }</a>
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
					</li>
				</c:forEach>
			</ul>
		</article>
	</section>
</body>
</html>