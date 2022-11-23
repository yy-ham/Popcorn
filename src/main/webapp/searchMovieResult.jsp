<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<link rel="stylesheet" href="jquery-ui-1.13.1.custom/jquery-ui.css">
<style type="text/css">

	*{
		margin:0px;
		padding:0px;
	}
	
	#type_moviename{
		border: 2px solid yellow;
	}
	
	#insert{
		text-align:center;
	}
	
	#input_moviename{
		width:500px;
		height:30px;
		font-size:1.2em;
	}
	
	
	#list{
		border: 1px solid orange;
		margin:0px auto;
		width:80%;
	}
	
	.item{
		margin:30px;
		margin-left:50px;
		width:200px;
		height:380px;
		background-color:white;
		border:2px solid black;
		border-radius:10px;
		float:left;
	}
	


	.movie_name{
		display:inline-block;
		margin:0px auto;
		border : 1px solid green;
		width:100%;
		text-align:center;
	}
	
	img{
		display:block;	
		border:1px solid black;
		margin:10px auto;
	}
	
	input::placeholder{
		text-align:center;
		font-size:0.8em;
	}
	
	
	.ui-autocomplete{
		width:500px;
		border-radius:10px;
	}
	

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery-ui-1.13.1.custom/jquery-ui.js"></script>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		var searchMovie = function(keyword){
			$.ajax({
				url:"SearchByMovietitle",
				data:{movietitle:keyword},
				success:function(list){
					$("#list").empty();
					$.each(list,function(){
							
							var div=$("<div></div>").addClass("item");
							var img=$("<img/>").attr({"src":"images/poster/"+this.poster,
														"width":"180px",		
														"height":"250px"
													});
							var br = $("<br>");
							var span = $("<span></span>").html(this.movietitle).addClass("movie_name");
							var span2 = $("<span></span>").html("연령제한 : "+this.agelimit).addClass("movie_name");
							var span3 = $("<span></span>").html("장르 : "+this.genre).addClass("movie_name");
							$(div).append(img,br,span,span2,span3);
							var a = $("<a></a>").append(div).attr("href", "detail.do?movieno="+this.movieno);
							$("#list").append(a);
								
							})
							
					$("#list").masonry({
						itemSelector:".item",
						columnWidth:100
					});
				}
			})
		}
		
		var keyword=$("#keyword").val();
		searchMovie(keyword);
		
		$("#search_movie").click(function(){
			var title=$("#input_moviename").val();
			searchMovie(title);
			
		})
		
		var tags=["범죄도시","늑대사냥","본 얼티메이텀","다만 악에서 구하소서",
			"기생충","부산행","피아니스트","말할 수 없는 비밀","어바웃 타임","타이타닉"];
		
		
		$("#input_moviename").autocomplete({
			source:tags
		});
		
		
	});
</script>
</head>
<body>
	<input type="hidden" value="${userno }" id="userno">
	
	<input type="hidden" value="${keyword }" id="keyword">
	<a href="mainPage.do">
		<img src="images/mainlogo.png" width="300px" height="100px"><br>
	</a>
	<div id="type_moviename">
		<div id="insert">
			<input type="text" placeholder="영화제목을 입력하세요" id="input_moviename">
			<button id="search_movie">검색</button>
		</div>
	</div>
	<hr>
	
	<div id="list">
		<div id="list_inner">
			<img src="images/poster/5_기생충_poster.jpg" width="200px" height="250px"><br>
			<span class="movie_name">기생충</span>
		</div>
	</div>
</body>
</html>