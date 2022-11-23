<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
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
		margin:0px auto;
	}
	
	input::placeholder{
		text-align:center;
		font-size:0.8em;
	}
	
	

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.2.min.js"></script>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("#search_movie").click(function(){
			
			$.ajax({
				url:"SearchByMovietitle",
				data:{movietitle:$("#input_moviename").val()},
				success:function(list){
					$("#list").empty();
					$.each(list,function(){
							
							var div=$("<div></div>").addClass("item");
							var img=$("<img/>").attr({"src":"img/poster/"+this.poster,
														"width":"180px",		
														"height":"250px"});
							var br = $("<br>");
							var span = $("<span></span>").html(this.movietitle).addClass("movie_name");
							var span2 = $("<span></span>").html(this.agelimit).addClass("movie_name");
							var span3 = $("<span></span>").html(this.genre).addClass("movie_name");
							$(div).append(img,br,span,span2,span3);
							$("#list").append(div);
								
							})
							
					$("#list").masonry({
						itemSelector:".item",
						columnWidth:100
					});
				}
			})
			
		})
				
		
	});
</script>
</head>
<body>

	<img src="img/pagelogo.png" width="300px" height="100px"><br>
	<div id="type_moviename">
		<div id="insert">
			<input type="text" placeholder="영화제목을 입력하세요" id="input_moviename">
			<button id="search_movie">검색</button>
		</div>
	</div>
	<hr>
	
	<div id="list">
		<div id="list_inner">
			<img src="img/poster/기생충.jpg" width="200px" height="250px"><br>
			<span class="movie_name">기생충</span>
		</div>
	</div>
</body>
</html>