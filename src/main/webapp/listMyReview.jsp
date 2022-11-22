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
	#myReview{
		margin-top:150px;
	}
	#ul{
		list-style:none;
	}
	.eachReview{
		border:3px solid black;
		height:130px;
		margin:10px;
		padding:10px;
		position:relative;
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
	#edit{
		float:right;
	}
	#titleEditContents{
		border:1px solid red;
		width:600px;
	}
	#textarea{
		display:none;
	}
	#confirm{
		display:none;
	}
	#reviewno{
		display:none;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#edit").click(function(){
		$("#textarea").css({display:"block"});
		$("#confirm").css({display:"block"});
	})
	$("#confirm").click(function(){
		$.ajax({
			url:"updateReviewAtMyPage.jsp",
			data:{
				reviewcontent:$("#textarea").val(),
				reviewno:$("#reviewno").text()
			},
			success:function(re){
				if(re==1){
					alert("리뷰를 수정했습니다.");
					$.ajax({
						url:"getUpdatedReview.jsp",
						data:{reviewno:$("#reviewno").text()},
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
			<div><b>내가 쓴 리뷰</b></div>
			<hr>
		</div>
	</header>
	<section>
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
								<a href="#" id="edit">수정</a>
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
							<div class="reviewElementsLower" id="reviewcontent">${re.reviewcontent }</div>
						</div>
						<div id="reviewno">${re.reviewno }</div>
					</li>
					<textarea cols="80" rows="5" id="textarea">${re.reviewcontent }</textarea>
					<a href="#" id="confirm">확인</a>
				</c:forEach>
			</ul>
		</article>
	</section>
</body>
</html>