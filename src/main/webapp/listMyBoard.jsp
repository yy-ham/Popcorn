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
	#myBoard{
		overflow:hidden;
		border:1px solid red;
		height:auto;
		margin-top:150px;
	}
	#ul_board{
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
	#ul_pageNum{
		overflow:hidden;
		list-style:none;
		border:1px solid blue;
		width:100px;
		left:45px;
	}
	.pageNum{
		float:left;
		margin:5px;
		cursor:pointer;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$.ajax({
			url:"getTotalPage.jsp",
			success:function(totalPage){
				for(i=1;i<=totalPage;i++){
					$("#ul_pageNum").append($("<li></li>").text(i).addClass("pageNum"));
				}
			}
		})
		$(document).on("click",".pageNum",function(){
			$("#ul_board").empty();
			$.ajax({
				url:"listBoardByPage.jsp",
				data:{pageNum:$(this).text()},
				success:function(list){
					$.each(list,function(){
						const a=$("<a></a>").text(this.boardtitle).attr("href","detailBoard.do?boardno="+this.boardno);
						a.addClass("boardElements ellipsis");
						const div1=$("<div></div>").text(this.boarddate);
						div1.addClass("boardElements");
						const div2=$("<div></div>").text(this.boardcontent);
						div2.addClass("boardElements ellipsis");
						const li=$("<li></li>").addClass("eachBoard");
						li.append(a,div1,div2);
						$("#ul_board").append(li);
					})
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
			<div><b>내 게시글</b></div>
			<hr>
		</div>
	</header>
	<section>
		<article id="myBoard">
			<ul id="ul_board">
				<c:forEach var="b" items="${list_board }">
					<li class="eachBoard">
						<a href="detailBoard.do?boardno=${b.boardno }" class="boardElements ellipsis">${b.boardtitle }</a>
						<div class="boardElements">${b.boarddate }</div>
						<div class="boardElements ellipsis">${b.boardcontent }</div>
					</li>
				</c:forEach>
			</ul>
			<ul id="ul_pageNum"></ul>
		</article>
	</section>
</body>
</html>