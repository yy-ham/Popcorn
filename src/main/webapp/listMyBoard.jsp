<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝콘-내가 쓴 게시글</title>
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
	
	
	section{
		margin-top:180px;
	}
	#title{
		font-size:22px;
		margin-left:150px;
	}
	
	#myBoard{
		overflow:hidden;
		border:1px solid #D9CDBF;
		margin-top:20px;
		margin-left:150px;
		margin-right:150px;
		border-radius:5px;
	}
	#ul_board{
		list-style:none;
	}
	.eachBoard{
		margin:10px 120px;;
		padding:20px;
		width:900px;
		height:100px;
		border:1px solid #D93223;
		border-radius:5px;
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
		width:200px;
		left:45px;
		display:block;
		margin:0 0 10px 550px;
	}
	.pageNum{
		float:left;
		margin:5px;
		cursor:pointer;
	}
	.ul{
		display:block;
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
		<div id="title">내가 쓴 게시글</div>
		<article id="myBoard">
			<ul id="ul_board" class="ul">
				<c:forEach var="b" items="${list_board }">
					<li class="eachBoard">
						<a href="detailBoard.do?boardno=${b.boardno }" class="boardElements ellipsis">${b.boardtitle }</a>
						<div class="boardElements">${b.boarddate }</div>
						<div class="boardElements ellipsis">${b.boardcontent }</div>
					</li>
				</c:forEach>
			</ul>
			<ul id="ul_pageNum" class="ul"></ul>
		</article>
	</section>
</body>
</html>