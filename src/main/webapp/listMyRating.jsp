<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	a{text-decoration:none;}
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
	#myrating{
		overflow:hidden;
		border:1px solid red;
	}
	#ul{
		list-style:none;
		margin-top:140px;
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
	$("#ul").masonry({columnWidth:200});
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
						$("#ul").masonry({columnWidth:200});
					}
				})
			}
			
		}
	})
})
</script>
</head>
<body>
	<header>
		<!-- 로고 -->
		<div id="logo">
			<a href="mainPage.do"><img src="./images/logo.png" width=300px;></a>
		</div>
		
		<div id="logout">
			<a href="logout.do">로그아웃</a>
		</div>
		
		<div id="title">
			<div><b>내가 평가한 영화</b></div>
			<hr>
		</div>
	</header>
	
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